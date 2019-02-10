require_relative './my_app'

# reusing the defined MyApp module for an extracted custom configuration

class CreateUser
  include MyApp::Transaction

  # Operations will be resolved from the `Container` specified above
  step :validate, with: "users.validate"
  step :create, with: "users.create"
end

create_user = CreateUser.new
result = create_user.call(name: 'Adam')
puts "transaction result: #{result}"
