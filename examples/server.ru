require 'json_rpc_ruby'

run JsonRpcRuby::RackApplication.new(ExampleService.new)