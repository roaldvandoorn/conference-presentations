Feature: HelloWorld
	As a programming idiot
	I want to be told hello world
	so I can avoid silly mistakes
	
@mytag
Scenario: Hello World
	Given the application is started
	When I click the Hello world button
	Then the label should show Hello World

Scenario: Clear World
	Given the application is started
	And  the Hello World text is visible
	When I click the Clear button
	Then the label is empty