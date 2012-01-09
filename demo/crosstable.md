% Crosstable
% Rapport package team @ https://github.com/aL3xa/rapport
% 2011-04-26 20:25 CET

## Description

Returning the Chi-squared test of two given variables with count,
percentages and Pearson's residuals table.

### Variable description

Two variables specified:

-   "gender" ("Gender") with 709 and
-   "dwell" ("Dwelling") with 709 valid values.

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

## Description

Returning the Chi-squared test of two given variables with count,
percentages and Pearson's residuals table.

### Variable description

Two variables specified:

-   "email" ("Email usage") with 709 and
-   "dwell" ("Dwelling") with 709 valid values.

### Counts

                **city**   **small town**   **village**
  ------------- ---------- ---------------- -------------
  never         12         0                1
  very rarely   34         1                3
  rarely        46         3                2
  sometimes     76         6                8
  often         113        11               5
  very often    106        5                5
  always        255        10               7

### Percentages

                **city**   **small town**   **village**
  ------------- ---------- ---------------- -------------
  never         0.0169     0.0000           0.0014
  very rarely   0.0480     0.0014           0.0042
  rarely        0.0649     0.0042           0.0028
  sometimes     0.1072     0.0085           0.0113
  often         0.1594     0.0155           0.0071
  very often    0.1495     0.0071           0.0071
  always        0.3597     0.0141           0.0099

#### Row percentages

                **city**   **small town**   **village**
  ------------- ---------- ---------------- -------------
  never         0.9231     0.0000           0.0769
  very rarely   0.8947     0.0263           0.0789
  rarely        0.9020     0.0588           0.0392
  sometimes     0.8444     0.0667           0.0889
  often         0.8760     0.0853           0.0388
  very often    0.9138     0.0431           0.0431
  always        0.9375     0.0368           0.0257

#### Column percentages

                **city**   **small town**   **village**
  ------------- ---------- ---------------- -------------
  never         0.0187     0.0000           0.0323
  very rarely   0.0530     0.0278           0.0968
  rarely        0.0717     0.0833           0.0645
  sometimes     0.1184     0.1667           0.2581
  often         0.1760     0.3056           0.1613
  very often    0.1651     0.1389           0.1613
  always        0.3972     0.2778           0.2258

### Chi-squared test

              **X-squared**   **df**   **p-value**
  ----------- --------------- -------- -------------
  X-squared   14.37           12.00    0.28

It seems that no real association can be pointed out between *email* and
*dwell* by the *Pearson's Chi-squared test* (χ=14.366 at the degree of
freedom being 12) at the significance level of 0.2779. For this end no
other statistical tests were performed.

#### Pearson's residuals

                **city**   **small town**   **village**
  ------------- ---------- ---------------- -------------
  never         0.2187     -0.8417          0.5908
  very rarely   -0.2332    -0.7060          1.0915
  rarely        -0.0897    0.2717           -0.1634
  sometimes     -2.1192    0.7349           2.2426
  often         -1.2678    1.9731           -0.3048
  very often    0.3338     -0.4116          -0.0357
  always        2.2980     -1.3407          -1.8480

#### Mosaic chart

![image](b26fc463113e2f16bc930c620677e929.png)