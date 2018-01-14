def ask(message)
  print message
  STDIN.gets.chomp
end

namespace :users do
  desc 'Creates an admin user'
  task admin: :environment do
    #Ask for credentials
    puts 'Please give admin credentials:'
    email = ask('Email: ')
    password = ask('Password (at least 8 chars): ')
    first_name = ask('First name: ')
    last_name = ask('Last name: ')
    ssn = ask('SSN: ')

    # Create user
    user = User.new(
      email: email,
      password: password,
      password_confirmation: password,
      admin: true,
      first_name: first_name,
      last_name: last_name,
      ssn: ssn,
      lang: 'en'
    )
    user.save!

  end

end
