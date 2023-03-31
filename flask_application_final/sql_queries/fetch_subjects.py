# this fxn is useful when we want to get all the subjects of
#  a given year and department

# this fxn returns 1 and the list of tuples (each tuple
# containing subject details) for the correct input and returns
# 0 and the error in case of failed retreival of data
# (0,error) is passed in tuple form

import psycopg2


def select_required_subjects(correspondingYear, deptId):
    try:
        connection = psycopg2.connect(user="postgres",
                                      password="pass",
                                      host="127.0.0.1",
                                      port="5432",
                                      database="flask_sem4_db",
                                      options="-c search_path=sy_mp,public")

        cursor = connection.cursor()

        if (correspondingYear == "1"):
            postgreSQL_select_Query = "select * from sy_mp.subject where corresponding_year =" + correspondingYear

        else:
            postgreSQL_select_Query = "select * from sy_mp.subject where corresponding_year =" + correspondingYear + " and fk_dept_id = " + deptId

        cursor.execute(postgreSQL_select_Query)
        subject_details = cursor.fetchall()
        print("Yo")
        return 1, subject_details


    except (Exception, psycopg2.Error) as error:
        return 0, "Error while fetching data from PostgreSQL " + str(error)

    finally:
        # closing database connection.
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")
