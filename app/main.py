from fastapi import FastAPI, Request
from datetime import datetime
import uvicorn
from mangum import Mangum

# Create the FastAPI app inside a function to delay initialization
def create_app():
    app = FastAPI(title="SimpleTimeService")

    @app.get("/")
    async def get_time_and_ip(request: Request):
        client_ip = request.client.host
        return {
            "timestamp": datetime.now().isoformat(),
            "ip": client_ip
        }

    return app

# Only create the app when needed
app = create_app()
handler = Mangum(app)

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000)
