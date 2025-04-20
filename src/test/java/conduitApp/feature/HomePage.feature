@Debug
Feature: Test for the home page

    Background: Define URL
        Given url apiUrl
        * configure headers = { } // Remove Global Set Auth Token

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['GitHub', 'Git']
        And match response.tags contains any ['noway', 'asdasdsad', 'Exam']
        And match response.tags !contains ['Popo']
        And match response.tags == '#array'
        And match each response.tags == '#string'

    Scenario: Get 10 articles from the page
        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#array'
        And match response.articles == '#[10]'
        And match response.articlesCount == 10
        And match response.articles[0].createdAt contains '2024'
        And match response.articles[*].favoritesCount contains 21
        And match response..bio contains null
        And match each response..following == false