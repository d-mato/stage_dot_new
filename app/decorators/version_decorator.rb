module VersionDecorator
  def target_link
    case item
    when Company
      link_to "#{item.name}の企業情報", user_company_path(item.user, item)
    when Interview
      link_to "#{item.company.name}の面談情報", user_interview_path(item.user, item)
    when Resume
      link_to 'レジュメ', user_path(item.user)
    end
  end
end
