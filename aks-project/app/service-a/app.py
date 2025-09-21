from flask import Flask, request, jsonify
import time, os
app = Flask(__name__)

@app.route("/health")
def health():
    return "OK", 200

@app.route("/")
def index():
    start = time.time()
    # simulate a tiny workload and occasional error
    if request.args.get("err") == "1":
        return jsonify({"error":"simulated"}), 500
    return jsonify({
        "message":"Hello from service-a",
        "pid": os.getpid(),
        "latency_ms": int((time.time()-start)*1000)
    })
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)

