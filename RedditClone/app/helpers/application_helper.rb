module ApplicationHelper

  def hidden_method_input(action)
    <<-HTML.html_safe
      <input type="hidden" name="_method" value="#{action}">
    HTML
  end

  def auth_token
    <<-HTML.html_safe
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTML
  end

end
