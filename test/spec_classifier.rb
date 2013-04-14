require 'xes'

describe "XES::Classifier" do
  it "should equal" do
    XES::Classifier.new("Event Name", "concept:name").should ==
      XES::Classifier.new("Event Name", "concept:name")
  end

  it "should not equal" do
    XES::Classifier.new("Event Name", "concept:name").should !=
      XES::Classifier.new("Resource", "org:resource")
  end

  it "should get the name" do
    XES::Classifier.new("Event Name", "concept:name").name.should == "Event Name"
  end

  it "should get the keys" do
    XES::Classifier.new("Event Name", "concept:name").keys.should == "concept:name"
  end

  it "should format as XML element" do
    XES::Classifier.new("Event Name", "concept:name").format.to_s.should ==
      "<classifier keys='concept:name' name='Event Name'/>"
  end
end
