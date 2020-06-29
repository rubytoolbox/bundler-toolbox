Feature: rubytoolbox CLI executable
  @disable-bundler
  Scenario: rubytoolbox CLI executable
    Given I use the fixture "sample-app"

    When I run `rake install`
    Then the output should match /bundler-toolbox \([^\)]+\) installed/

    And I run `rubytoolbox`
    Then the output should contain "Plain rubytoolbox executable works!"
