### Containerized web app by python ###
- Prerequisite
    1. Install python-dotenv for external vairable references
        ```
        pip install python-dotenv
        ```
    2. Freeze and export current libraries for later consistent python runtime build in container
        ```
        pip freeze > requirement.txt
        ```
    3. Create flask_app.py
    4. Create dockerfile
        - Use official parent image, python:13.3-slim
        - Install system dependencies required for building Python packages, This is a common step for slim images.
            gcc (GNU Compiler Collection)
        - leverage gunicorn to host the web server


- docker-compose
    1. Why --build with docker-compose up?
        Normally, docker-compose up -d will:
        Build images only if they don’t exist yet. Otherwise, it reuses cached images.
        --build forces a rebuild of images, even if they exist.
            Use it if you’ve changed your Dockerfile or app code, and you want to ensure the latest build is used.