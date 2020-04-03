# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

## userテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|unique: true, null: false|
|password|string|null: false|

## Association
has_many :namecards

## cardテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|company|string|null: false|
|address|string||
|tel|string||
|email|string||
|apiresulttext|text||
|apiresulthash|integer|
|user_id|integer|null:false, foreign_key: true|

## Association
belongs_to :user
has_many :episodes

## episodeテーブル
|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|when|string||
|where|string||
|namecard_id|integer|null:false, foreign_key: true|

## Association
belongs_to : namecard

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
