# Replace the default Rails <div class="field_with_errors"> wrapper so that
# invalid form inputs render with Bootstrap's `is-invalid` class instead.
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html = html_tag.to_s

  # Add `is-invalid` to inputs/selects/textareas; leave labels untouched-ish.
  if html =~ /<(input|select|textarea)/
    if html =~ /class="([^"]*)"/
      html.sub(/class="([^"]*)"/, 'class="\1 is-invalid"').html_safe
    else
      html.sub(/<(input|select|textarea)/, '<\1 class="is-invalid"').html_safe
    end
  else
    html.html_safe
  end
end
