class SqlTasksController < ApplicationController
  def show_sql(file_path)
    if File.exist?(file_path)
      File.read(file_path)
    else
      "SQL file not found: #{file_path}"
    end
  end

  def index
    base_path = "/rails/sql/"

    path_hash = {
      task7: [ "task_7/create.sql" ],
      task8: [ "task_8/create_newly_acquired_stocks.sql", "task_8/create_stock_prices.sql", "task_8/inset_newly_acquired_stocks.sql" ],
      task9: [ "task_9/Report.sql" ],
      task10: [ "task_10/insert_new_stock.sql", "task_10/outer_joint.sql" ],
      task11: [ "task_11/task_11.sql" ],
      task12: [ "task_12/task_12.sql" ],
      task13: [ "task_13/stocks_i_like.sql" ]
    }

    @sql_files_content = {}

    path_hash.each do |task, files|
      files.each do |file|
        file_path = base_path + file
        @sql_files_content["#{task}/#{file}"] = show_sql(file_path)  # Combine task and file name for unique keys
      end
    end
  end
end
