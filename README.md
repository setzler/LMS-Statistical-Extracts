LMS Statistical Extracts
================

This is a repository to help researchers use statistical extracts
produced as part of two papers coauthored by Lamadon, Mogstad, and
Setzler:

- “Imperfect competition, compensating differentials, and rent sharing
  in the US labor market” by Thibaut Lamadon, Magne Mogstad, and Bradley
  Setzler. American Economic Review 112.1 (2022): 169-212.

- “How Much Should we Trust Estimates of Firm Effects and Worker
  Sorting?” by Stéphane Bonhomme, Kerstin Holzheu, Thibaut Lamadon,
  Elena Manresa, Magne Mogstad, and Bradley Setzler. Working Paper
  w27368. National Bureau of Economic Research (2021).

## Differences over Time for Stayers in the US Tax Data

Here, we provide the estimates of the regional pass-through from firm
productivity shocks to the earnings of workers. In particular, we
provide the region-specific changes in log earnings and log value added
relative to event time zero at which a log value added shock occurs
using the approach described under the heading
\`\`Difference-in-Difference Illustration of Internal Instruments” in
subsection III.A of
[LMS](https://www.bradleysetzler.com/files/LMS-supplement.pdf). The
provided variables are:

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

| EventTime | LogWageDiff_Unconditional | LogVADiff_Unconditional | LogWageDiff_FirmLevel | LogVADiff_FirmLevel | LogWageDiff_MarketLevel | LogVADiff_MarketLevel |
|----------:|--------------------------:|------------------------:|----------------------:|--------------------:|------------------------:|----------------------:|
|        -6 |                 0.0047330 |               0.0082319 |             0.0034821 |           0.0099495 |               0.0020086 |             0.0079590 |
|        -5 |                -0.0005126 |              -0.0013977 |             0.0008827 |          -0.0007460 |              -0.0047909 |            -0.0063824 |
|        -4 |                -0.0003985 |               0.0046383 |             0.0009619 |           0.0032093 |              -0.0051363 |            -0.0085800 |

## Region-Sector Pass-through for Stayers in the US Tax Data

Here, we provide the region-specific instrumental variables estimation
of the pass-through from log value added to log earnings using the
approach described under the heading \`\`Formal Identification Using
Internal Instruments” in subsection III.A of
[LMS](https://www.bradleysetzler.com/files/LMS-supplement.pdf). Denoting
log earnings by $w$ and log value added by $y$, the empirical equation
is,

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
- `UnconditionalPassthrough`: This variable indicates the IV estimate of
  $\gamma_r$ that does not control for market-year fixed effects.
- `NetPassthrough`: This variable indicates the preferred IV estimate of
  $\gamma_r$ that controls for market-year fixed effects.
- `MarketPassthrough`: This variable indicates the IV estimate of
  $\Upsilon$ using only market-level aggregate data; this estimate does
  not vary across broad markets.
- `Parameter_rho`: This is the estimate of the within-market preference
  parameter $\rho_r$, which varies across broad markets.
- `Parameter_beta`: This is the estimate of the between-market
  preference parameter $\beta$; this estimate does not vary across broad
  markets.

Estimating this equation requires population employer-employee data on
earnings and firm value added. We provide estimates of the various terms
in this equation. The statistical extract containing these estimates is
available for download
[here](https://raw.githubusercontent.com/setzler/LMS-Statistical-Extracts/main/StatisticalExtracts/LMS-Regional-Passthrough.csv).
The first 3 rows of the statistical extract are as follows:

| BroadMarket      | UnconditionalPassthrough | NetPassthrough | MarketPassthrough | Parameter_rho | Parameter_beta |
|:-----------------|-------------------------:|---------------:|------------------:|--------------:|---------------:|
| Midwest_Goods    |                0.1562206 |      0.1558363 |         0.1795542 |     0.8435221 |        4.56935 |
| Midwest_Services |                0.1358427 |      0.1243210 |         0.1795542 |     0.6487151 |        4.56935 |
| Northeast_Goods  |                0.1259046 |      0.1317955 |         0.1795542 |     0.6936381 |        4.56935 |

## Region-Sector Rent-Sharing in the US Tax Data

| BroadMarket      | LaborShare | Parameter_alpha | ValueAdded | Wagebill | WorkerRents_FirmLevel | WorkerRents_MarketLevel | FirmRents_FirmLevel | FirmRents_MarketLevel |
|:-----------------|-----------:|----------------:|-----------:|---------:|----------------------:|------------------------:|--------------------:|----------------------:|
| Midwest_Goods    |  0.6298813 |       0.2538398 |   91198.66 | 43647.52 |              6801.869 |                7837.094 |            4041.102 |              4940.472 |
| Midwest_Services |  0.6597992 |       0.2465285 |   90504.73 | 34054.24 |              4233.657 |                6114.580 |            3530.709 |              5734.364 |
| Northeast_Goods  |  0.6630055 |       0.2363487 |  107545.25 | 50693.46 |              6681.169 |                9102.221 |            4197.952 |              6310.806 |

## Earnings Inequality and Firm-Worker Clusters in the US Tax Data

Here, we provide the estimates of the equilibrium earnings expression
presented in equation (14) of
[LMS](https://www.bradleysetzler.com/files/LMS-supplement.pdf) using the
empirical specification and estimation approach described in subsection
IV.A of LMS. The empirical equation is,

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

The estimates are available for download
[here](https://raw.githubusercontent.com/setzler/LMS-Statistical-Extracts/main/StatisticalExtracts/LMS-Firm-Worker-Matches.csv).

| FirmCluster_k | Size_FirmCluster_k | FirmPremium_psik | SkillComplementarity_thetak | WorkerDecile_q | WorkerSkill_xq | ExpectedLogWage_wkq |
|--------------:|-------------------:|-----------------:|----------------------------:|---------------:|---------------:|--------------------:|
|             1 |           11064786 |                0 |                           1 |            0.1 |     -0.7989672 |          -0.7989672 |
|             1 |           11064786 |                0 |                           1 |            0.2 |     -0.6709900 |          -0.6709900 |
|             1 |           11064786 |                0 |                           1 |            0.3 |     -0.5787095 |          -0.5787095 |

In case the user prefers not to use the LMS adjustment for productivity
shocks, the unadjusted version of these estimates are available for
download
[here](https://raw.githubusercontent.com/setzler/LMS-Statistical-Extracts/main/StatisticalExtracts/LMS-Firm-Worker-Matches_unadjusted.csv).

## Between and Within Firm Inequality in the US and Europe
