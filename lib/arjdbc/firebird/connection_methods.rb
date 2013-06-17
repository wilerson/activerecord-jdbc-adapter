ArJdbc::ConnectionMethods.module_eval do
  def firebird_connection(config)
    begin
      require 'jdbc/firebird'
      ::Jdbc::FireBird.load_driver(:require)
    rescue LoadError # assuming driver.jar is on the class-path
    end

    config[:host] ||= 'localhost'
    config[:port] ||= 3050
    config[:url] ||= begin
      "jdbc:firebirdsql://#{config[:host]}:#{config[:port]}/#{config[:database]}"
    end
    config[:driver] ||= ::Jdbc::FireBird.driver_name
    config[:adapter_spec] ||= ::ArJdbc::FireBird

    puts config.inspect

    jdbc_connection(config)
  end
  # alias_method :jdbcfirebird_connection, :firebird_connection
end
