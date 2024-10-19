# DB 設計

## user table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| nickname           | string              | null: false               |
| email              | string              | null: false ,unique: true |
| password           | string              | null: false               |
| re_password        | string              | null: false,unique: true  |
| family_name        | text                | null: false               |
| firsty_name        | text                | null: false               |
| family_name_kana   | text                | null: false               |
| first_name_kana    | text                | null: false               |
| birthday           | string              | null: false               |

### Association

* has_many_to:item
* belongs_to:purchase_information
 

## item table

| Column                              | Type       | Options                                  |
|-------------------------------------|------------|------------------------------------------|
| item_name                           |text        |null:false                                |
| categori                            |text        |null: false                               |
| status                              |text        |null: false                               |
| cost                                |text        |null: false                               |
| delivery_days                       |string      |null:false                                |
| sales_commision                     |text        |null:false                                |
| sales_profit                        |text        |null:false                                |
| shipping_prefecture                 |text        |null:false                                |
| item_image                          |image       |null:false                                |
| user_id                             | string     |null:false,unique:true,foreign_key:true   |         


### Association

- belongs_to :user
- has_many :delivery_item
- has_many :shipping destination,through::delivery_item
 

## purchase_information table

| Column         | Type       | Options                                    |
|----------------|------------|--------------------------------------------|
| post_code      | string     | null: false                                |
| item_image     | image      | null: false                                |
| item_name      | text       | null: false                                |
| price          | string     | null: false                                |
| shipping_fee   | string     | null: false                                |
| user_id        | string     | null:false,unique:true,foreign_key:true    |


### Association

- belongs_to :user

## shipping destination table

| Column                   | Type       | Options                        |
|----------------         -|------------|--------------------------------|
| post_code                | string     | null: false                    |
| prefectures              | text       | null: false                    |
| municipality             | text       | null: false                    |  |
| street_address           | text       | null: false                    |
| building_name            | text       | null: false                    |
| telephone                | string     | null: false                    |
| shipping_destination_id


### Association

- has_many :delivery_item
- has_many :purchase_information,through::delivery_item

## delivery_item table

| Column                   | Type       | Options                                    |
|--------------------------|------------|--------------------------------------------|
| item_id                  | string     | null:false,unique:true,foreign_key:true    |
| shipping_destination_id  | string     | null:false,unique:true,foreign_key:true    |


### Association

- has_many :shipping destination_id
- has_many :item_id 