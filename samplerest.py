import flask

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods=['GET'])
def home():
    return "<h1>VIA GET response check assignment</h1><p>I am absolutely healthy</p>"

app.run(host='0.0.0.0')
