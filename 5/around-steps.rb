require 'dry/container'
require 'dry/transaction'

class DbError < StandardError; end

class MyContainer
  extend Dry::Container::Mixin

  register "transaction" do |input, &block|
    result = nil

    begin
      puts 'starting a transaction'
      result = block.(Dry::Monads::Success(input))
      raise DbError if result.failure?
      puts 'closing a transaction'
      result
    rescue DbError
      puts 'rescuing an error'
      result
    end
  end
end

class CreateUser
  include Dry::Transaction(container: MyContainer)

  around :transaction, with: 'transaction'
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

create_user = CreateUser.new
result = create_user.call(name: 'Adam')
puts "transaction result: #{result}"
