class ChangeDatesFormat < ActiveRecord::Migration[6.0]
  def change
    # remove_column :reservations, :startDate, :datetime
    # remove_column :reservations, :endDate, :datetime
    # add_column :reservations, :start_date, :time
    # add_column :reservations, :end_date, :time
    rename_column :reservations, :startDate, :start_date
    rename_column :reservations, :endDate, :end_date
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
