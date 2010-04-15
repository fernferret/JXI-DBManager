Given /^the following tables:$/ do |tables|
  Table.create!(tables.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) table$/ do |pos|
  visit tables_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following tables:$/ do |expected_tables_table|
  expected_tables_table.diff!(tableish('table tr', 'td,th'))
end
