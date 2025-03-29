@Regression
Feature: Articles

    Background: Define URL
        Given url 'https://conduit-api.bondaracademy.com/api/'
        # * def tokenResponse = call read('classpath:helpers/CreateToken.feature')
        * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature') {"email": "bonkai@bonk.com","password": "bonkaibonkai998"}
        * def token = tokenResponse.authToken
    
    @Create
    Scenario: Create a new article
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"title": "bonkai131","description": "about6","body": "markdown6","tagList": ["tags6"]}}
        When method Post
        Then status 201
        And match response.article.title == "bonkai131"
        And match response.article.description == 'about6'
        And match response.article.body == 'markdown6'
        And match response.article.tagList == '#array'
        And match response.article.tagList == '#[1]'
        And match response.article.tagList contains ['tags6']
    
    @Delete
    Scenario: Create and Delete article
        Given header Authorization = 'Token ' + token
        And path 'articles'
        And request {"article": {"title": "bonkai132","description": "about6","body": "markdown6","tagList": ["tags6"]}}
        When method Post
        Then status 201
        And match response.article.slug == '#regex bonkai132.*'
        * def articleSlug = response.article.slug

        Given header Authorization = 'Token ' + token
        And path 'articles'
        And params { limit:10, offset: 0}
        When method Get
        Then status 200
        And match response.articles[0].title == 'bonkai132'

        Given header Authorization = 'Token ' + token
        And path 'articles', articleSlug
        When method Delete
        Then status 204

        Given path 'articles'
        And params { limit: 10, offset: 0 }
        When method Get
        Then status 200
        And match response.articles[0].title != 'bonkai132'

        Given path 'articles',articleSlug
        When method Get
        Then status 404