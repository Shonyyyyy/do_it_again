class GraphqlController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def query
    variables = params[:variables] || {}
    schema = GraphQL::Schema.new(query: QueryType)
    result_hash = schema.execute(params[:query], variables: variables)
    render json: result_hash
  end
end
