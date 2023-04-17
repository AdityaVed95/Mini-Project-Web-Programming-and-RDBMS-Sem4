# this fxn is useful when we want to get all the textbooks of
#  a given subject
# this fxn returns 1 and list of tuples (each tuple containing textbook
# details of a given textbook) for a legitimate input
# and returns 0 and error if incorrect subjectId is passed to it
# (0,error) is passed in tuple form

import psycopg2

def select_required_courses(subject_name,dept_name,year):
    connection = 0
    try:
        connection = psycopg2.connect(user="postgres",
                                    password="pass",
                                    host="127.0.0.1",
                                    port="5432",
                                    database="postgres",
                                    options="-c search_path=sy_mp,public")

        cursor = connection.cursor()

        if year == 'FY':
            postgreSQL_select_Query = "select course_name,course_link from sy_mp.online_courses where fk_subject_name ='"+subject_name+"' and fk_dept_name is null"

        else:
            postgreSQL_select_Query = "select course_name,course_link from sy_mp.online_courses where fk_subject_name ='"+subject_name+"' and fk_dept_name = '"+dept_name+"'"

        cursor.execute(postgreSQL_select_Query)
        textbook_details = cursor.fetchall()
        return 1, textbook_details


    except (Exception, psycopg2.Error) as error:
        return 0, "Error while fetching data from PostgreSQL "+ str(error)

    finally:
        # closing database connection.
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed") 

    