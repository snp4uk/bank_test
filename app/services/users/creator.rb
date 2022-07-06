# frozen_string_literal: true

module Users
  class Creator < BaseService
    def initialize(params)
      @params = params
    end

    def call
      User.create(params, &:build_bank_account)
    end

    private

    attr_reader :params
  end
end
