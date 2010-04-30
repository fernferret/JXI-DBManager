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
  f.sequence(:email) { |n| "Email#{n}@example.com" }
end

Factory.define :admin, :class => User do |f|
  f.sequence(:username) { |n| "Admin#{n}" }
  f.sequence(:name) { |n| "Admin#{n}" }
  f.password "Password"
  f.password_confirmation { |u| u.password }
  f.permissions "admin"
  f.sequence(:email) { |n| "AdminEmail#{n}@example.com" }
end

Factory.define :ta, :class => User do |f|
  f.sequence(:username) { |n| "TA#{n}" }
  f.sequence(:name) { |n| "TA#{n}" }
  f.password "Password"
  f.password_confirmation { |u| u.password }
  f.permissions "ta"
  f.sequence(:email) { |n| "TAEmail#{n}@example.com" }
end
