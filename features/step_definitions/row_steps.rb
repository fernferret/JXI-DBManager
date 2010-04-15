Given /^the following rows:$/ do |rows|
  Table.create!(rows.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) row$/ do |pos|
  visit rows_url
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following rows:$/ do |expected_rows_table|
  expected_rows_table.diff!(tableish('table tr', 'td,th'))
end
