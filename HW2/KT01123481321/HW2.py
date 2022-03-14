from flask import Flask, render_template, request
import pandas as pd
import joblib

app = Flask(__name__, static_folder="static")


def getPressure(age, weight):
    clf = joblib.load("regr.pkl")
    x = pd.DataFrame([[age, weight]], columns=["Age", "Weight"])
    return clf.predict(x)[0]


@app.route("/", methods=["POST", "GET"])
def bloodPressure():
    age = ""
    weight = ""
    pressure = ""
    if request.method == "POST":
        age = request.form["age"]
        weight = request.form["weight"]
        pressure = getPressure(int(age), int(weight))
    return render_template("HW2.html", age=age, weight=weight, pressure=pressure)


app.run()
