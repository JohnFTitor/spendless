class TransactionsController < ApplicationController
  def index 
    @group = current_user.groups.find(params[:category_id])
    @transactions = @group.ordered_transactions
  end
end
