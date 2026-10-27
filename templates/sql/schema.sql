CREATE TABLE IF NOT EXISTS tasks (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    done INTEGER NOT NULL DEFAULT 0
);

INSERT INTO tasks (title, done) VALUES ('Estudar Emacs', 0);
