module Segment
  class TablesController < ::Admin::BaseController
    def create
      @table = Table.new(model: params[:model], title: params[:title])
      @table.save
      redirect_to [main_app, @table.model_klass, view: @table.id]
    end
  end
end
