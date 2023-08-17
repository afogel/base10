module ApplicationHelper
  include Pagy::Frontend

  def turbo_id_for(obj)
    obj.persisted? ? obj.id : obj.hash
  end

  def sort_link_to(name, column, **options)
    if params[:sort] == column.to_s
      direction = params[:direction] == "asc" ? "desc" : "asc"
    else
      direction = "asc"
    end

    link_to name, request.params.merge(sort: column, direction: direction), **options
  end
end
