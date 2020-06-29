Feature: Bundler Plugin
  @disable-bundler
  Scenario: Bundler plugin integration
    Given I use the fixture "sample-app"

    When I run `rake install`
    Then the output should match /bundler-toolbox \([^\)]+\) installed/

    And I run `bundle`
    Then the output should contain "Installed plugin bundler-toolbox"

    And I run `bundle toolbox`
    Then the output should contain "Bundler plugin integration works!"
