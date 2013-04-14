require 'xes'

describe "XES::Trace" do
  it "should equal" do
    XES::Trace.new.tap do |x|
      x.attributes << XES.string("concept:name", "A")
      x.events << XES::Event.new([XES.string("concept:name", "B")])
    end.should ==
      XES::Trace.new.tap do |x|
      x.attributes << XES.string("concept:name", "A")
      x.events << XES::Event.new([XES.string("concept:name", "B")])
    end
  end

  it "should not equal" do
    XES::Trace.new.tap do |x|
      x.attributes << XES.string("concept:name", "A")
      x.events << XES::Event.new([XES.string("concept:name", "B")])
    end.should !=
      XES::Trace.new.tap do |x|
      x.attributes << XES.string("concept:name", "A")
      x.events << XES::Event.new([XES.string("concept:name", "C")])
    end
  end

  it "should get attributes" do
    XES::Trace.new.tap do |x|
      x.attributes << XES.string("concept:name", "A")
      x.events << XES::Event.new([XES.string("concept:name", "B")])
    end.attributes.should == [XES.string("concept:name", "A")]
  end

  it "should get events" do
    XES::Trace.new.tap do |x|
      x.attributes << XES.string("concept:name", "A")
      x.events << XES::Event.new([XES.string("concept:name", "B")])
    end.events.should == [XES::Event.new([XES.string("concept:name", "B")])]
  end

  it "should get concept:name" do
    XES::Trace.new.tap do |x|
      x.attributes << XES.string("concept:name", "A")
    end.concept_name.should == "A"
  end

  it "should set concept:name" do
    XES::Trace.new.tap{|x| x.concept_name = "A"}.concept_name.should == "A"
  end

  it "should get semantic:modelReference" do
    XES::Trace.new.tap do |x|
      x.attributes << XES.string("semantic:modelReference", "A")
    end.semantic_modelReference.should == "A"
  end

  it "should set semantic:modelReference" do
    XES::Trace.new.tap{|x| x.semantic_modelReference = "A"}.semantic_modelReference.should == "A"
  end

  it "should get identity:id" do
    XES::Trace.new.tap do |x|
      x.attributes << XES.id("identity:id", "A")
    end.identity_id.should == "A"
  end

  it "should set identity:id" do
    XES::Trace.new.tap{|x| x.identity_id = "A"}.identity_id.should == "A"
  end

  it "should get cost:total" do
    XES::Trace.new.tap do |x|
      x.attributes << XES.float("cost:total", "A")
    end.cost_total.should == "A"
  end

  it "should set cost:total" do
    XES::Trace.new.tap{|x| x.cost_total = "A"}.cost_total.should == "A"
  end

  it "should get cost:currency" do
    XES::Trace.new.tap do |x|
      x.attributes << XES.string("cost:currency", "AUD")
    end.cost_currency.should == "AUD"
  end

  it "should set cost:currency" do
    XES::Trace.new.tap{|x| x.cost_currency = "AUD"}.cost_currency.should == "AUD"
  end

  it "should be formattable" do
    XES::Trace.new.tap{|x| x.events << XES::Event.new([XES.string("concept:name", "B")])}.should.formattable
  end

  it "should be not formattable when the trace have no events" do
    XES::Trace.new.should.not.formattable
  end

  it "should be not formattable when the trace have only invalid event" do
    XES::Trace.new.tap{|x| x.events << XES::Event.new}.should.not.formattable
  end

  it "should raise FormatError because the trace has no events" do
    should.raise(XES::FormatError) do
      XES::Trace.new.format
    end
  end

  it "should raise FormatError because events of the trace are invalid" do
    should.raise(XES::FormatError) do
      XES::Trace.new.tap{|x| x.events << XES::Event.new}.format
    end
  end
end
