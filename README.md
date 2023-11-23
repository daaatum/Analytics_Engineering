# Analytics_Engineering

# Content Description

- configs.py: <br>
      contains the configuration data required for running the code on Python (make sure to provide the file path of your data for data_file_path)
- .env.shadow: <br>
      contains the user, password, database name, host, and port variables that need to be filled in with the corresponding info of your database
- tasks.py: <br>
      contains functions used in the flow 
- queries (folder): <br>
      contains sql scripts to create, update, delete, and query the tables
- models (folder): <br>
      contains dbt models
- infrastructure_initiation.py: <br>
    * contains the code for the initial creation of a database, including creation/deletion of tables <br>
    * this file should be run only once at the beginning of the flow to make sure that the tables are created <br>
    * information on the created tables is provided in the "Tables" section below (note that the database diagram is also provided as a seperate .pdf file)
- flow.py: <br>
      contains the code to update the database
- infrastructure_logger.py: <br>
      contains the code for infrastructure_initiation's logging
- flow_logger.py: <br>
      contains the code for flow's logging
- utils.py:  <br>
      contains utility functons used in tasks
  
##  Tables

<h3 align="center"> DimOperator </h3>

|  Column Name   |  Type   |    Pk/Fk    |                    Description                    |     Values/Examples     |
|:--------------:|:-------:|:-----------:|:-------------------------------------------------:|:-----------------------:|
| dim_oper_sk_pk | SERIAL  | Primary key |   Serial primary key for the DimOperator table    |                         |
| permanent_name | VARCHAR |    FALSE    |   The correct and permanent name of an operator   |    'VIVA', 'UCOM', 'TEAM'     |
|  current_name  | VARCHAR |    FALSE    | Possible variations of the names of the operators | 'Vivacell', 'Beeline', 'Ucom' |
| quarter_start_date | VARCHAR |    FALSE    |            The start date of a quarter            |                         |
| insertion_date | Timestamp |    FALSE    |         The insertion date of a new tuple         |                         |

<br>

<h3 align="center"> operator_name_mapping </h3>


|   Column Name    |       Type       |    Pk/Fk    |                 Description                  | Values/Examples  |
|:-----------------:|:----------------:|:-----------:|:---------------------------------------------:|:----------------:|
| oper_name_source  |     VARCHAR      | Primary key |   Source operator name (Unique Constraint)   |                 |
| oper_name_perm    |     VARCHAR      |    FALSE    | Permanent operator name                      |                 |
| insertion_date    |    TIMESTAMP     |    FALSE    |      Date and time of insertion (Default: Now()) |                 |


<br>

<h3 align="center"> DimGender </h3>



| Column Name |  Type   |    Pk/Fk    |                Description                 |    Values/Examples     |
|:-----------:|:-------:|:-----------:|:------------------------------------------:|:------------:|
|  gender_id  | SERIAL  | Primary key | Serial primary key for the DimGender table |              |
|   gender    | VARCHAR |    FALSE    |        All the genders in the data         | 'Male', 'Female' |



<br>

<h3 align="center"> DimAgeGroup </h3>


| Column Name |  Type   |    Pk/Fk    |                 Description                  |      Values/Examples      |
|:-----------:|:-------:|:-----------:|:--------------------------------------------:|:-------------------------:|
|     id      | SERIAL  | Primary key | Serial primary key for the DimAgeGroup table |                           |
|  age_group  | VARCHAR |    FALSE    |        All the age groups in the data        | '14-19', '20-25', '26-35','36-45' |



<br>

<h3 align="center"> DimExperience </h3>



| Column Name |  Type   |    Pk/Fk    |                  Description                   |        Values/Examples        |
|:-----------:|:-------:|:-----------:|:----------------------------------------------:|:-----------------------------:|
|  experience_id  | SERIAL  | Primary key | Serial primary key for the DimExperience table |                               |
|   usage_time_range    | VARCHAR |    FALSE    |          The range of usage          | 'Less than 2', '2-5', 'More than 5' |


<br>

<h3 align="center"> DimEducationLevel </h3>



|    Column Name    |  Type   |    Pk/Fk    |                            Description                            |          Values/Examples          |
|:-----------------:|:-------:|:-----------:|:-----------------------------------------------------------------:|:---------------------------------:|
| education_lvl_id  | SERIAL  | Primary key |        Serial primary key for the DimEducationLevel table         |                                   |
|         education_level          | VARCHAR |    FALSE    |                All the education level in the data                | 'High education', 'No High education' |


<br>

<h3 align="center"> DimFamilyFinancialState </h3>



|    Column Name    |  Type   |    Pk/Fk    |                       Description                        |          Values/Examples          |
|:-----------------:|:-------:|:-----------:|:--------------------------------------------------------:|:---------------------------------:|
| financial_state_id | SERIAL  | Primary key | Serial primary key for the DimFamilyFinancialState table |                                   |
|         fam_financial_state        | VARCHAR |    FALSE    |                 The income of the family                 |  |

<br>

<h3 align="center"> DimDate </h3>


|     Column Name         |    Type    |    Pk/Fk    |               Description               | Values/Examples          |
|:-----------------------:|:----------:|:-----------:|:----------------------------------------:|:------------------------:|
|       date_id           |    INT     | Primary key |        Unique identifier for the date   |                          |
|          date           |    DATE    |    FALSE    |                 Date value               |   YYYY-MM-DD             |
|          epoch          |   BIGINT   |    FALSE    |              Epoch timestamp             |                          |
|      day_suffix         |  VARCHAR   |    FALSE    |            Suffix for the day            |      'st', 'nd', 'rd'   |
|       day_name          |  VARCHAR   |    FALSE    |                Name of the day           |   'Monday', 'Tuesday'   |
|     day_of_week         |    INT     |    FALSE    |              Day of the week             |         1, 2, ..., 7     |
|    day_of_month         |    INT     |    FALSE    |            Day of the month              |         1, 2, ..., 31    |
|   day_of_quarter        |    INT     |    FALSE    |           Day of the quarter             |         1, 2, ..., 90    |
|      day_of_year        |    INT     |    FALSE    |              Day of the year             |         1, 2, ..., 365   |
|    week_of_month         |    INT     |    FALSE    |            Week of the month             |         1, 2, ..., 5     |
|     week_of_year         |    INT     |    FALSE    |             Week of the year             |         1, 2, ..., 52    |
|         month            |    INT     |    FALSE    |                 Month number              |         1, 2, ..., 12    |
|      month_name          | VARCHAR(9) |    FALSE    |               Name of the month          |  'January', 'February'  |
| month_name_abbreviated   |  CHAR(3)   |    FALSE    | Abbreviated name of the month             |     'Jan', 'Feb', ...   |
|        quarter           |    INT     |    FALSE    |               Quarter number             |         1, 2, 3, 4       |
|     quarter_name         | VARCHAR(9) |    FALSE    |            Name of the quarter           | 'Q1', 'Q2', 'Q3', 'Q4'  |
|          year            |    INT     |    FALSE    |                Year value                |                          |
| first_day_of_week        |    DATE    |    FALSE    |          First day of the week           |   YYYY-MM-DD             |
|  last_day_of_week        |    DATE    |    FALSE    |           Last day of the week           |   YYYY-MM-DD             |
| first_day_of_month       |    DATE    |    FALSE    |         First day of the month           |   YYYY-MM-DD             |
|  last_day_of_month        |    DATE    |    FALSE    |          Last day of the month           |   YYYY-MM-DD             |
| first_day_of_quarter     |    DATE    |    FALSE    |        First day of the quarter          |   YYYY-MM-DD             |
|  last_day_of_quarter      |    DATE    |    FALSE    |         Last day of the quarter          |   YYYY-MM-DD             |
| first_day_of_year        |    DATE    |    FALSE    |           First day of the year          |   YYYY-MM-DD             |
|  last_day_of_year         |    DATE    |    FALSE    |            Last day of the year          |   YYYY-MM-DD             |
|          mmyyyy          |  CHAR(6)   |    FALSE    |           Month and year as 'MMYYYY'     |         '012022'         |
|        mmddyyyy          |  CHAR(10)  |    FALSE    |         Date as 'MMDDYYYY' format         |       '01012022'         |
|      weekend_indr        |  BOOLEAN   |    FALSE    |   Indicator for weekend (TRUE/FALSE)     |         TRUE/FALSE       |


<br>

<h3 align="center"> DimIsPayer </h3>


|  Column Name  |   Type   |    Pk/Fk    |             Description              | Values/Examples  |
|:-------------:|:--------:|:-----------:|:-----------------------------------:|:----------------:|
| is_payer_id   | SERIAL   | Primary key | Serial primary key for the DimIsPayer table |                 |
|   who_pays    | VARCHAR  |    FALSE    |        Indicates who is the payer     | 'Company', 'Individual', 'Organization' |

<br>

<h3 align="center"> DimKidsUnder14 </h3>


|   Column Name        |   Type   |    Pk/Fk    |                  Description                   | Values/Examples  |
|:--------------------:|:--------:|:-----------:|:-----------------------------------------------:|:----------------:|
|    has_kids_id       | SERIAL   | Primary key | Serial primary key for the DimKidsUnder14 table |                 |
| has_kids_under_14    | VARCHAR  |    FALSE    |  Indicates whether the individual has kids under 14 years old | 'Yes', 'No'      |

<br>

<h3 align="center"> DimLocation </h3>

|  Column Name  |   Type   |    Pk/Fk    |                  Description                  |                                                     Values/Examples                                                      |
|:-------------:|:--------:|:-----------:|:----------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------:|
| location_id   | SERIAL   | Primary key | Serial primary key for the DimLocation table   |                                                                                                                          |
|    region     | VARCHAR  |    FALSE    |          Geographic region or area            | 'Aragatsotn', 'Ararat', 'Armavir', 'Gegharquniq', 'Lory', 'Kotayq', 'Shirak', 'Syunik', 'Vayots Dzor', 'Tavush', 'Yerevan' |
| location_type | VARCHAR  |    FALSE    | Type or classification of the location        |                                                      'City','Rural'                                                      |


<br>

<h3 align="center"> DimOccupation </h3>



|      Column Name        |   Type   |    Pk/Fk    |                    Description                    |        Values/Examples        |
|:-----------------------:|:--------:|:-----------:|:--------------------------------------------------:|:-----------------------------:|
|     occupation_id       | SERIAL   | Primary key | Serial primary key for the DimOccupation table    |                               |
| participant_occupation  | VARCHAR  |    FALSE    | Occupation or profession of the participant       | 'Student', 'Employed', 'None' |

<br>

<h3 align="center"> DimParticipant </h3>


|   Column Name   |   Type   |    Pk/Fk    |                    Description                    | Values/Examples  |
|:---------------:|:--------:|:-----------:|:-------------------------------------------------:|:----------------:|
| participant_id  | SERIAL   | Primary key |  Serial primary key for the DimParticipant table  |                 |
|     user_id     | VARCHAR  |    FALSE    |       Unique identifier for the participant       |                 |
|    phone_num    | INTEGER  |    FALSE    | Phone number of the participant (Only VIVA users) |                 |
|       age       | INTEGER  |    FALSE    |              Age of the participant               |                 |


<br>

<h3 align="center"> DimSpending </h3>

|  Column Name   |   Type   |    Pk/Fk    |                 Description                 | Values/Examples  |
|:--------------:|:--------:|:-----------:|:-------------------------------------------:|:----------------:|
| spending_id    | SERIAL   | Primary key | Serial primary key for the DimSpending table |                 |
| spending_range | VARCHAR  |    FALSE    |         Range representing spending levels   |  |



<br>

<h3 align="center">  DimQuestion </h3>

|   Column Name    |   Type   |    Pk/Fk    |              Description               | Values/Examples  |
|:-----------------:|:--------:|:-----------:|:--------------------------------------:|:----------------:|
|   question_id    | SERIAL   | Primary key | Serial primary key for the DimQuestion table |                 |
| long_name_rus    | VARCHAR  |    FALSE    | Long name of the question in Russian    |                 |
| short_name_eng   | VARCHAR  |    FALSE    | Short name of the question in English   |                 |
|     is_nps       | VARCHAR  |    FALSE    | Indicates if the question is related to Net Promoter Score (NPS) | 'Yes', 'No' |
|  is_filter_of    | VARCHAR  |    FALSE    | Indicates the question is a filter for another question |              |


<br>

<h3 align="center">  StagingRow </h3>



|   Column Name    |       Type       | Pk/Fk |                  Description                  | Values/Examples  |
|:-----------------:|:----------------:|:-----:|:---------------------------------------------:|:----------------:|
|        id         |     INTEGER      | FALSE |                  Identifier                   |                 |
|     phone_n       |     INTEGER      | FALSE |               Phone number                     |                 |
|     operator      |     VARCHAR      | FALSE |                Operator name                   |                 |
|      gender       |     VARCHAR      | FALSE |                  Gender                        | 'Male', 'Female' |
|        age        |     INTEGER      | FALSE |                    Age                          |                 |
|    age_group      |     VARCHAR      | FALSE |                 Age group                       | '14-19', '20-25' |
|     location      |     VARCHAR      | FALSE |                 Location                        |                 |
|  location_type    |     VARCHAR      | FALSE |              Type of location                   | 'City', 'Suburb' |
|  usage_period     |     VARCHAR      | FALSE |               Usage period                      |                 |
|   is_only_sim     |     VARCHAR      | FALSE |     Indicates if the user has only one SIM      | 'Yes', 'No'      |
|       sim2        |     VARCHAR      | FALSE |                Second SIM status               | 'Active', 'Inactive' |
|     spendings     |     INTEGER      | FALSE |                 Spending amount                 |                 |
| spending_range    |     VARCHAR      | FALSE |              Spending range                    | 'Low', 'Medium'  |
|    occupation     |     VARCHAR      | FALSE |                 Occupation                      | 'Teacher', 'Engineer' |
|  education_lvl    |     VARCHAR      | FALSE |              Education level                    | 'High School', 'Bachelor' |
|     has_kids      |     VARCHAR      | FALSE |           Indicates if participant has kids     | 'Yes', 'No'      |
|    fin_state      |     VARCHAR      | FALSE |              Financial state                   | 'Stable', 'Unstable' |
|       date        |    TIMESTAMP     | FALSE |                    Date                         |                 |
|       wave        |     VARCHAR      | FALSE |                    Wave                         | 'Wave1', 'Wave2' |
|     who_pays      |     VARCHAR      | FALSE |               Who pays the bill                 | 'Individual', 'Company' |
|      weight       |     NUMERIC      | FALSE |                   Weight                        |                 |
| Q3_1_mob_int      |      BYTEA       | FALSE |     Binary data for Q3_1_mob_int               |                 |
|       Q1A         |     INTEGER      | FALSE |                     Q1A                         |                 |
|        N01        |     INTEGER      | FALSE |                     N01                         |                 |
| insertion_date    |    TIMESTAMP     | FALSE |     Date and time of insertion (Default: Now()) |                 |



<br>

<h3 align="center">  temp_StagingRow </h3>

<h4 >  Contains the question row from the original data </h4>





|   Column Name    |       Type       | Pk/Fk |                  Description                  | Values/Examples  |
|:-----------------:|:----------------:|:-----:|:---------------------------------------------:|:----------------:|
|        id         |     VARCHAR      | FALSE |                  Identifier                   |                 |
|     phone_n       |     VARCHAR      | FALSE |               Phone number                     |                 |
|     operator      |     VARCHAR      | FALSE |                Operator name                   |                 |
|      gender       |     VARCHAR      | FALSE |                  Gender                        | 'Male', 'Female' |
|        age        |     VARCHAR      | FALSE |                    Age                          |                 |
|    age_group      |     VARCHAR      | FALSE |                 Age group                       | '14-19', '20-25' |
|     location      |     VARCHAR      | FALSE |                 Location                        |                 |
|  location_type    |     VARCHAR      | FALSE |              Type of location                   | 'City', 'Suburb' |
|  usage_period     |     VARCHAR      | FALSE |               Usage period                      |                 |
|   is_only_sim     |     VARCHAR      | FALSE |     Indicates if the user has only one SIM      | 'Yes', 'No'      |
|       sim2        |     VARCHAR      | FALSE |                Second SIM status               | 'Active', 'Inactive' |
|     spendings     |     VARCHAR      | FALSE |                 Spending amount                 |                 |
| spending_range    |     VARCHAR      | FALSE |              Spending range                    | 'Low', 'Medium'  |
|    occupation     |     VARCHAR      | FALSE |                 Occupation                      | 'Teacher', 'Engineer' |
|  education_lvl    |     VARCHAR      | FALSE |              Education level                    | 'High School', 'Bachelor' |
|     has_kids      |     VARCHAR      | FALSE |           Indicates if participant has kids     | 'Yes', 'No'      |
|    fin_state      |     VARCHAR      | FALSE |              Financial state                   | 'Stable', 'Unstable' |
|       date        |    VARCHAR     | FALSE |                    Date                         |                 |
|       wave        |     VARCHAR      | FALSE |                    Wave                         | 'Wave1', 'Wave2' |
|     who_pays      |     VARCHAR      | FALSE |               Who pays the bill                 | 'Individual', 'Company' |
|      weight       |     VARCHAR      | FALSE |                   Weight                        |                 |
| Q3_1_mob_int      |      VARCHAR       | FALSE |     Binary data for Q3_1_mob_int               |                 |
|       Q1A         |     VARCHAR      | FALSE |                     Q1A                         |                 |
|        N01        |     VARCHAR      | FALSE |                     N01                         |                 |
| insertion_date    |    VARCHAR     | FALSE |     Date and time of insertion (Default: Now()) |                 |


<br>

<h3 align="center">  Fact </h3>


|          Column Name            |    Type   | Pm/Fk       |                  Description                   | Values/Examples  |
|:------------------------------:|:---------:|:-----------:|:-----------------------------------------------:|:----------------:|
|           fact_id               |  SERIAL   | Primary key  | Serial primary key for the Fact table           |                 |
|             date                | TIMESTAMP |   FALSE     |                  Date of the fact                |                 |
|          phone_num              |  INTEGER  |   FALSE     |                Phone number related to the fact   |                 |
|     participant_id_nk          | VARCHAR   |   FALSE     |   Natural key for participant identification     |                 |
|          operator_id            |  INTEGER  |   Foreign key |           Reference to the Operator table         |                 |
|            age_id               |  INTEGER  |   Foreign key |            Reference to the Age table             |                 |
|           gender_id             |  INTEGER  |   Foreign key |          Reference to the Gender table            |                 |
|          spending_id            |  INTEGER  |   Foreign key |         Reference to the Spending table           |                 |
|         location_id             |  INTEGER  |   Foreign key |         Reference to the Location table           |                 |
|        experience_id            |  INTEGER  |   Foreign key |        Reference to the Experience table          |                 |
|       participant_id            |  INTEGER  |   Foreign key |       Reference to the Participant table          |                 |
|         occupation_id           |  INTEGER  |   Foreign key |        Reference to the Occupation table          |                 |
|    education_level_id           |  INTEGER  |   Foreign key |   Reference to the Education Level table          |                 |
| has_kids_under_14_id            |  INTEGER  |   Foreign key | Reference to the Has Kids Under 14 Status table   |                 |
| family_financial_state_id       |  INTEGER  |   Foreign key | Reference to the Family Financial State table     |                 |
|          question_id            |  INTEGER  |   Foreign key |         Reference to the Question table            |                 |
|            date_id              |  INTEGER  |   Foreign key |            Reference to the Date table             |                 |
|   avg_monthly_spending           |  INTEGER  |   FALSE     |          Average monthly spending related to the fact |                 |
|         is_the_payer            | VARCHAR   |   FALSE     |           Indicates if the participant is the payer | 'Yes', 'No'      |
|             score               |  INTEGER  |   FALSE     |                 Score related to the fact        |                 |
|            weight               |  NUMERIC  |   FALSE     |                  Weight related to the fact      |                 |


<br>



##  Views

<br>
<h3 align="center"> nps_by_features </h3>

The view calculates the Net Promoter Score (NPS) for different features, aggregating the scores and weights from the Fact table. 
The features include the operator's permanent name, gender, age group, location type, and usage time range. 
The number of nps_by_features views is equal to the number of questions regarding NPS (about 30)

<br>
<h4 > Columns: </h4>



|          permanent_name           | gender | age_group |  location_type  | usage_time_range |
|:---------------------------------:|:------:|:---------:|:---------------:|:------------------------------:|

<br>
<h4 > Derived columns: </h4>

|  Column Name   |                           Description                            | 
|:--------------:|:----------------------------------------------------------------:|
|        promoter_weights        | Sum of weights for participants who gave a score of 9 or higher  |  
| detractor_weights| Sum of weights for participants who gave a score between 0 and 6 |  
| neutral_weights|    Sum of weights for participants who gave a score of 7 or 8    |  
| weights|            Total sum of weights for all participants             |  


<br>
<h3 align="center"> nps_calculation </h3>

This view refines the calculation of the NPS by aggregating the promoter, detractor, and total weights calculated in the nps_by_features view. The calculation is performed for each distinct value of a specified feature (%s) within the dataset.


<br>
<h4 > Columns: </h4>

|   Column Name   |                                                             Description                                                             | 
|:---------------:|:-----------------------------------------------------------------------------------------------------------------------------------:|
| permanent_name  |                                                 The permanent name of the operator                                                  |  
|  Feature (%s)   |The specified feature (e.g., gender, age group, location type, usage time range) for which the Net Promoter Score (NPS) is calculated|  
| nps|                                    The calculated Net Promoter Score, expressed as a percentage                                     |  


<br>
<h2 align="center"> Workflow </h2>

![flow](https://github.com/daaatum/trial/assets/151869175/8e479e33-a5a6-440f-a622-47d863c897c9)


# Requirements and Flow

To run the project locally, perform the following steps:

- make sure to have Python installed on your machine
- make sure to have all the files for this project in one directory
- create a Python virtual environment as follows: <br>
     python -m venv env
- activate the Python virtual environment created in the previous step as follows: <br>
     env\Scripts\activate
- to install all the necessary libraries run the following: <br>
     pip install -r requirements.txt
- to install Prefect (a workflow orchestration tool) run the following: <br>
     pip install -U prefect
- to start a Prefect agent run the following: <br>
     prefect agent start -q 'default'
- to change the default db to Postgres run the following by providing the info for username, password, host, port, and db_name: <br>
     prefect config set PREFECT_API_DATABASE_CONNECTION_URL="postgresql+asyncpg://username:password@host:port/db_name"
- to start Prefect server run the following: <br>
     prefect server start
- to install dbt (data build tool) run the following: <br>
     pip install dbt-postgres
- to create a new dbt project run the following: <br>
     dbt init project_name	 
- to run the models, add the models from the provided models folder, and run the following: <br>
     dbt run
- to install, set up and run Apache Superset: <br>
  &ensp; - run the following: <br>
  &emsp; git clone https://github.com/apache/superset.git <br>
  &emsp; cd superset <br>
  &emsp; docker-compose -f docker-compose-non-dev.yml pull <br>
  &emsp; docker-compose -f docker-compose-non-dev.yml up <br>
  &ensp; - open localhost:8088/login <br>
  &ensp; - input username:admin, password:admin <br>
  &ensp; - to connect to Postgres, input: <br>
  &emsp; host: db <br>
  &emsp; port: 5432 <br>
  &emsp; db_name: superset <br>
  &emsp; username: superset <br>
  &emsp; password: superset <br>
- run the infrastructure_initiation.py file only once as follows: <br>
     python infrastructure_initiation.py --ingestion_date "mm/dd/yyyy" 
- run the flow.py file as follows: <br>
     python flow.py --ingestion_date "mm/dd/yyyy"
