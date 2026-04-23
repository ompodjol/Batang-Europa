from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/roster')
def roster():
    return render_template('roster.html')

@app.route('/schedule')
def schedule():
    return render_template('schedule.html')

@app.route('/gallery')
def gallery():
    return render_template('gallery.html')

@app.route('/register')
def register():
    return render_template('register.html')

if __name__ == '__main__':
    # Run on port 1981
    app.run(host='0.0.0.0', port=1981, debug=True)
