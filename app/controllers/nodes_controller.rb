class NodesController < ApplicationController
  def create
    @annoyer = Annoyer.find params.require(:node)['annoyer_id']
    @node = Node.new node_params

    if @node.save
      redirect_to @annoyer
    else
      render 'annoyers/show'
    end
  end

  def destroy
    node = Node.find params[:id]
    annoyer = Annoyer.find node.annoyer_id
    node.destroy

    redirect_to annoyer_path(annoyer)
  end

  private
    def node_params
      params.require(:node).permit(:title, :content, :annoyer_id)
    end
end
