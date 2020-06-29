Feature: Rubygems Plugin
  @disable-bundler
  Scenario: Rubygems plugin integration
    Given I use the fixture "sample-app"

    When I run `rake install`
    Then the output should match /bundler-toolbox \([^\)]+\) installed/

    And I run `gem toolbox`
    Then the output should contain "Rubygems plugin integration works!"
