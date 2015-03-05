module AuthenticationHelper
  def register_user
    click_link 'Sign up'
    fill_in 'user[email]', with: Faker::Internet.email
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
  end

  def confirm_and_sign_in(user)
    user.confirm!
    sign_in user
  end

  def sign_in(user)
    visit root_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end
end
