require 'jsv/context'

module JSV
  module_function

  def create_context
    Context.new
  end

  def create_environment(env)
    create_context.environment(env)
  end
end
