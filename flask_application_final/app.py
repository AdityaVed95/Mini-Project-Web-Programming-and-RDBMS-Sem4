from flask import Flask, render_template, url_for, request, session, redirect, send_file
from sql_queries import fetch_subjects, insert_student, fetch_student_details, fetch_textbook_from_db, \
    fetch_no_of_modules, fetch_online_courses, fetch_kjsce_notes_module_data,fetch_student_notes_module_data
from flask_session import Session

app = Flask(__name__)

# run this on command line for deploying on cloud : 
# flask run --host=0.0.0.0 --port=5000

app.config["SESSION_PERMANENT"] = True
app.config["SESSION_TYPE"] = "filesystem"
Session(app)


@app.route('/')
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
@app.route('/home/faqs')
def faqs_fxn():
    if not session.get("studentId"):
        return redirect("/welcome")
    return render_template('faqs_template.html')


@app.route('/home/contact')
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

            if (result[1][0][3] == request.form.get("studentPassword")):
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

@app.route('/home/<year>')
def branch_fxn(year):
    if not session.get("studentId"):
        return redirect("/welcome")
    return render_template('branch_template.html', year=year)


@app.route('/home/<year>/<dept_name>')
def subject_fxn(year, dept_name):
    if not session.get("studentId"):
        return redirect("/welcome")
    result = fetch_subjects.select_required_subjects(year, dept_name)

    if (result[0] == 0):
        return redirect(url_for('branch_fxn', year=year))

    return render_template('subjects_template.html', year=year, dept_name=dept_name, subjects=result[1])


@app.route('/home/<year>/<dept_name>/<subject_name>')
def resource_fxn(year, dept_name, subject_name):
    if not session.get("studentId"):
        return redirect("/welcome")

    return render_template('resource_template.html', year=year, dept_name=dept_name, subject_name=subject_name)


@app.route('/home/<year>/<dept_name>/<subject_name>/<resource_name>')
def module_fxn(year, dept_name, subject_name, resource_name):
    if not session.get("studentId"):
        return redirect("/welcome")

    result = fetch_no_of_modules.get_no(subject_name)
    print("=========================")
    # print(result[1][0][0])

    # (1,[('n1',30),('n2',56)])
    # (0,'Error')

    # result[0] == 0:
    #     unsucusseceful

    return render_template('module_template.html', year=year, dept_name=dept_name, subject_name=subject_name,
                           no_of_modules=int(result[1][0][0]), resource_name=resource_name)


@app.route('/home/<year>/<dept_name>/<subject_name>/textbook')
def textbook_fxn(year, dept_name, subject_name):
    if not session.get("studentId"):
        return redirect("/welcome")

    result = fetch_textbook_from_db.select_required_textbooks(subject_name, dept_name, year)
    print(result)
    return render_template('textbook_template.html', result=result[1], subject_name=subject_name)


@app.route('/home/<year>/<dept_name>/<subject_name>/Online_Courses')
def course_fxn(subject_name, dept_name, year):
    if not session.get("studentId"):
        return redirect("/welcome")

    result = fetch_online_courses.select_required_courses(subject_name, dept_name, year)
    return render_template('online_courses.html', result=result[1], subject_name=subject_name)


# @app.route('/home/<year>/<dept_name>/<subject_name>/<resource_name>/<path:filename>')
# def download_kjsce_notes_fxn():
#     uploads = os.path.join(current_app.root_path, app.config['UPLOAD_FOLDER'])
#     return send_from_directory(directory=uploads, filename=filename)

@app.route('/download/<path:file_path>')
def download_fxn(file_path):
    # file_path = './static/page.jpg'
    print(file_path)
    return send_file(file_path, as_attachment=True)


@app.route('/home/<year>/<dept_name>/<subject_name>/<resource_name>/<module_no>')
def module_data_fxn(year, dept_name, subject_name, resource_name, module_no):
    if not session.get("studentId"):
        return redirect("/welcome")

    if resource_name == "kjsce_notes":
        result = fetch_kjsce_notes_module_data.select_required_module_data(subject_name, dept_name, module_no, year)

    else:
        result = fetch_student_notes_module_data.select_required_module_data(subject_name, dept_name, module_no, year)

    # print(result)
    if result[0] == 0:
        return render_template('problem_template.html')

    return render_template('module_data_template.html', result=result[1])


@app.route('/home/profile')
def profile_fxn():
    if not session.get("studentId"):
        return redirect("/welcome")

    result = fetch_student_details.get_student_details(session.get("studentId"))

    return render_template("profile.html", result=result[1])
    # return render_template('profile_template.html',session.get('studentId'))


if __name__ == "__main__":
    app.run(debug=True)

# # testing whether python programs to interact with data base is working :

# # fetch subject of corresponding year and department from database : 
# @app.route('/test1/<correspondingYear>/<deptId>')
# def test1_fxn(correspondingYear, deptId):
#     operation_result = fetch_subjects.select_required_subjects(correspondingYear, deptId)
#     return operation_result[1]


# # create new entry of student in database
# # demo : http://127.0.0.1:5000/test2/10/208/Aditya/aditya.ved@somaiya.edu/my_pass/5/1
# @app.route('/test2/<studentId>/<rollNo>/<studentName>/<studentEmail>/<studentPassword>/<studentCurrentSem>/<deptId>')
# def test2_fxn(studentId, rollNo, studentName, studentEmail, studentPassword, studentCurrentSem, deptId):
#     result = insert_student.insert_student_into_db(studentId, rollNo, studentName, studentEmail, studentPassword,
#                                                    studentCurrentSem, deptId)
#     return result[1]


# # fetching student info for profile page
# @app.route('/test3/<studentId>')
# def test3_fxn(studentId):
#     result = fetch_student_details.get_student_details(studentId)
#     return result[1]


# # fetching textbooks for given subject
# @app.route('/test4/<subjectId>')
# def test4_fxn(subjectId):
#     result = fetch_textbook_from_db.select_required_textbooks(subjectId)
#     return result[1]


# if __name__ == "__main__":
#     app.run(debug=True)

# @app.route('/test_module/<subject_id>')
# def test_module_fxn(subject_id):
#     result = fetch_no_of_modules.get_no(subject_id)
#     print(result)
#     print (result[1][0][0])
#     return("hello")
