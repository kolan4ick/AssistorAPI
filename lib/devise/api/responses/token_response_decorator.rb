module Devise::Api::Responses::TokenResponseDecorator
  def body
    default_body.merge({ resource_owner: {
      id: resource_owner.id,
      email: resource_owner.email,
      name: resource_owner.name,
      surname: resource_owner.surname,
      username: resource_owner.username,
      created_at: resource_owner.created_at,
      updated_at: resource_owner.updated_at
    } })
  end
end