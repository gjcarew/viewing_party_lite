module ApplicationHelper

  def flash_class(level)
    case level
        when 'notice' then "alert alert-primary"
        when 'success' then "alert alert-success"
        when 'error' then "alert alert-danger"
        when 'alert' then "alert alert-secondary"
    end
  end
end
