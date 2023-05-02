from sql_queries import connection_fxn 
import psycopg2
def delete_required_kjsce_note(subject_name,dept_name,year,kjsce_note_name):
    connection = 0
    try:
        connection=connection_fxn.make_connection()
        cursor=connection.cursor()

        if year == 'FY':
             sql_delete_query = "Delete from sy_mp.kjsce_notes where fk_subject_name = '"+ subject_name + "' and fk_dept_name is null and kjsce_note_name = '"+ kjsce_note_name + "' "

        else:
            sql_delete_query = "Delete from sy_mp.kjsce_notes where fk_subject_name ='"+ subject_name + "' and fk_dept_name = '"+ dept_name + "' and kjsce_note_name = '"+ kjsce_note_name + "' "

        cursor.execute(sql_delete_query, (subject_name,dept_name,year,kjsce_note_name))
        connection.commit()

    
    except (Exception, psycopg2.Error) as error:
        print("Error")
        return 0, "Error while fetching data from PostgreSQL "+ str(error)

    finally:
        # closing database connection.
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed") 


delete_required_kjsce_note('Applied Mathematics I',None,'FY','2.DE-MOIVRES THEOREM-2.pdf')

