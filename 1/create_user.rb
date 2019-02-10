require "dry/transaction"

class CreateUser
  include Dry::Transaction

  step :validate
  step :create
  step :notify

  private

  def validate(input)
    puts 'user validated'
    Success(input)
    #Failure('bad user name!')
  end

  def create(input)
    puts 'user created'
    Success(input)
  end

  def notify(input, email: 'default@email.example')
    puts "user notified at #{email}"
    Success(input)
  end
end

create_user = CreateUser.new

result = create_user.call(name: 'Adam')
puts "transaction result: #{result}"

create_user.call(name: "Tony", email: "tony@doe.com") do |m|
  m.success do |user|
    puts "Created user for #{user[:name]}!"
  end

  m.failure :validate do |validation|
    # Runs only when the transaction fails on the :validate step
    puts "Please provide a valid user."
  end

  m.failure do |error|
    # Runs for any other failure
    puts "Couldn’t create this user."
  end
end

create_user
  .with_step_args(notify: [email: "foo@bar.com"])
  .call(name: "Jane", email: "jane@doe.com")
