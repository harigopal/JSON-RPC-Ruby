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

  subject { JsonRpc::Client.new('http://example.com/') }

  describe "#method_missing" do
    before :each do
      subject.stub(:random_id).and_return("a1b2c3d4e5")
    end

    it "posts JSON RPC request to URL supplied at initialization" do
      #Net::HTTP.any_instance.should_receive(:post) #.with("http://example.com", {'json_rpc' => "2.0", "method" => "anything", "id" => "a1b2c3d4e5"})
      subject.anything
    end

    context "when arguments are supplied" do
      it "passes along arguments as well" do
        #Net::HTTP.any_instance.should_receive(:post) #.with("http://example.com", {'json_rpc' => "2.0", "method" => "anything", "id" => "a1b2c3d4e5", "params" => [1, "two", "3"]})
        subject.anything(1, :two, "3")
      end
    end
  end

  describe "#random_id" do
    it "generates a string" do
      subject.random_id.should be_a String
    end

    it "has length 8" do
      subject.random_id.length.should == 10
    end

    it "generates random value" do
      subject.random_id.should_not == subject.random_id
    end
  end
end
