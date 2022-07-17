from airflow import DAG
from airflow.operators.empty import EmptyOperator
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.decorators import task

from datetime import datetime


@task
def load_file_list(source_dir):
    import glob
    return [f for f in glob.glob(f"{source_dir}/*.csv")]


def transform_data(file):
    from pathlib import Path
    import pandas as pd
    df = pd.read_csv(file, dtype=str)

    # Strip empty name
    df[df['name'].str.strip().astype(bool)]
    df.dropna(subset=['name'], inplace=True)

    df[['first_name', 'last_name']] = df['name'].str.rsplit(' ', 1, expand=True)
    df['first_name'] = df['first_name'].replace(['Miss ', 'Mr\. ', 'Ms\. ', 'Dr\. '], '', regex=True)
    # Deal with price column
    df.price.str.strip()
    df['price_100'] = df.apply(lambda row: float(row['price']) > 100, axis=1)

    # Write to destination
    p = Path(file)

    destination_file = f'{p.parent}/processed/{p.name}'
    df.to_csv(destination_file, index=False)
    return 'Done'

# Daily after 1am
with DAG(
        dag_id='de-test-1',
        start_date=datetime(2022, 7, 15),
        schedule_interval='30 1 * * *') as dag:
    import glob

    index = 0
    for index, f in enumerate(glob.glob('/opt/airflow/source/*.csv')):
        start_task = EmptyOperator(
            task_id=f'start_{index}'
        )

        transform_task = PythonOperator(
            task_id=f'transform_data_{index}',
            python_callable=transform_data,
            op_kwargs={'file': f},
            dag=dag,
        )

        # Move original file to folder to avoid processing same file multiple times
        #end_task = BashOperator(
        #    task_id=f'end_{index}',
        #    bash_command=f'mv {f} /opt/airflow/source/origin',
        #    dag=dag
        #)

        # Do nothing just for show case
        end_task = EmptyOperator(
            task_id=f'end_{index}'
        )

        start_task >> transform_task >> end_task

# Local testing
if __name__ == "__main__":
    transform_data('../source/dataset2.csv')