module InterviewsHelper
  def category_label(category)
    class_name = category == '面接' ? 'formal' : 'casual'
    "<span class='label #{class_name}'>#{category}</span>".html_safe
  end
end
