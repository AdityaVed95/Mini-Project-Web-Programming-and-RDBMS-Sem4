from flask import Flask, render_template

app = Flask(__name__)

@app.get('/home')
def home_fxn():
    return render_template('home.html')