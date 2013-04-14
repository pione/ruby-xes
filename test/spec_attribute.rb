require 'xes'

describe "XES::Attribute" do
  it "should equal" do
    XES::Attribute.new("string", "concept:name", "A").should ==
      XES::Attribute.new("string", "concept:name", "A")
  end

  it 'should not equal' do
    XES::Attribute.new("string", "concept:name", "A").should !=
      XES::Attribute.new("string", "concept:name", "B")
  end

  it 'should make string attribute' do
    XES.string("concept:name", "A").should ==
      XES::Attribute.new("string", "concept:name", "A")
  end

  it 'should make date attribute' do
    Time.now.tap do |time|
      XES.date("time:timestamp", time).should ==
        XES::Attribute.new("date", "time:timestamp", time)
    end
  end

  it 'should make int attribute' do
    XES.int("counter", 123).should ==
      XES::Attribute.new("int", "counter", 123)
  end

  it 'should make float attribute' do
    XES.float("counter", 0.123).should ==
      XES::Attribute.new("float", "counter", 0.123)
  end

  it 'should make boolean attribute' do
    XES.boolean("truth", true).should ==
      XES::Attribute.new("boolean", "truth", true)
  end

  it 'should make id attribute' do
    XES.id("identity:id", "123").should ==
      XES::Attribute.new("id", "identity:id", "123")
  end

  it 'should get the type' do
    XES::Attribute.new("string", "concept:name", "A").type.should == "string"
  end

  it 'should get the key' do
    XES::Attribute.new("string", "concept:name", "A").key.should == "concept:name"
  end

  it 'should get the value' do
    XES::Attribute.new("string", "concept:name", "A").value.should == "A"
  end

  it 'should get meta attributes' do
    XES::Attribute.new("string", "concept:name", "A").tap do |x|
      x.meta << XES::Attribute.new("string", "meta", "1")
    end.meta.should == [XES::Attribute.new("string", "meta", "1")]
  end

  it 'should get identity:id' do
    XES::Attribute.new("string", "concept:name", "A").tap do |x|
      x.meta << XES::Attribute.new("id", "identity:id", "123456")
    end.identity_id.should == "123456"
  end

  it 'should set identity:id' do
    XES::Attribute.new("string", "concept:name", "A").tap do |x|
      x.identity_id = "test"
    end.identity_id.should == "test"
  end

  it "should get cost:amount" do
    XES.string("concept:name", "A").tap do |x|
      x.meta << XES.float("cost:amount", 0.123)
    end.cost_amount.should == 0.123
  end

  it "should set cost:amount" do
    XES.string("concept:name", "A").tap do |x|
      x.cost_amount = 0.123
    end.cost_amount.should == 0.123
  end

  it "should get cost:driver" do
    XES.string("concept:name", "A").tap do |x|
      x.meta << XES.string("cost:driver", "xyz123")
    end.cost_driver.should == "xyz123"
  end

  it "should set cost:driver" do
    XES.string("concept:name", "A").tap do |x|
      x.cost_driver = "xyz123"
    end.cost_driver.should == "xyz123"
  end

  it "should get cost:type" do
    XES.string("concept:name", "A").tap do |x|
      x.meta << XES.string("cost:type", "Fixed Overhead")
    end.cost_type.should == "Fixed Overhead"
  end

  it "should set cost:driver" do
    XES.string("concept:name", "A").tap do |x|
      x.cost_type = "Fixed Overhead"
    end.cost_type.should == "Fixed Overhead"
  end

  it 'should format string attribute as XML' do
    XES.string("concept:name", "A").format.to_s.should ==
      "<string key='concept:name' value='A'/>"
  end

  it 'should format date attribute as XML' do
    Time.now.tap do |time|
      XES.date("time:timestamp", time).format.to_s.should ==
        "<date key='time:timestamp' value='%s'/>" % time.iso8601
    end
  end

  it 'should format int attribute as XML' do
    XES.int("counter", 123).format.to_s.should ==
      "<int key='counter' value='123'/>"
  end

  it 'should format float attribute as XML' do
    XES.float("counter", 0.123).format.to_s.should ==
      "<float key='counter' value='0.123'/>"
  end

  it 'should format boolean attribute as XML' do
    XES.boolean("truth", true).format.to_s.should ==
      "<boolean key='truth' value='true'/>"
  end

  it 'should format id attribute as XML' do
    XES.id("identity:id", "123456").format.to_s.should ==
      "<id key='identity:id' value='123456'/>"
  end

  it 'should format attribute with meta attribute as XML' do
    XES.string("concept:name", "A").tap do |x|
      x.identity_id = "123456"
    end.format.to_s.should ==
      "<string key='concept:name' value='A'><id key='identity:id' value='123456'/></string>"
  end
end
