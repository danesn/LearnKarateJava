@Create
Feature: Articles

    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api/'
        * def credentials = call read('classpath:karate-credentials.js')

    Scenario: Create a new article
        Given path 'users/login'
        And request { "user": {"email": "#(credentials.email)","password": "#(credentials.password)"}}
        When method Post
        Then status 200