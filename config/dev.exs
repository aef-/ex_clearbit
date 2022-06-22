import Config

config :git_hooks,
  auto_install: true,
  verbose: true,
  hooks: [
    pre_commit: [
      tasks: [
        {:cmd, "mix format --check-formatted"}
      ]
    ],
    pre_push: [
      verbose: false,
      tasks: [
        {:cmd, "mix dialyzer"},
        {:cmd, "mix test --color --exclude not_implemented"},
        {:cmd, "echo 'success!'"}
      ]
    ]
  ]

import_config "#{config_env()}.exs"
