Feature: CAMARA Common Artifact C02 - Test scenarios for phoneNumber errors

    Common error scenarios for POST operations with phoneNumber as input either in the request
    body or implied from the access.

    Artifact parameters (to be replaced by values according to the API operation):
    
    - {{feature_identifier}} 

    This is not a complete feature but a collection of scenarios that can be applied
    with minor modifications to test plans.

    These scenarios assume that other properties not explicitly mentioned in the scenario
    are set by default to a valid value. This can be specified in the feature Background.


    # Error scenarios for management of input parameter phoneNumber

    # If the access token identifies a phone number, error 422 UNNECESSARY_DEVICE may be returned instead
    @{{feature_identifier}}_C02.01_phone_number_not_schema_compliant
    Scenario: Phone number value does not comply with the schema
        Given the header "Authorization" is set to a valid access which does not identifiy a single phone number
        And the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
        When the HTTP "POST" request is sent
        Then the response status code is 400
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

   
    # This scenario may happen e.g. with 2-legged access tokens, which do not identify a single phone number.
    @{{feature_identifier}}_C02.02_phone_number_not_found
    Scenario: Phone number not found
        Given the header "Authorization" is set to a valid access which does not identifiy a single phone number
        And the request body property "$.phoneNumber" is compliant with the schema but does not identify a valid phone number
        When the HTTP "POST" request is sent
        Then the response status code is 404
        And the response property "$.status" is 404
        And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
        And the response property "$.message" contains a user friendly text


    @{{feature_identifier}}_C02.03_unnecessary_phone_number
    Scenario: Phone number not to included when can be deducted from the access token
        Given the header "Authorization" is set to a valid access token identifying a phone number
        And  the request body property "$.phoneNumber" is set to a valid phone number
        When the HTTP "POST" request is sent
        Then the response status code is 403
        And the response property "$.status" is 422
        And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
        And the response property "$.message" contains a user friendly text


    @{{feature_identifier}}_C02.04_unidentifiable_device
    Scenario: Phone number not included and cannot be deducted from the access token
        Given the header "Authorization" is set to a valid access which does not identifiy a single phone number
        And the request body property "$.phoneNumber" is not included
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "MISSING_IDENTIFIER"
        And the response property "$.message" contains a user friendly text


    # When the service is only offered to certain type of subcriptions, e.g. IoT, , B2C, etc
    @{{feature_identifier}}_C02.05_phone_number_not_supported
    Scenario: Service not available for the phone number
        Given that the service is not available for all phone numbers commercialized by the operator
        And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
        When the HTTP "POST" request is sent
        Then the response status code is 422
        And the response property "$.status" is 422
        And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
        And the response property "$.message" contains a user friendly text
