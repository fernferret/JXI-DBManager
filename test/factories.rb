# Watch Railscast #158 for more details on Factory Girl
# http://railscasts.com/episodes/158-factories-not-fixtures
Factory.define :database, :class => Database do |d|
  d.sequence(:name) { |n| "My DB#{n}" }
  d.user { |user| user.association(:user) }
end

Factory.define :table, :class => Table do |f|
  f.sequence(:name) { |n| "Table#{n}" }
  f.association :database
end

Factory.define :column, :class => Column do |f|
  f.sequence(:name) { |n| "Column#{n}" }
  f.column_type "string"
  f.null "true"
  f.association :table
end

Factory.define :user, :class => User do |f|
  f.sequence(:username) { |n| "User#{n}" }
  f.sequence(:name) { |n| "User#{n}" }
  f.password "Password"
  f.password_confirmation { |u| u.password }
end
