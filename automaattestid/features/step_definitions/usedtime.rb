And(/^fill up new usedtime form$/) do
  fill_in('_workDate_id', :with => $test_date)
  fill_in('_hours_id', :with => $test_hours)
  click_on('proceed')
end

Then(/^usedtime is saved$/) do
  page.has_content?('Show Used Time')
  page.has_content?($test_date)
  page.has_content?($test_hours)
  page.has_content?($test_subjectname)
  page.has_content?($test_username)
end

Then(/^new usedtime is listed$/) do
  page.has_content?($test_date)
  page.has_content?($test_hours)
  page.has_content?($test_subjectname)
  page.has_content?($test_username)
end

When(/^I open usedtime form$/) do
  pending
end

And(/^change usedtime data$/) do
  pending
end

Then(/^modified usedtime is listed$/) do
  pending
end