# JSON API на RoR
=================

### Install

Ввести в терминал
```bash
git clone git@github.com:wildkain/umbrella-blog.git && cd umbrella-blog/
bundle && rails s
```
> Заполнение базы тестовыми данными
```
rails db:setup
```

### API Endpoints:
 

#### 1. Создать пост:
    
   Request:
   
    POST "http://localhost:3000/api/v1/posts")
    params = { "post" => {'title'=>"posttitle", 'body'=>"postbody", 'username'=>"someuser", "ip"=>"127.0.1.1" } }
    
   Response:
   
    {
        "id": 1,
        "title": "posttitle",
        "body": "postbody",
        "ip": "127.0.0.1",
        "author": "someuser",
        "date": "2019-01-29 10:01"
    }

#### 2. Поставить оценку посту:

        
   Request:
   
    POST "http://localhost:3000/api/v1/rates"
    params = {post_id: 1, rate: 3 (any from 1 to 5) }
    
   Response:
   
    {
       "post": 1,
       "rating": 3.15 (avg)
    }


#### 3. Получить топ N постов по среднему рейтингу:

        
   Request:
   
    GET "http://localhost:3000/api/v1/posts"
    params = {quantity: 10}
    
   Response:
   
    {
       "title": "post_1_title",
       "body": "post_1_body"
    },
    {
       "title": "post_2_title",
       "body": "post_2_body"
    }
    




#### 4. Получить список айпи, с которых постило несколько разных авторов:	

        
   Request:
   
    GET "http://localhost:3000/api/v1/ips"
    params = {}
    
   Response:
   
    {
       "ip": "127.0.0.1",
       "usernames": ["username1", "username2"....]
    },
    {
       "ip": "127.1.1.1",
       "usernames": ["username3", "username1"....]
    }
    



#### RSpec
* Обязательное наличие спеков
```bash
rspec
```

## SQL Task

Дана таблица users вида - id, group_id

```sql
CREATE TABLE users(id bigserial, group_id bigint);
INSERT INTO users(group_id) VALUES (1), (1), (1), (2), (1), (3); 

id  | group_id
----+----------
  1 |        1
  2 |        1
  3 |        1
  4 |        2
  5 |        1
  6 |        3
```

В этой таблице, упорядоченой по ID необходимо: 

1. Выделить непрерывные группы по group_id с учетом указанного порядка записей (их 4) 

2. Подсчитать количество записей в каждой группе

3. Вычислить минимальный ID записи в группе

**Query**
```sql
WITH
  start_groups AS (
    SELECT
       id,
       group_id,
       CASE
            WHEN lag(group_id) over () = group_id THEN 0
            ELSE 1
       END as start_group
    FROM users
  ),
 
  groups_with_start_index AS (
      SELECT
           id,
           group_id,
           CASE
               WHEN start_group = 1 THEN id
               ELSE 0
           END AS start_index
      FROM start_groups
      WHERE start_group <> 0
  )
 
SELECT
    start_index AS min_id,
    group_id,    
    CASE
        WHEN lead(start_index) over () IS NOT NULL THEN lead(start_index) over () - start_index
        ELSE 1
    END AS count
FROM groups_with_start_index
ORDER BY id;


```
Result:
```sql
min_id | group_id | count
--------+----------+-------
1 | 1 | 3
4 | 2 | 1
5 | 1 | 1
6 | 3 | 1
(4 rows)
```