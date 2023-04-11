# frozen_string_literal: true

gem 'tk'
require 'tk'
root = TkRoot.new { title 'Tax Calculator' }

# Get income
TkLabel.new(root) do
  text 'Income:'
  grid('row' => 0, 'column' => 0, 'sticky' => 'w')
end
income = TkEntry.new(root) { grid('row' => 0, 'column' => 1) }
# SSS
TkLabel.new(root) do
  text 'SSS contribution:'
  grid('row' => 0, 'column' => 3, 'sticky' => 'w')
end
SSS = TkLabel.new(root) { grid('row' => 0, 'column' => 4) }
# philhealth
TkLabel.new(root) do
  text 'PhilHealth contribution:'
  grid('row' => 2, 'column' => 3, 'sticky' => 'w')
end
PhilHealth = TkLabel.new(root) { grid('row' => 2, 'column' => 4) }
# pag-ibig
TkLabel.new(root) do
  text 'Pag-ibig contribution:'
  grid('row' => 3, 'column' => 3, 'sticky' => 'w')
end
Pagibig = TkLabel.new(root) { grid('row' => 3, 'column' => 4) }
# Total
TkLabel.new(root) do
  text 'Total contribution:'
  grid('row' => 5, 'column' => 3, 'sticky' => 'w')
end
Total = TkLabel.new(root) { grid('row' => 5, 'column' => 4) }
# tax Amount
TkLabel.new(root) do
  text 'Tax Amount:'
  grid('row' => 2, 'column' => 0, 'sticky' => 'w')
end
tax_amount = TkLabel.new(root) { grid('row' => 2, 'column' => 1) }
# net Pay
TkLabel.new(root) do
  text 'Net pay:'
  grid('row' => 3, 'column' => 0, 'sticky' => 'w')
end
net_pay = TkLabel.new(root) { grid('row' => 3, 'column' => 1) }

def setSSSContribution(income_val)
  table = [
    [4250, 4749.99, 202.5],
    [4750, 5249.99, 225],
    [5250, 5749.99, 247.5],
    [5750, 6249.99, 270],
    [6250, 6749.99, 292.5],
    [6750, 7249.99, 315],
    [7250, 7749.99, 337.5],
    [7750, 8249.99, 360],
    [8250, 8749.99, 382.5],
    [8750, 9249.99, 405],
    [9250, 9749.99, 427.5],
    [9750, 10_249.99, 450],
    [10_250, 10_749.99, 472.5],
    [10_750, 11_249.99, 495],
    [11_250, 11_749.99, 517.5],
    [11_750, 12_249.99, 540],
    [12_250, 12_749.99, 562.5],
    [12_750, 13_249.99, 585],
    [13_250, 13_749.99, 607.5],
    [13_750, 14_249.99, 630],
    [14_250, 14_749.99, 652.5],
    [14_750, 15_249.99, 675],
    [15_250, 15_749.99, 697.5],
    [15_750, 16_249.99, 720],
    [16_250, 16_749.99, 742.5],
    [16_750, 17_249.99, 765],
    [17_250, 17_749.99, 787.5],
    [17_750, 18_249.99, 810],
    [18_250, 18_749.99, 832.5],
    [18_750, 19_249.99, 855],
    [19_250, 19_749.99, 877.5],
    [19_750, 20_249.99, 900],
    [20_250, 20_749.99, 922.5],
    [20_750, 21_249.99, 945],
    [21_250, 21_749.99, 967.5],
    [21_750, 22_249.99, 990],
    [22_250, 22_749.99, 1012.5],
    [22_270, 23_249.99, 1035],
    [23_250, 23_749.99, 1057.5],
    [23_750, 24_249.99, 1080],
    [24_250, 24_279.99, 1102.5],
    [24_750, 25_249.99, 1125],
    [25_250, 25_749.99, 1147.5],
    [25_750, 26_249.99, 1170],
    [26_250, 26_749.99, 1192.5],
    [26_750, 27_249.99, 1215],
    [27_250, 27_749.99, 1237.5],
    [27_750, 28_249.99, 1260],
    [28_250, 28_749.99, 1282.5],
    [28_750, 29_249.99, 1305],
    [29_250, 29_749.99, 1327.5],
    [29_750, 1350]
  ]

  (0...table.length).each do |i|
    return 1350 if income_val >= 29_750
    return 180 if income_val < 4250
    return table[i][2] if income_val >= table[i][0] && income_val <= table[i][1]
  end
end

def setPhilHealthContribution(income_val)
  if income_val < 10_000
    450 / 2
  elsif income_val >= 10_000.01 && income_val < 89_999.99
    (income_val * 0.045) / 2
  else
    4050
  end
end

def setTaxVal(income)
  if income <= 20_833
    0
  elsif income <= 33_332
    0.15 * (income - 20_833)
  elsif income <= 66_666
    1_875 + ((income - 33_333) * 0.20)
  elsif income <= 166_666
    8_541.8 + ((income - 66_667) * 0.25)
  elsif income <= 666_666
    33_541.8 + ((income - 166_667) * 0.30)
  else
    183_541.8 + ((income - 666_667) * 0.35)
  end
end

def setPagIbig(income_val)
  if income_val <= 1500
    income_val*0.01
  elsif income_val>1500 && income_val< 5000
    income_val*0.02
  else
    100
  end
end

# calculate tax
calculate_tax = proc {
  income_val = income.get.to_f

  SSS_contribution = setSSSContribution(income_val)
  PhilHealth_contribution = setPhilHealthContribution(income_val)
  Pagibig_Contribution = setPagIbig(income_val)
  Total_contribution = SSS_contribution + PhilHealth_contribution + Pagibig_Contribution
  tax_amount_val = setTaxVal(income_val-Total_contribution)

  net_pay_val = income_val - tax_amount_val - SSS_contribution - PhilHealth_contribution - Pagibig_Contribution
  tax_amount.text('%.2f' % tax_amount_val)
  net_pay.text('%.2f' % net_pay_val)
  Total.text(format('%.2f', Total_contribution))
  PhilHealth.text(format('%.2f', PhilHealth_contribution))
  Pagibig.text(format('%.2f', Pagibig_Contribution))
  SSS.text(format('%.2f', SSS_contribution))
}

# create calculate button
TkButton.new(root) do
  text 'Calculate'
  command calculate_tax
  grid('row' => 7, 'column' => 4)
end

# set focus on income entry field
income.focus
net_pay.focus
Tk.mainloop
