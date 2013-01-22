module DishtypesHelper
  def current_dishtype_selector
    collection_select(:dishtype, :id, Dishtype.all, :id, :name, {:prompt => "Select a Dish type"})
  end
end

