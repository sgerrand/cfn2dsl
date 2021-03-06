require_relative 'spec_helper'

describe Parameter do
  let(:cfn_file) {File.open("#{File.dirname(__FILE__)}/load-based-auto-scaling.json")}
  let(:cfn_json) {JSON.parse(cfn_file.read)}
  let(:name) {"InstanceType"}

  subject { Parameter.new(name, cfn_json['Parameters']['InstanceType'])}

  context("a known element") do
    it "includes the :default attribute with provided value" do
      expect(subject.default).to eq("m1.small")
    end
  end

  context("empty element") do
    it "excludes :allowed_pattern attribute" do
      expect(subject.allowed_pattern).to be_nil
    end
  end

  context("unknown element") do
    it "never set unknown attribute" do
      expect(subject.instance_variable_get('@foo')).to be_nil
    end
  end
end
