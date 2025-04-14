import pytest
from fastapi.testclient import TestClient
from unittest.mock import patch
import sys
import os

# Get the absolute path to the app directory
app_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'app'))

# Add it to the Python path
if app_path not in sys.path:
    sys.path.insert(0, app_path)

# Now import the main module directly
from main import app

client = TestClient(app)

def test_get_time_and_ip():
    """Test that the root endpoint returns a JSON with timestamp and IP."""
    response = client.get("/")
    assert response.status_code == 200
    data = response.json()
    assert "timestamp" in data
    assert "ip" in data
    
@patch("main.datetime")
def test_timestamp_format(mock_datetime):
    """Test that the timestamp is in ISO format."""
    # Mock the datetime to return a fixed value
    mock_datetime.now.return_value.isoformat.return_value = "2023-09-15T12:00:00"
    
    response = client.get("/")
    data = response.json()
    assert data["timestamp"] == "2023-09-15T12:00:00"

def test_ip_address():
    """Test that the IP address is returned correctly."""
    # The TestClient uses 'testclient' as the default IP
    response = client.get("/")
    data = response.json()
    assert data["ip"] == "testclient"
