Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  e1index = page.body.index(e1)
  e2index = page.body.index(e2)
  e2index.should be > e1index
end

