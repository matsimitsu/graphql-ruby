# frozen_string_literal: true
module GraphQL
  class Query
    # This object can be `ctx` in places where there is no query
    class NullContext
      class NullWarden < GraphQL::Schema::Warden
        def visible?(t); true; end
        def visible_field?(t); true; end
        def visible_type?(t); true; end
      end

      attr_reader :schema, :query, :warden

      def initialize
        @query = nil
        @schema = GraphQL::Schema.new
        @warden = NullWarden.new(
          GraphQL::Filter.new,
          context: self,
          schema: @schema,
        )
      end

      class << self
        extend GraphQL::Delegate

        def instance
          @instance = self.new
        end

        def_delegators :instance, :query, :schema, :warden
      end
    end
  end
end
