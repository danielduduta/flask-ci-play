import pytest

from ciplay.server import app


@pytest.fixture()
def fapp():
    app.config.update({"TESTING": True})
    return app

@pytest.fixture()
def client(fapp):
    return fapp.test_client()
