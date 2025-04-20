@Regression
Feature: Articles

    Background: Define URL
        Given url apiUrl
    
    @Create
    Scenario: Create a new article
        And path 'articles'
        And request {"article": {"title": "bonkai163","description": "about6","body": "markdown6","tagList": ["tags6"]}}
        When method Post
        Then status 201
        And match response.article.title == "bonkai163"
        And match response.article.description == 'about6'
        And match response.article.body == 'markdown6'
        And match response.article.tagList == '#array'
        And match response.article.tagList == '#[1]'
        And match response.article.tagList contains ['tags6']
    
    @debug
    Scenario: Create and Delete article
        And path 'articles'
        And request {"article": {"title": "bonkai164","description": "about6","body": "markdown6","tagList": ["tags6"]}}
        When method Post
        Then status 201
        And match response.article.slug == '#regex bonkai164.*'
        * def articleSlug = response.article.slug

        And path 'articles'
        And params { limit:10, offset: 0}
        When method Get
        Then status 200
        And match response.articles[0].title == 'bonkai164'

        And path 'articles', articleSlug
        When method Delete
        Then status 204

        Given path 'articles'
        And params { limit: 10, offset: 0 }
        When method Get
        Then status 200
        And match response.articles[0].title != 'bonkai164'

        Given path 'articles',articleSlug
        When method Get
        Then status 404