# Data Pipe Line

Step 1: Extract data

|   name    |    price     | 
|:----------|--------------|
| William Dixon |  109.0372796 |

Step 2: Transform - Split `name` column into `first_name` and `last_name`

|first_name | last_name |    price     | 
|:----------|:----------|--------------|
| William   | Dixon     |  109.0372796 |

Step 3: Transform - Data Cleaning

- Remove any zeros prepended to the `price` field
- Delete any rows which do not have a `name`

Step 4: Transform 

- Create a new field named `above_100`, which is `true` if the price is strictly greater than 100

|first_name | last_name |    price     | above_100  |
|:----------|:----------|--------------|:----------:|
| William   | Dixon     |  109.0372796 | true       |

Step 5: Load into destination