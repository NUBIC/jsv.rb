require 'spec_helper'

module JSV
  describe Context do
    describe '#inspect' do
      it 'works across garbage collections' do
        ctx = JSV::Context.new
        env = ctx.create_environment
        report = env.validate('{}', '{}')
        runs_before = GC.count

        until GC.count > runs_before do
          (1...1000).to_a
        end

        lambda { ctx.inspect }.should_not raise_error
      end
    end
  end
end
