Feature: SpecFlowFeature1
	In order to avoid silly mistakes
	As a user
	I want to be told which button I clicked

@mytag
Scenario Outline: Verify button
	Given I am on <tab>
	When I click <button>
	Then the label should say <buttonclicked>

Examples:
| tab | button | buttonclicked |
| 2   | 2      | 2             |
| 1   | 1      | 1             |



