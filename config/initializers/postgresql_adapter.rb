module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter < AbstractAdapter
      # Override this routine since it causes an error when we
      # try and drop the referential integrity while build our
      # OO model.                       # 21-Jun-2013/PL
      def supports_disable_referential_integrity? #:nodoc:
        false
      end
    end
  end
end
