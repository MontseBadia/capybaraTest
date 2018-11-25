require 'capybara/rspec'
require 'rspec/expectations'


extend RSpec::Matchers


Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium
  config.app_host = 'https://www.amazon.es/'
  config.exact = true
  config.match = :first
end

driver = Capybara::Session.new(:selenium)


describe "When navigating to amazon.es", type: :feature do
  before :each do
    visit 'https://www.amazon.es/'
  end
  
  it "the title is correct" do
    expect(title.include? "Amazon.es: compra online de electrónica, libros, deporte, hogar, moda y mucho más.").to be true
  end
  
  it "users can look for night tables" do
    fill_in('field-keywords', with: 'Mesita de noche')
    find_button('Ir').click
    find('#leftNavContainer').find('span', text: 'Armarios para baño', match: :prefer_exact).click

    expect(page).to have_selector('#s-result-info-bar-content')
  end
end