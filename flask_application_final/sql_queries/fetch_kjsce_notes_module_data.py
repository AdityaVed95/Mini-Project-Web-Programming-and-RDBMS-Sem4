from sql_queries import connection_fxn 

def select_required_module_data(subject_name,dept_name,moduleNo,year):
    connection = 0
    try:
        cursor=connection_fxn.make_connection()

        if year == 'FY':
            postgreSQL_select_Query = "select * from sy_mp.kjsce_notes where fk_subject_name ='"+subject_name+"' and fk_dept_name is null and module_number = "+moduleNo

        else:
            postgreSQL_select_Query = "select * from sy_mp.kjsce_notes where fk_subject_name ='"+subject_name+"' and fk_dept_name = '"+dept_name+"' and module_number = "+moduleNo

        cursor.execute(postgreSQL_select_Query)
        module_data_details = cursor.fetchall()
        return 1, module_data_details


    except (Exception, psycopg2.Error) as error:
        return 0, "Error while fetching data from PostgreSQL "+ str(error)

    finally:
        # closing database connection.
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed") 

    