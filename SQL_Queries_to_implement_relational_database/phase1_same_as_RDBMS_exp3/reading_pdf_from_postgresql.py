# on running this file : the pdf will get saved and will open
# on your local machine

import psycopg2
import os


# Connect to the PostgreSQL database
conn = psycopg2.connect(
    host="localhost",
    database="my_first_database",
    user="postgres",
    password="pass"
)

# Open a cursor to perform database operations
cur = conn.cursor()

# Execute a SELECT statement to retrieve the PDF file
cur.execute("SELECT actualPdf FROM sy_mp.textbook WHERE textbookId = %s", (1,))
pdf_data = cur.fetchone()[0]

# Close the cursor and database connection
cur.close()
conn.close()

# Write the PDF data to a file on your local machine
with open("textbook.pdf", "wb") as f:
    f.write(pdf_data)

# Open the PDF file in your default PDF viewer
os.system("open textbook.pdf")
