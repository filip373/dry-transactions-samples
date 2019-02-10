require 'dry/transaction'
require_relative './container'

# we can use a container to configure a transaction with reusable operations
class CreateUser
  include Dry::Transaction(container: Container)

  step :validate, with: "users.validate"
  step :create, with: "users.create"
end

create_user = CreateUser.new
result = create_user.call(name: 'Adam')
puts "transaction result: #{result}"
