Then /there should be the button "(.*)"/ do |button|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  should have_button button
end

num_profs = 0
Given /the following professors exist/ do |prof_table|
  num_profs = 0 #need to reset if this statement called twice in a feature
  prof_table.hashes.each do |prof|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    p = Professor.create(prof)
    num_profs += 1
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  e1index = page.body.index(e1)
  e2index = page.body.index(e2)
  e2index.should be > e1index
end

Then /I should not see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  e1index = page.body.index(e1)
  e2index = page.body.index(e2)
  e2index.should be < e1index
end

