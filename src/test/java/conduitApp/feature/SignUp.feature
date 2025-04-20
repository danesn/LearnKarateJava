Feature: Sign Up

    Background: 
        Given url apiUrl

    @RegisterUser
    Scenario: Register new a User
        Given def userData = {"email": "testerd11@popo.com", "username": "testerd11"}
        And path 'users'
        And request
        """
            {
                "user": {
                    "email": #(userData.email),
                    "password": "qwerty12345",
                    "username": #(userData.username)
                }
            }
        """
        When method Post
        Then status 201
        And match response.user.email == userData.email
        And match response.user.username == userData.username
        And match response.user.token == "#string"
        And match response.user.token != null
