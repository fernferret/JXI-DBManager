# Watch Railscast #158 for more details on Factory Girl
# http://railscasts.com/episodes/158-factories-not-fixtures

Factory.define :database do |f|
  f.sequence(:name) { |n| "My DB#{n}" }
  f.user_id {|u| u.id}
  f.association :user
end

Factory.define :table do |t|
  t.name "Table"
  t.association :database
end

Factory.define :user do |f|
  f.name "User"
end
