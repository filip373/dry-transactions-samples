require 'dry/transaction'
require 'dry/monads/result'
require_relative '../1/container'

# we can extend existing operations by injecting them into constructor
class CreateUser
  include Dry::Transaction(container: Container)

  step :prepare
  step :validate, with: "users.validate"
  step :create, with: "users.create"

  private

  def prepare(input)
    Success(input)
  end
end

prepare = -> input { Dry::Monads::Success(input.merge(name: "#{input[:name]}!!")) }
create  = -> user  { Dry::Monads::Failure([:could_not_create, user]) }

create_user = CreateUser.new(prepare: prepare, create: create)
result = create_user.call(name: "Jane", email: "jane@doe.com")
puts "transaction result: #{result}"
