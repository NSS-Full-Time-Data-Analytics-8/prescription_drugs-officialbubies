-- q1: DAVID COFFEY; NPI = 1912011792; 4538 claims
SELECT DISTINCT scrib.npi, 
	scrib.nppes_provider_last_org_name AS last_name, 
	scrib.nppes_provider_first_name AS first_name, 
	total_claim_count AS scrip_count,
	scrib.specialty_description 
FROM prescription AS scrip
INNER JOIN prescriber AS scrib
ON scrip.npi = scrib.npi
ORDER BY scrip_count DESC;

-- q2: a) Family Practice had the most total claims over all drugs
SELECT specialty_description AS spec_desc, SUM(total_claim_count) AS sum_claims
FROM prescriber
INNER JOIN prescription
USING (npi)
GROUP BY specialty_description
ORDER BY sum_claims DESC;

-- q2 b) Famliy Practice had the most opiod claims
SELECT specialty_description, drug_name, generic_name, total_claim_count, drug.opioid_drug_flag
FROM prescriber
INNER JOIN prescription
USING (npi)
INNER JOIN drug
USING (drug_name)
WHERE drug.opioid_drug_flag = 'Y'
ORDER BY total_claim_count DESC;

-- q2 c) No, they all have associated prescritions?
SELECT DISTINCT specialty_description, total_claim_count, drug_name
FROM prescription
INNER JOIN prescriber
USING(npi)
ORDER BY total_claim_count ASC;

/* q3: a) INSULIN GLARGINE,HUM.REC.ANLOG
	   b) C1 ESTERASE INHIBITOR
*/
SELECT generic_name, ROUND(SUM(total_drug_cost), 2) AS highest_cost
FROM drug
INNER JOIN prescription
USING(drug_name)
GROUP BY generic_name
ORDER BY highest_cost DESC;

SELECT generic_name, ROUND(SUM(total_drug_cost)/SUM(total_day_supply), 2) AS cost_per_day
FROM drug
INNER JOIN prescription
USING(drug_name)
GROUP BY generic_name
ORDER BY cost_per_day DESC;

-- q4 a)
SELECT DISTINCT drug_name,
	CASE WHEN opioid_drug_flag = 'Y' THEN 'opiod' 
		 WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
		 ELSE 'neither' END AS drug_type
FROM drug
ORDER BY drug_name;

-- q4 b)
SELECT DISTINCT drug_name, total_drug_cost::money,
	CASE WHEN opioid_drug_flag = 'Y' THEN 'opiod' 
		 WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
		 ELSE 'neither' END AS drug_type
FROM drug
INNER JOIN prescription
USING(drug_name)
ORDER BY total_drug_cost DESC;

--q5







