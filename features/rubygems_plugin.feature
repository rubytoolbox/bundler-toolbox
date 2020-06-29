Feature: Rubygems Plugin
  @disable-bundler
  Scenario: Rubygems plugin integration
    Given I use the fixture "sample-app"

    When I run `rake install`
    Then the output should match /bundler-toolbox \([^\)]+\) installed/

    And I run `gem toolbox version --info`
    Then the output should contain "bundler-toolbox v"
    And the output should contain "Execution environment: rubygems"
