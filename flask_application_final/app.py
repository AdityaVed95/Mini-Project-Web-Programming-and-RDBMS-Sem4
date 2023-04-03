from flask import Flask, render_template, url_for, request
from sql_queries import fetch_subjects, insert_student, fetch_student_details, fetch_textbook_from_db

app = Flask(__name__)

# run this on command line for deploying on cloud : 
# export FLASK_APP=app.py
# flask run --host=0.0.0.0 --port=5000

@app.route('/')
def home_fxn():
    temp = request.headers.get('User-Agent')
    if "iPhone" in temp or "Android" in temp:
        return "<html> <h1> This application is only supported for Desktop computers and not for mobile phones </h1> </html>"
    return render_template('home_template.html')


# navbar routes
@app.route('/faqs')
def faqs_fxn():
    return render_template('faqs_template.html')


@app.route('/contact')
def contact_fxn():
    return render_template('contact_template.html')


@app.route('/login', methods=['GET', 'POST'])
def login_fxn():
    if request.method == 'POST':
        return render_template('home_template.html')
    else:
        return render_template('login_template.html')


@app.route('/signup', methods=['GET', 'POST'])
def signup_fxn():
    if request.method == 'POST':
        return render_template('home_template.html')
    else:
        return render_template('signup_template.html')


# main routes

@app.route('/select_branch/<year>')
def branch_fxn(year):
    return render_template('branch_template.html', year=year.capitalize())


@app.route('/select_resource/<branch>')
def resource_fxn(branch):
    return render_template('resource_template.html', branch=branch.capitalize())


@app.route('/select_subject/<type>')
def subject_fxn(type):
    return render_template('subjects_template.html', type=type)


# testing whether python programs to interact with data base is working :

# fetch subject of corresponding year and department from database : 
@app.route('/test1/<correspondingYear>/<deptId>')
def test1_fxn(correspondingYear, deptId):
    operation_result = fetch_subjects.select_required_subjects(correspondingYear, deptId)
    return operation_result[1]


# create new entry of student in database
# demo : http://127.0.0.1:5000/test2/10/208/Aditya/aditya.ved@somaiya.edu/my_pass/5/1
@app.route('/test2/<studentId>/<rollNo>/<studentName>/<studentEmail>/<studentPassword>/<studentCurrentSem>/<deptId>')
def test2_fxn(studentId, rollNo, studentName, studentEmail, studentPassword, studentCurrentSem,deptId):
    result = insert_student.insert_student_into_db(studentId, rollNo, studentName, studentEmail, studentPassword,
                                                   studentCurrentSem,deptId)
    return result[1]


# fetching student info for profile page
@app.route('/test3/<studentId>')
def test3_fxn(studentId):
    result = fetch_student_details.get_student_details(studentId)
    return result[1]


# fetching textbooks for given subject
@app.route('/test4/<subjectId>')
def test4_fxn(subjectId):
    result = fetch_textbook_from_db.select_required_textbooks(subjectId)
    return result[1]


if __name__ == "__main__":
    app.run(debug=True)
