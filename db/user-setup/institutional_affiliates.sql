--- Already in database AFFILIATE_ID 555
--- NUCATS
--- Clinical and Translational Sciences Institute


--- NUBIC
--- Biomedical Informatics Center

SELECT * FROM T_INSTITUTIONAL_AFFILIATES WHERE PARENT_ID = 555
SELECT AFFILIATE_ID FROM T_INSTITUTIONAL_AFFILIATES WHERE NAME_ABBREV = 'CECD'
SELECT NAME_ABBREV FROM T_INSTITUTIONAL_AFFILIATES WHERE AFFILIATE_ID = 5002

INSERT INTO T_INSTITUTIONAL_AFFILIATES
(
  AFFILIATE_ID
, PARENT_ID
, INSTITUTION_ID
, PRU_ID
, PRU_PARENT_ID
, PRU_CAMPUS
, NAME_FULL
, NAME_SORT
, NAME_ABBREV
, PRU_STATUS
, ENTERED_ID
, ENTERED_IP
, ENTERED_DATE
)
VALUES
(
  5001 -- 5001(stg) / 4635(prod)
, 555
, 1008
, 5001
, 555
, 'Chicago'
, 'Biomedical Informatics Center'
, 'Medical Sch./NUCATS_NUBIC'
, 'NUBIC'
, 'Active'
, 61823
, '192.168.1.221'
,  sysdate
)

--- CECD
--- Center for Education and Career Development

INSERT INTO T_INSTITUTIONAL_AFFILIATES
(
  AFFILIATE_ID
, PARENT_ID
, INSTITUTION_ID
, PRU_ID
, PRU_PARENT_ID
, PRU_CAMPUS
, NAME_FULL
, NAME_SORT
, NAME_ABBREV
, PRU_STATUS
, ENTERED_ID
, ENTERED_IP
, ENTERED_DATE
)
VALUES
(
  5002
, 555
, 1008
, 5002
, 555
, 'Chicago'
, 'Center for Education and Career Development'
, 'Medical Sch./NUCATS_CECD'
, 'CECD'
, 'Active'
, 61823
, '192.168.1.221'
,  sysdate
)


--- CRC
--- Center for Clinical Research

INSERT INTO T_INSTITUTIONAL_AFFILIATES
(
  AFFILIATE_ID
, PARENT_ID
, INSTITUTION_ID
, PRU_ID
, PRU_PARENT_ID
, PRU_CAMPUS
, NAME_FULL
, NAME_SORT
, NAME_ABBREV
, PRU_STATUS
, ENTERED_ID
, ENTERED_IP
, ENTERED_DATE
)
VALUES
(
  5003
, 555
, 1008
, 5003
, 555
, 'Chicago'
, 'Center for Clinical Research'
, 'Medical Sch./NUCATS_CRC'
, 'CRC'
, 'Active'
, 61823
, '192.168.1.221'
,  sysdate
)

--- RSP
--- Regulatory Support Program

INSERT INTO T_INSTITUTIONAL_AFFILIATES
(
  AFFILIATE_ID
, PARENT_ID
, INSTITUTION_ID
, PRU_ID
, PRU_PARENT_ID
, PRU_CAMPUS
, NAME_FULL
, NAME_SORT
, NAME_ABBREV
, PRU_STATUS
, ENTERED_ID
, ENTERED_IP
, ENTERED_DATE
)
VALUES
(
  5004
, 5003
, 1008
, 5004
, 5003
, 'Chicago'
, 'Regulatory Support Program'
, 'Medical Sch./NUCATS_RSP'
, 'RSP'
, 'Active'
, 61823
, '192.168.1.221'
,  sysdate
)

--- CRU
--- Clinical Research Unit

INSERT INTO T_INSTITUTIONAL_AFFILIATES
(
  AFFILIATE_ID
, PARENT_ID
, INSTITUTION_ID
, PRU_ID
, PRU_PARENT_ID
, PRU_CAMPUS
, NAME_FULL
, NAME_SORT
, NAME_ABBREV
, PRU_STATUS
, ENTERED_ID
, ENTERED_IP
, ENTERED_DATE
)
VALUES
(
  5005
, 5003
, 1008
, 5005
, 5003
, 'Chicago'
, 'Clinical Research Unit'
, 'Medical Sch./NUCATS_CRU'
, 'CRU'
, 'Active'
, 61823
, '192.168.1.221'
,  sysdate
)

--- CTI
--- Center for Translational Innovation

INSERT INTO T_INSTITUTIONAL_AFFILIATES
(
  AFFILIATE_ID
, PARENT_ID
, INSTITUTION_ID
, PRU_ID
, PRU_PARENT_ID
, PRU_CAMPUS
, NAME_FULL
, NAME_SORT
, NAME_ABBREV
, PRU_STATUS
, ENTERED_ID
, ENTERED_IP
, ENTERED_DATE
)
VALUES
(
  5006
, 555
, 1008
, 5006
, 555
, 'Chicago'
, 'Center for Translational Innovation'
, 'Medical Sch./NUCATS_CTI'
, 'CTI'
, 'Active'
, 61823
, '192.168.1.221'
,  sysdate
)

--- CERC
--- Community Engaged Research Center

INSERT INTO T_INSTITUTIONAL_AFFILIATES
(
  AFFILIATE_ID
, PARENT_ID
, INSTITUTION_ID
, PRU_ID
, PRU_PARENT_ID
, PRU_CAMPUS
, NAME_FULL
, NAME_SORT
, NAME_ABBREV
, PRU_STATUS
, ENTERED_ID
, ENTERED_IP
, ENTERED_DATE
)
VALUES
(
  5007
, 555
, 1008
, 5007
, 555
, 'Chicago'
, 'Community Engaged Research Center'
, 'Medical Sch./NUCATS_CERC'
, 'CERC'
, 'Active'
, 61823
, '192.168.1.221'
,  sysdate
)

--- RTC
--- Research Team Support Program

INSERT INTO T_INSTITUTIONAL_AFFILIATES
(
  AFFILIATE_ID
, PARENT_ID
, INSTITUTION_ID
, PRU_ID
, PRU_PARENT_ID
, PRU_CAMPUS
, NAME_FULL
, NAME_SORT
, NAME_ABBREV
, PRU_STATUS
, ENTERED_ID
, ENTERED_IP
, ENTERED_DATE
)
VALUES
(
  5008
, 555
, 1008
, 5008
, 555
, 'Chicago'
, 'Research Team Support Program'
, 'Medical Sch./NUCATS_RTC'
, 'RTC'
, 'Active'
, 61823
, '192.168.1.221'
,  sysdate
)


--- T & E
--- Tracking and Evaluation Program

INSERT INTO T_INSTITUTIONAL_AFFILIATES
(
  AFFILIATE_ID
, PARENT_ID
, INSTITUTION_ID
, PRU_ID
, PRU_PARENT_ID
, PRU_CAMPUS
, NAME_FULL
, NAME_SORT
, NAME_ABBREV
, PRU_STATUS
, ENTERED_ID
, ENTERED_IP
, ENTERED_DATE
)
VALUES
(
  5009
, 555
, 1008
, 5009
, 555
, 'Chicago'
, 'Tracking and Evaluation Program'
, 'Medical Sch./NUCATS_T and E'
, 'T and E'
, 'Active'
, 61823
, '192.168.1.221'
,  sysdate
)