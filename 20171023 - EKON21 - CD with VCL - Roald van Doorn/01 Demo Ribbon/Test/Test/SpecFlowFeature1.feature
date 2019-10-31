Feature: SpecFlowFeature1
	In order to avoid silly mistakes
	As a user
	I want to be told which button I clicked

@mytag
Scenario: Verify button
	Given I have am on Tab2
	When I click button2
	Then the label should say button2clicked
