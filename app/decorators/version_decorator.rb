module VersionDecorator
  def target_link
    case item
    when Company
      link_to item.name, user_company_path(item.user, item)
    when Interview
      link_to "#{item.company.name}の#{item.category}", user_interview_path(item.user, item)
    when Resume
      link_to 'レジュメ', user_path(item.user)
    end
  end

  def event_label
    case event
    when 'create'
      '作成'
    when 'update'
      '更新'
    else
      '更新'
    end
  end
end
