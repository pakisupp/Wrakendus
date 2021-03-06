When(/^I open Intime$/) do
  visit $intime_url
  page.should have_css('div.'+'submit')
end

And(/^log in with "([^"]*)"$/) do |username|
  fill_in('j_username', :with => username)
  fill_in('j_password', :with => username)
  click_on('proceed')
end

When(/^I log out$/) do
  visit('http://95.85.35.177:8080/intime/resources/j_spring_security_logout')
  page.has_content?('Login')
end

And(/^make sure English is selected$/) do
  click_on('English')
end

When(/^I open "([^"]*)"$/) do |link_text|
  click_on(link_text)
end

When(/^I go to home page$/) do
  visit('http://95.85.35.177:8080/intime/')
end

And(/^delete inserted value$/) do
  click_on('Delete')
  page.driver.browser.switch_to.alert.accept
end

And(/^delete the added value$/) do
  within(:xpath, '//tr[td//text()[contains(., "capybara")]]') do
    click_on('Delete')
  end
  page.driver.browser.switch_to.alert.accept
end

Then(/^login error message is given$/) do
  page.has_content?('Bad credentials')
end