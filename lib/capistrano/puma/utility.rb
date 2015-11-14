module Capistrano
  module Puma
    module Utility
      def run_puma_cmd(&block)
        on roles fetch(:puma_roles) do |host|
          if host.user == fetch(:puma_user)
            within release_path do
              with rack_env: fetch(:puma_env), rails_env: fetch(:puma_env) do
                instance_eval(&block)
              end
            end
          else
            as fetch(:puma_user) do
              within release_path do
                with rack_env: fetch(:puma_env), rails_env: fetch(:puma_env) do
                  instance_eval(&block)
                end
              end
            end
          end
        end
      end

      def puma_signal(sig)
        fail('Puma is not running!') unless puma_running?

        execute(:kill, "-#{sig}", "$( cat #{fetch(:puma_pid)} )")
      end

      def puma_running?
        return false unless test("[ -f #{fetch(:puma_pid)} ]")

        unless test(:kill, '-0', "$( cat #{fetch(:puma_pid)} )")
          execute(:rm, fetch(:puma_pid))

          return false
        end

        true
      end

      def start_puma
        execute(:puma, "-C #{fetch(:puma_conf)}", '--daemon')

        4.times do
          sleep 2

          return if puma_running?
        end

        fail('Puma failed to start!')
      end

      def stop_puma
        return unless puma_running?

        execute(:pumactl, "-S #{fetch(:puma_state)}", "-F #{fetch(:puma_conf)}", :stop)
      end

      def restart_puma(strategy = nil)
        if puma_running?
          strategy ||= fetch(:puma_restart_strategy)

          execute(:pumactl, "-S #{fetch(:puma_state)}", "-F #{fetch(:puma_conf)}", strategy)
        else
          start_puma
        end
      end
    end
  end
end
