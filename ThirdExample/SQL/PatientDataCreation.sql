-- Database: "PatientData"

-- DROP DATABASE "PatientData";

CREATE DATABASE "PatientData"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Italian_Italy.1252'
       LC_CTYPE = 'Italian_Italy.1252'
       CONNECTION LIMIT = -1;

 CREATE TABLE public.patient_image
(
  patient_id character varying,
  image_name character varying,
  image_type character varying,
  exam_id character varying,
  image_ypos double precision,
  image_xpos double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.patient_image
  OWNER TO postgres;


