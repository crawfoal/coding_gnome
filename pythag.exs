defmodule Pythag do
  def find_triples(max) do
    for a <- 1..max,
      b <- (a+1)..max,
      c <- (b+1)..max,
      a + b > c,
      a*a + b*b == c*c
    do
      {a, b, c}
    end
  end
end

