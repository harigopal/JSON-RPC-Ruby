BASEPATH = File.dirname(File.expand_path(__FILE__))
require "#{BASEPATH}/../lib/json_rpc_ruby"

run JsonRpcRuby::RackApplication.new