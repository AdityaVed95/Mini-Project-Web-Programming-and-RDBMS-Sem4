from flask import Flask, render_template, url_for, request, session, redirect
from sql_queries import fetch_subjects, insert_student, fetch_student_details, fetch_textbook_from_db
from flask_session import Session

app = Flask(__name__)

# run this on command line for deploying on cloud : 
# flask run --host=0.0.0.0 --port=5000

app.config["SESSION_PERMANENT"] = True
app.config["SESSION_TYPE"] = "filesystem"
Session(app)


@app.route('/welcome')
def welcome_fxn():
    temp = request.headers.get('User-Agent')
    if "iPhone" in temp or "Android" in temp:
        return "<html> <h1> This application is only supported for Desktop computers and not for mobile phones </h1> </html>"
    return render_template('welcome.html')


@app.route('/home')
def home_fxn():
    if not session.get("studentId"):
        print("session establish failure")
        return redirect("/welcome")

    return render_template('home_template.html')


# navbar routes
@app.route('/faqs')
def faqs_fxn():
    if not session.get("studentId"):
        return redirect("/welcome")
    return render_template('faqs_template.html')


@app.route('/contact')
def contact_fxn():
    if not session.get("studentId"):
        return redirect("/welcome")
    return render_template('contact_template.html')


@app.route('/login', methods=['GET', 'POST'])
def login_fxn():
    if request.method == 'POST':
        result = fetch_student_details.get_student_details(request.form.get("studentId"))
        # successful authentication
        if result[0] == 1:

            if(result[1][0][3]==request.form.get("studentPassword")):
                session["studentId"] = request.form.get("studentId")
                return redirect(url_for('home_fxn'))
            
            else:
                return render_template('login_fail.html', result=result)
                
        else:
            return render_template('login_fail.html', result=result)

        # return render_template('home_template.html')
    else:
        return render_template('login_template.html')


@app.route('/signup', methods=['GET', 'POST'])
def signup_fxn():
    if request.method == 'POST':
        result = insert_student.insert_student_into_db(request.form.get("studentId"), request.form.get("studentName"),
                                                       request.form.get("studentEmail"),
                                                       request.form.get("studentPassword"),
                                                       request.form.get("studentCurrentSem"))

        return render_template('signup_success_fail.html', result=result)

    else:
        return render_template('signup_template.html')


@app.route("/logout")
def logout_fxn():
    session["studentId"] = None
    return redirect("/welcome")

# main routes

@app.route('/select_branch/<year>')
def branch_fxn(year):
    if not session.get("studentId"):
        return redirect("/welcome")
    return render_template('branch_template.html', year=year.capitalize())


@app.route('/select_resource/<branch>')
def resource_fxn(branch):
    if not session.get("studentId"):
        return redirect("/welcome")
    return render_template('resource_template.html', branch=branch.capitalize())


@app.route('/select_subject/<type>')
def subject_fxn(type):
    if not session.get("studentId"):
        return redirect("/welcome")
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
def test2_fxn(studentId, rollNo, studentName, studentEmail, studentPassword, studentCurrentSem, deptId):
    result = insert_student.insert_student_into_db(studentId, rollNo, studentName, studentEmail, studentPassword,
                                                   studentCurrentSem, deptId)
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
