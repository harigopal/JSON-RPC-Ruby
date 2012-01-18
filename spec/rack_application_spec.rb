require_relative 'spec_helper'

describe JsonRpcRuby::RackApplication do
  it { should respond_to(:call).with(1).argument }

  describe "#call" do
    it "returns an array with three elements" do
      subject.call({}).should == [200, {"Content-Type" => "application/json"}, ["foo"]]
    end
  end
end
