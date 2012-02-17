require 'json_rpc'

API = JsonRpc::Client.connect('http://localhost', :port => 80)

p API.add(1,2)

begin
  API.faulty_method
rescue StandardError
  puts "Captured StandardError from API's faulty method."
end