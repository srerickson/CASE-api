class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :configs 

  def configs
    { active_schema_id: 1 }
  end
end