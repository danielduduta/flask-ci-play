
def test_index_route(client):
    route = "/"
    expected = b"Glad to see you again"
    response = client.get(route)
    assert expected in response.data


def test_hello_route(client):
    route = "/hello"
    expected = b"Hello world!"
    response = client.get(route)
    assert expected in response.data
