# fetches the _no_of_modules_of_a_given subject

from sql_queries import connection_fxn 


def get_no(subject_name):
    connection = 0
    try:
        cursor=connection_fxn.make_connection()

        postgreSQL_select_Query = "select no_of_modules from sy_mp.subject where subject_name ='" + subject_name +"'"
        
        cursor.execute(postgreSQL_select_Query)
        student_details = cursor.fetchall()
        return 1, student_details


    except (Exception, psycopg2.Error) as error:
        return (0, "Error while fetching data from PostgreSQL " + str(error))

    finally:
        # closing database connection.
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")
