class AddTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :api_token, :string

    User.all.each do |user|
      user.api_token = SecureRandom.urlsafe_base64.to_s if user.api_token.nil?
    end

  end
end
