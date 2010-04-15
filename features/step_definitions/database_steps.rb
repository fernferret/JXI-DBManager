Given /^the following databases:$/ do |databases|
  Table.create!(databases.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) database$/ do |pos|
  visit databases_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following databases:$/ do |expected_databases_table|
  expected_databases_table.diff!(tableish('table tr', 'td,th'))
end
