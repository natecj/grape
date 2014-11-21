module Grape
  module Validations
    class AllOrNoneOfValidator < Validator
      attr_reader :params

      def validate!(params)
        @params = params
        if only_subset_present
          raise Grape::Exceptions::Validation, params: attrs.map(&:to_s), message_key: :all_or_none_of
        end
        params
      end

      private

      def only_subset_present
        keys_in_common.length > 0 && keys_in_common.length < attrs.length
      end

      def keys_in_common
        (attrs.map(&:to_s) & params.stringify_keys.keys).map(&:to_s)
      end
    end
  end
end
