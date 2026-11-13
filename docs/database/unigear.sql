USE unigear;

CREATE TABLE users (
    user_id    BIGINT        NOT NULL AUTO_INCREMENT primary key,
    email      VARCHAR(255)  NOT NULL unique,
    password   VARCHAR(255)  NOT NULL,                
    full_name  VARCHAR(100)  NOT NULL,
    phone      VARCHAR(20)   NULL,
    role       ENUM('customer','seller','admin') NOT NULL,
    status     ENUM('active','disabled') NOT NULL DEFAULT 'ACTIVE',
   balance DECIMAL(15,2) NOT NULL DEFAULT 0 check(balance >= 0)
);

CREATE TABLE addresses (
    address_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id     BIGINT NOT NULL,
    province    VARCHAR(100) NOT NULL,
    district    VARCHAR(100) NOT NULL,
    ward        VARCHAR(100) NOT NULL,
    detail      VARCHAR(255) NOT NULL,
    is_default  BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE stores (
    store_id       BIGINT AUTO_INCREMENT PRIMARY KEY,
    owner_id       BIGINT NOT NULL UNIQUE,
    name           VARCHAR(150) NOT NULL,
    phone          VARCHAR(20) NOT NULL,
    store_address  VARCHAR(255) NOT NULL,
    logo_url       VARCHAR(500),
    status         ENUM('PENDING','ACTIVE','SUSPENDED') NOT NULL DEFAULT 'PENDING',
    FOREIGN KEY (owner_id) REFERENCES users(user_id)
);

create table categories (
	category_id bigint auto_increment primary key,
    name varchar(150) not null
);

create table products (
	product_id bigint auto_increment primary key,
    category_id bigint not null,
    store_id bigint not null,
    name varchar(200) not null,
    description text,
    thumbnail_url varchar(500),
    status enum('pending', 'approved', 'rejected', 'hidden') not null default 'pending',
    created_at datetime not null default current_timestamp,
    deleted_at datetime,
    FOREIGN KEY (store_id)    REFERENCES stores(store_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE product_variants (
    variant_id  BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id  BIGINT NOT NULL,
    name        VARCHAR(100) NOT NULL,
    price       DECIMAL(15,2) NOT NULL CHECK (price >= 0),
    stock       INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    image_url   VARCHAR(500),	
    deleted_at  DATETIME,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE cart_items (
    user_id      BIGINT NOT NULL,
    variant_id   BIGINT NOT NULL,
    quantity     INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    is_selected  BOOLEAN NOT NULL DEFAULT false,
    PRIMARY KEY (user_id, variant_id),
    FOREIGN KEY (user_id)    REFERENCES users(user_id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(variant_id)
);

create table orders (
	order_id bigint auto_increment primary key,
    user_id bigint not null,
    store_id bigint not null,
    status enum('pending', 'confirmed', 'shipping', 'delivered', 'cancelled') not null default 'pending',
    payment_method enum('cod', 'creadit_card','debit_card','bank_transfer', 'e_wallet') not null,
    shipping_fee decimal(15,2) not null default 0 check (shipping_fee >=0),
    recipient_name varchar(100) not null,
    phone varchar(20) not null,
    address varchar(500) not null,
    cancel_reason varchar(500),
    created_at datetime not null default current_timestamp,
    foreign key (user_id) references users(user_id), 
    foreign key (store_id) references stores(store_id)
);


create table order_items(
	order_item_id bigint auto_increment primary key,
    variant_id bigint not null,
    order_id bigint not null,
    quantity int not null check(quantity > 0),
    unique (order_id, variant_id),
    foreign key (variant_id) references product_variants(variant_id),
    foreign key (order_id) references orders(order_id)
);

create table reviews (
    review_id bigint auto_increment primary key,
    order_item_id  bigint not null,
    rating         tinyint not null check (rating between 1 and 5),
    comment        varchar(1000),
    created_at     datetime not null default current_timestamp,
    foreign key (order_item_id) references order_items(order_item_id)
);

create table wallet_transactions (
	transaction_id bigint auto_increment primary key,
    user_id bigint not null,
    order_id bigint,
    amount decimal(15,2) not null,
    type enum('payment','income','refund', 'admin_adjust', 'deposit', 'withback') not null,
    created_at datetime not null default current_timestamp,
    foreign key (user_id) references users(user_id),
    foreign key (order_id) references orders(order_id)
);

create table chat_rooms (
    chat_room_id bigint auto_increment primary key,
    customer_id bigint not null,
    store_id bigint not null,
    customer_deleted_at datetime,
    seller_deleted_at datetime,
    unique (customer_id, store_id),
    foreign key (customer_id) references users(user_id),
    foreign key (store_id) references stores(store_id)
);

create table messages (
    message_id    bigint auto_increment primary key,
    chat_room_id  bigint not null,
    sender_side   ENUM('customer','store') not null,
    content       varchar(2000) not null,
    sent_at       datetime not null default current_timestamp,
    is_read       boolean not null default false,
    index (chat_room_id, sent_at),
    foreign key (chat_room_id) references chat_rooms(chat_room_id)
);