from flask import Flask,render_template,url_for,request

app=Flask(__name__)

@app.route('/')
def home_fxn():
    return render_template('home_template.html')

# navbar routes
@app.route('/faqs')
def faqs_fxn():
    return render_template('faqs_template.html')

@app.route('/contact')
def contact_fxn():
    return render_template('contact_template.html')    

@app.route('/login',methods=['GET','POST'])
def login_fxn():
    if request.method == 'POST':
        return render_template('home_template.html')
    else:
        return render_template('login_template.html')

@app.route('/signup',methods=['GET','POST'])
def signup_fxn():
    if request.method == 'POST':
        return render_template('home_template.html')
    else:
        return render_template('signup_template.html')


# main routes

@app.route('/select_branch/<year>')
def branch_fxn(year):
    return render_template('branch_template.html',year=year.capitalize())

@app.route('/select_resource/<branch>')    
def resource_fxn(branch):
    return render_template('resource_template.html',branch=branch.capitalize())
    
@app.route('/select_subject/<type>')
def subject_fxn(type):
    return render_template('subjects_template.html',type=type)

if __name__ ==  "__main__":
    app.run(debug=True)