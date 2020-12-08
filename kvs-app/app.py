from flask import Flask, render_template, redirect, url_for, request
from utils import format
from utils.db import DataBase

db = DataBase()

app = Flask(__name__, template_folder='templates')

@app.route("/")
def index():
    table = format.to_table_rows(db.get_all())
    return render_template('index.html', key_value_pairs = table)

@app.route("/put", methods = ['POST'])
def put():
    key = request.form['key']
    value = request.form['value']

    if key.strip() != "" and value.strip() != "" and db.find(key) == None:
        db.insert(key, value)

    return redirect(url_for('index'))

@app.route("/get", methods = ['POST'])
def get():
    key = request.form['key']

    value = db.find(key)

    return format.to_search_result(key, value)

@app.route("/remove/<key>")
def remove(key):
    db.remove(key)
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(host = "0.0.0.0", debug = True)
