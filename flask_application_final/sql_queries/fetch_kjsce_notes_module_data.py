import psycopg2

def select_required_module_data(subject_name,dept_name,moduleNo,year):
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

    