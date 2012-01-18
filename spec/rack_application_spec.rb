require_relative 'spec_helper'

describe JsonRpcRuby::RackApplication do
  it "should accept a Service class object upon initialization" do
    JsonRpcRuby::RackApplication.should respond_to(:new).with(1).argument
  end

  let(:mock_service) { double("Service").as_null_object }

  subject { JsonRpcRuby::RackApplication.new(mock_service) }

  let(:mock_request) { double "Rack Request", :POST => {"method" => "a_method", "params" => [1, 2, 3]}.to_json }

  before :each do
    Rack::Request.stub(:new).and_return(mock_request)
  end

  it { should respond_to(:call).with(1).argument }

  describe "#call" do
    it "calls the method supplied in the 'method' request parameter with the supplied method parameters" do
      mock_service.should_receive(:a_method).with(1, 2, 3)
      subject.call({})
      other_arguments = [3, 4, 5]
      mock_request.stub(:POST).and_return({"method" => "another_method", "params" => other_arguments}.to_json)
      mock_service.should_receive(:another_method).with(3, 4, 5)
      subject.call({})
    end

    context "when passed all mandatory parameters" do
      context "when method execution occurs normally" do
        it "returns an array with three elements" do
          mock_request.stub(:POST).and_return({"method" => "add", "params" => [1, 2], "id" => 1}.to_json)
          mock_service.stub(:add).and_return(3)
          subject.call({}).should == [200, {"Content-Type" => "application/json"}, [{"result" => 3, "error" => nil, "id" => 1}.to_json]]
        end
      end

      context "when method execution fails" do
        it "closes connection and returns an error message" do
          mock_service.stub(:add).and_raise(TypeError)
          mock_request.stub(:POST).and_return({"method" => "add", "params" => [1, "2"], "id" => 1}.to_json)
          status, headers, body = subject.call({})
          status.should == 500
          headers.should == {"Content-Type" => "application/json"}
          body = JSON.load(body[0])
          body["result"].should == nil
          body["error"].should_not == nil
          body["id"].should == 1
        end
      end
    end

    context "when passed invalid parameters" do
      it "closes connection and returns an error message" do
        mock_request.stub(:POST).and_return({}.to_json)
        subject.call({}).should == [400, {"Content-Type" => "application/json"}, [{"result" => nil, "error" => "Invalid Request Parameters", "id" => nil}.to_json]]
      end
    end
  end
end
