@Regression
Feature: Articles

    Background: Define URL
        Given url apiUrl
        * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
        * def token = tokenResponse.authToken
    
    @Create
    Scenario: Create a new article
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"title": "bonkai146","description": "about6","body": "markdown6","tagList": ["tags6"]}}
        When method Post
        Then status 201
        And match response.article.title == "bonkai146"
        And match response.article.description == 'aboutc6'
        And match response.article.body == 'markdown6'
        And match response.article.tagList == '#array'
        And match response.article.tagList == '#[1]'
        And match response.article.tagList contains ['tags6']
    
    @debug
    Scenario: Create and Delete article
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"title": "bonkai153","description": "about6","body": "markdown6","tagList": ["tags6"]}}
        When method Post
        Then status 201
        And match response.article.slug == '#regex bonkai153.*'
        * def articleSlug = response.article.slug

        Given header Authorization = 'Token ' + token
        And path 'articles'
        And params { limit:10, offset: 0}
        When method Get
        Then status 200
        And match response.articles[0].title == 'bonkai153'

        Given header Authorization = 'Token ' + token
        And path 'articles', articleSlug
        When method Delete
        Then status 204

        Given path 'articles'
        And params { limit: 10, offset: 0 }
        When method Get
        Then status 200
        And match response.articles[0].title != 'bonkai153'

        Given path 'articles',articleSlug
        When method Get
        Then status 404