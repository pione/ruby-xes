require 'xes'

describe "XES::Event" do
  it "should equal" do
    XES::Event.new([XES.string("concept:name", "A")]).should ==
      XES::Event.new([XES.string("concept:name", "A")])
  end

  it "should get concept:name" do
    XES::Event.new([XES.string("concept:name", "A")]).concept_name.should == "A"
  end

  it "should set concept:name" do
    XES::Event.new.tap{|x| x.concept_name = "A"}.concept_name.should == "A"
  end

  it "should get lifecycle:transition" do
    XES::Event.new([XES.string("lifecycle:transition", "start")]).lifecycle_transition.should == "start"
  end

  it "should set lifecycle:transition" do
    XES::Event.new.tap{|x| x.lifecycle_transition = "start"}.lifecycle_transition.should == "start"
  end

  it "should get org:resource" do
    XES::Event.new([XES.string("org:resource", "A")]).org_resource.should == "A"
  end

  it "should set org:resource" do
    XES::Event.new.tap{|x| x.org_resource = "A"}.org_resource.should == "A"
  end

  it "should get org:role" do
    XES::Event.new([XES.string("org:role", "A")]).org_role.should == "A"
  end

  it "should set org:role" do
    XES::Event.new.tap{|x| x.org_role = "A"}.org_role.should == "A"
  end

  it "should get org:group" do
    XES::Event.new([XES.string("org:group", "A")]).org_group.should == "A"
  end

  it "should set org:group" do
    XES::Event.new.tap{|x| x.org_group = "A"}.org_group.should == "A"
  end

  it "should get time:timestamp" do
    Time.now.tap do |time|
      XES::Event.new([XES.date("time:timestamp", time)]).time_timestamp.should == time
    end
  end

  it "should set time:timestamp" do
    Time.now.tap do |time|
      XES::Event.new.tap{|x| x.time_timestamp = time}.time_timestamp.should == time
    end
  end

  it "should get semantic:modelReference" do
    XES::Event.new([XES.string("semantic:modelReference", "A")]).semantic_modelReference.should == "A"
  end

  it "should set semantic:modelReference" do
    XES::Event.new.tap{|x| x.semantic_modelReference = "A"}.semantic_modelReference.should == "A"
  end

  it "should get identity:id" do
    XES::Event.new([XES.id("identity:id", "A")]).identity_id.should == "A"
  end

  it "should set identity:id" do
    XES::Event.new.tap{|x| x.identity_id = "123456"}.identity_id.should == "123456"
  end

  it "should get cost:total" do
    XES::Event.new([XES.float("cost:total", 0.123)]).cost_total.should == 0.123
  end

  it "should set cost:total" do
    XES::Event.new.tap{|x| x.cost_total = 0.123}.cost_total.should == 0.123
  end

  it "should get cost:currency" do
    XES::Event.new([XES.string("cost:currency", "AUD")]).cost_currency.should == "AUD"
  end

  it "should set cost:total" do
    XES::Event.new.tap{|x| x.cost_currency = "AUD"}.cost_currency.should == "AUD"
  end

  it "should get attributes" do
    XES::Event.new([XES.string("concept:name", "A")]).attributes.should ==
      [XES.string("concept:name", "A")]
  end

  it "should format as XML" do
    XES::Event.new([XES.string("concept:name", "A")]).format.to_s.should ==
      "<event><string key='concept:name' value='A'/></event>"
  end
end
