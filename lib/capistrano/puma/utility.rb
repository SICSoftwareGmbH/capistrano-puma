require 'tempfile'

module Capistrano
  module Puma
    module Utility
      def puma_roles
        fetch(:puma_roles, :app)
      end

      def puma_cmd(cmd)
        cmds = []

        if fetch(:puma_bundle)
          cmds += fetch(:puma_bundle).to_s.split(/\s+/)
          cmds << 'exec'
        end

        cmds += fetch(cmd).to_s.split(/\s+/)

        cmds.compact
      end

      def check_puma_config
        return if puma_test "[ -f #{fetch(:puma_conf)} ]"

        fail "Puma config file missing: #{fetch(:puma_conf)}"
      end

      def puma_signal(sig)
        #unless check_puma_pid
        #  fail "Puma is not running!"
        #end

        on roles puma_roles do
          puma_execute :kill, "-#{sig}", "$( cat #{fetch(:puma_pid)} )"
        end
      end

      def puma_execute(*args)
        check_puma_config

        options = args.extract_options!

        command = [:bash, '-l', '-c', "\"#{args.join(' ')}\""]

        within release_path do
          with rack_env: fetch(:puma_env), rails_env: fetch(:puma_env) do
            if puma_user = fetch(:puma_user)
              execute :sudo, '-u', puma_user, command, options
            else
              execute *command, options
            end
          end
        end
      end

      def puma_test(*args)
        options = args.extract_options!

        command = [:bash, '-l', '-c', "\"#{args.join(' ')}\""]

        if puma_user = fetch(:puma_user)
          test :sudo, '-u', puma_user, command, options
        else
          test *command, options
        end
      end

      def check_puma_pid
        return false unless test "[ -f #{fetch(:puma_pid)} ]"

        unless puma_test "kill -0 $( cat #{fetch(:puma_pid)} )"
          puma_execute :rm, fetch(:puma_pid)

          return false
        end

        true
      end

      def start_puma
        puma_execute puma_cmd(:puma_bin), "-C #{fetch(:puma_conf)}", '--daemon'
      end

      def stop_puma
        return unless check_puma_pid

        puma_execute puma_cmd(:pumactl_bin), "-S #{fetch(:puma_state)}", "-F #{fetch(:puma_conf)}", :stop
      end

      def restart_puma
        if check_puma_pid
          puma_execute puma_cmd(:pumactl_bin), "-S #{fetch(:puma_state)}", "-F #{fetch(:puma_conf)}", :restart
        else
          start_puma
        end
      end

      def phased_restart_puma
        if check_puma_pid
          puma_execute puma_cmd(:pumactl_bin), "-S #{fetch(:puma_state)}", "-F #{fetch(:puma_conf)}", 'phased-restart'
        else
          start_puma
        end
      end

      def puma_deploy_restart
        restart_strategy = fetch(:puma_restart_strategy, :restart).to_s

        case restart_strategy
        when 'restart'
          restart_puma
        when 'phased-restart'
          phased_restart_puma
        else
          fail "Invalid restart strategy: #{restart_strategy}"
        end
      end
    end
  end
end
