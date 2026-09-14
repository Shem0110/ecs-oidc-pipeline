import os

from flask import Flask, jsonify

app = Flask(__name__)
COMMIT = os.environ.get("GIT_SHA", "local-dev")


@app.get("/")
def index():
    return jsonify(
        message="Deployed by GitHub Actions using OIDC. No stored AWS keys. Deployed from Singapore.",
        commit=COMMIT,
    )


@app.get("/healthz")
def healthz():
    return jsonify(status="ok"), 200
