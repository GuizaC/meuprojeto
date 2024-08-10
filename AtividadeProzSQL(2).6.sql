-- Criar a tabela Autores
CREATE TABLE Autores (
    AutorID INTEGER PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Nacionalidade TEXT
);

-- Criar a tabela Livros
CREATE TABLE Livros (
    LivroID INTEGER PRIMARY KEY,
    Titulo VARCHAR(50) NOT NULL,
    AutorID INTEGER,
    Genero VARCHAR(50),
    FOREIGN KEY (AutorID) REFERENCES Autores(AutorID)
);

-- Criar a tabela Emprestimos
CREATE TABLE Emprestimos (
    EmprestimoID INTEGER PRIMARY KEY,
    LivroID INTEGER,
    DataEmprestimo DATE,
    DataDevolucao DATE,
    NomePessoa VARCHAR(50),
    FOREIGN KEY (LivroID) REFERENCES Livros(LivroID)
);

-- Inserir dados na tabela Autores
INSERT INTO Autores ( Nome, AutorID, Nacionalidade) VALUES
('J.K. Rowling', 1, 'Britânica'),
('George R.R. Martin', 2, 'Americana'),
('J.R.R. Tolkien', 3, 'Britânica');

-- Inserir dados na tabela Livros
INSERT INTO Livros (LivroID, Titulo, AutorID, Genero) VALUES
(1, 'Harry Potter e a Pedra Filosofal', 1, 'Fantasia'),
(2, 'A Guerra dos Tronos', 2, 'Fantasia'),
(3, 'O Senhor dos Anéis', 3, 'Fantasia');

-- Inserir dados na tabela Emprestimos
INSERT INTO Emprestimos (EmprestimoID, LivroID, DataEmprestimo, DataDevolucao, NomePessoa) VALUES
(1, 1, '2024-08-01', '2024-08-15', 'Alice'),
(3, 2, '2024-08-03', '2024-08-17', 'Bob'),
(2, 3, '2024-08-05', '2024-08-20', 'Charlie');

-- Consulta de livros com seus respectivos autores
SELECT Livros.Titulo, Autores.Nome AS Autor
FROM Livros
JOIN Autores ON Livros.AutorID = Autores.AutorID;

-- Consulta de empréstimos
SELECT Emprestimos.NomePessoa, Livros.Titulo, Emprestimos.DataEmprestimo, Emprestimos.DataDevolucao
FROM Emprestimos
JOIN Livros ON Emprestimos.LivroID = Livros.LivroID;

-- Consulta de empréstimos com autores
SELECT Emprestimos.NomePessoa, Livros.Titulo, Autores.Nome AS Autor, Emprestimos.DataEmprestimo, Emprestimos.DataDevolucao
FROM Emprestimos
JOIN Livros ON Emprestimos.LivroID = Livros.LivroID
JOIN Autores ON Livros.AutorID = Autores.AutorID;

ALTER TABLE emprestimos
ADD COLUMN log_emprestimos VARCHAR(50);

CREATE TRIGGER AfterInsertEmprestimo
AFTER INSERT ON Emprestimos
FOR EACH ROW
BEGIN
	if log_emprestimos IS NULL THEN
		INSERT INTO emprestimos (log_emprestimos)
		VALUES (datetime('now'));
    END IF;
END;