# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie['title'], :rating => movie['rating'], :release_date => movie['release_date'])
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |movie1, movie2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should =~ /#{movie1}.*#{movie2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(%r{,\s*}).each do |rating|
    field = "ratings_#{rating}"
    if uncheck 
      uncheck(field)
    else
      check(field)
    end
  end
end

Then /^I should (not )?see movies rated: (.*)/ do |should_not, rating_list|
  rating_list.split(%r{,\s*}).each do |rating|
    # code very similar to web steps 
    if should_not
      page.has_no_xpath?('//*', :text => "#{rating}")
    else
      assert page.has_xpath?('//*', :text => "#{rating}")
    end
  end
end

Then /^I should see (.*) of the movies/ do |amt|
  row = page.all("table#movies tr").count
  case amt
  when 'all'
    row.should == 11
  end
end



