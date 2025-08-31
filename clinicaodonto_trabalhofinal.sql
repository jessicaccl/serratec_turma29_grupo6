create schema ClinicaOdonto;

create table ClinicaOdonto.Dentista
(
    id_dentista serial primary key,
    nome_completo varchar(100) not null,
    cpf varchar(11) not null unique,
    cro varchar(15) not null unique,
    especialidade varchar(100) not null
);

create table ClinicaOdonto.Bairro (
    id_bairro serial primary key,
    nm_bairro varchar(100)
);

create table ClinicaOdonto.Cidade (
    id_cidade serial primary key,
    nm_cidade varchar(100),
    uf varchar(2)
);

create table ClinicaOdonto.Endereco (
    id_endereco serial primary key,
    logradouro varchar(150),
    id_bairro int references ClinicaOdonto.Bairro(id_bairro),
    id_cidade int references ClinicaOdonto.Cidade(id_cidade)
);

create table ClinicaOdonto.Paciente
(
    id_paciente serial primary key,
    nome_completo varchar(100) not null,
    cpf varchar(11) unique,
    data_nascimento date,
    telefone varchar(20),
    email varchar(100) unique,
	id_endereco int references ClinicaOdonto.Endereco(id_endereco)
);

create table ClinicaOdonto.Consulta
(
    id_consulta serial primary key,
    data_hora timestamp not null,
    descricao_queixa text,
    prescricao text,
    id_paciente int not null,
    id_dentista int not null,
	consulta_realizada boolean,
	
constraint fk_consulta_paciente foreign key (id_paciente)
    references ClinicaOdonto.Paciente (id_paciente)
    on update cascade on delete restrict,

constraint fk_consulta_dentista foreign key (id_dentista)
    references ClinicaOdonto.Dentista (id_dentista)
    on update cascade on delete restrict
);

create table ClinicaOdonto.Consulta_Paciente
(
	idConsulta_Paciente serial primary key,
	id_paciente int references ClinicaOdonto.Paciente(id_paciente),
    id_consulta int references ClinicaOdonto.Consulta(id_consulta)
);

alter table ClinicaOdonto.Paciente
add column historico_consulta int references ClinicaOdonto.Consulta_Paciente(idConsulta_Paciente);


create table ClinicaOdonto.Procedimento
(
    id_procedimento serial primary key,
    nome varchar(100) not null unique,
    descricao text,
    duracao_media int
);


create table ClinicaOdonto.Procedimento_Consulta
(
	idProcedimento_consulta serial primary key,
	id_procedimento int references ClinicaOdonto.Procedimento(id_procedimento),
    id_consulta int references ClinicaOdonto.Consulta(id_consulta)
);

create table ClinicaOdonto.Horario_Dentista
(
    id_horario serial primary key,
    id_dentista int references ClinicaOdonto.Dentista(id_dentista),
    dia_semana char(20) not null check (dia_semana in('Segunda','Terça','Quarta','Quinta','Sexta','Sábado')),
    hora_inicio time not null,
    hora_fim time
);
