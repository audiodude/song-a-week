class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest
      t.string :status
      t.string :name
      t.string :tagline
      t.text :bio
      t.text :application
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        #add uniqueness constraints
        execute <<-SQL
            ALTER TABLE users
            ADD CONSTRAINT users_uniq_email
            UNIQUE (email)
        SQL
        execute <<-SQL
            ALTER TABLE users
            ADD CONSTRAINT users_uniq_username
            UNIQUE (username)
        SQL
      end
      dir.down do
        execute <<-SQL
            ALTER TABLE users
            DROP CONSTRAINT users_uniq_email
        SQL
        execute <<-SQL
            ALTER TABLE users
            DROP CONSTRAINT users_uniq_username
        SQL
      end
    end

  end
end
