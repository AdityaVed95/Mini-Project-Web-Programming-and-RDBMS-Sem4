# this fxn is useful when a user wishes to see the their personal
# details on their profile page

# this fxn returns 1 and the student details for the correct input and returns
# 0 and the error in case of failed retreival of data

from sql_queries import connection_fxn 

def get_student_details(studentId):
    connection = 0
    try:
        cursor=connection_fxn.make_connection()
        postgreSQL_select_Query = "select * from sy_mp.student where student_id ='" + studentId + "'"
        # 'select * from sy_mp.student where student_id =id2'
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
