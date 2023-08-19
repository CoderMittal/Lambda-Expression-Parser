def FreeV(term)
    if(term[0] == "(")
        # (\x.M) search in M
        tempList = FreeV(term[4..-2])
        tempList.delete(term[2])
        return tempList
    elsif(term[0] == '[')
        bracCount = 1
        tempList = []
        for i in 1..term.length
            if term[i]=='['
                bracCount += 1
            elsif term[i]==']'
                bracCount -=1
                if bracCount == 0
                    tempList1 = FreeV(term[1..(i-1)])
                    tempList2 = FreeV(term[(i+2)..(term.length-2)])
                    # [M][N] union of FV{M} and FV{N}
                    tempList = tempList1 | tempList2
                    break
                end
            end
        end
        return tempList
    else
        return [term]
    end
end

File.foreach("./tests/test_freeVars.txt") { |line| 
print FreeV line.chomp; 
print " is/are free variable(s) in "; 
print line.chomp ;
print "\n----------------------------------------"; puts; puts  }
