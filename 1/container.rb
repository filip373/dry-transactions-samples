require 'dry/container'
require_relative './users'

class Container
  extend Dry::Container::Mixin

  namespace "users" do
    register "validate" do
      Users::Validate.new
    end

    register "create" do
      Users::Create.new
    end
  end
end
