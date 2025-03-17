
CREATE TABLE flow."event" (
	code serial4 NOT NULL,
	active bool NULL,
	description text NULL,
	allowdebit bool NULL,
	allowcredit bool NULL,
	createdat timestamptz DEFAULT now() NULL,
	CONSTRAINT event_pkey PRIMARY KEY (code)
);




CREATE TABLE flow."transaction" (
	id uuid DEFAULT gen_random_uuid() NOT NULL,
	branch text NULL,
	account text NULL,
	amount numeric(15, 2) NULL,
	debitcredit varchar(1) NULL,
	eventcode int4 NULL,
	description text NULL,
	tracekey uuid NULL,
	details json NULL,
	dateref date NULL,
	createdat timestamptz DEFAULT now() NULL,
	CONSTRAINT check_debitcredit CHECK (((debitcredit)::text = ANY ((ARRAY['D'::character varying, 'C'::character varying])::text[]))),
	CONSTRAINT transaction_pkey PRIMARY KEY (id),
	CONSTRAINT transaction_eventcode_fkey FOREIGN KEY (eventcode) REFERENCES flow."event"(code)
);




CREATE TABLE flow.balance (
	id uuid DEFAULT gen_random_uuid() NOT NULL,
	branch text NULL,
	account text NULL,
	dateref date NULL,
	totaldebit numeric(15, 2) NULL,
	totalcredit numeric(15, 2) NULL,
	createdat timestamptz DEFAULT now() NULL,
	tracekey uuid NULL,
	acumulateddebit numeric(15, 2) NULL,
	acumulatedcredit numeric(15, 2) NULL,
	CONSTRAINT balance_pkey PRIMARY KEY (id)
);
CREATE UNIQUE INDEX balance_account ON flow.balance USING btree (branch, account, dateref);

