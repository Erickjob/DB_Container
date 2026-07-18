CREATE TABLE Usuario (
    endereco_email VARCHAR(150) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nasc DATE NOT NULL,
    senha VARCHAR(100) NOT NULL
);

CREATE TABLE email (
    id_email SERIAL PRIMARY KEY,
    assunto VARCHAR(200),
    conteudo TEXT,
    data DATE NOT NULL,
    hora TIME NOT NULL,
    endereco_email VARCHAR(150) NOT NULL,
    FOREIGN KEY (endereco_email) REFERENCES Usuario(endereco_email) ON DELETE CASCADE
);

CREATE TABLE Caixa_Spam (
    id_spam SERIAL PRIMARY KEY,
    endereco_email VARCHAR(150) NOT NULL,
    id_email INT NOT NULL,
    FOREIGN KEY (endereco_email) REFERENCES Usuario(endereco_email) ON DELETE CASCADE,
    FOREIGN KEY (id_email) REFERENCES email(id_email) ON DELETE CASCADE
);

CREATE TABLE Caixa_email (
    id_caixaEmail SERIAL PRIMARY KEY,
    favoritar BOOLEAN DEFAULT FALSE,
    endereco_email VARCHAR(150) NOT NULL,
    id_email INT NOT NULL,
    FOREIGN KEY (endereco_email) REFERENCES Usuario(endereco_email) ON DELETE CASCADE,
    FOREIGN KEY (id_email) REFERENCES email(id_email) ON DELETE CASCADE
);

CREATE TABLE Marcadores (
    nome VARCHAR(50),
    cor VARCHAR(20),
    id_email INT,
    PRIMARY KEY (nome, id_email),
    FOREIGN KEY (id_email) REFERENCES email(id_email) ON DELETE CASCADE
);
