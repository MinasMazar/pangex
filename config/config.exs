# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :pangex, start_device_cmd: System.get_env("PANGEX_START_DEVICE_CMD", "scripts/stub_device.sh")

import_config "#{config_env()}.exs"
