@Regression
Feature: Articles

    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api/'
        * def credentials = call read('classpath:karate-credentials.js')
        And path 'users/login'
        And request { "user": {"email": "#(credentials.email)","password": "#(credentials.password)"}}
        When method Post
        Then status 200
        * def token = response.user.token 

    Scenario: Create a new article
    
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"title": "pulkanarticle6","description": "about6","body": "markdown6","tagList": ["tags6"]}}
        When method Post
        Then status 201
        And match response.article.title == 'pulkanarticle6'
        And match response.article.description == 'about6'
        And match response.article.body == 'markdown6'
        And match response.article.tagList == '#array'
        And match response.article.tagList == '#[1]'
        And match response.article.tagList contains ['tags6']
