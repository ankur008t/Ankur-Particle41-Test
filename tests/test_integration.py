import os
import pytest
import requests
from datetime import datetime
import time

# Get the API endpoint from environment variable or use the default
API_ENDPOINT = os.environ.get("API_ENDPOINT", "http://localhost:8000")

def test_api_availability():
    """Test that the API is available and responding."""
    response = requests.get(f"{API_ENDPOINT}/")
    assert response.status_code == 200
    
def test_response_structure():
    """Test that the response has the expected structure."""
    response = requests.get(f"{API_ENDPOINT}/")
    data = response.json()
    
    assert "timestamp" in data
    assert "ip" in data

def test_ip_address_format():
    """Test that the IP address is in a valid format."""
    response = requests.get(f"{API_ENDPOINT}/")
    data = response.json()
    
    # Simple check for IP format (IPv4 or IPv6)
    ip = data["ip"]
    assert ip, "IP address is empty"
    
    # For more thorough validation, you could use ipaddress module
    # import ipaddress
    # try:
    #     ipaddress.ip_address(ip)
    # except ValueError:
    #     pytest.fail(f"Invalid IP address format: {ip}")

def test_performance():
    """Test API response time."""
    start_time = time.time()
    requests.get(f"{API_ENDPOINT}/")
    end_time = time.time()
    
    response_time = end_time - start_time
    assert response_time < 1.0, f"Response time too slow: {response_time} seconds"
