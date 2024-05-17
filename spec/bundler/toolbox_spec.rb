# frozen_string_literal: true

RSpec.describe Bundler::Toolbox do
  it "has a version number" do
    expect(Bundler::Toolbox::VERSION).not_to be_nil
  end

  describe Bundler::Toolbox::FixtureAdapter do
    describe "#compare" do
      it "returns a project list containing a Rubytoolbox::Api::Project" do
        expect(described_class.new.compare("simplecov"))
          .to be_a(Array)
          .and have_attributes(size: 1)
          .and include(kind_of(Rubytoolbox::Api::Project))
      end

      it "returns expected project for known one" do
        expect(described_class.new.compare("simplecov").first)
          .to have_attributes(name: "simplecov")
      end

      it "ignores unknown projects" do
        expect(described_class.new.compare("foo", "unknown")).to be_a(Array)
          .and be_empty
      end
    end
  end

  describe ".adapter" do
    it "returns FixtureAdapter instance when given fixtures: false" do
      expect(described_class.adapter(fixtures: true)).to be_a described_class::FixtureAdapter
    end

    it "returns Rubytoolbox::Api instance when given fixtures: true" do
      expect(described_class.adapter(fixtures: false)).to be_a Rubytoolbox::Api
    end

    it "returns Rubytoolbox::Api instance when not passing fixtures flag" do
      expect(described_class.adapter).to be_a Rubytoolbox::Api
    end
  end

  describe ".compare" do
    it "requests compare for given projects for requested adapter instance" do
      adapter = instance_double described_class::FixtureAdapter

      allow(described_class).to receive(:adapter)
        .with(fixtures: "the argument")
        .and_return(adapter)

      expect(adapter).to receive(:compare).with("foo", "bar", "baz")

      described_class.compare "foo", "bar", "baz", fixtures: "the argument"
    end
  end
end
