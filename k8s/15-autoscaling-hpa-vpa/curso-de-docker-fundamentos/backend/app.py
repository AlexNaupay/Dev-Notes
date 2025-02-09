from flask import Flask,jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/getMyInfo')
def getMyInfo():
    value = {
        "name": "Kubernetes",
        "lastname": "Orquestador",
        "socialMedia":
        {
            "facebookUser": "kubernetesio",
            "instagramUser": "cloudnativecomputingfoundation",
            "xUser": "K8sArchitect",
            "linkedin": "company/cloud-native-computing-foundation/",
            "githubUser": "kubernetes"
        },
        "blog": "https://kubernetes.io/",
        "author": "CNCF"
    }

    return jsonify(value)

if __name__ == '__main__':
    app.run(port=5001)