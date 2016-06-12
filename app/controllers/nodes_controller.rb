class NodesController < ApplicationController
  def create
    validate_user params.require(:node)['annoyer_id'] do |annoyer|
      @annoyer = annoyer
      @node = Node.new(node_params)

      if @node.save
        redirect_to(@annoyer)
      else
        render('annoyers/show')
      end
    end
  end

  def destroy
    node = Node.find(params[:id])
    validate_user Annoyer.find(node.annoyer_id) do |annoyer|
      node.destroy
      redirect_to(annoyer_path(annoyer))
    end
  end

  private
    def node_params
      params.require(:node).permit(:title, :content, :annoyer_id)
    end

    def validate_user(annoyer_id)
      annoyer = Annoyer.find(annoyer_id)
      if current_user.id == annoyer.user_id
        yield annoyer
      else
        redirect_to(root_path)
      end
    end
end
