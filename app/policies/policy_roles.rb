# Role questions shared by the policies and their scopes.
# They use the methods of the role enum on User; no role name is written as a string.
module PolicyRoles
  private

  def signed_in?
    user.present?
  end

  def owner?
    user&.owner? || false
  end

  def counter?
    user&.counter? || false
  end

  def mechanic?
    user&.mechanic? || false
  end
end