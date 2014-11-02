Rack::Timeout.timeout = 5
Rack::Timeout.unregister_state_change_observer :logger
