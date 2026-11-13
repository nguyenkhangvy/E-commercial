drop database if exists unigear;
create database unigear
  character set utf8mb4
  collate utf8mb4_unicode_ci;
use unigear;

create table users (
    user_id    bigint        not null auto_increment primary key,
    email      varchar(255)  not null unique,
    password   varchar(255)  not null,
    full_name  varchar(100)  not null,
    phone      varchar(20)   null,
    role       enum('CUSTOMER','SELLER','ADMIN') not null,
    status     enum('ACTIVE','DISABLED') not null default 'ACTIVE',
    balance    decimal(15,2) not null default 0 check (balance >= 0)
);

create table addresses (
    address_id  bigint auto_increment primary key,
    user_id     bigint not null,
    province    varchar(100) not null,
    district    varchar(100) not null,
    ward        varchar(100) not null,
    detail      varchar(255) not null,
    is_default  boolean not null default false,
    foreign key (user_id) references users(user_id)
);

create table stores (
    store_id       bigint auto_increment primary key,
    owner_id       bigint not null unique,
    name           varchar(150) not null,
    phone          varchar(20) not null,
    store_address  varchar(255) not null,
    logo_url       varchar(500),
    status         enum('PENDING','ACTIVE','SUSPENDED') not null default 'PENDING',
    foreign key (owner_id) references users(user_id)
);

create table categories (
    category_id  bigint auto_increment primary key,
    name         varchar(150) not null
);

create table products (
    product_id     bigint auto_increment primary key,
    category_id    bigint not null,
    store_id       bigint not null,
    name           varchar(200) not null,
    description    text,
    thumbnail_url  varchar(500),
    status         enum('PENDING','APPROVED','REJECTED','HIDDEN') not null default 'PENDING',
    created_at     datetime not null default current_timestamp,
    deleted_at     datetime,
    foreign key (store_id)    references stores(store_id),
    foreign key (category_id) references categories(category_id)
);

create table product_variants (
    variant_id  bigint auto_increment primary key,
    product_id  bigint not null,
    name        varchar(100) not null,
    price       decimal(15,2) not null check (price >= 0),
    stock       int not null default 0 check (stock >= 0),
    image_url   varchar(500),
    deleted_at  datetime,
    foreign key (product_id) references products(product_id)
);

create table cart_items (
    user_id      bigint not null,
    variant_id   bigint not null,
    quantity     int not null default 1 check (quantity > 0),
    is_selected  boolean not null default false,
    primary key (user_id, variant_id),
    foreign key (user_id)    references users(user_id),
    foreign key (variant_id) references product_variants(variant_id)
);

create table orders (
    order_id        bigint auto_increment primary key,
    user_id         bigint not null,
    store_id        bigint not null,
    status          enum('PENDING','CONFIRMED','SHIPPING','DELIVERED','CANCELLED') not null default 'PENDING',
    payment_method  enum('COD','CREADIT_CARD','DEBIT_CARD','BANK_TRANSFER','E_WALLET') not null,
    shipping_fee    decimal(15,2) not null default 0 check (shipping_fee >= 0),
    recipient_name  varchar(100) not null,
    phone           varchar(20) not null,
    address         varchar(500) not null,
    cancel_reason   varchar(500),
    created_at      datetime not null default current_timestamp,
    foreign key (user_id)  references users(user_id),
    foreign key (store_id) references stores(store_id)
);

create table order_items (
    order_item_id  bigint auto_increment primary key,
    variant_id     bigint not null,
    order_id       bigint not null,
    quantity       int not null check (quantity > 0),
    unique (order_id, variant_id),
    foreign key (variant_id) references product_variants(variant_id),
    foreign key (order_id)   references orders(order_id)
);

create table reviews (
    review_id      bigint auto_increment primary key,
    order_item_id  bigint not null,
    rating         tinyint not null check (rating between 1 and 5),
    comment        varchar(1000),
    created_at     datetime not null default current_timestamp,
    foreign key (order_item_id) references order_items(order_item_id)
);

create table wallet_transactions (
    transaction_id  bigint auto_increment primary key,
    user_id         bigint not null,
    order_id        bigint,
    amount          decimal(15,2) not null,
    type            enum('PAYMENT','INCOME','REFUND','ADMIN_ADJUST','DEPOSIT','WITHBACK') not null,
    created_at      datetime not null default current_timestamp,
    foreign key (user_id)  references users(user_id),
    foreign key (order_id) references orders(order_id)
);

create table chat_rooms (
    chat_room_id         bigint auto_increment primary key,
    customer_id          bigint not null,
    store_id             bigint not null,
    customer_deleted_at  datetime,
    seller_deleted_at    datetime,
    unique (customer_id, store_id),
    foreign key (customer_id) references users(user_id),
    foreign key (store_id)    references stores(store_id)
);

create table messages (
    message_id    bigint auto_increment primary key,
    chat_room_id  bigint not null,
    sender_side   enum('CUSTOMER','STORE') not null,
    content       varchar(2000) not null,
    sent_at       datetime not null default current_timestamp,
    is_read       boolean not null default false,
    index (chat_room_id, sent_at),
    foreign key (chat_room_id) references chat_rooms(chat_room_id)
);

create table complaints (
    complaint_id  bigint auto_increment primary key,
    order_id      bigint not null unique,
    reason        varchar(1000) not null,
    status        enum('PENDING','APPROVED','REJECTED') not null default 'PENDING',
    admin_note    varchar(1000),
    created_at    datetime not null default current_timestamp,
    resolved_at   datetime,
    foreign key (order_id) references orders(order_id)
);