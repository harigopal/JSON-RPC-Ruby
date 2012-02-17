require_relative 'spec_helper'

describe JsonRpc::Client do
  before :each do
    FakeWeb.register_uri(:any, %r|http://example\.com|, :body => "Hello World!")
  end

  it "should accept a server URL, and options upon initialization" do
    expect {
      JsonRpc::Client.new('http://localhost')
      JsonRpc::Client.new('http://localhost', {})
    }.to_not raise_error
  end

  subject { JsonRpc::Client.new('http://example.com') }

  describe "#method_missing" do
    it "posts JSON RPC request to URL supplied at initialization" do
      Net::HTTP.should_receive(:post_form).with("http://example.com", {'json_rpc' => "2.0", "method" => "anything", "id" => "a1b2c3"})
      subject.anything
    end
  end
end
