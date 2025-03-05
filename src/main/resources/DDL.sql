-- Задание 1

-- Таблица логов
create table public.logs
(
    id          serial
        primary key,
    action      text    not null,
    user_id     integer not null,
    username    text,
    change_time timestamp default CURRENT_TIMESTAMP
);

alter table public.logs
    owner to postgres;

-- Таблица пользователей
create table public.users
(
    id       integer not null
        primary key,
    username text
);

alter table public.users
    owner to postgres;

-- Триггер для обновления пользователя
create function public.log_update() returns trigger
    language plpgsql
as
$$
BEGIN
INSERT INTO logs (action, user_id, username)
VALUES ('изменили', NEW.id, NEW.username);
RETURN NEW;
END;
$$;

alter function public.log_update() owner to postgres;

-- Триггер для удаления пользователя
create function public.log_delete() returns trigger
    language plpgsql
as
$$
BEGIN
INSERT INTO logs (action, user_id, username)
VALUES ('удалили', OLD.id, OLD.username);
RETURN OLD;
END;
$$;

alter function public.log_delete() owner to postgres;

-- Функция для получения последнего пользователя
create function public.last_user() returns text
    language plpgsql
as
$$
DECLARE
last_username TEXT;
BEGIN
SELECT username INTO last_username FROM users ORDER BY id DESC LIMIT 1;
RETURN last_username;
END;
$$;

alter function public.last_user() owner to postgres;

-- Задание 2

-- Таблица книг
create table public.books
(
    id               serial
        primary key,
    title            text    not null,
    author           text    not null,
    publication_year integer not null
);

alter table public.books
    owner to postgres;

-- Таблица читателей
create table public.readers
(
    id    serial
        primary key,
    name  text not null,
    email text not null
        unique
);

alter table public.readers
    owner to postgres;

-- Таблица бронирования книг
create table public.reservations
(
    id               serial
        primary key,
    book_id          integer not null
        constraint fk_book
            references public.books
            on delete cascade,
    reader_id        integer not null
        constraint fk_reader
            references public.readers
            on delete cascade,
    reservation_date timestamp default CURRENT_TIMESTAMP,
    return_date      timestamp
);

alter table public.reservations
    owner to postgres;




