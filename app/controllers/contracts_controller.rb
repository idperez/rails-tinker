# frozen_string_literal: true

class ContractsController < ApplicationController
  def index
    @contracts = Contract.all
  end
end
