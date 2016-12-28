module ApplicationHelper
  def body_classes
    "page_#{controller.controller_name} action_#{controller.action_name}"
  end
end
