import os
from prefect import task
from dotenv import load_dotenv
import utils


@task(refresh_cache=True)
def bootstrap():

    load_dotenv()
    user = os.getenv('USER')
    pw = os.getenv('PASS')
    db = os.getenv('DB')
    host = os.getenv('HOST')
    port = os.getenv('PORT')

    params = {'user': user, 'pw': pw, 'db': db, 'host': host, 'port': port}

    return params


@task(refresh_cache=True)
def drop_table(table_name):
    drop_table_script = utils.load_query("drop_table").format(table_name=table_name)

    return drop_table_script


@task(refresh_cache=True)
def create_table(table_name):
    create_table_script = utils.load_query("create_table_{}".format(table_name)).format(table_name=table_name)

    return create_table_script


@task(refresh_cache=True)
def delete_from_table(table_name):
    delete_from_table_script = utils.load_query("delete_from_table").format(table_name=table_name)

    return delete_from_table_script


@task(refresh_cache=True)
def load_temp_staging_raw(temp_table_name, file_path):
    update_table_script = utils.load_query("update_table_{}".format(temp_table_name)).format(
        temp_table_name=temp_table_name,
        file_path=file_path
    )

    return update_table_script


@task(refresh_cache=True)
def load_staging_raw(dst_table_name, src_table_name):
    update_table_script = utils.load_query("update_table_{}".format(dst_table_name)).format(
        dst_table_name=dst_table_name,
        src_table_name=src_table_name
    )

    return update_table_script


@task(refresh_cache=True)
def update_bridge_table(bridge_table_name):
    update_table_script = utils.load_query("update_table_{}".format(bridge_table_name)).format(
        bridge_table_name=bridge_table_name
    )

    return update_table_script


@task(refresh_cache=True)
def update_DimOper_table(dst_table_name, src_table_name, bridge_table_name):
    update_table_script = utils.load_query("update_table_{}".format(dst_table_name)).format(
        dst_table_name=dst_table_name,
        src_table_name=src_table_name,
        bridge_table_name=bridge_table_name
    )

    return update_table_script


@task(refresh_cache=True)
def update_dim_table(dst_table_name, src_table_name):
    update_table_script = utils.load_query("update_table_{}".format(dst_table_name)).format(
        dst_table_name=dst_table_name,
        src_table_name=src_table_name
    )

    return update_table_script


@task(refresh_cache=True)
def update_fact_table(dst_table_name, src_table_name):
    update_table_script = utils.load_query("update_table_{}".format(dst_table_name)).format(
        dst_table_name=dst_table_name,
        src_table_name=src_table_name
    )

    return update_table_script


@task(refresh_cache=True)
def drop_view(view_name):
    drop_view_script = utils.load_query("drop_view").format(view_name=view_name)

    return drop_view_script


@task(refresh_cache=True)
def create_view(view_name):
    create_view_script = utils.load_query("create_view_{}".format(view_name)).format(view_name=view_name)

    return create_view_script
