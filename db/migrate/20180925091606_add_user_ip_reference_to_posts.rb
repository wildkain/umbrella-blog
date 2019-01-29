class AddUserIpReferenceToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :user_ip, index: true
  end
end
