# frozen_string_literal: true

class BaseQuery < BaseService
  def initialize(scope:, **params)
    @scope = scope
    @params = params
  end

  def call
    @query = default_filters

    params.each do |method, value|
      @query = send(method, value)
    end

    query
  end

  private

  attr_reader :scope, :params, :query

  def default_filters
    scope
  end

  def omit_id(id)
    query.where.not(id:)
  end
end
