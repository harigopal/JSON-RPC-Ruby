lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'json_rpc_ruby'

Gem::Specification.new do |s|
  s.name        = "JSON RPC Ruby"
  s.version     = JsonRpcRuby::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Hari Gopal"]
  s.email       = ["harigopal1@gmail.com"]
  s.summary     = %q{A client and server implementation for JSON-RPC in Ruby}
  s.description = %q{A rack-compatible client server implementation for JSON-RPC in Ruby}

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "yard"

  s.add_dependency "thin"

  s.files              = `git ls-files`.split("\n") - ["Gemfile.lock", ".rvmrc"]
  s.test_files         = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths      = ["lib"]
end
