module TailwindHelper
  def tailwind_class_for(flash_type)
    {
      success: "success-flash hover:success-flash-hover",
      error: "error-flash hover:error-flash-hover",
      alert: "warn-flash hover:warn-flash-hover",
      notice: "notice-flash hover:notice-flash-hover"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end
end
