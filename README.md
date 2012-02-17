# JSON-RPC Ruby (WIP)

An experiment, in creating a client and server implementation for JSON-RPC in Ruby.

# Examples

## Server

### Application

    class ExampleService
      def add(value_1, value_2)
        value_1 + value_2
      end

      def faulty_method
        raise StandardError, "Oops! Something went wrong!"
      end
    end

### Rack-up

    require 'json_rpc_ruby'

    run JsonRpcRuby::RackApplication.new(ExampleService.new)

## Client (Not functional)

    require 'json_rpc_ruby'

    API = JsonRpcRuby::Client.connect('http://localhost', :port => 80)

    p API.add(1,2)

    begin
      API.faulty_method
    rescue StandardError
      puts "Captured StandardError from API's faulty method."
    end