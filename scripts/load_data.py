import pandas as pd
from sqlalchemy import create_engine

#Postgre credentials
pg_user = 'postgres'
pg_password = 'demoteste'
pg_host = 'localhost'
pg_port ='5432'
pg_database = 'retail_plus'

#Postgre connection
conn_postgre = create_engine(f'postgresql+psycopg2://{pg_user}:{pg_password}@{pg_host}:{pg_port}/{pg_database}')

#Test postgre connection
try:
  test_connection = pd.read_sql_query('SELECT 1', conn_postgre)
  print('Connection success!')
except Exception as e:
  print(f'Failed to connect with Postgre Database! Error: {e}')

#List all csv files to send 
csv_files = ['customers', 'products', 'orders']

#Automation to read and send all files to postgre database
for table_name in csv_files:
  #Read csv file
  df = pd.read_csv(f'./data/{table_name}.csv', sep=',')
  try:
    print(f'Sending table {table_name} to Postgre ------------------------')
    #Send a selected table to database
    df.to_sql(f'{table_name}', conn_postgre, schema='bronze', if_exists='append', index=False)
    print(f'Total rows added ', df.shape[0])
    print(f'Table {table_name} saved in Postgre --------------------------\n\n')
  except Exception as e:
    print(f'Error to send table: {e}')