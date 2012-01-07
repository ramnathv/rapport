% Crosstable
% (Username not set) (E-mail address not set)
% 2011-04-26 20:25 CET

## Description

Returning the Chi-squared test of two given variables with count,
percentages and Pearson's residuals table.

### Variable description

Two variables specified: \* "gender" ("Gender") with 709 and \* "dwell"
("Dwelling") with 709 valid values.

### Counts

           **city**   **small town**   **village**
  -------- ---------- ---------------- -------------
  male     380        30               22
  female   262        6                9

### Percentages

           **city**   **small town**   **village**
  -------- ---------- ---------------- -------------
  male     0.5360     0.0423           0.0310
  female   0.3695     0.0085           0.0127

#### Row percentages

           **city**   **small town**   **village**
  -------- ---------- ---------------- -------------
  male     0.8796     0.0694           0.0509
  female   0.9458     0.0217           0.0325

#### Column percentages

           **city**   **small town**   **village**
  -------- ---------- ---------------- -------------
  male     0.5919     0.8333           0.7097
  female   0.4081     0.1667           0.2903

### Chi-squared test

              **X-squared**   **df**   **p-value**
  ----------- --------------- -------- -------------
  X-squared   9.72            2.00     0.01

It seems that a real association can be pointed out between *gender* and
*dwell* by the *Pearson's Chi-squared test* (χ=9.7188 at the degree of
freedom being 2) at the significance level of 0.0078. Based on Goodman
and Kruskal's lambda it seems that *dwell* (λ=0.7581) has an effect on
*gender* (λ=0) if we assume both variables to be nominal. The
association between the two variables seems to be weak based on Cramer's
V (0.0828).

#### Pearson's residuals

           **city**   **small town**   **village**
  -------- ---------- ---------------- -------------
  male     -2.9409    2.8277           1.1713
  female   2.9409     -2.8277          -1.1713

#### Mosaic chart

![image](66ba5aa603e08fec150848bb688f0953.png)