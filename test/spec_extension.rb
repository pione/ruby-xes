require 'xes'

describe "XES::Extension" do
  it "should equal" do
    XES::Extension.new("Concept", "concept", "http://www.xes-standard.org/concept.xesext").should ==
      XES::Extension.new("Concept", "concept", "http://www.xes-standard.org/concept.xesext")
  end

  it "shoud not equal" do
    XES::Extension.new("Concept", "concept", "http://www.xes-standard.org/concept.xesext").should !=
      XES::Extension.new("Identity", "identity", "http://www.xes-standard.org/identity.xesext")
  end

  it "should get the name" do
    XES::Extension.new("Concept", "concept", "http://www.xes-standard.org/concept.xesext").name.should == "Concept"
  end

  it "should get the prefix" do
    XES::Extension.new("Concept", "concept", "http://www.xes-standard.org/concept.xesext").prefix.should == "concept"
  end

  it "should be formattable" do
    XES::Extension.new("Concept", "concept", "http://www.xes-standard.org/concept.xesext").should.formattable
  end

  it "should be not formattable" do
    XES::Extension.new("Concept", "concept", nil).should.not.formattable
  end

  it "should get the uri" do
    XES::Extension.new("Concept", "concept", "http://www.xes-standard.org/concept.xesext").uri.should ==
      "http://www.xes-standard.org/concept.xesext"
  end
end
