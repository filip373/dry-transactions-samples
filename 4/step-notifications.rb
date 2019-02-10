require 'dry/transaction'

NOTIFICATIONS = []

# we can subscribe to event notifications on any step within transaction in a pub/sub way
class CreateUser
  include Dry::Transaction

  step :validate
  step :create

  private

  def validate(input)
    puts 'user validated'
    Success(5)
  end

  def create(input)
    puts 'user created'
    Success(input)
  end
end

module UserCreationListener
  extend self

  def on_step(event)
    args = event[:args]
    NOTIFICATIONS << "Started creation of #{args}"
  end

  def on_step_succeeded(event)
    args = event[:args]
    NOTIFICATIONS << "#{args} created"
  end

  def on_step_failed(event)
    args = event[:args]
    NOTIFICATIONS << "#{args} creation failed"
  end
end

create_user = CreateUser.new
create_user.subscribe(create: UserCreationListener)
result = create_user.call(name: "Jane", email: "jane@doe.com")
puts "transaction result: #{result}"
