module Puppet::Parser::Functions

  newfunction(:validate_fact, :doc => <<-'ENDHEREDOC') do |args|
    Validate that the given fact's value matches any of the
    possible expected values given


    ENDHEREDOC

    unless args.length == 2
      raise Puppet::ParseError, "validate_fact: wrong number of arguments (#{args.length}); must be 2"
    end

    fact = args[0]
    value = lookupvar(fact)

    expected_values = Array(args[1])

    unless expected_values.member? value
      raise Puppet::Error, \
        "validate_fact(#{fact.inspect}): expected #{fact.inspect} to be one of #{expected_values.inspect}, got: '#{value}'"
    end

  end

end
