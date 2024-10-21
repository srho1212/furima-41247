# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| nickname           | string              | null: false               |
| email              | string              | null: false ,unique: true |
| encrypted_password | string              | null: false               |
| family_name        | string              | null: false               |
| firsty_name        | string              | null: false               |
| family_name_kana   | string              | null: false               |
| first_name_kana    | string              | null: false               |
| birthday           | date                | null: false               |

### Association

* has_many :items
* has_many :purchase_informations
 

## items table

| Column                              | Type       | Options                                  |
|-------------------------------------|------------|------------------------------------------|
| item_name                           |string      |null:false                                |
| categori_id                         |integer     |null:false                                |
| status_id                           |integer     |null:false                                |
| price                               |integer     |null:false                                |
| delivery_day_id                     |integer     |null:false                                |
| shipping_prefecture_id              |integer     |null:false                                |
| shipping_fee_id                     |integer     |null:false                                |
| shipping_destination                |references  |null:false                                |
| user                                |references  |null:false,foreign_key:true               |         


### Association

- has_many :user
- extend ActiveHash::Associations::ActiveRecordExtensions
- belongs_to :purchase_information
 
 
## purchase_informations table

| Column         | Type       | Options                                    |
|----------------|------------|--------------------------------------------|
| item           |references  |null:false,foreign_key:true                 |
| user           |references  |null:false,foreign_key:true                 |         


### Association

- belongs_to :user
- has_many :shipping_destination
- belongs_to :item


## shipping_destinations table

| Column                   | Type       | Options                                    |
|--------------------------|------------|--------------------------------------------|
| post_code                | string     | null: false                                |
| shipping_prefecture_id   |integer     |null:false                                  |
| municipality             | string     | null: false                                |
| street_address           | string     | null: false                                |
| building_name            | string     |                                            |
| telephone                | string     | null: false                                |
| purchase_information     | references | null:false,foreign_key:true                |



### Association

- belongs_to :purchase_information
- include ActiveHash::Associations


