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
    
    @Create
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
    
    @Delete
    Scenario: Create and Delete article
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"title": "pulkanarticle13","description": "about6","body": "markdown6","tagList": ["tags6"]}}
        When method Post
        Then status 201
        And match response.article.slug == '#regex pulkanarticle13.*'
        * def articleSlug = response.article.slug

        Given header Authorization = 'Token ' + token
        And path 'articles'
        And params { limit:10, offset: 0}
        When method Get
        Then status 200
        And match response.articles[0].title == 'pulkanarticle13'

        Given header Authorization = 'Token ' + token
        And path 'articles', articleSlug
        When method Delete
        Then status 204

        Given path 'articles'
        And params { limit: 10, offset: 0 }
        When method Get
        Then status 200
        And match response.articles[0].title != 'pulkanarticle13'

        Given path 'articles',articleSlug
        When method Get
        Then status 404