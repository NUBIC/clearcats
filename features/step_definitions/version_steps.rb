Given /^a Person with a first name "(.*)" who was changed from "(.*)" and netid "([^"]*)"$/ do |current_first_name, previous_first_name, netid|
  person = Factory.build(:person, :netid => netid, :first_name => previous_first_name)
  person.save!
  person.first_name = current_first_name
  person.save!
end

Given /^an Award with a grant title "(.*)" which was changed from "(.*)" and budget_identifier "(.*)"$/ do |current_grant_title, previous_grant_title, budget_identifier|
  award = Factory.build(:award, :grant_title => previous_grant_title, :budget_identifier => budget_identifier)
  award.save!
  award.grant_title = current_grant_title
  award.save!
end

Given /^a Publication with a pmcid "(.*)" which was changed from "(.*)" and pmid "(.*)"$/ do |current_pmcid, previous_pmcid, pmid|
  pub = Factory.build(:publication, :pmcid => previous_pmcid, :pmid => pmid)
  pub.save!
  pub.pmcid = current_pmcid
  pub.save!
end