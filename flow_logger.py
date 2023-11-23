import os
import logging
from config import log_folder, flow_log_file


logfolder = os.getcwd() + '\\' + log_folder
if not os.path.exists(logfolder):
    os.makedirs(logfolder)


def log(msg):

    logger = logging.getLogger(flow_log_file)
    logger.setLevel('INFO')

    if not logger.handlers:
        # The first time the logger with this name is called, it will have no handlers associated
        # Note using absolute path to LOG_DIR
        handler = logging.FileHandler(os.path.join(logfolder, flow_log_file), encoding='utf-8')
        logger.addHandler(handler)

        # Formatter can be whatever you want
        formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s',
                                      datefmt='%Y-%m-%d_%H:%M:%S')
        handler.setFormatter(formatter)

    # Print to stdout so logs will arrive @ prefect cloud
    print(msg)

    # Log to FileHandler
    logger.info(msg)
