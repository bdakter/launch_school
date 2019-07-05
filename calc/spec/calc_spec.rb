require_relative './spec_helper'
require '/home/boruch/repositories/ls/calc/calc.rb'

describe "#get_data" do
  # TODO: simulate user input
end

describe "#compute" do
  it "sums two numbers" do
    oper = :a

    sum1  = compute(1,    2,	oper)		# 3
    sum2	= compute(100,  99, oper)		# 199
    sum3	= compute(0,    0,	oper)		# 0
    sum4	= compute(-2,   1,	oper)		# -1
    sum5	= compute(3,   -4, 	oper)		# -1
    sum6	= compute(-3,  -4, 	oper)		# -7
    sum7	= compute(0,    5,	oper)		# 5
    sum8	= compute(5,   0,		oper)   # 5

    expect( sum1 ).to eq( 3   )
    expect( sum2 ).to eq( 199 )
    expect( sum3 ).to eq( 0   )
    expect( sum4 ).to eq( -1  )
    expect( sum5 ).to eq( -1  )
    expect( sum6 ).to eq( -7  )
    expect( sum7 ).to eq( 5   )
    expect( sum8 ).to eq( 5   )


  end

  it "subtracts two numbers" do

  end

  it "multiplies two numbers" do

  end

  it "divides two numbers" do

  end

end
