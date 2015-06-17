require 'ostruct'

class Utils
    def self.make(hash)
        #struct = OpenStruct.new(hash)
        object = OpenStruct.new()
        if (!hash.kind_of?(Hash))
            raise ArgumentError('Argument is not of type Hash')
        end
        hash.keys.each do |key|
            #puts key + " " + hash[key].class().to_s()
            if hash[key].respond_to?('keys')
                object[key] = make(hash[key])
            elsif hash[key].kind_of?(Array)
                subArray = Array.new()
                hash[key].each do |subValue|
                    if subValue.respond_to?('keys')
                        subArray << make(subValue)
                    else
                        subArray << subValue
                    end
                    object[key] = subArray
                end
            else
                object[key] = hash[key]
            end
        end
        return object
    end
end
