DROP TABLE IF EXISTS proex.empresajunior_discente;
DROP TABLE IF EXISTS proex.empresajunior_anexo;
DROP TABLE IF EXISTS proex.empresajunior_supervisor;
DROP TABLE IF EXISTS proex.empresajunior_esclarecimento;
DROP TABLE IF EXISTS proex.empresajunior_tramitacao;
DROP TABLE IF EXISTS proex.empresajunior_tramitacao_etapa;
DROP TABLE IF EXISTS proex.empresajunior_proposta;
DROP TABLE IF EXISTS proex.empresajunior;

---------------------------------------------------------------------------------
CREATE TABLE proex.empresajunior(
	id serial not null, 
	num_processo character varying(17), -- proposta
	nome text, -- proposta
	resumo text, -- proposta
	curso_vinculado_id integer,	-- proposta
	abrangencia text, -- proposta	
	dt_criacao date, -- proposta
	publico_alvo text, -- proposta
	tipos_atividade text, -- proposta
	apresentacao text, -- detalhamento
	objetivo text, -- detalhamento
	temario text, -- detalhamento
	projetos_referenciais text, -- detalhamento
	dt_fim date, 
	sttcodigo integer not null,		
	CONSTRAINT empresajunior_pkey PRIMARY KEY (id),	
	CONSTRAINT sttcodigo_fkey FOREIGN KEY (sttcodigo)
        REFERENCES proex.statusext (sttcodigo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT curso_vinculado_id_fkey FOREIGN KEY (curso_vinculado_id)
    	REFERENCES proex.cursograd_view (codcur_cur) MATCH SIMPLE
    	ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE proex.empresajunior OWNER to postgres;

GRANT ALL ON TABLE proex.empresajunior TO sis_proexweb;
GRANT ALL ON TABLE proex.empresajunior TO wilson;
GRANT ALL ON TABLE proex.empresajunior TO postgres;

GRANT SELECT, UPDATE ON SEQUENCE proex.empresajunior_id_seq TO postgres;
GRANT ALL ON SEQUENCE proex.empresajunior_id_seq TO sis_proexweb;
GRANT ALL ON SEQUENCE proex.empresajunior_id_seq TO wilson;

---------------------------------------------------------------------------------
CREATE TABLE proex.empresajunior_proposta(
	id serial not null,
	empresajunior_id integer not null, 	
	dt_envio_proposta date not null,
	nro_ufscar_proponente integer not null,
	id_vinculo_proponente integer,	
	CONSTRAINT empresajunior_proposta_pkey PRIMARY KEY (id),
	CONSTRAINT empresajunior_proposta_empresajuniorid__fkey FOREIGN KEY (empresajunior_id)
        REFERENCES proex.empresajunior (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE proex.empresajunior_proposta OWNER to postgres;
GRANT ALL ON TABLE proex.empresajunior_proposta TO sis_proexweb;
GRANT ALL ON TABLE proex.empresajunior_proposta TO wilson;
GRANT ALL ON TABLE proex.empresajunior_proposta TO postgres;

GRANT SELECT, UPDATE ON SEQUENCE proex.empresajunior_proposta_id_seq TO postgres;
GRANT ALL ON SEQUENCE proex.empresajunior_proposta_id_seq TO sis_proexweb;
GRANT ALL ON SEQUENCE proex.empresajunior_proposta_id_seq TO wilson;

---------------------------------------------------------------------------------
CREATE TABLE proex.empresajunior_supervisor (
	id serial not null,		
	empresajunior_id integer not null, 	
	nro_ufscar integer not null,
	cpf character varying(11) not null, 
	dt_inicio date,
	dt_fim	date,
	id_vinculo integer,
	ativo boolean,
	CONSTRAINT empresajunior_supervisor_pkey PRIMARY KEY (id),
	CONSTRAINT empresajunior_supervisor_empresajuniorid__fkey FOREIGN KEY (empresajunior_id)
        REFERENCES proex.empresajunior (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT empresajunior_supervisor_nroufscar_fkey FOREIGN KEY (nro_ufscar)
        REFERENCES core.pessoa (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE proex.empresajunior_supervisor OWNER to postgres;

GRANT ALL ON TABLE proex.empresajunior_supervisor TO sis_proexweb;
GRANT ALL ON TABLE proex.empresajunior_supervisor TO wilson;
GRANT ALL ON TABLE proex.empresajunior_supervisor TO postgres;

GRANT SELECT, UPDATE ON SEQUENCE proex.empresajunior_supervisor_id_seq TO postgres;
GRANT ALL ON SEQUENCE proex.empresajunior_supervisor_id_seq TO sis_proexweb;
GRANT ALL ON SEQUENCE proex.empresajunior_supervisor_id_seq TO wilson;

---------------------------------------------------------------------------------
CREATE TABLE proex.empresajunior_discente (
	id serial not null,
	empresajunior_id integer not null,
	nro_ufscar integer,
	cod_curso integer,
	funcao character varying(40),
	dt_inicio date,
	dt_fim date,
	ativo boolean,
	CONSTRAINT empresajunior_discente_unique UNIQUE (empresajunior_id, nro_ufscar, dt_inicio),
	CONSTRAINT empresajunior_discente_pkey PRIMARY KEY (id),
	CONSTRAINT empresajunior_empresajuniorid_fkey FOREIGN KEY (empresajunior_id)
        REFERENCES proex.empresajunior (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT empresajunior_discente_nroufscar_fkey FOREIGN KEY (nro_ufscar)
        REFERENCES core.pessoa (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE proex.empresajunior_discente OWNER to postgres;

GRANT ALL ON TABLE proex.empresajunior_discente TO sis_proexweb;
GRANT ALL ON TABLE proex.empresajunior_discente TO wilson;
GRANT ALL ON TABLE proex.empresajunior_discente TO postgres;

GRANT SELECT, UPDATE ON SEQUENCE proex.empresajunior_discente_id_seq TO postgres;
GRANT ALL ON SEQUENCE proex.empresajunior_discente_id_seq TO sis_proexweb;
GRANT ALL ON SEQUENCE proex.empresajunior_discente_id_seq TO wilson;

---------------------------------------------------------------------------------
CREATE TABLE proex.empresajunior_anexo (
	id serial not null,
	empresajunior_id integer not null,
	nome_arquivo character varying(150),
	tipo character varying(20), -- (ata, regimento, estatuto, plano)
	origem integer, -- (1=proposta, 2=detalhamento)
	dt_envio date,	
	ativo boolean,
	nome_arquivo_disco character varying(100),
	CONSTRAINT empresajunior_anexo_pkey PRIMARY KEY (id),	
	CONSTRAINT empresajunior_fkey FOREIGN KEY (empresajunior_id)
	        REFERENCES proex.empresajunior (id) MATCH SIMPLE
	        ON UPDATE NO ACTION
	        ON DELETE NO ACTION
);

ALTER TABLE proex.empresajunior_anexo OWNER to postgres;

GRANT ALL ON TABLE proex.empresajunior_anexo TO sis_proexweb;
GRANT ALL ON TABLE proex.empresajunior_anexo TO wilson;
GRANT ALL ON TABLE proex.empresajunior_anexo TO postgres;

GRANT SELECT, UPDATE ON SEQUENCE proex.empresajunior_anexo_id_seq TO postgres;
GRANT ALL ON SEQUENCE proex.empresajunior_anexo_id_seq TO sis_proexweb;
GRANT ALL ON SEQUENCE proex.empresajunior_anexo_id_seq TO wilson;

---------------------------------------------------------------------------------
CREATE TABLE proex.empresajunior_tramitacao_etapa (
	id integer,
	descricao character varying(50), --(edicao, NUEmp, Depto Sup, Coord Curso, CAex, COEx, Aprovada  ...)
	CONSTRAINT empresajunior_tramitacao_etapa_pkey PRIMARY KEY (id)
);

ALTER TABLE proex.empresajunior_tramitacao_etapa OWNER to postgres;

GRANT ALL ON TABLE proex.empresajunior_tramitacao_etapa TO sis_proexweb;
GRANT ALL ON TABLE proex.empresajunior_tramitacao_etapa TO wilson;
GRANT ALL ON TABLE proex.empresajunior_tramitacao_etapa TO postgres;

---------------------------------------------------------------------------------
CREATE TABLE proex.empresajunior_tramitacao (
	id serial not null,
	empresajunior_id integer not null, -- fk proex.empresajunior
	etapa integer not null, --fk proex.empresajunior_tramitacao_etapa
	unidade_organizacional_id integer not null, --fk core.unidade_organizacional (da tramitacao em questao, nuemp, depto supervisor, ...)
	dt_solicitacao date,
	dt_parecer date,
	texto_parecer text,
	texto_observacao text,
	nro_ufscar_parecerista integer, --fk core.pessoa (numero ufscar de quem aprovou)
	tramitacao_status_id integer, -- fk proex.statusext (em tramitacao = 2, em esclarecimento = 8, em edicao = 1, ...)
	codigo_seguranca character varying(10),
	CONSTRAINT empresajunior_tramitacao_pkey PRIMARY KEY (id),	
	CONSTRAINT empresajunior_tramitacao_empresajuniorid_fkey FOREIGN KEY (empresajunior_id)
        REFERENCES proex.empresajunior (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
	CONSTRAINT empresajunior_tramitacao_tramiteext_fkey FOREIGN KEY (etapa)
        REFERENCES proex.empresajunior_tramitacao_etapa (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT empresajunior_tramitacao_unidadeorganizacionalid_fkey FOREIGN KEY (unidade_organizacional_id)
        REFERENCES core.unidade_organizacional (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT empresajunior_tramitacao_nroufscarparecerista_fkey FOREIGN KEY (nro_ufscar_parecerista)
        REFERENCES core.pessoa (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT empresajunior_tramitacao_tramitacaostatusid_fkey FOREIGN KEY (tramitacao_status_id)
        REFERENCES proex.statusext (sttcodigo) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE proex.empresajunior_tramitacao OWNER to postgres;

GRANT ALL ON TABLE proex.empresajunior_tramitacao TO sis_proexweb;
GRANT ALL ON TABLE proex.empresajunior_tramitacao TO wilson;
GRANT ALL ON TABLE proex.empresajunior_tramitacao TO postgres;

GRANT SELECT, UPDATE ON SEQUENCE proex.empresajunior_tramitacao_id_seq TO postgres;
GRANT ALL ON SEQUENCE proex.empresajunior_tramitacao_id_seq TO sis_proexweb;
GRANT ALL ON SEQUENCE proex.empresajunior_tramitacao_id_seq TO wilson;

---------------------------------------------------------------------------------
CREATE TABLE proex.empresajunior_esclarecimento (
	id serial not null,
	nro_ufscar_solicitante integer not null, 
	nro_ufscar_esclarecedor integer,
	empresajunior_id integer not null,
	empresajunior_tramitacao_id integer not null,
	dt_solicitacao timestamp without time zone,
	dt_resposta timestamp without time zone,
	texto_solicitacao text,
	texto_resposta text,
	esclarecido boolean,
	CONSTRAINT empresajunior_esclarecimento_pkey PRIMARY KEY (id),
	CONSTRAINT empresajunior_esclarecimento_empresajuniorid_fkey FOREIGN KEY (empresajunior_id)
        REFERENCES proex.empresajunior (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT empresajunior_esclarecimento_ejtramitacaoid_fkey FOREIGN KEY (empresajunior_tramitacao_id)
        REFERENCES proex.empresajunior_tramitacao (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE proex.empresajunior_esclarecimento OWNER to postgres;

GRANT ALL ON TABLE proex.empresajunior_esclarecimento TO sis_proexweb;
GRANT ALL ON TABLE proex.empresajunior_esclarecimento TO wilson;
GRANT ALL ON TABLE proex.empresajunior_esclarecimento TO postgres;

GRANT SELECT, UPDATE ON SEQUENCE proex.empresajunior_esclarecimento_id_seq TO postgres;
GRANT ALL ON SEQUENCE proex.empresajunior_esclarecimento_id_seq TO sis_proexweb;
GRANT ALL ON SEQUENCE proex.empresajunior_esclarecimento_id_seq TO wilson;

INSERT INTO proex.empresajunior_tramitacao_etapa (
	id,
	descricao
) 
VALUES
(	
	1,
	'Em edição'
),
(	
	2,
	'NUEmp'
),
(	
	3,
	'Departamento do Supervisor'
),
(
	4,
	'Coordenação de Curso'
),
(
	5,
	'CAEx'	
),
(
	6,
	'CoEx'
),
(
	7,
	'Aprovada'
)
ON CONFLICT DO NOTHING;
