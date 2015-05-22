module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end
 
  # def flash_messages(opts = {})
  #   flash.each do |msg_type, message|
  #     concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do 
  #             concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' }, type: "button")
  #             concat message 
  #           end)
  #   end
  #   nil
  # end
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(javascript_tag("
                  $(function(){
                    $.notify({
                      message: '#{message}'
                    },{
                      type: '#{msg_type}',
                      delay: 5000,
                      allow_dismiss: true,
                      animate: {
                        enter: 'animated fadeInRight',
                        exit: 'animated fadeOutRight'
                      },
                      newest_on_top: true,
                      placement: {
                        from: 'top',
                        align: 'center'
                      }
                    });
                  });"))
    end
    nil
  end

  def current_user
    ac_current_user.nickname
  end
end
