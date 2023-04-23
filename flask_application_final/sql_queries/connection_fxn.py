import psycopg2
def make_connection():    
    connection = psycopg2.connect(user="postgres",
                                password="abhishek",
                                host="127.0.0.1",
                                port="5432",
                                database="postgres",
                                options="-c search_path=sy_mp,public")
    return connection


