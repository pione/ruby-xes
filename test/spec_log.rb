require 'xes'

describe "XES::Log" do
  it "should equal" do
    XES::Log.new.should == XES::Log.new
  end

  it "should not equal" do
    XES::Log.new.tap{|log| log.traces << XES::Trace.new}.should != XES::Log.new
  end

  it "should set and get xes_version" do
    XES::Log.new.tap{|log| log.xes_version = "1.1"}.xes_version.should == "1.1"
  end

  it "should set and get xes_featuers" do
    XES::Log.new.tap{|log| log.xes_features = ""}.xes_features.should == ""
  end

  it "should set and get openxes_version" do
    XES::Log.new.tap{|log| log.openxes_version = "1.9"}.openxes_version.should == "1.9"
  end

  it "should set and get xmlns" do
    XES::Log.new.tap{|log| log.xmlns = "test"}.xmlns.should == "test"
  end

  it "should set and get extensions" do
    XES::Log.new.tap do |log|
      log.extensions << XES::EXTENSION[:semantic]
    end.extensions.should.include(XES::EXTENSION[:semantic])
  end

  it "should set and get classifiers" do
    XES::Log.new.tap do |log|
      log.classifiers << XES::Classifier.new("test", "time:timestamp")
    end.classifiers.should.include(XES::Classifier.new("test", "time:timestamp"))
  end

  it "should set and get event_global" do
    XES::Log.new.tap do |log|
      log.event_global.concept_name = "__INVALID__"
    end.event_global.attributes.should.include(XES.string("concept:name", "__INVALID__"))
  end

  it "should set and get trace_global" do
    XES::Log.new.tap do |log|
      log.trace_global.concept_name = "__INVALID__"
    end.trace_global.attributes.should.include(XES.string("concept:name", "__INVALID__"))
  end

  it "should set and get attributes" do
    XES::Log.new.tap do |log|
      log.attributes << XES.string("concept:name", "test")
    end.attributes.should.include(XES.string("concept:name", "test"))
  end

  it "should set and get traces" do
    XES::Log.new.tap do |log|
      log.traces << XES::Trace.new
    end.traces.should.include(XES::Trace.new)
  end

  it "should be formattable" do
    XES::Log.new.tap do |log|
      log.traces << XES::Trace.new.tap do |trace|
        trace.events << XES::Event.new.tap do |event|
          event.attributes << XES.string("concept:name", "test")
        end
      end
    end.should.formattable
  end

  it "should be not formattable" do
    XES::Log.new.tap do |log|
      log.traces << XES::Trace.new
    end.should.not.formattable
  end

  it "should format as XML element" do
    XES::Log.new.tap do |log|
      log.traces << XES::Trace.new.tap do |trace|
        trace.events << XES::Event.new.tap do |event|
          event.attributes << XES.string("concept:name", "test")
        end
      end
    end.format.to_s.should ==
      "<log xes.features='' xes.version='1.4' xmlns='http://www.xes-standard.org/'><trace><event><string key='concept:name' value='test'/></event></trace></log>"
  end
end
