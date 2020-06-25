Feature: validate alphavantage time series daily api
  @test
  Scenario: Get alphavantage time series daily api
    Given Set HEADER param request content type as "application/json"
	And Set HEADER param response accept type as "application/json"
    When I raise "GET" HTTP request with endpoint "function=TIME_SERIES_DAILY&symbol=IBM&apikey=9K7P44NWI40PEBAK"
    And I retrieve the results
    Then the status code should be "200"
    And Response HEADER content type should be "application/json"

  Scenario Outline: validate the get call of alphavantage time series daily api
    Given Set HEADER param request content type as "application/json"
    And Set HEADER param response accept type as "application/json"
    When I raise "GET" HTTP request with endpoint "function=TIME_SERIES_DAILY&symbol=IBM&apikey=9K7P44NWI40PEBAK"
    And I retrieve the results
    Then the status code should be "200"
    And it should have the field "<name>"
    And request structure corresponds to the scheme "daily_time_series.schema"

    Examples:
      | name |
      |  Time Series (Daily)|

  Scenario: validate the get call of alphavantage time series daily api with output size full
    Given Set HEADER param request content type as "application/json"
    And Set HEADER param response accept type as "application/json"
    When I raise "GET" HTTP request with endpoint "function=TIME_SERIES_DAILY&symbol=IBM&outputsize=full&apikey=demo"
    Then the status code should be "200"

  Scenario: validate the get call of alphavantage time series daily api with datatype csv
    Given Set HEADER param request content type as "application/json"
    And Set HEADER param response accept type as "application/json"
    When I raise "GET" HTTP request with endpoint "function=TIME_SERIES_DAILY&symbol=IBM&apikey=demo&datatype=csv"
    Then the status code should be "200"

  @skip
  Scenario: Get alphavantage time series daily api when service is down
    Given Set HEADER param request content type as "application/json"
    And Set HEADER param response accept type as "application/json"
    When I raise "GET" HTTP request with endpoint "function=TIME_SERIES_DAILY&symbol=IBM&apikey=9K7P44NWI40PEBAK"
    Then the status code should be "500"

