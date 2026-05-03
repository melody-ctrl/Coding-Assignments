import mysql.connector
from config import db_config

# connection factory 
def get_connection():
    return mysql.connector.connect(**db_config)