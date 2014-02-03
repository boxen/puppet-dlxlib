require "spec_helper"

describe Puppet::Parser::Functions.function(:validate_fact) do

  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  describe "when calling validate_fact from puppet" do

    it "should not compile with too many args" do
      Puppet[:code] = <<-EOC
        validate_fact('waynes_world')
      EOC

      expect {
        scope.compiler.compile
      }.to raise_error(Puppet::ParseError, /validate_fact: wrong number of arguments \(1\); must be 2/)

    end

    it "should not compile with too few args" do
      Puppet[:code] = <<-EOC
        validate_fact('waynes_world', 'party on wayne', 'party on garth')
      EOC

      expect {
        scope.compiler.compile
      }.to raise_error(Puppet::ParseError, /validate_fact: wrong number of arguments \(3\); must be 2/)

    end

    it "should not compile when the fact doesn't match" do
      Puppet[:code] = <<-EOC
        # let's pretend this isn't just a scope lookup
        $waynes_world = 'party on garth'
        validate_fact('waynes_world', 'party on wayne')
      EOC

      expect {
        scope.compiler.compile
      }.to raise_error(Puppet::Error, /validate_fact\("waynes_world"\): expected "waynes_world" to be one of \["party on wayne"\], got: 'party on garth'/)
    end

    it "should compile if the fact matches any of the EVs" do
      Puppet[:code] = <<-EOC
        # let's pretend this isn't just a scope lookup
        $waynes_world = 'party on wayne'
        validate_fact('waynes_world', ['party on wayne', 'party on garth'])
      EOC

      scope.compiler.compile
    end

  end
end
