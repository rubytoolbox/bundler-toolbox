Feature: Bundler Plugin
  Scenario: Bundler plugin integration
    When I run `rake install`
    And I run `bundle toolbox`
    Then the output should contain "Bundler plugin integration works!"
