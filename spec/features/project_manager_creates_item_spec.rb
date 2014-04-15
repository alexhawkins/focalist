require 'spec_helper'

  #PM goes to the TODO creation page
  #PM submits new TODO description
  #PM sees confirmation message
  #PM sees newly saved TODO

feature 'Project manager creates ITEM' do
  scenario 'Successfully' do
    visit new_item_path
    fill_in 'Add an "Item" in your Inbox', with: 'Meet up with the team'
    click_button 'Save'
    expect( page ).to have_content('Your new ITEM was saved')
    expect( page ).to have_content('Meet up with the team')
  end
end