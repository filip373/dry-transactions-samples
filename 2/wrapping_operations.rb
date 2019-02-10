require 'dry/transaction'
require_relative '../1/container'

# for reusing and extending the existing configuration from a container

class CreateUser
  include Dry::Transaction(container: Container)

  step :validate, with: "users.validate"
  step :create, with: "users.create"

  private

  def validate(input)
    adjusted_input = upcase_values(input)
    super(adjusted_input)
  end

  def upcase_values(input)
    input.each_with_object({}) { |(key, value), hash|
      hash[key.to_sym] = value.upcase
    }
  end
end

create_user = CreateUser.new
result = create_user.call(name: "Jane", email: "jane@doe.com")
puts "transaction result: #{result}"
