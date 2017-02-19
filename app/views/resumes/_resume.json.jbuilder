json.extract! resume, :id, :user_id, :body, :created_at, :updated_at
json.url resume_url(resume, format: :json)