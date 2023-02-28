# do pip install psycopg2 on the terminal

import psycopg2
import io

# Connect to the PostgreSQL database
conn = psycopg2.connect(
    host="localhost",
    database="my_first_database",
    user="postgres",
    password="pass"
)

# Read the contents of the PDF file
with open('/Users/adityaved/Downloads/db_book.pdf', 'rb') as file:
    binary_data = file.read()

# Create a cursor to execute SQL statements
cursor = conn.cursor()

# Insert the PDF file into the database using the BYTEA data type
cursor.execute("""
    INSERT INTO sy_mp.textbook (textbookId, textbookName, textbookAvgRating, textbookNoOfRatings, textbookAuthor, textbookEdition, publication_year,publisher,actualPdf)
    VALUES (1, 'Intro to DBMS Korth', 5, 10 , 'Korth', 7, 2022 , 'McGraww Hill' , %s);
""", (psycopg2.Binary(binary_data),))

# Commit the transaction and close the cursor and connection
conn.commit()
cursor.close()
conn.close()
