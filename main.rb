require 'csv'

# classical statistical approach from the field of linear models
# to uses the analysis of variance and can thus be realized by means
# of existing statistical software.

class BiasedReviewer
  # Load data file, that is placed in the same directory
  # named data.csv with ',' symbol used as a delimiter
  def initialize
    begin
      @data = CSV.read('./data.csv')
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end

  # This is a placeholder for parsing data algorythm
  def parse_data
    @data
  end

  # Here we're going to aggregate all the statistics results
  def calculate_result
    while (@data) do |i,j|
      linear_model(i,j)
    end
  end

  private

  # The strategy in the following is to ignore the discretization in the
  # statistics and to assume that the discretized data belong to the truly
  # linear model

  def linear_model(i,j)
    y = µ + α(i) + β(j) + ε(i,j)
  end

  def µ()
    # µ is the overall mean of all scores given
  end

  def α(i)
    # α(i) is the mean difference between the scores of reviewer r(i) and µ
  end

  def β(i,j)
    # β(j) is the mean difference between the scores of paper p(j) and µ
  end

  def ε(i,j)
    # ε(i,j) is a random error for (i,j)
  end

end
