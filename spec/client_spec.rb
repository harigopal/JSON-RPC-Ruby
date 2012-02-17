require_relative 'spec_helper'

describe JsonRpc::Client do
  it "should accept a server URL, and options upon initialization" do
    expect {
      JsonRpc::Client.new('http://localhost')
      JsonRpc::Client.new('http://localhost', {})
    }.to_not raise_error
  end


end
