import config
import psycopg2
from flow_logger import *
import tasks
from prefect import flow
import utils
import time
from psycopg2.extensions import AsIs


@flow
def update_tables_flow():

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

            log("Created a cursor")

            if utils.args.ingestion_date:
                print(f"The ingestion date is {utils.args.ingestion_date}")

            if utils.args.reload:
                tasks.delete_from_table(table_name="temp_StagingRaw")
                log("Reload: deleted all from temp_StagingRaw")

                # tasks.load_temp_staging_raw(temp_table_name="temp_StagingRaw",
                #                             file_path=config.data_file_path)

                tasks.delete_from_table(table_name="StagingRaw")
                log("Reload: deleted all from StagingRaw")

                # tasks.load_staging_raw(dst_table_name="StagingRaw",
                #                        src_table_name="temp_StagingRaw")

            # update staging tables
            update_table_tsr = tasks.load_temp_staging_raw(temp_table_name="temp_StagingRaw",
                                                           file_path=config.data_file_path)
            cursor.execute(update_table_tsr)
            log(f"temp_StagingRaw table has been updated")

            update_table_sr = tasks.load_staging_raw(dst_table_name="StagingRaw",
                                                     src_table_name="temp_StagingRaw")
            cursor.execute(update_table_sr)
            log(f"StagingRaw table has been updated")

            # update dim tables
            for table_name in config.dim_tables:

                if table_name == "DimQuestion":
                    src_table_name = "temp_StagingRaw"
                    update_table_dim = tasks.update_dim_table(dst_table_name=table_name,
                                                              src_table_name=src_table_name)

                elif table_name == "DimOperator":
                    update_table_bridge = tasks.update_bridge_table(bridge_table_name="_operator_name_mapping")
                    cursor.execute(update_table_bridge)
                    log(f"_operator_name_mapping table has been updated")
                    time.sleep(15)
                    update_table_dim = tasks.update_DimOper_table(dst_table_name=table_name,
                                                                  src_table_name="StagingRaw",
                                                                  bridge_table_name="_operator_name_mapping")
                    log(f"_operator_name_mapping table has been updated")

                else:
                    src_table_name = "StagingRaw"
                    update_table_dim = tasks.update_dim_table(dst_table_name=table_name,
                                                              src_table_name=src_table_name)

                cursor.execute(update_table_dim)
                log(f"{table_name} table has been updated")

            update_table_fact = tasks.update_fact_table(dst_table_name="Fact",
                                                        src_table_name="StagingRaw")
            cursor.execute(update_table_fact)
            log(f"Fact table has been updated")

            # views can be created using dbt
            drop_view_script = tasks.drop_view(view_name="nps_by_features")
            cursor.execute(drop_view_script)
            log(f"nps_by_features view has been dropped")

            create_nps_view = tasks.create_view(view_name="nps_by_features")
            cursor.execute(create_nps_view)
            log(f"nps_by_features view has been created")

            drop_view_script = tasks.drop_view(view_name="calculate_nps")
            cursor.execute(drop_view_script)
            log(f"calculate_nps view has been dropped")

            create_nps_view = tasks.create_view(view_name="calculate_nps")
            cursor.execute(create_nps_view, (AsIs('usage_time_range'), AsIs('usage_time_range')))
            log(f"nps_by_features view has been created")


if __name__ == "__main__":
    update_tables_flow()