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

--q3 a) 





