# this fxn is useful when a new student creates their accoutn
# which is to added to the database 

import psycopg2

# this fxn returns 1,"1" tuple if the insertion was successful and 
#  0, error if it was not successful


def insert_student_into_db(studentId,rollNo,studentName,studentEmail,studentPassword,studentCurrentSem):

    try:
        connection = psycopg2.connect(user="postgres",
                                    password="pass",
                                    host="127.0.0.1",
                                    port="5432",
                                    database="flask_sem4_db",
                                    options="-c search_path=sy_mp,public")

        cursor = connection.cursor()

        postgreSQL_insert_Query = """
        
        insert into student 
        values(%s,%s,%s,%s,%s,%s)

        """

        record_to_insert = (studentId,rollNo,studentName,studentEmail,studentPassword,studentCurrentSem)

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
        
        

