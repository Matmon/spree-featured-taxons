module AuthenticationHelpers
  def sign_in_as!(user)
    visit '/login'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => 'secret'
    click_button 'Login'
  end

end

RSpec.configure do |c|
  c.include AuthenticationHelpers, :type => :request
end

shared_context "authenticated as admin" do
  before(:each) { sign_in_as!(Factory(:admin_user)) }
end
