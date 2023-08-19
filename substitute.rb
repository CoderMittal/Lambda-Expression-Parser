def FreeV(term)
    if(term[0] == "(")
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

# substitution 
def Subst(term, var, subst)
    if(term[0] == "(")
        if(term[2] == var)
            return term
        elsif(FreeV(subst).include?(term[2]))
            temp = Alpha(term, term[2])
            return Subst(temp, var, subst)
        else
            return "(\\" + term[2] + "." + Subst(term[4..-2], var, subst) + ")"
        end
    elsif(term[0] == '[')
        bracCount = 1
        for i in 1..term.length
            if term[i]=='['
                bracCount += 1
            elsif term[i]==']'
                bracCount -=1
                if bracCount == 0
                    return "[" + Subst(term[1..(i-1)], var, subst) + "]" +  "[" + Subst(term[(i+2)..(term.length-2)], var, subst) +"]"
                end
            end
        end
    else
        if(term == var)
            return subst
        else
            return term
        end
    end
end

# alpha reduction 
def Alpha(term, var)
    if(term[0] == "(")
        if(term[2] == var)
            for i in 2..term.length
                if term[i] == var
                    term[i] = term[i].upcase
                end
            end
            return term
        else
            return  term[0..3] + Alpha(term[4..(-2)], var) + term[-1]
        end
    elsif(term[0] == '[')
        bracCount = 1
        for i in 1..term.length
            if term[i]=='['
                bracCount += 1
            elsif term[i]==']'
                bracCount -=1
                if bracCount == 0
                    return "[" + Alpha(term[1..(i-1)], var) + "]" +  "[" +  Alpha(term[(i+2)..(term.length-2)], var) +"]"
                end
            end
        end
    else
        return term
    end
end


File.foreach("./tests/test_substitute.txt") { |line| print Subst((line.chomp).split[0],(line.chomp).split[1],(line.chomp).split[2]) ; puts}