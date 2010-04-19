# Watch Railscast #158 for more details on Factory Girl
# http://railscasts.com/episodes/158-factories-not-fixtures
Factory.define :db do |f|
  f.sequence(:name) { |n| "My DB#{n}" }
  f.association :user
end

Factory.define :table do |f|
  f.name "Table"
  f.association :database
end

Factory.define :column do |f|
  f.name "Column Name"
  f.column_type "string"
  f.null "null"
end

Factory.define :user do |f|
  f.sequence(:username) { |n| "User#{n}" }
  f.sequence(:name) { |n| "User#{n}" }
  f.password "Password"
end
