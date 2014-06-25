class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :configs 

  def configs
    { active_schema: 1 }
  end
end