import json
import os
import requests
from jsonschema import validate
from behave import given, when, then, step

BASE_URL = 'http://www.alphavantage.co/query?'
SCHEMA_PATH = os.getcwd() + '/Schema/'
http_request_header = {}
http_request_body = {}
global_general_variables = {}


@when('I retrieve the results')
def step_impl(context):
    context.status_code = global_general_variables['response_full'].status_code
    context.data = global_general_variables['response_full'].json()


@given('Set HEADER param request content type as "{header_content_type}"')
def step_impl(context, header_content_type):
    http_request_header['content-type'] = header_content_type


@given('Set HEADER param response accept type as "{header_accept_type}"')
def step_impl(context, header_accept_type):
    http_request_header['Accept'] = header_accept_type


@then('the status code should be "{status_code}"')
def step_impl(context, status_code):
    assert (int(global_general_variables['response_full'].status_code) == int(status_code))


@when('I Raise "{http_request_type}" HTTP request with endpoint "{endpoint}"')
def step_impl(context, http_request_type, endpoint):
    end_url = BASE_URL
    if 'GET' == http_request_type:
        end_url += endpoint
        global_general_variables['response_full'] = requests.get(end_url)
    elif 'POST' == http_request_type:
        global_general_variables['response_full'] = requests.post(end_url,
                                                                  headers=http_request_header,
                                                                  data=http_request_body)


@then('Response HEADER content type should be "{expected_response_content_type}"')
def step_impl(context, expected_response_content_type):
    assert (expected_response_content_type == global_general_variables['response_full'].headers['Content-Type'])


@then('it should have the field "{field}"')
def step_impl(context, field):
    assert (field in context.data)


@then('request structure corresponds to the scheme "{schema_file}"')
def step_impl(context, schema_file):
    with open(SCHEMA_PATH + schema_file, 'r', encoding='utf-8') as f:
        file = json.load(f)
        validate(context.data, file)
