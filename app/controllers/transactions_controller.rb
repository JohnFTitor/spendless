class TransactionsController < ApplicationController
  def index 
    @group = current_user.groups.find(params[:category_id])
    @transactions = @group.ordered_transactions
  end

  def new 
    @categories = current_user.groups
    operation = Operation.new
    id = params[:category_id]
    respond_to do |format|
      format.html { render :new, locals: { operation:, id: }}
    end
  end

  def create
    name = transaction_params[:name]
    amount = transaction_params[:amount]
    categories = transaction_params[:categories]
    transaction = Operation.new(name: name, amount: amount)
    transaction.author = current_user
    respond_to do |format|
      format.html do
        if transaction.save
          # First record is empty so gets deleted
          categories.shift

          first_category_id = categories[0]
          
          # Iterates through the categories and create relationships with the operation
          categories.each_with_index do |category_id, index|
            
            group = Group.find(category_id)
            GroupOperation.create(group: group, operation: transaction)
          end
          flash[:notice] = "Transaction created successfully"
          redirect_to(category_transactions_path(category_id: first_category_id))
        else
          @categories = current_user.groups
          flash.now[:alert] = 'Error: Please make sure to fill all fields with the proper input'
          render :new, status: 422, locals: { operation: transaction, id: params[:category_id] }
        end
      end
    end
  end

  private

  def transaction_params
    params.require(:operation).permit(:name, :amount, :categories => [])
  end
end
