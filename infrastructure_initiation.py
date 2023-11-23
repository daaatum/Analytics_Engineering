import psycopg2
from prefect import flow
from infrastructure_logger import *
import tasks
import config


@flow
def infrastructure_initiation_flow():

    params = tasks.bootstrap()

    # connect to an existing database
    with psycopg2.connect(
            database=params['db'],
            user=params['user'],
            host=params['host'],
            password=params['pw'],
            port=params['port']) as conn:

        log("Connected to the DB")

        # open a cursor
        with conn.cursor() as cursor:

            # drop tables if they exist
            for table_name in config.all_tables:
                drop_table_script = tasks.drop_table(table_name=table_name)
                cursor.execute(drop_table_script)
                log(f"{table_name} table has been dropped")

            # create tables
            for table_name in config.all_tables:
                create_table_script = tasks.create_table(table_name=table_name)
                cursor.execute(create_table_script)
                log(f"{table_name} table has been created")


if __name__ == "__main__":
    infrastructure_initiation_flow()
