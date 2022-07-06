# frozen_string_literal: true

describe BaseService do
  describe '.call' do
    specify { expect { described_class.call }.to raise_error(NotImplementedError) }
  end
end
