# this fxn is useful when a new student creates their accoutn
# which is to added to the database 

from sql_queries import connection_fxn 

# this fxn returns 1,"1" tuple if the insertion was successful and 
#  0, error if it was not successful


def insert_student_into_db(studentId,studentName,studentEmail,studentPassword,studentCurrentSem):
    connection = 0
    try:
        cursor=connection_fxn.make_connection()

        postgreSQL_insert_Query = """
        
        insert into student 
        values(%s,%s,%s,%s,%s)

        """

        record_to_insert = (studentId,studentName,studentEmail,studentPassword,studentCurrentSem)

        cursor.execute(postgreSQL_insert_Query,record_to_insert)
        
        connection.commit()

        return 1,"1"

    except (Exception, psycopg2.Error) as error:
        return 0,"Error while inserting data into PostgreSQL : "+ str(error)
        

    finally:
        # closing database connection.
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")
        
        

