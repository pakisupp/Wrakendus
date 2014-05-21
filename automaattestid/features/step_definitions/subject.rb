And(/^fill up new subject form$/) do
  fill_in('_code_id', :with => $test_subjectcode)
  fill_in('_name_id', :with => $test_subjectname)
  click_on('proceed')
end

Then(/^subject is saved$/) do
  page.has_content?('Show Subject')
  page.has_content?($test_subjectname)
  page.has_content?($test_username)
end

Then(/^new subject is listed$/) do
  page.has_content?($test_subjectcode)
  page.has_content?($test_subjectname)
  page.has_content?($test_username)
end

When(/^I open subject form$/) do
  pending
end

And(/^change subject data$/) do
  pending
end

Then(/^modified subject is listed$/) do
  pending
end


Then(/^subject is not shown$/) do
  page.should have_no_content($test_subjectname)
  page.should have_no_content($test_subjectcode)
end