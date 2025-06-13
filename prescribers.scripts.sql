--1a. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the npi and the total number of claims.
SELECT *
FROM prescriber;

SELECT DISTINCT npi, SUM(total_claim_count)
FROM prescription
GROUP BY npi
ORDER BY SUM(total_claim_count) DESC;
--1881634483 = 99707

--1b. Repeat the above, but this time report the nppes_provider_first_name, 
--nppes_provider_last_org_name,  specialty_description, and the total number of claims.

SELECT nppes_provider_first_name, nppes_provider_last_org_name, specialty_description, total_claim_count
FROM prescription
INNER JOIN prescriber AS p
ON prescription.npi = p.npi 
ORDER BY total_claim_count DESC;
--

--2.a. Which specialty had the most total number of claims (totaled over all drugs)?
SELECT p.specialty_description, SUM(total_claim_count)
FROM prescription
INNER JOIN prescriber AS p
ON prescription.npi = p.npi
GROUP BY p.specialty_description
ORDER BY SUM(total_claim_count) DESC;

--2.b.
SELECT p.specialty_description, SUM(total_claim_count), drug.opioid_drug_flag
FROM prescription
INNER JOIN prescriber AS p
ON prescription.npi = p.npi
INNER JOIN drug
ON prescription.drug_name = drug.drug_name
WHERE opioid_drug_flag = 'Y'
GROUP BY p.specialty_description, drug.opioid_drug_flag
ORDER BY SUM(total_claim_count) DESC;
