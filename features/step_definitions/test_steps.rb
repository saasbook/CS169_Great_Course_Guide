Then /there should be the button "(.*)"/ do |button|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  should have_button button
end

