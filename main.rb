# This is implementation of Linear Model and basic approach described in:
# http://mpref2012.lip6.fr/proceedings/RoosMPREF2012.pdf
#
# Consider the data in Table 1. There are five reviewers
# (ri) and five papers (pj). The original scores yi j from the reference are here
# multiplied by 10 and are thus in the range from 0 to 10. Consisting
# of only 15 scores in total, this data set is very small

require 'csv'

reviews = [
  [ 6 , 6 , 6 ,'-','-'],
  [ 3 ,'-','-', 4 ,'-'],
  [ 3 ,'-','-','-', 4 ],
  ['-', 3 , 3 , 4 , 4 ],
  ['-', 3 , 3 , 4 , 4 ],
].freeze

puts 'Initial reviews:'

reviews.each do |row|
  puts row.inspect
end

papers = reviews.first.size
reviewers = reviews.size

puts "\nData set size is #{reviewers} x #{papers}"

def get_mu(reviews)
  elements = reviews.dup.flatten
  count_mean(elements)
end

def alpha(r, mu, reviews)
  elements = reviews[r-1].dup
  count_mean(elements) - mu
end

def beta(p, mu, reviews)
  elements = reviews.map { |row| row[p-1] }
  count_mean(elements) - mu
end

def count_mean(elements)
  elements.delete_if { |x| x == '-' }
  elements.reduce(0,:+)/elements.size.to_f
end

def y(alpha,beta,mu)
  mu + alpha + beta
end

# count mu
mu = get_mu(reviews)
puts "mu: #{mu}"

# count alphas
a = []
reviewers.times do |i|
  a << alpha(i+1, mu, reviews)
end
puts "alphas: #{a}"

# count betas
b = []
papers.times do |i|
  b << beta(i+1, mu, reviews)
end
puts "betas: #{b}"

# calculating y[i,j]
# yi j = µ +αi +βj +εij
# εij considered as 0 for this calculation
y_array = []
reviewers.times do |i|
  y_array[i] = []
  papers.times do |j|
    y_array[i] << reviews[i][j] == '-' ? '-' : y(a[i], b[j], mu)
  end
end

puts "\nRecalculated reviews:"
y_array.each do |row|
  puts row.inspect
end
