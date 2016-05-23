module CommentsHelper # :nodoc:
  # Helper method to help hide the comment when prepended
  def element_hide(flag)
    flag ? 'display:none;' : ''
  end
end
