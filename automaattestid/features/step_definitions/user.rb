And(/^fill up new user form$/) do
  fill_in('_username_id', :with => $test_username)
  fill_in('_password_id', :with => $test_pw)
  fill_in('_eMail_id', :with => $test_mail)
  fill_in('_fullName_id', :with => $test_name)
  fill_in('_openIdIdentifier_id', :with => 'TODO')
  click_on('proceed')
end

Then(/^new user is listed$/) do
  page.has_content?($test_username)
  page.has_content?($test_mail)
  page.has_content?($test_name)
end

Then(/^user is saved$/) do
  page.has_content?($test_username)
  page.has_content?('Show App User')
end

And(/^I open user form$/) do
  pending
end

And(/^change user data$/) do
  pending
end

Then(/^modified user is listed$/) do
  pending
end

Then(/^main menu items are visible$/) do
  page.has_content?('Create new Subject')
  page.has_content?('List all Subjects')
  page.has_content?('Create new Used Time')
  page.has_content?('List all Used Times')
  page.has_content?('Graph')
end

Then(/^user is not shown$/) do
  page.should have_no_content($test_username)
end