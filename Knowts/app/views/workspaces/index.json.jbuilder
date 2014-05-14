json.array!(@workspaces) do |workspace|
  json.extract! workspace, :id, :name, :description
  json.url workspace_url(workspace, format: :json)
end
