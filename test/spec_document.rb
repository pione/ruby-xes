require 'xes'

describe "XES::Document" do
  it "should equal" do
    XES::Document.new.should == XES::Document.new
  end

  it "should formattable" do
    XES::Document.new.tap do |doc|
      doc.log = XES::Log.new.tap do |log|
        log.traces << XES::Trace.new.tap do |trace|
          trace.events << XES::Event.new.tap do |event|
            event.attributes << XES.string("concept:name", "test")
          end
        end
      end
    end.should.formattable
  end
end
