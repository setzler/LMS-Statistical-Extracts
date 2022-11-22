LMS Statistical Extracts
================

This is a repository to help researchers use statistical extracts
produced as part of two papers coauthored by Lamadon, Mogstad, and
Setzler:

- “Imperfect competition, compensating differentials, and rent sharing
  in the US labor market” by Thibaut Lamadon, Magne Mogstad, and Bradley
  Setzler. American Economic Review 112.1 (2022): 169-212.
  \[[LMS](https://www.bradleysetzler.com/files/Lamadon-Mogstad-Setzler.pdf)\]
  \[[bibtex](cite_LMS.bib)\]

- “How Much Should we Trust Estimates of Firm Effects and Worker
  Sorting?” by Stéphane Bonhomme, Kerstin Holzheu, Thibaut Lamadon,
  Elena Manresa, Magne Mogstad, and Bradley Setzler. Working Paper
  w27368. National Bureau of Economic Research (2021).
  \[[BHLMMS](https://www.bradleysetzler.com/files/BHLMM-Setzler.pdf)\]
  \[[bibtex](cite_BHLMMS.bib)\]

Aside from the statistical extracts described here, LMS papers also
produced publicly-available software packages that may be useful to
researchers:

- [PyTwoWay](https://github.com/tlamadon/pytwoway): Provides
  implementations of all of the estimators considered by BHLMMS,
  including the two-way fixed-effect estimators of Abowd, Kramarz, and
  Margolis (1999, Econometrica); Bonhomme, Lamadon, and Manresa (2019,
  Econometrica); and Kline, Saggio, and Solvsten (2020, Econometrica).
  This package is written in Python and can be executed from Stata.

- [eventStudy](https://github.com/setzler/eventStudy): Provides
  difference-in-differences estimation in R that accounts for staggered
  treatment onset using a “stacked data” approach. Importantly, it
  scales to very large datasets. This package is written in R.

- [textables](https://github.com/setzler/textables): Provides automated
  production of highly-customized LaTeX tables, including PDF
  compilation, directly from R. All tables in LMS and BHLMMS were
  produced using this package. This package is written in R.

## Value Added and Wage Growth for Stayers in the US Tax Data

Here, we provide the estimates of the regional pass-through from firm
productivity shocks to the earnings of workers. In particular, we
provide the region-specific changes in log earnings and log value added
relative to event time zero at which a log value added shock occurs
using the approach described under the heading
\`\`Difference-in-Difference Illustration of Internal Instruments” in
subsection III.A of
[LMS](https://www.bradleysetzler.com/files/Lamadon-Mogstad-Setzler.pdf).
The provided variables are:

- `EventTime`: This is the number of years since the treated group
  received a positive log value added shock and the control group did
  not.
- `LogVADiff_Unconditional` and `LogWageDiff_Unconditional`: These
  variables are the mean difference in firm-specific log value added and
  log earnings among stayers, respectively, between the treated group
  and control group at a particular event time.
- `LogVADiff_MarketLevel` and `LogWageDiff_MarketLevel`: These variables
  are the mean difference in market-level averages of log value added
  and log earnings among stayers, respectively, between the treated
  group and control group at a particular event time.
- `LogVADiff_FirmLevel` and `LogWageDiff_FirmLevel`: These variables are
  similar to `LogVADiff_Unconditional` and `LogWageDiff_Unconditional`,
  respectively, but controlling for market-year fixed effects.

The statistical extract containing these estimates is available for
download
[here](https://raw.githubusercontent.com/setzler/LMS-Statistical-Extracts/main/StatisticalExtracts/LMS-Stayer-Differences.csv).
The first 3 rows of the statistical extract are as follows:

``` r
dd = setDT(read.csv(file="StatisticalExtracts/LMS-Stayer-Differences.csv"))
```

| EventTime | LogWageDiff_Unconditional | LogVADiff_Unconditional | LogWageDiff_FirmLevel | LogVADiff_FirmLevel | LogWageDiff_MarketLevel | LogVADiff_MarketLevel |
|----------:|--------------------------:|------------------------:|----------------------:|--------------------:|------------------------:|----------------------:|
|        -6 |                 0.0047330 |               0.0082319 |             0.0034821 |           0.0099495 |               0.0020086 |             0.0079590 |
|        -5 |                -0.0005126 |              -0.0013977 |             0.0008827 |          -0.0007460 |              -0.0047909 |            -0.0063824 |
|        -4 |                -0.0003985 |               0.0046383 |             0.0009619 |           0.0032093 |              -0.0051363 |            -0.0085800 |

## Region-Sector Pass-through Measures for Stayers in the US Tax Data

Here, we provide the region-specific instrumental variables estimation
of the pass-through from log value added to log earnings using the
approach described under the heading \`\`Formal Identification Using
Internal Instruments” in subsection III.A of
[LMS](https://www.bradleysetzler.com/files/Lamadon-Mogstad-Setzler.pdf).
Denoting log earnings by $w$ and log value added by $y$, the empirical
equation is,

$$ \mathbb{E}[ \Delta y_t (w_{t+e} - w_{t-e'} - \gamma_r(y_{t+e} - y_{t-e'}))  ] = 0 $$

which is estimated only among workers who are stayers and which is
estimated separately for each broad market $r$. A similar equation is
estimated using market-level means across all broad markets, in which
case the parameter estimate is denoted $\Upsilon$.The preferred
estimates of $\gamma_r$ are based on firm-level deviations from
market-level means. The estimated $(\gamma_r,\Upsilon)$ parameters can
then be transformed into the preference parameters $(\rho_r,\beta)$.

The statistical extract contains the following estimates:

- `BroadMarket`: This variable indicates the broad market, defined as a
  region and a sector of the economy.
- `UnconditionalPassthrough`: This variable is the IV estimate of
  $\gamma_r$ that does not control for market-year fixed effects.
- `NetPassthrough`: This variable is the preferred IV estimate of
  $\gamma_r$ that controls for market-year fixed effects.
- `MarketPassthrough`: This variable is the IV estimate of $\Upsilon$
  using only market-level aggregate data; this estimate does not vary
  across broad markets.
- `Parameter_rho`: This variable is the estimate of the within-market
  preference parameter $\rho_r$, which varies across broad markets.
- `Parameter_beta`: This variable is the estimate of the between-market
  preference parameter $\beta$; this estimate does not vary across broad
  markets.

Estimating this equation requires population employer-employee data on
earnings and firm value added. We provide estimates of the various terms
in this equation. The statistical extract containing these estimates is
available for download
[here](https://raw.githubusercontent.com/setzler/LMS-Statistical-Extracts/main/StatisticalExtracts/LMS-Regional-Passthrough.csv).
The first 3 rows of the statistical extract are as follows:

``` r
dd = setDT(read.csv(file="StatisticalExtracts/LMS-Regional-Passthrough.csv"))
```

| BroadMarket      | UnconditionalPassthrough | NetPassthrough | MarketPassthrough | Parameter_rho | Parameter_beta |
|:-----------------|-------------------------:|---------------:|------------------:|--------------:|---------------:|
| Midwest_Goods    |                0.1562206 |      0.1558363 |         0.1795542 |     0.8435221 |        4.56935 |
| Midwest_Services |                0.1358427 |      0.1243210 |         0.1795542 |     0.6487151 |        4.56935 |
| Northeast_Goods  |                0.1259046 |      0.1317955 |         0.1795542 |     0.6936381 |        4.56935 |

## Region-Sector Rents in the US Tax Data

Here, we provide the region-specific rent estimation using the approach
of Result 4 from subsection II.E of
[LMS](https://www.bradleysetzler.com/files/Lamadon-Mogstad-Setzler.pdf).
In particular, equation (9) of LMS shows that the firm technology
parameter $\alpha_r$ can be recovered for each market using only the
parameters $(\rho_r,\beta)$ discussed above and the (quasi) labor share.
Then, given parameters $(\alpha_r,\rho_r,\beta)$, Result 4 of LMS shows
that per-capita rents can be recovered from the per-capita wagebill and
per-capita value added.

The statistical extract contains the following estimates:

- `BroadMarket`: This variable indicates the broad market, defined as a
  region and a sector of the economy.
- `SampleWorkerYears`: This variable is the count of worker-year
  observations used in the estimation, measured in 1,000 units.
- `SampleFirmYears`: This variable is the count of firm-year
  observations used in the estimation, measured in 1,000 units.
- `LaborShare`: This variable is the estimate of the (quasi) labor share
  defined as $\exp( \mathbb{E}[\ell + w - y])$, where $\ell$ is log
  labor, $w$ is log earnings, and $y$ is log value added.
- `ValueAdded`: This variable is the estimate of average value added, in
  per-capita units.
- `Wagebill`: This variable is the estimate of average wage bill, in
  per-capita units.
- `Parameter_alpha`: This variable is the estimate of the
  market-specific firm productivity parameter $\alpha_r$.
- `WorkerRents_FirmLevel` and `FirmRents_FirmLevel`: These variables are
  the estimates of rents at the firm-level that are captured by workers
  and by firms, respectively, measured as \$1 per-capita.
- `WorkerRents_MarketLevel` and `FirmRents_MarketLevel`: These variables
  are the estimates of rents at the market-level that are captured by
  workers and by firms, respectively, measured as \$1 per-capita.

We provide estimates of the various terms in this equation. The
statistical extract containing these estimates is available for download
[here](https://raw.githubusercontent.com/setzler/LMS-Statistical-Extracts/main/StatisticalExtracts/LMS-Regional-Rents.csv).
The first 3 rows of the statistical extract are as follows:

``` r
dd = setDT(read.csv(file="StatisticalExtracts/LMS-Regional-Rents.csv"))
```

| BroadMarket      | SampleWorkerYears | SampleFirmYears | LaborShare | ValueAdded | Wagebill | Parameter_alpha | WorkerRents_FirmLevel | WorkerRents_MarketLevel | FirmRents_FirmLevel | FirmRents_MarketLevel |
|:-----------------|------------------:|----------------:|-----------:|-----------:|---------:|----------------:|----------------------:|------------------------:|--------------------:|----------------------:|
| Midwest_Goods    |          42908.01 |        1945.136 |  0.6298813 |   91198.66 | 43647.52 |       0.2538398 |              6801.869 |                7837.094 |            4041.102 |              4940.472 |
| Midwest_Services |          69044.54 |        6636.190 |  0.6597992 |   90504.73 | 34054.24 |       0.2465285 |              4233.657 |                6114.580 |            3530.709 |              5734.364 |
| Northeast_Goods  |          26699.95 |        1498.971 |  0.6630055 |  107545.25 | 50693.46 |       0.2363487 |              6681.169 |                9102.221 |            4197.952 |              6310.806 |

## Earnings Inequality and Firm-Worker Clusters in the US Tax Data

Here, we provide the estimates of the equilibrium earnings expression
presented in equation (14) of
[LMS](https://www.bradleysetzler.com/files/Lamadon-Mogstad-Setzler.pdf)
using the empirical specification and estimation approach described in
subsection IV.A of LMS. The empirical equation is,

$$w^a_{k}(x) = \psi_k + x\theta_k $$

where $k$ denotes a cluster of firms, $x$ denotes the measure of worker
skill, $w^a$ is the predicted log wage after residualization and
adjustment for productivity shocks, $\psi$ is the cluster-specific wage
premium, and $\theta$ is the cluster-specific skill complementarity.

Estimating this equation requires population employer-employee data on
earnings and firm value added. We provide estimates of the various terms
in this equation, evaluated at quantiles $q$ in the $x$ distribution. In
particular, the variables are:

- `FirmCluster_k`: This variable indicates the cluster $k$ of firms.
- `Size_FirmCluster_k`: This variable indicates the number of workers
  employed by cluster $k$.
- `FirmPremium_psik`: This variable indicates the firm premium $\psi_k$
  for cluster $k$.
- `SkillComplementarity_thetak`: This variable indicates the skill
  complementarity $\theta_k$ for cluster $k$.
- `WorkerDecile_q`: This variable indicates quantile $q$ in the
  distribution of $x$.
- `WorkerSkill_xq`: This variable indicates the value of worker skill
  $x$ at quantile $q$.
- `ExpectedLogWage_wkq`: This variable indicates the expected log wage
  $w^a$ for cluster $k$ and worker skill quantile $q$, which is
  residualized on observables and adjusted for productivity shocks.

The statistics are available for download
[here](https://raw.githubusercontent.com/setzler/LMS-Statistical-Extracts/main/StatisticalExtracts/LMS-Firm-Worker-Matches.csv).

``` r
dd = setDT(read.csv(file="StatisticalExtracts/LMS-Firm-Worker-Matches.csv"))
```

| FirmCluster_k | Size_FirmCluster_k | FirmPremium_psik | SkillComplementarity_thetak | WorkerDecile_q | WorkerSkill_xq | ExpectedLogWage_wkq |
|--------------:|-------------------:|-----------------:|----------------------------:|---------------:|---------------:|--------------------:|
|             1 |           11064786 |                0 |                           1 |            0.1 |     -0.7989672 |          -0.7989672 |
|             1 |           11064786 |                0 |                           1 |            0.2 |     -0.6709900 |          -0.6709900 |
|             1 |           11064786 |                0 |                           1 |            0.3 |     -0.5787095 |          -0.5787095 |

In case the user prefers not to use the LMS adjustment for productivity
shocks, the unadjusted version of these estimates are available for
download
[here](https://raw.githubusercontent.com/setzler/LMS-Statistical-Extracts/main/StatisticalExtracts/LMS-Firm-Worker-Matches_unadjusted.csv).

## Between and Within Firm Inequality in Tax Data from the US and 4 European Countries

[BHLMMS](https://www.bradleysetzler.com/files/BHLMM-Setzler.pdf) analyze
employer-employee administrative data from 5 countries: Austria, Italy,
Norway, Sweden, and the US. They take extensive steps to harmonize the
various datasets to ensure cross-country comparability.

They characterize the role of firms in wage inequality by performing a
within-between decomposition. Letting $w$ denote the log wage (or
earnings), and letting $j(it)$ denote the firm at which worker $i$ is
employed in year $t$, the average wage in firm $j$ is given by
$w_j \equiv \mathbb{E}[w_{it} | j(it)=j]$. Then, we can write
$w_{it} = w_j + (w_{it} - w_j)$, so the total variance in log wages can
be expressed,
$$\text{Var}(w_{it}) = \text{Var}(w_{j}) + \text{Var}(w_{it} - w_j)$$
where $\text{Var}(w_{j})$ is the between-firm variance and
$\text{Var}(w_{it} - w_j)$ is the within-firm variance.

In addition to providing the within-between decomposition,
[BHLMMS](https://www.bradleysetzler.com/files/BHLMM-Setzler.pdf)
describe the connectedness of each country’s firms by examining movers
across firms and analyzing how many firms are workers are contained the
full data, the connected subset of firms, and the leave-one-out
connected subset of firms. The variables provided are:

- `Country`: This variable indicates the country represented by the
  data.
- `YearRange`: This variable indicates the number of years included in
  the sampling timeframe.
- `Set`: The set can be all firms, the connected subset of firms, or the
  leave-one-out connected subset of firms
- `WorkerCount`: This variable is the count of workers used in the
  estimation.
- `MoverCount`: This variable is the count of movers (i.e. workers who
  switch employers) used in the estimation.
- `FirmCount`: This variable is the count of firms used in the
  estimation.
- `LogWageVariance`: This is the variance in log wages (or earnings),
  $\text{Var}(w_{it})$.
- `BetweenFirmVariance`: This is the between-firm variance in log wages
  (or earnings), $\text{Var}(w_{j})$.
- `WihtinFirmVariance`: This is the within-firm variance in log wages
  (or earnings), $\text{Var}(w_{it} - w_{j})$.

The statistics are available for download
[here](https://raw.githubusercontent.com/setzler/LMS-Statistical-Extracts/main/StatisticalExtracts/LMS-Firm-Worker-Matches.csv).
The first 3 rows of the statistical extract are as follows:

``` r
dd = setDT(read.csv(file="StatisticalExtracts/BHLMMS-WithinBetween-Variance.csv"))
```

| Country | YearRange | Set       | WorkerCount | MoverCount | FirmCount | LogWageVariance | BetweenFirmVariance | WithinFirmVariance |
|:--------|----------:|:----------|------------:|-----------:|----------:|----------------:|--------------------:|-------------------:|
| Austria |         3 | connected |     2844534 |     340754 |    116960 |       0.1830276 |           0.0798959 |          0.1031317 |
| Italy   |         3 | connected |      863955 |     130469 |     54299 |       0.1762210 |           0.0791938 |          0.0970272 |
| Norway  |         3 | connected |      986365 |     181415 |     63397 |       0.2292411 |           0.1021057 |          0.1271353 |

## Firm Effects and Sorting in Tax Data from the US and 4 European Countries

Here, we provide the estimates of the two-way fixed-effects
decomposition from equation (3) of
[BHLMMS](https://www.bradleysetzler.com/files/BHLMM-Setzler.pdf) using 4
estimators applied to data from 5 countries. Assuming that the residual
log wage $w$ can be expressed as
$w_{it} = x_i + \psi_{j(it)} + \epsilon_{it}$, where $j(it)$ denotes the
firm at which worker $i$ is employed in year $t$, then the variation in
the log wage can be expressed,

$$\text{Var}(w_{it}) = \text{Var}(x_i) +\text{Var}(\psi_{j(it)}) + 2\text{Cov}(\psi_{j(it)},x_i) +  \text{Var}(\epsilon_{it})$$
The two key components of interest are $\text{Var}(\psi_{j(it)})$, which
is the variance in log wages due to firm premia, and
$2\text{Cov}(\psi_{j(it)},x_i)$, which is the variance in log wages due
to the sorting of worker skill to firm premia.

Estimating this equation requires population employer-employee data on
earnings from each of the countries. The 4 estimation methods are FE,
CRE, FE-HO, FE-HE; see Section 4 of
[BHLMMS](https://www.bradleysetzler.com/files/BHLMM-Setzler.pdf) for
discussion of the methods. The variables are:

- `Country`: This variable indicates the country represented by the
  data.
- `YearRange`: This variable indicates the number of years included in
  the sampling timeframe.
- `Estimator`: This variable indicates which of the methods was used in
  the estimation.
- `LogWageVariance`: This is the variance in log wages (or earnings),
  $\text{Var}(w)$.
- `FirmEffectVariance`: This is the variance in the firm effects,
  $\text{Var}(\psi)$.
- `FirmWorkerEffectsCovariance`: This is the covariance between the firm
  effects and the worker effects, $\text{Cov}( \psi , x )$.

The estimates using each of those methods are available for download
[here](https://raw.githubusercontent.com/setzler/LMS-Statistical-Extracts/main/StatisticalExtracts/BHLMMS-FirmEffects-Sorting.csv).
The first 3 rows of the statistical extract are as follows:

``` r
dd = setDT(read.csv(file="StatisticalExtracts/BHLMMS-FirmEffects-Sorting.csv"))
```

| Country | YearRange | Estimator | LogWageVariance | FirmEffectVariance | FirmWorkerEffectsCovariance |
|:--------|----------:|:----------|----------------:|-------------------:|----------------------------:|
| Austria |         3 | CRE       |       0.1830276 |          0.0185641 |                   0.0160264 |
| Austria |         6 | CRE       |       0.1865862 |          0.0218879 |                   0.0182701 |
| Austria |         3 | FE        |       0.1830276 |          0.0360737 |                  -0.0048577 |

## Licenses

The code is licensed under a [MIT License.](LICENSE.md)

The data is licensed under a
<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png" /></a><a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative
Commons Attribution 4.0 International License</a>.
