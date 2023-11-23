import os
import config
import argparse
from datetime import datetime


# load queries
def load_query(query_name):
    query_location = os.getcwd() + config.queries
    sql_script = ''
    for script in os.listdir(query_location):
        if query_name in script:
            with open(query_location + '\\' + script, 'r') as script_file:
                sql_script = script_file.read()
            break
    return sql_script


# reload for temp_StagingRaw, StagingRaw and Fact tables
parser = argparse.ArgumentParser(description="Reload staging raw table by date")

parser.add_argument(
    "--ingestion_date",
    type=str,
    required=True,
    help="Data ingestion DATE"
)

parser.add_argument(
    "--reload",
    default=None,
    type=bool,
    required=False,
    help="Whether to reload the module",
)

args = parser.parse_args()


# question code versioning (not applied in the current version)
field_dict = {
    '2023-01-01': {
        'default': ['N01']
    },
    '2023-04-01': {
        'default': ['N01', 'Q1A']
    }
}


def get_score_fields(date):
    current_date = datetime.strptime(date)

    for version_date in sorted(field_dict, reverse=True):
        if current_date >= datetime.strptime(version_date, '%Y-%m-%d'):
            fields = field_dict[version_date]
            return fields.get('default')
