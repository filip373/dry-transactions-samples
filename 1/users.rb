require "dry/container"
require "dry/transaction"
require "dry/transaction/operation"

module Users
  class Validate
    include Dry::Transaction::Operation

    def call(input)
      puts 'user validated in custom operation'
      Success(input)
    end
  end

  class Create
    include Dry::Transaction::Operation

    def call(input)
      puts 'user validated in custom operation'
      Success(input)
    end
  end
end
