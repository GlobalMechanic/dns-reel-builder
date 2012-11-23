Given /^I do have a web application$/ do
  # I suppose we have an app?
end

When /^I visit the home page$/ do
  visit '/'
end

Then /^I should see the home page$/ do
  page.should have_content "Sign in"
end

# Then /^I should see "([^"]*)"$/ do |text|
#   page.should have_content text
# end
