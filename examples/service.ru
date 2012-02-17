require 'json_rpc'

run JsonRpc::RackApplication.new(ExampleService.new)