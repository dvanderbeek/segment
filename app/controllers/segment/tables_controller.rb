module Segment
  class TablesController < ::Admin::BaseController
    before_action :set_table

    def create
      @table = Table.new(model: params[:model])
      @table.save
      redirect_to [main_app, :admin, @table.model_klass, view: @table.id], notice: "Table created successfully."
    end

    def update
      @table.update(permitted_params)
      redirect_to [main_app, :admin, @table.model_klass, view: @table.id], notice: "Table updated successfully."
    end

    def destroy
      @table.destroy
      redirect_to [main_app, :admin, @table.model_klass], notice: "Table deleted successfully."
    end

    private

      def permitted_params
        params.fetch(:table, {}).permit(:title, :combinator, filters_attributes: [:id, :condition, :value, :_destroy])
      end

      def set_table
        @table = Table.find(params[:id]) if params[:id]
      end
  end
end
