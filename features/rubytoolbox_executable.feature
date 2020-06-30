Feature: rubytoolbox CLI executable
  @disable-bundler
  Scenario: rubytoolbox CLI executable
    Given I use the fixture "sample-app"

    When I run `rake install`
    Then the output should match /bundler-toolbox \([^\)]+\) installed/

    And I run `rubytoolbox version --info`
    Then the output should contain "bundler-toolbox v"
    And the output should contain "Execution environment: standalone"
