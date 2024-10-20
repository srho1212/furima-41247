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

* has_many :item
* has_many :purchase_information
 

## items table

| Column                              | Type       | Options                                  |
|-------------------------------------|------------|------------------------------------------|
| item_name                           |string      |null:false                                |
| categori                            |string      |null: false                               |
| status                              |string      |null: false                               |
| price                               |string      |null: false                               |
| days                                |string      |null:false                                |
| sales_commision                     |text        |null:false                                |
| sales_profit                        |text        |null:false                                |
| shipping_prefecture                 |text        |null:false                                |
| shipping_destination                |references  |null:false,foreign_key:true               |
| user                                |references  |null:false,foreign_key:true               |         


### Association

- belongs_to :user
- extend ActiveHash::Associations::ActiveRecordExtensions
- has_many :shipping destination
 
 
## purchase_informations table

| Column         | Type       | Options                                    |
|----------------|------------|--------------------------------------------|
| item           |references  |null:false,foreign_key:true                 |
| user           |references  |null:false,foreign_key:true                 |         


### Association

- belongs_to :user

## shipping destinations table

| Column                   | Type       | Options                                    |
|--------------------------|------------|--------------------------------------------|
| post_code                | string     | null: false                                |
| shipping_prefecture      | text       |null:false                                  |
| municipality             | string     | null: false                                |
| street_address           | string     | null: false                                |
| building_name            | string     |                                            |
| telephone                | string     | null: false                                |
| purchase_information     | references | null:false,foreign_key:true                |



### Association

- has_many :item
- include ActiveHash::Associations


