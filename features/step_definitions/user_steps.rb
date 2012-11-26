# user_steps.rb

def create_visitor
  @visitor ||= { :name => "Testy McUserton", :email => "example@example.com",
    :password => "please", :password_confirmation => "please" }
end

def delete_user
  @user ||= User.first conditions: {:email => @visitor[:email]}
  @user.destroy unless @user.nil?
end

def create_user
  create_visitor
  delete_user
  @user = User.create(
    :name => @visitor[:name],
    :email => @visitor[:email],
    :password => @visitor[:password],
    :password_confirmation => @visitor[:password],
  )
end

def sign_in
  visit '/users/sign_in'
  fill_in "Login", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  click_button "Sign in"
end

# Given:

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I am not logged in$/ do
  page.driver.delete '/users/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

# When: 

When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrong")
  sign_in
end

When /^I sign out$/ do
  page.should have_content "Browse Clips"
  click_link "Logout"
end

When /^I edit my account details$/ do
  click_link "Edit " + @visitor[:name]
  fill_in "Name", :with => "New name"
  fill_in "Current password", :with => @visitor[:password]
  click_button "Update"
end

When /^I look at the list of users$/ do
  click_link "Users"
end

# Then:

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid login or password."
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should be signed in$/ do
  page.should have_content "Logout"
  page.should_not have_content "Login"
end

Then /^I should see a signed out message$/ do
  page.should have_content "You need to sign in or sign up before continuing."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
  page.should have_content "Edit New name"
end

Then /^I should see my name$/ do
  page.should have_content "Listing users"
  page.should have_content @visitor[:name]
  page.should have_content @visitor[:email]
end
