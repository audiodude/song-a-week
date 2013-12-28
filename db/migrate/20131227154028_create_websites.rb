class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.references :user
      t.string :url
    end

    reversible do |dir|
      dir.up do
        #add a foreign key
        execute <<-SQL
          ALTER TABLE websites
            ADD CONSTRAINT fk_users_websites
            FOREIGN KEY (user_id)
            REFERENCES users(id)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE websites
            DROP CONSTRAINT fk_users_websites
        SQL
      end
    end

  end
end
