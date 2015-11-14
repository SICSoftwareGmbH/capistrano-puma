# Change Log

## Unreleased
### Changed
- Use phased restart by default
- Use app_user if available
- Check Puma pid before sending signal
- Check if Puma is running after start

## 0.2.0 (2015-07-16)
### Fixed
- Support for Puma 2.12.0 (config file argument for pumactl)
