require 'xes'

describe "XES::Global" do
  it "should equal" do
    XES::Global.event.should == XES::Global.event
  end

  it "should not equal" do
    XES::Global.event.should != XES::Global.trace
  end

  it "should get the scope" do
    XES::Global.event.scope.should == "event"
  end

  it "should get the attributes" do
    XES::Global.event.tap do |global|
      global.attributes << XES.string("concept:name", "__INVALID__")
    end.attributes.should == [XES.string("concept:name", "__INVALID__")]
  end

  it "should set and get concept:name of event global" do
    XES::Global.event.tap do |global|
      global.concept_name = "A"
    end.concept_name.should == "A"
  end

  it "should set and get concept:instance of event global" do
    XES::Global.event.tap do |global|
      global.concept_instance = "A"
    end.concept_instance.should == "A"
  end

  it "should set and get lifecycle:transition of event global" do
    XES::Global.event.tap do |global|
      global.lifecycle_transition = "complete"
    end.lifecycle_transition.should == "complete"
  end

  it "should set and get org:resource of event global" do
    XES::Global.event.tap do |global|
      global.org_resource = "A"
    end.org_resource.should == "A"
  end

  it "should set and get org:role of event global" do
    XES::Global.event.tap do |global|
      global.org_role = "A"
    end.org_role.should == "A"
  end

  it "should set and get org:group of event global" do
    XES::Global.event.tap do |global|
      global.org_group = "A"
    end.org_group.should == "A"
  end

  it "should set and get time:timestamp of event global" do
    Time.now.tap do |time|
      XES::Global.event.tap do |global|
        global.time_timestamp = time
      end.time_timestamp.should == time
    end
  end

  it "should set and get semantic:modelReference of event global" do
    XES::Global.event.tap do |global|
      global.semantic_modelReference = "A"
    end.semantic_modelReference.should == "A"
  end

  it "should set and get identity:id of event global" do
    XES::Global.event.tap do |global|
      global.identity_id = "A"
    end.identity_id.should == "A"
  end

  it "should set and get cost:total of event global" do
    XES::Global.event.tap do |global|
      global.cost_total = 0.123
    end.cost_total.should == 0.123
  end

  it "should set and get cost:currency of event global" do
    XES::Global.event.tap do |global|
      global.cost_currency = "A"
    end.cost_currency.should == "A"
  end

  it "should set and get concept:name of trace global" do
    XES::Global.trace.tap do |global|
      global.concept_name = "A"
    end.concept_name.should == "A"
  end

  it "should set and get semantic:modelReference of trace global" do
    XES::Global.trace.tap do |global|
      global.semantic_modelReference = "A"
    end.semantic_modelReference.should == "A"
  end

  it "should set and get identity:id of trace global" do
    XES::Global.trace.tap do |global|
      global.identity_id = "A"
    end.identity_id.should == "A"
  end

  it "should set and get cost:total of trace global" do
    XES::Global.trace.tap do |global|
      global.cost_total = 0.123
    end.cost_total.should == 0.123
  end

  it "should set and get cost:currency of trace global" do
    XES::Global.trace.tap do |global|
      global.cost_currency = "A"
    end.cost_currency.should == "A"
  end

  it "should format event global as XML element" do
    XES::Global.event.tap do |global|
      global.concept_name = "A"
    end.format.to_s.should == "<global scope='event'><string key='concept:name' value='A'/></global>"
  end

  it "should format trace global as XML element" do
    XES::Global.trace.tap do |global|
      global.concept_name = "A"
    end.format.to_s.should == "<global scope='trace'><string key='concept:name' value='A'/></global>"
  end
end
