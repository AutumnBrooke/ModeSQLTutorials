Write a query that counts the number of 300lb+ players for each of the following regions: 
West Coast (CA, OR, WA), Texas, and Other (everywhere else).

SELECT CASE WHEN state IN ('WA', 'OR', 'CA') THEN 'West Coast'
            WHEN state = 'TX' THEN 'Texas'
            ELSE 'everywhere else' END AS region,
            COUNT (1) AS count
  FROM benn.college_football_players
  WHERE weight >= 300
  GROUP BY (region)

region	           count
everywhere else	     1590
West Coast	           186
Texas	                 208


Write a query that calculates the combined weight of all underclass players (FR/SO) in California 
as well as the combined weight of all upperclass players (JR/SR) in California.

SELECT CASE WHEN year IN ('SO', 'FR') THEN 'underclass'
            WHEN year IN ('JR', 'SR') THEN 'upperclass'
            ELSE NULL END AS class_group,
            SUM(weight) AS combined_player_weight
  FROM benn.college_football_players
 WHERE state = 'CA'
 GROUP BY (1)

class_group	combined_player_weight
underclass	274374
upperclass	262452











Write a query that displays the number of players in each state, with FR, SO, JR, and SR players in separate columns and another column for the total number of players. Order results such that states with the most players come first.

SELECT state,
       COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
       COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
       COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
       COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count,
       COUNT(1) AS total_players
  FROM benn.college_football_players
  GROUP BY state
  ORDER BY total_players DESC
  
state	fr_count	so_count	jr_count	sr_count	total_players
TX	1055	639	649	498	2841
FL	944	571	523	497	2535
CA	769	478	632	541	2420
GA	657	418	368	315	1758
OH	443	284	229	207	1163
NC	442	248	187	137	1014
PA	311	205	189	210	915
IL	350	204	185	144	883
LA	319	210	178	164	871
VA	344	169	176	162	851
NJ	232	195	210	187	824
AL	299	182	175	112	768
--	335	99	102	177	713
TN	274	148	150	112	684
NY	183	145	138	165	631
MD	186	141	144	132	603
SC	190	134	100	160	584
MI	189	90	87	79	445
MS	123	84	129	95	431
MO	142	82	72	58	354
WA	129	76	70	66	341
IN	131	82	55	63	331
AZ	113	83	59	68	323
MA	87	66	78	61	292
KY	125	70	57	36	288
CO	105	61	50	51	267
OK	87	66	47	66	266
IA	101	50	52	55	258
UT	101	60	45	41	247
WI	97	48	47	39	231
MN	79	52	43	44	218
CT	69	50	48	47	214
AR	90	41	37	30	198
KS	66	32	60	28	186
OR	81	38	35	29	183
HI	50	43	38	34	165
NV	41	25	29	32	127
NE	51	25	21	23	120
ID	39	24	27	11	101
MT	37	21	15	12	85
DE	31	14	19	11	75
DC	21	20	21	12	74
NM	24	19	11	11	65
ME	30	18	7	3	58
WV	24	12	9	5	50
RI	9	14	10	13	46
SD	8	12	13	9	42
NH	10	7	10	14	41
ND	13	6	10	6	35
ON	4	8	5	6	23
WY	7	3	1	2	13
AK	5	2	1	3	11
VT	3	1	1	1	6
PQ	3	2	1	0	6
BC	2	1	1	1	5
SW	3	1	1	0	5
FA	0	0	2	1	3
AB	0	1	1	0	2
VC	0	0	0	1	1
ST	0	0	1	0	1
LE	1	0	0	0	1
OL	0	0	1	0	1
EN	1	0	0	0	1
GE	0	0	1	0	1
SK	0	0	1	0	1
QU	0	0	1	0	1
AM	0	1	0	0	1






Write a query that shows the number of players at schools with names that start with A through M, and the number at schools with names starting with N - Z.

SELECT CASE WHEN school_name < 'n' THEN 'A-M'
            WHEN school_name > 'n' THEN 'N-Z'
            ELSE NULL END AS school_name_group,
       COUNT (1) AS players
  FROM benn.college_football_players
  GROUP BY 1
 ORDER BY school_name_group
        
school_name_group	players
A-M	13786
N-Z	12512

Write a query that returns the unique values in the year and month columns, in chronological order.

SELECT DISTINCT year,
                month
  FROM tutorial.aapl_historical_stock_price
  ORDER BY year, month
LIMIT 20

year	month
2000	1
2000	2
2000	3
2000	4
2000	5
2000	6
2000	7
2000	8
2000	9
2000	10
2000	11
2000	12
2001	1
2001	2
2001	3
2001	4
2001	5
2001	6
2001	7
2001	8

Write a query that counts the number of unique values in the month column for each year.

SELECT year,
       COUNT (DISTINCT month) as months
  FROM tutorial.aapl_historical_stock_price
  GROUP BY year
  ORDER BY year
 
year	months
2000	12
2001	12
2002	12
2003	12
2004	12
2005	12
2006	12
2007	12
2008	12
2009	12
2010	12
2011	12
2012	12
2013	12
2014	1

Write a query that separately counts the number of unique values in the month column and the number of unique values in the `year` column.

SELECT COUNT (DISTINCT year) AS years_count,
       COUNT (DISTINCT month) AS months_count
  FROM tutorial.aapl_historical_stock_price
  
years_count	months_count
15	12






Write a query that selects the school name, player name, position, and weight for every player in Georgia, ordered by weight (heaviest to lightest). Be sure to make an alias for the table, and to reference all column names in relation to the alias.

SELECT players.school_name,
      players.player_name,
      players.position,
      players.weight
FROM benn.college_football_players players
WHERE state = 'GA'
ORDER BY players.weight DESC
LIMIT 20

school_name	player_name	position	weight
Florida	Trenton Brown	OL	361
Georgia Tech	Shamire Devine	OL	355
Alabama State	Jordan Harris	OL	355
Grambling State	Ernest Echols	DL	350
LSU	Vadal Alexander	OT	350
Morgan State	Clarence Swain	OL	350
Alabama State	Anthony Jacob	OL	342
South Florida	Jeremi Hall	OL	340
Georgia	John Taylor	DE	336
UCF	Micah Anderson	DL	332
Florida State	Tre' Jackson	OL	330
Mississippi Valley State	Kevin James	OL	330
LSU	Andy Dodd	OL	330
UAB	Uneik Crumbley	OL	327
Tennessee	Gregory Clark	DL	327
Georgia	Kenarious Gates	OT	327
North Carolina State	Alex Barr	OT	326
South Alabama	Darius McKeller	OL	325
Alabama A&M	Ricky Clarke	DL	325
South Alabama	Steve McKenzie	OL	325









Write a query that displays player names, school names and conferences for schools in the "FBS (Division I-A Teams)" division.

SELECT players.player_name,
       players.school_name,
       teams.conference
FROM benn.college_football_players AS players
  INNER JOIN benn.college_football_teams AS teams
    ON players.school_name=teams.school_name
WHERE teams.division = 'FBS (Division I-A Teams)'
LIMIT 20

player_name	school_name	conference
Ralph Abernathy	Cincinnati	American Athletic
Mekale McKay	Cincinnati	American Athletic
Trenier Orr	Cincinnati	American Athletic
Bennie Coney	Cincinnati	American Athletic
Johnny Holton	Cincinnati	American Athletic
Howard Wilder	Cincinnati	American Athletic
Munchie Legaux	Cincinnati	American Athletic
Mark Barr	Cincinnati	American Athletic
Aaron Brown	Cincinnati	American Athletic
Anthony McClung	Cincinnati	American Athletic
Tion Green	Cincinnati	American Athletic
Mike Tyson	Cincinnati	American Athletic
Gunner Kiel	Cincinnati	American Athletic
Adrian Witty	Cincinnati	American Athletic
Patrick Coyne	Cincinnati	American Athletic
Dionne Thrweatt-Vassar	Cincinnati	American Athletic
Jordan Luallen	Cincinnati	American Athletic
Deven Drane	Cincinnati	American Athletic
Brendon Kay	Cincinnati	American Athletic
Leviticus Payne	Cincinnati	American Athletic










Write a query that performs an inner join between the tutorial.crunchbase_acquisitions table and the tutorial.crunchbase_companies table, but instead of listing individual rows, count the number of non-null rows in each table.

SELECT COUNT(companies.permalink) AS companies_rowcount,
       COUNT(acquisitions.company_permalink) AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies as companies
    INNER JOIN tutorial.crunchbase_acquisitions as acquisitions
      ON companies.permalink = acquisitions.company_permalink

companies_rowcount	acquisitions_rowcount
1673	1673

Modify the query above to be a LEFT JOIN. Note the difference in results.

SELECT COUNT(companies.permalink) AS companies_rowcount,
       COUNT(acquisitions.company_permalink) AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies as companies
    LEFT JOIN tutorial.crunchbase_acquisitions as acquisitions
      ON companies.permalink = acquisitions.company_permalink

companies_rowcount	acquisitions_rowcount
27355	1673

Count the number of unique companies (don't double-count companies) and unique acquired companies by state. Do not include results for which there is no state data, and order by the number of acquired companies from highest to lowest.

SELECT companies.state_code,
       COUNT(DISTINCT companies.permalink) AS unique_companies,
       COUNT(DISTINCT acquisitions.company_permalink) AS unique_companies_acquired
  FROM tutorial.crunchbase_companies as companies
    LEFT JOIN tutorial.crunchbase_acquisitions as acquisitions
      ON companies.permalink = acquisitions.company_permalink
WHERE companies.state_code IS NOT NULL
GROUP BY companies.state_code 
ORDER BY 3 DESC





Rewrite the previous practice query in which you counted total and acquired companies by state, but with a RIGHT JOIN instead of a LEFT JOIN. The goal is to produce the exact same results.

SELECT companies.state_code,
       COUNT(DISTINCT companies.permalink) AS unique_companies,
       COUNT(DISTINCT acquisitions.company_permalink) AS acquired_companies
  FROM tutorial.crunchbase_acquisitions acquisitions
 RIGHT JOIN tutorial.crunchbase_companies companies
    ON companies.permalink = acquisitions.company_permalink
 WHERE companies.state_code IS NOT NULL
 GROUP BY 1
 ORDER BY 3 DESC
LIMIT 20

state_code	unique_companies	unique_companies_acquired
CA	6170	616
NY	1731	128
MA	1272	107
WA	638	64
TX	808	49
CO	453	29
IL	430	22
NJ	304	21
PA	462	20
VA	341	18
GA	310	16
MD	300	15
NC	262	14
OR	173	13
FL	478	12
UT	190	9
CT	201	6
MN	218	6
NH	74	6
AZ	173	6






Write a query that shows a company's name, "status" (found in the Companies table), and the number of unique investors in that company. Order by the number of investors from most to fewest. Limit to only companies in the state of New York.

SELECT c.name AS company_name,
       c.status AS status,
       COUNT (DISTINCT i.investor_name) AS unique_investors
    FROM tutorial.crunchbase_companies AS c
  LEFT JOIN tutorial.crunchbase_investments AS i
    ON c.permalink = i.company_permalink 
  WHERE c.state_code = 'NY'
  GROUP BY 1,2
  ORDER BY 3 DESC
  LIMIT 20

company_name	status	unique_investors
Fitocracy	operating	27
Lua Technologies	operating	26
Kohort	closed	22
Path101	closed	21
DailyWorth	operating	20
Bitly	operating	20
Artsy	operating	19
The FeedRoom	acquired	19
MileWise	acquired	18
Namely	operating	18
Qwiki	acquired	18
Kickstarter	operating	18
Hullabalu	operating	18
Amicus	operating	17
ChatID	operating	17
littleBits Electronics	operating	17
Knewton	operating	17
Odeo	acquired	17
Fancy	operating	16
betaworks	operating	16








Write a query that lists investors based on the number of companies in which they are invested. Include a row for companies with no investor, and order from most companies to least.

SELECT CASE WHEN i.investor_name IS NULL THEN 'No Investors'
            ELSE i.investor_name END AS investor,
       COUNT (DISTINCT c.permalink) AS companies_invested_in
  FROM tutorial.crunchbase_companies AS c
    LEFT JOIN tutorial.crunchbase_investments AS i
      ON c.permalink = i.company_permalink
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20

investor	companies_invested_in
No Investors	9363
Y Combinator	370
SV Angel	357
Intel Capital	320
Sequoia Capital	276
New Enterprise Associates	260
500 Startups	253
Accel Partners	248
Draper Fisher Jurvetson (DFJ)	228
Techstars	226
Kleiner Perkins Caufield & Byers	215
First Round Capital	175
Greylock Partners	163
Index Ventures	160
Andreessen Horowitz	157
Bessemer Venture Partners	142
Google Ventures	138
IDG Capital Partners	135
Lightspeed Venture Partners	133
Battery Ventures	132










Write a query that joins tutorial.crunchbase_companies and tutorial.crunchbase_investments_part1 using a FULL JOIN. Count up the number of rows that are matched/unmatched as in the example above.

SELECT COUNT(CASE WHEN c.permalink IS NOT NULL AND i.company_permalink IS NULL
                  THEN c.permalink ELSE NULL END) AS companies_only,
       COUNT(CASE WHEN c.permalink IS NOT NULL AND i.company_permalink IS NOT NULL
                  THEN c.permalink ELSE NULL END) AS both_tables,
       COUNT(CASE WHEN c.permalink IS NULL AND i.company_permalink IS NOT NULL
                  THEN c.permalink ELSE NULL END) AS investments_only
  FROM tutorial.crunchbase_companies AS c
    FULL JOIN tutorial.crunchbase_investments_part1 AS i
      ON c.permalink = i.company_permalink


companies_only	both_tables	investments_only
13707	33838	0


Write a query that appends the two crunchbase_investments datasets above (including duplicate values). Filter the first dataset to only companies with names that start with the letter "T", and filter the second to companies with names starting with "M" (both not case-sensitive). Only include the company_permalink, company_name, and investor_name columns.

SELECT company_permalink,
       company_name,
       investor_name
  FROM tutorial.crunchbase_investments_part1
  WHERE company_name ILIKE 'T%'

 UNION ALL

 SELECT company_permalink,
        company_name,
        investor_name
   FROM tutorial.crunchbase_investments_part2
   WHERE company_name ILIKE 'M%'
LIMIT 50

company_permalink	company_name	investor_name
/company/tokita-investments	Tokita Investments	01Startups
/company/tackk	Tackk	10Xelerator
/company/toviefor	ToVieFor	2010 NYU Stern Business Plan Competition
/company/trilliant	Trilliant	ABB
/company/trilliant	Trilliant	ABB
/company/tareasplus	TareasPlus	Academic Partnerships
/company/the-virtual-pulp-company	The Virtual Pulp Company	Adtoma
/company/tigerspike	Tigerspike	Aegis Media
/company/terrajoule	Terrajoule	Air Liquide
/company/the-new-motion	The New Motion	Alliander
/company/the-new-motion	The New Motion	Alliander
/company/the-talk-market	The Talk Market	Amazon
/company/trinity-biosystems	Trinity Biosystems	Amgen
/company/trinity-biosystems	Trinity Biosystems	Amgen
/company/theraclone-sciences	Theraclone Sciences	Amgen
/company/tetralogic-pharmaceuticals	TetraLogic Pharmaceuticals	Amgen
/company/theraclone-sciences	Theraclone Sciences	Amgen
/company/artkive	The Kive Company	Amplify.LA
/company/20jeans	Twenty Jeans	Amplify.LA
/company/theshelf	TheShelf	AngelPad
/company/truly-wireless	Truly Wireless	AngelPad
/company/trakbill	TrakBill	Arch Grants
/company/the-360-mall	The 360 Mall	Artesian Capital Management
/company/telsar-pharma	Telsar Pharma	Astellas Pharma
/company/tuition-io	Tuition.io	Atom Factory
/company/ticketea	ticketea	Atrapalo
/company/taggify	Taggify	Aurus VC
/company/tagapet	TagaPet	Awesome Inc
/company/tipping-bucket	Tipping Bucket	Ballard Center for Economic Self Reliance
/company/timbre	Timbre	Bantam Group
/company/tektrak	TekTrak	BCITL Ventures
/company/taguin	tagUin	BeGreat
/company/tracelytics	Tracelytics	Betaspring
/company/tweetwall	Tweetwall	Betaspring
/company/tennishub-2	TennisHub	Betaspring
/company/thryve	Thryve	Betaspring
/company/thumbs-up	Thumbs Up	Betaspring
/company/tu-nr	tu.nr	Betaspring
/company/tumblr	Tumblr	betaworks
/company/tipjoy	Tipjoy	betaworks
/company/tweetdeck	TweetDeck	betaworks
/company/tweetdeck	TweetDeck	betaworks
/company/thelial-technologies	Thelial Technologies	Biocant Ventures
/company/tetra-discovery	Tetra Discovery	Biosciences Research & Commercialization Center
/company/the-university-of-nottingham	The University of Nottingham	Biotechnology and Biological Sciences Research Council (BBSRC)
/company/toontime	ToonTime	Bitfactory Holding
/company/tastebuds-fm	Tastebuds	Black Ocean
/company/talentory-com	Talentory.com	Black River Ventures
/company/the-coveteur	The Coveteur	Blackpoynt Ventures
/company/talend	Talend	Bpifrance


Write a query that shows 3 columns. The first indicates which dataset (part 1 or 2) the data comes from, the second shows company status, and the third is a count of the number of investors.

Hint: you will have to use the tutorial.crunchbase_companies table as well as the investments tables. And you'll want to group by status and dataset.

SELECT 'crunchbase_investments_part1' AS dataset_name,
       companies.status,
       COUNT(DISTINCT investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1,2

 UNION ALL
 
 SELECT crunchbase_'investments_part2' AS dataset_name,
       companies.status,
       COUNT(DISTINCT investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part2 investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1,2


dataset_name	status	investors
crunchbase_investments_part1	acquired	1265
crunchbase_investments_part1	closed	942
crunchbase_investments_part1	ipo	417
crunchbase_investments_part1	operating	5341
crunchbase_investments_part2	acquired	1668
crunchbase_investments_part2	closed	1153
crunchbase_investments_part2	ipo	328
crunchbase_investments_part2	operating	8080




