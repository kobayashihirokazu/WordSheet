# Wordsheet
---

# Description
単語とそれに対する説明を投稿することができるWebアプリです↓↓    
**テスト用 (email, passwd) = (test, test)** [http://3.115.187.120/] 

# Demo
<img src="https://gyazo.com/cc23b3a92422a575073357bf00c69228.gif" width=50%>

# 技術一覧
* インフラ : AWS(Webサーバ: EC2, DBサーバ: EC2)
* アプリケーションサーバ : Unicorn
* Webサーバ : Nginx
* データベース : MySQL

# 機能一覧
* ログイン機能(bcrypt)
* ページネーション機能(kaminari)
* いいね機能
* ユーザフォロー機能
* 記事投稿・更新・消去機能(redcarpet)
* 記事一覧表示機能
* 記事詳細表示機能
* 記事検索機能(ransack)
* 画像ファイルのアップロード機能
* DBテーブルのリレーション管理
* 単体テスト機能(RSpec, Capybara, FactoryBot)

# Requirement
* Ruby 2.6.3
* Rails 5.2.3
* MySQL2 0.5.3

# Usage
```cd wordsheet```  
```gem install bundler```  
```bundle install```  
```rails db:create```  
```rails s```  