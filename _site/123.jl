function ForAcc(A, B, S, P, Acc)
   if A > B
      return Acc
   end 
   Acc = P(Acc, A)
   ForAcc(A+S, B, S, P, Acc)   
end

function Sum(x,y)
  return x + y
end

# суммирование всех значении в диапазоне
println( ForAcc(1,10,1,Sum,0) ) 
