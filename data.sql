--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6 (Ubuntu 16.6-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.6 (Ubuntu 16.6-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addon_configsettings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addon_configsettings (
    id bigint NOT NULL,
    view_more text,
    currency_sign text,
    currency_abbreviation text,
    service_fee_percentage bigint,
    service_fee_flat_rate numeric,
    service_fee_charge_type text,
    enforce_2fa boolean,
    activate_affiliate_system boolean,
    send_email_notifications boolean
);


ALTER TABLE public.addon_configsettings OWNER TO postgres;

--
-- Name: addon_configsettings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.addon_configsettings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.addon_configsettings_id_seq OWNER TO postgres;

--
-- Name: addon_configsettings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.addon_configsettings_id_seq OWNED BY public.addon_configsettings.id;


--
-- Name: addon_tax; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addon_tax (
    id bigint NOT NULL,
    country text,
    rate bigint,
    active boolean,
    date timestamp with time zone
);


ALTER TABLE public.addon_tax OWNER TO postgres;

--
-- Name: addon_tax_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.addon_tax_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.addon_tax_id_seq OWNER TO postgres;

--
-- Name: addon_tax_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.addon_tax_id_seq OWNED BY public.addon_tax.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id bigint NOT NULL,
    name text
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id bigint,
    permission_id bigint
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id bigint NOT NULL,
    content_type_id bigint,
    codename text,
    name text
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id bigint NOT NULL,
    object_id text,
    object_repr text,
    action_flag smallint,
    change_message text,
    content_type_id bigint,
    user_id bigint,
    action_time timestamp with time zone
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id bigint NOT NULL,
    app_label text,
    model text
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app text,
    name text,
    applied timestamp with time zone
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key text NOT NULL,
    session_data text,
    expire_date timestamp with time zone
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: store_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_address (
    id bigint NOT NULL,
    full_name text,
    mobile text,
    email text,
    state text,
    town_city text,
    address text,
    zip text,
    status boolean,
    same_as_billing_address boolean,
    country_id bigint,
    user_id bigint
);


ALTER TABLE public.store_address OWNER TO postgres;

--
-- Name: store_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_address_id_seq OWNER TO postgres;

--
-- Name: store_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_address_id_seq OWNED BY public.store_address.id;


--
-- Name: store_brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_brand (
    id bigint NOT NULL,
    title text,
    image text,
    active boolean
);


ALTER TABLE public.store_brand OWNER TO postgres;

--
-- Name: store_brand_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_brand_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_brand_id_seq OWNER TO postgres;

--
-- Name: store_brand_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_brand_id_seq OWNED BY public.store_brand.id;


--
-- Name: store_cancelledorder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_cancelledorder (
    id bigint NOT NULL,
    email text,
    refunded boolean,
    orderitem_id bigint,
    user_id bigint
);


ALTER TABLE public.store_cancelledorder OWNER TO postgres;

--
-- Name: store_cancelledorder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_cancelledorder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_cancelledorder_id_seq OWNER TO postgres;

--
-- Name: store_cancelledorder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_cancelledorder_id_seq OWNED BY public.store_cancelledorder.id;


--
-- Name: store_cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_cart (
    id bigint NOT NULL,
    qty integer,
    price numeric,
    sub_total numeric,
    shipping_amount numeric,
    service_fee numeric,
    tax_fee numeric,
    total numeric,
    country text,
    size text,
    color text,
    cart_id text,
    date timestamp with time zone,
    product_id bigint,
    user_id bigint
);


ALTER TABLE public.store_cart OWNER TO postgres;

--
-- Name: store_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_cart_id_seq OWNER TO postgres;

--
-- Name: store_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_cart_id_seq OWNED BY public.store_cart.id;


--
-- Name: store_cartorder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_cartorder (
    id bigint NOT NULL,
    sub_total numeric,
    shipping_amount numeric,
    tax_fee numeric,
    service_fee numeric,
    total numeric,
    payment_status text,
    order_status text,
    initial_total numeric,
    saved numeric,
    full_name text,
    email text,
    mobile text,
    address text,
    city text,
    state text,
    country text,
    stripe_session_id text,
    oid text,
    date timestamp with time zone,
    buyer_id bigint
);


ALTER TABLE public.store_cartorder OWNER TO postgres;

--
-- Name: store_cartorder_coupons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_cartorder_coupons (
    id bigint NOT NULL,
    cartorder_id bigint,
    coupon_id bigint
);


ALTER TABLE public.store_cartorder_coupons OWNER TO postgres;

--
-- Name: store_cartorder_coupons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_cartorder_coupons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_cartorder_coupons_id_seq OWNER TO postgres;

--
-- Name: store_cartorder_coupons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_cartorder_coupons_id_seq OWNED BY public.store_cartorder_coupons.id;


--
-- Name: store_cartorder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_cartorder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_cartorder_id_seq OWNER TO postgres;

--
-- Name: store_cartorder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_cartorder_id_seq OWNED BY public.store_cartorder.id;


--
-- Name: store_cartorder_vendor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_cartorder_vendor (
    id bigint NOT NULL,
    cartorder_id bigint,
    vendor_id bigint
);


ALTER TABLE public.store_cartorder_vendor OWNER TO postgres;

--
-- Name: store_cartorder_vendor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_cartorder_vendor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_cartorder_vendor_id_seq OWNER TO postgres;

--
-- Name: store_cartorder_vendor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_cartorder_vendor_id_seq OWNED BY public.store_cartorder_vendor.id;


--
-- Name: store_cartorderitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_cartorderitem (
    id bigint NOT NULL,
    qty bigint,
    color text,
    size text,
    price numeric,
    sub_total numeric,
    shipping_amount numeric,
    tax_fee numeric,
    service_fee numeric,
    total numeric,
    expected_delivery_date_from date,
    expected_delivery_date_to date,
    initial_total numeric,
    saved numeric,
    order_placed boolean,
    processing_order boolean,
    quality_check boolean,
    product_shipped boolean,
    product_arrived boolean,
    product_delivered boolean,
    delivery_status text,
    tracking_id text,
    applied_coupon boolean,
    oid text,
    date timestamp with time zone,
    delivery_couriers_id bigint,
    order_id bigint,
    product_id bigint,
    vendor_id bigint
);


ALTER TABLE public.store_cartorderitem OWNER TO postgres;

--
-- Name: store_cartorderitem_coupon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_cartorderitem_coupon (
    id bigint NOT NULL,
    cartorderitem_id bigint,
    coupon_id bigint
);


ALTER TABLE public.store_cartorderitem_coupon OWNER TO postgres;

--
-- Name: store_cartorderitem_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_cartorderitem_coupon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_cartorderitem_coupon_id_seq OWNER TO postgres;

--
-- Name: store_cartorderitem_coupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_cartorderitem_coupon_id_seq OWNED BY public.store_cartorderitem_coupon.id;


--
-- Name: store_cartorderitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_cartorderitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_cartorderitem_id_seq OWNER TO postgres;

--
-- Name: store_cartorderitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_cartorderitem_id_seq OWNED BY public.store_cartorderitem.id;


--
-- Name: store_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_category (
    id bigint NOT NULL,
    title text,
    image text,
    active boolean,
    slug text
);


ALTER TABLE public.store_category OWNER TO postgres;

--
-- Name: store_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_category_id_seq OWNER TO postgres;

--
-- Name: store_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_category_id_seq OWNED BY public.store_category.id;


--
-- Name: store_color; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_color (
    id bigint NOT NULL,
    name text,
    color_code text,
    image text,
    product_id bigint
);


ALTER TABLE public.store_color OWNER TO postgres;

--
-- Name: store_color_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_color_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_color_id_seq OWNER TO postgres;

--
-- Name: store_color_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_color_id_seq OWNED BY public.store_color.id;


--
-- Name: store_coupon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_coupon (
    id bigint NOT NULL,
    code text,
    discount bigint,
    date timestamp with time zone,
    active boolean,
    cid text,
    vendor_id bigint
);


ALTER TABLE public.store_coupon OWNER TO postgres;

--
-- Name: store_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_coupon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_coupon_id_seq OWNER TO postgres;

--
-- Name: store_coupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_coupon_id_seq OWNED BY public.store_coupon.id;


--
-- Name: store_coupon_used_by; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_coupon_used_by (
    id bigint NOT NULL,
    coupon_id bigint,
    user_id bigint
);


ALTER TABLE public.store_coupon_used_by OWNER TO postgres;

--
-- Name: store_coupon_used_by_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_coupon_used_by_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_coupon_used_by_id_seq OWNER TO postgres;

--
-- Name: store_coupon_used_by_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_coupon_used_by_id_seq OWNED BY public.store_coupon_used_by.id;


--
-- Name: store_couponusers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_couponusers (
    id bigint NOT NULL,
    full_name text,
    email text,
    mobile text,
    coupon_id bigint,
    order_id bigint
);


ALTER TABLE public.store_couponusers OWNER TO postgres;

--
-- Name: store_couponusers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_couponusers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_couponusers_id_seq OWNER TO postgres;

--
-- Name: store_couponusers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_couponusers_id_seq OWNED BY public.store_couponusers.id;


--
-- Name: store_deliverycouriers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_deliverycouriers (
    id bigint NOT NULL,
    name text,
    tracking_website text,
    url_parameter text
);


ALTER TABLE public.store_deliverycouriers OWNER TO postgres;

--
-- Name: store_deliverycouriers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_deliverycouriers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_deliverycouriers_id_seq OWNER TO postgres;

--
-- Name: store_deliverycouriers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_deliverycouriers_id_seq OWNED BY public.store_deliverycouriers.id;


--
-- Name: store_gallery; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_gallery (
    id bigint NOT NULL,
    image text,
    active boolean,
    date timestamp with time zone,
    gid text,
    product_id bigint
);


ALTER TABLE public.store_gallery OWNER TO postgres;

--
-- Name: store_gallery_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_gallery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_gallery_id_seq OWNER TO postgres;

--
-- Name: store_gallery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_gallery_id_seq OWNED BY public.store_gallery.id;


--
-- Name: store_notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_notification (
    id bigint NOT NULL,
    seen boolean,
    date timestamp with time zone,
    order_id bigint,
    order_item_id bigint,
    user_id bigint,
    vendor_id bigint
);


ALTER TABLE public.store_notification OWNER TO postgres;

--
-- Name: store_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_notification_id_seq OWNER TO postgres;

--
-- Name: store_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_notification_id_seq OWNED BY public.store_notification.id;


--
-- Name: store_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_product (
    id bigint NOT NULL,
    title text,
    image text,
    description text,
    tags text,
    brand text,
    price numeric,
    old_price numeric,
    shipping_amount numeric,
    stock_qty integer,
    in_stock boolean,
    status text,
    type text,
    featured boolean,
    hot_deal boolean,
    special_offer boolean,
    digital boolean,
    views integer,
    orders integer,
    saved integer,
    rating bigint,
    sku text,
    pid text,
    slug text,
    date timestamp with time zone,
    category_id bigint,
    vendor_id bigint
);


ALTER TABLE public.store_product OWNER TO postgres;

--
-- Name: store_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_product_id_seq OWNER TO postgres;

--
-- Name: store_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_product_id_seq OWNED BY public.store_product.id;


--
-- Name: store_productfaq; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_productfaq (
    id bigint NOT NULL,
    pid text,
    email text,
    question text,
    answer text,
    active boolean,
    date timestamp with time zone,
    product_id bigint,
    user_id bigint
);


ALTER TABLE public.store_productfaq OWNER TO postgres;

--
-- Name: store_productfaq_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_productfaq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_productfaq_id_seq OWNER TO postgres;

--
-- Name: store_productfaq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_productfaq_id_seq OWNED BY public.store_productfaq.id;


--
-- Name: store_review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_review (
    id bigint NOT NULL,
    review text,
    reply text,
    rating bigint,
    active boolean,
    date timestamp with time zone,
    product_id bigint,
    user_id bigint
);


ALTER TABLE public.store_review OWNER TO postgres;

--
-- Name: store_review_helpful; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_review_helpful (
    id bigint NOT NULL,
    review_id bigint,
    user_id bigint
);


ALTER TABLE public.store_review_helpful OWNER TO postgres;

--
-- Name: store_review_helpful_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_review_helpful_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_review_helpful_id_seq OWNER TO postgres;

--
-- Name: store_review_helpful_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_review_helpful_id_seq OWNED BY public.store_review_helpful.id;


--
-- Name: store_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_review_id_seq OWNER TO postgres;

--
-- Name: store_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_review_id_seq OWNED BY public.store_review.id;


--
-- Name: store_review_not_helpful; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_review_not_helpful (
    id bigint NOT NULL,
    review_id bigint,
    user_id bigint
);


ALTER TABLE public.store_review_not_helpful OWNER TO postgres;

--
-- Name: store_review_not_helpful_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_review_not_helpful_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_review_not_helpful_id_seq OWNER TO postgres;

--
-- Name: store_review_not_helpful_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_review_not_helpful_id_seq OWNED BY public.store_review_not_helpful.id;


--
-- Name: store_size; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_size (
    id bigint NOT NULL,
    name text,
    price numeric,
    product_id bigint
);


ALTER TABLE public.store_size OWNER TO postgres;

--
-- Name: store_size_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_size_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_size_id_seq OWNER TO postgres;

--
-- Name: store_size_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_size_id_seq OWNED BY public.store_size.id;


--
-- Name: store_specification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_specification (
    id bigint NOT NULL,
    title text,
    content text,
    product_id bigint
);


ALTER TABLE public.store_specification OWNER TO postgres;

--
-- Name: store_specification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_specification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_specification_id_seq OWNER TO postgres;

--
-- Name: store_specification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_specification_id_seq OWNED BY public.store_specification.id;


--
-- Name: store_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_tag (
    id bigint NOT NULL,
    title text,
    active boolean,
    slug text,
    category_id bigint
);


ALTER TABLE public.store_tag OWNER TO postgres;

--
-- Name: store_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_tag_id_seq OWNER TO postgres;

--
-- Name: store_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_tag_id_seq OWNED BY public.store_tag.id;


--
-- Name: store_wishlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_wishlist (
    id bigint NOT NULL,
    date timestamp with time zone,
    product_id bigint,
    user_id bigint
);


ALTER TABLE public.store_wishlist OWNER TO postgres;

--
-- Name: store_wishlist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_wishlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.store_wishlist_id_seq OWNER TO postgres;

--
-- Name: store_wishlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_wishlist_id_seq OWNED BY public.store_wishlist.id;


--
-- Name: token_blacklist_blacklistedtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_blacklist_blacklistedtoken (
    blacklisted_at timestamp with time zone,
    token_id bigint,
    id bigint NOT NULL
);


ALTER TABLE public.token_blacklist_blacklistedtoken OWNER TO postgres;

--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.token_blacklist_blacklistedtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.token_blacklist_blacklistedtoken_id_seq OWNER TO postgres;

--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.token_blacklist_blacklistedtoken_id_seq OWNED BY public.token_blacklist_blacklistedtoken.id;


--
-- Name: token_blacklist_outstandingtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token_blacklist_outstandingtoken (
    token text,
    created_at timestamp with time zone,
    expires_at timestamp with time zone,
    user_id bigint,
    jti text,
    id bigint NOT NULL
);


ALTER TABLE public.token_blacklist_outstandingtoken OWNER TO postgres;

--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.token_blacklist_outstandingtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.token_blacklist_outstandingtoken_id_seq OWNER TO postgres;

--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.token_blacklist_outstandingtoken_id_seq OWNED BY public.token_blacklist_outstandingtoken.id;


--
-- Name: userauths_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userauths_profile (
    id bigint NOT NULL,
    image text,
    full_name text,
    about text,
    gender text,
    country text,
    city text,
    state text,
    address text,
    newsletter boolean,
    type text,
    date timestamp with time zone,
    pid text,
    user_id bigint
);


ALTER TABLE public.userauths_profile OWNER TO postgres;

--
-- Name: userauths_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userauths_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.userauths_profile_id_seq OWNER TO postgres;

--
-- Name: userauths_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.userauths_profile_id_seq OWNED BY public.userauths_profile.id;


--
-- Name: userauths_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userauths_user (
    id bigint NOT NULL,
    password text,
    last_login timestamp with time zone,
    is_superuser boolean,
    first_name text,
    last_name text,
    is_staff boolean,
    is_active boolean,
    date_joined timestamp with time zone,
    username text,
    email text,
    full_name text,
    phone text,
    otp text,
    reset_token text
);


ALTER TABLE public.userauths_user OWNER TO postgres;

--
-- Name: userauths_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userauths_user_groups (
    id bigint NOT NULL,
    user_id bigint,
    group_id bigint
);


ALTER TABLE public.userauths_user_groups OWNER TO postgres;

--
-- Name: userauths_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userauths_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.userauths_user_groups_id_seq OWNER TO postgres;

--
-- Name: userauths_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.userauths_user_groups_id_seq OWNED BY public.userauths_user_groups.id;


--
-- Name: userauths_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userauths_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.userauths_user_id_seq OWNER TO postgres;

--
-- Name: userauths_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.userauths_user_id_seq OWNED BY public.userauths_user.id;


--
-- Name: userauths_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userauths_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint,
    permission_id bigint
);


ALTER TABLE public.userauths_user_user_permissions OWNER TO postgres;

--
-- Name: userauths_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userauths_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.userauths_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: userauths_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.userauths_user_user_permissions_id_seq OWNED BY public.userauths_user_user_permissions.id;


--
-- Name: vendor_vendor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_vendor (
    id bigint NOT NULL,
    image text,
    name text,
    email text,
    description text,
    mobile text,
    verified boolean,
    active boolean,
    vid text,
    date timestamp with time zone,
    slug text,
    user_id bigint
);


ALTER TABLE public.vendor_vendor OWNER TO postgres;

--
-- Name: vendor_vendor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendor_vendor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_vendor_id_seq OWNER TO postgres;

--
-- Name: vendor_vendor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendor_vendor_id_seq OWNED BY public.vendor_vendor.id;


--
-- Name: addon_configsettings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addon_configsettings ALTER COLUMN id SET DEFAULT nextval('public.addon_configsettings_id_seq'::regclass);


--
-- Name: addon_tax id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addon_tax ALTER COLUMN id SET DEFAULT nextval('public.addon_tax_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: store_address id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_address ALTER COLUMN id SET DEFAULT nextval('public.store_address_id_seq'::regclass);


--
-- Name: store_brand id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_brand ALTER COLUMN id SET DEFAULT nextval('public.store_brand_id_seq'::regclass);


--
-- Name: store_cancelledorder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cancelledorder ALTER COLUMN id SET DEFAULT nextval('public.store_cancelledorder_id_seq'::regclass);


--
-- Name: store_cart id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cart ALTER COLUMN id SET DEFAULT nextval('public.store_cart_id_seq'::regclass);


--
-- Name: store_cartorder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorder ALTER COLUMN id SET DEFAULT nextval('public.store_cartorder_id_seq'::regclass);


--
-- Name: store_cartorder_coupons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorder_coupons ALTER COLUMN id SET DEFAULT nextval('public.store_cartorder_coupons_id_seq'::regclass);


--
-- Name: store_cartorder_vendor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorder_vendor ALTER COLUMN id SET DEFAULT nextval('public.store_cartorder_vendor_id_seq'::regclass);


--
-- Name: store_cartorderitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorderitem ALTER COLUMN id SET DEFAULT nextval('public.store_cartorderitem_id_seq'::regclass);


--
-- Name: store_cartorderitem_coupon id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorderitem_coupon ALTER COLUMN id SET DEFAULT nextval('public.store_cartorderitem_coupon_id_seq'::regclass);


--
-- Name: store_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_category ALTER COLUMN id SET DEFAULT nextval('public.store_category_id_seq'::regclass);


--
-- Name: store_color id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_color ALTER COLUMN id SET DEFAULT nextval('public.store_color_id_seq'::regclass);


--
-- Name: store_coupon id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_coupon ALTER COLUMN id SET DEFAULT nextval('public.store_coupon_id_seq'::regclass);


--
-- Name: store_coupon_used_by id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_coupon_used_by ALTER COLUMN id SET DEFAULT nextval('public.store_coupon_used_by_id_seq'::regclass);


--
-- Name: store_couponusers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_couponusers ALTER COLUMN id SET DEFAULT nextval('public.store_couponusers_id_seq'::regclass);


--
-- Name: store_deliverycouriers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_deliverycouriers ALTER COLUMN id SET DEFAULT nextval('public.store_deliverycouriers_id_seq'::regclass);


--
-- Name: store_gallery id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_gallery ALTER COLUMN id SET DEFAULT nextval('public.store_gallery_id_seq'::regclass);


--
-- Name: store_notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_notification ALTER COLUMN id SET DEFAULT nextval('public.store_notification_id_seq'::regclass);


--
-- Name: store_product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_product ALTER COLUMN id SET DEFAULT nextval('public.store_product_id_seq'::regclass);


--
-- Name: store_productfaq id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_productfaq ALTER COLUMN id SET DEFAULT nextval('public.store_productfaq_id_seq'::regclass);


--
-- Name: store_review id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review ALTER COLUMN id SET DEFAULT nextval('public.store_review_id_seq'::regclass);


--
-- Name: store_review_helpful id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review_helpful ALTER COLUMN id SET DEFAULT nextval('public.store_review_helpful_id_seq'::regclass);


--
-- Name: store_review_not_helpful id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review_not_helpful ALTER COLUMN id SET DEFAULT nextval('public.store_review_not_helpful_id_seq'::regclass);


--
-- Name: store_size id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_size ALTER COLUMN id SET DEFAULT nextval('public.store_size_id_seq'::regclass);


--
-- Name: store_specification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_specification ALTER COLUMN id SET DEFAULT nextval('public.store_specification_id_seq'::regclass);


--
-- Name: store_tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_tag ALTER COLUMN id SET DEFAULT nextval('public.store_tag_id_seq'::regclass);


--
-- Name: store_wishlist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_wishlist ALTER COLUMN id SET DEFAULT nextval('public.store_wishlist_id_seq'::regclass);


--
-- Name: token_blacklist_blacklistedtoken id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken ALTER COLUMN id SET DEFAULT nextval('public.token_blacklist_blacklistedtoken_id_seq'::regclass);


--
-- Name: token_blacklist_outstandingtoken id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken ALTER COLUMN id SET DEFAULT nextval('public.token_blacklist_outstandingtoken_id_seq'::regclass);


--
-- Name: userauths_profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_profile ALTER COLUMN id SET DEFAULT nextval('public.userauths_profile_id_seq'::regclass);


--
-- Name: userauths_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_user ALTER COLUMN id SET DEFAULT nextval('public.userauths_user_id_seq'::regclass);


--
-- Name: userauths_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_user_groups ALTER COLUMN id SET DEFAULT nextval('public.userauths_user_groups_id_seq'::regclass);


--
-- Name: userauths_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.userauths_user_user_permissions_id_seq'::regclass);


--
-- Name: vendor_vendor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_vendor ALTER COLUMN id SET DEFAULT nextval('public.vendor_vendor_id_seq'::regclass);


--
-- Data for Name: addon_configsettings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addon_configsettings (id, view_more, currency_sign, currency_abbreviation, service_fee_percentage, service_fee_flat_rate, service_fee_charge_type, enforce_2fa, activate_affiliate_system, send_email_notifications) FROM stdin;
1	View All	NRs.	NPR	10	0.9	percentage	t	t	t
\.


--
-- Data for Name: addon_tax; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addon_tax (id, country, rate, active, date) FROM stdin;
1	Nepal	13	t	2025-03-05 15:46:26.055302+05:45
2	India	13	t	2025-03-05 15:46:51.598292+05:45
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, content_type_id, codename, name) FROM stdin;
1	1	add_logentry	Can add log entry
2	1	change_logentry	Can change log entry
3	1	delete_logentry	Can delete log entry
4	1	view_logentry	Can view log entry
5	2	add_permission	Can add permission
6	2	change_permission	Can change permission
7	2	delete_permission	Can delete permission
8	2	view_permission	Can view permission
9	3	add_group	Can add group
10	3	change_group	Can change group
11	3	delete_group	Can delete group
12	3	view_group	Can view group
13	4	add_contenttype	Can add content type
14	4	change_contenttype	Can change content type
15	4	delete_contenttype	Can delete content type
16	4	view_contenttype	Can view content type
17	5	add_session	Can add session
18	5	change_session	Can change session
19	5	delete_session	Can delete session
20	5	view_session	Can view session
21	6	add_user	Can add user
22	6	change_user	Can change user
23	6	delete_user	Can delete user
24	6	view_user	Can view user
25	7	add_profile	Can add profile
26	7	change_profile	Can change profile
27	7	delete_profile	Can delete profile
28	7	view_profile	Can view profile
29	8	add_address	Can add address
30	8	change_address	Can change address
31	8	delete_address	Can delete address
32	8	view_address	Can view address
33	9	add_brand	Can add brand
34	9	change_brand	Can change brand
35	9	delete_brand	Can delete brand
36	9	view_brand	Can view brand
37	10	add_cancelledorder	Can add cancelled order
38	10	change_cancelledorder	Can change cancelled order
39	10	delete_cancelledorder	Can delete cancelled order
40	10	view_cancelledorder	Can view cancelled order
41	11	add_cart	Can add cart
42	11	change_cart	Can change cart
43	11	delete_cart	Can delete cart
44	11	view_cart	Can view cart
45	12	add_cartorder	Can add cart order
46	12	change_cartorder	Can change cart order
47	12	delete_cartorder	Can delete cart order
48	12	view_cartorder	Can view cart order
49	13	add_cartorderitem	Can add cart order item
50	13	change_cartorderitem	Can change cart order item
51	13	delete_cartorderitem	Can delete cart order item
52	13	view_cartorderitem	Can view cart order item
53	14	add_category	Can add category
54	14	change_category	Can change category
55	14	delete_category	Can delete category
56	14	view_category	Can view category
57	15	add_color	Can add color
58	15	change_color	Can change color
59	15	delete_color	Can delete color
60	15	view_color	Can view color
61	16	add_coupon	Can add coupon
62	16	change_coupon	Can change coupon
63	16	delete_coupon	Can delete coupon
64	16	view_coupon	Can view coupon
65	17	add_couponusers	Can add coupon users
66	17	change_couponusers	Can change coupon users
67	17	delete_couponusers	Can delete coupon users
68	17	view_couponusers	Can view coupon users
69	18	add_deliverycouriers	Can add delivery couriers
70	18	change_deliverycouriers	Can change delivery couriers
71	18	delete_deliverycouriers	Can delete delivery couriers
72	18	view_deliverycouriers	Can view delivery couriers
73	19	add_gallery	Can add gallery
74	19	change_gallery	Can change gallery
75	19	delete_gallery	Can delete gallery
76	19	view_gallery	Can view gallery
77	20	add_notification	Can add notification
78	20	change_notification	Can change notification
79	20	delete_notification	Can delete notification
80	20	view_notification	Can view notification
81	21	add_product	Can add product
82	21	change_product	Can change product
83	21	delete_product	Can delete product
84	21	view_product	Can view product
85	22	add_productfaq	Can add product faq
86	22	change_productfaq	Can change product faq
87	22	delete_productfaq	Can delete product faq
88	22	view_productfaq	Can view product faq
89	23	add_review	Can add review
90	23	change_review	Can change review
91	23	delete_review	Can delete review
92	23	view_review	Can view review
93	24	add_size	Can add size
94	24	change_size	Can change size
95	24	delete_size	Can delete size
96	24	view_size	Can view size
97	25	add_specification	Can add specification
98	25	change_specification	Can change specification
99	25	delete_specification	Can delete specification
100	25	view_specification	Can view specification
101	26	add_tag	Can add tag
102	26	change_tag	Can change tag
103	26	delete_tag	Can delete tag
104	26	view_tag	Can view tag
105	27	add_wishlist	Can add wishlist
106	27	change_wishlist	Can change wishlist
107	27	delete_wishlist	Can delete wishlist
108	27	view_wishlist	Can view wishlist
109	28	add_vendor	Can add vendor
110	28	change_vendor	Can change vendor
111	28	delete_vendor	Can delete vendor
112	28	view_vendor	Can view vendor
113	29	add_configsettings	Can add Settings
114	29	change_configsettings	Can change Settings
115	29	delete_configsettings	Can delete Settings
116	29	view_configsettings	Can view Settings
117	30	add_tax	Can add tax
118	30	change_tax	Can change tax
119	30	delete_tax	Can delete tax
120	30	view_tax	Can view tax
121	31	add_blacklistedtoken	Can add blacklisted token
122	31	change_blacklistedtoken	Can change blacklisted token
123	31	delete_blacklistedtoken	Can delete blacklisted token
124	31	view_blacklistedtoken	Can view blacklisted token
125	32	add_outstandingtoken	Can add outstanding token
126	32	change_outstandingtoken	Can change outstanding token
127	32	delete_outstandingtoken	Can delete outstanding token
128	32	view_outstandingtoken	Can view outstanding token
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, object_id, object_repr, action_flag, change_message, content_type_id, user_id, action_time) FROM stdin;
1	1	timilsina.abhishek@email.com	2	[{"changed": {"fields": ["First name", "Last name", "Username", "Full name", "Phone"]}}]	6	1	2025-03-05 15:32:15.855218+05:45
2	1	timilsina.abhishek@email.com	2	[{"changed": {"fields": ["Image", "About", "Gender", "Country", "City", "State", "Address", "Type"]}}]	7	1	2025-03-05 15:33:03.445618+05:45
3	1	Abhishek Timilsina	2	[{"changed": {"fields": ["Full name"]}}]	7	1	2025-03-05 15:41:24.600948+05:45
4	1	ConfigSettings object (1)	1	[{"added": {}}]	29	1	2025-03-05 15:46:14.266724+05:45
5	1	Nepal	1	[{"added": {}}]	30	1	2025-03-05 15:46:26.055732+05:45
6	2	India	1	[{"added": {}}]	30	1	2025-03-05 15:46:51.598654+05:45
7	7	ram.bhandari@yopmail.com	2	[{"changed": {"fields": ["First name", "Last name"]}}]	6	1	2025-03-05 15:47:14.267914+05:45
8	6	sachin.karki@yopmail.com	2	[{"changed": {"fields": ["First name", "Last name"]}}]	6	1	2025-03-05 15:47:25.314856+05:45
9	7	Ram Bhandari	2	[{"changed": {"fields": ["About", "Gender", "Newsletter", "Type"]}}]	7	1	2025-03-05 15:47:53.650949+05:45
10	6	Sachin Karki	2	[{"changed": {"fields": ["About", "Gender", "Newsletter"]}}]	7	1	2025-03-05 15:48:09.509156+05:45
11	5	Alika Mishra	2	[{"changed": {"fields": ["Full name", "About"]}}]	7	1	2025-03-05 15:48:28.866856+05:45
12	4	Shreya Adhikari	2	[{"changed": {"fields": ["About", "Gender", "Country", "City", "Address"]}}]	7	1	2025-03-05 15:48:51.485109+05:45
13	1	Movies	1	[{"added": {}}]	14	1	2025-03-05 15:49:20.222726+05:45
14	2	Toys	1	[{"added": {}}]	14	1	2025-03-05 15:49:31.556957+05:45
15	3	Soft Drinks	1	[{"added": {}}]	14	1	2025-03-05 15:49:52.5686+05:45
16	4	Video Games	1	[{"added": {}}]	14	1	2025-03-05 15:50:10.232706+05:45
17	5	Books	1	[{"added": {}}]	14	1	2025-03-05 15:50:26.810906+05:45
18	6	Clothes	1	[{"added": {}}]	14	1	2025-03-05 15:50:49.714+05:45
19	7	Foods	1	[{"added": {}}]	14	1	2025-03-05 15:51:08.026302+05:45
20	1	Sony	1	[{"added": {}}]	9	1	2025-03-05 15:51:57.13165+05:45
21	2	BenQ	1	[{"added": {}}]	9	1	2025-03-05 15:52:34.224767+05:45
22	3	Dolby Digital	1	[{"added": {}}]	9	1	2025-03-05 15:57:12.075286+05:45
23	4	Lego	1	[{"added": {}}]	9	1	2025-03-05 15:57:21.536504+05:45
24	5	Coca Cola	1	[{"added": {}}]	9	1	2025-03-05 15:57:33.286478+05:45
25	6	Cambridge Press	1	[{"added": {}}]	9	1	2025-03-05 15:57:44.747486+05:45
26	7	Nike	1	[{"added": {}}]	9	1	2025-03-05 15:57:56.220742+05:45
27	8	Adidas	1	[{"added": {}}]	9	1	2025-03-05 15:58:05.245422+05:45
28	9	McDonald's	1	[{"added": {}}]	9	1	2025-03-05 15:58:16.865664+05:45
29	10	Pizza Hut	1	[{"added": {}}]	9	1	2025-03-05 15:58:27.164162+05:45
30	1	DHL	1	[{"added": {}}]	18	1	2025-03-05 15:59:45.636425+05:45
31	2	FedEx	1	[{"added": {}}]	18	1	2025-03-05 16:00:00.691123+05:45
32	3	UPS	1	[{"added": {}}]	18	1	2025-03-05 16:00:41.950678+05:45
33	1	Film	1	[{"added": {}}]	26	1	2025-03-05 16:01:03.000996+05:45
34	2	video games	1	[{"added": {}}]	26	1	2025-03-05 16:01:17.771249+05:45
35	5	Beanie by Adidas	2	[{"added": {"name": "color", "object": "Color object (6)"}}, {"added": {"name": "color", "object": "Color object (7)"}}, {"changed": {"name": "color", "object": "Color object (5)", "fields": ["Color code"]}}]	21	1	2025-03-05 16:37:23.6193+05:45
36	10	Minions and Gru's Family Mansion	2	[{"changed": {"fields": ["Hot deal"]}}]	21	1	2025-03-05 16:54:26.513727+05:45
37	10	Minions and Gru's Family Mansion	2	[{"changed": {"fields": ["Special offer"]}}]	21	1	2025-03-05 16:54:47.413581+05:45
38	10	Minions and Gru's Family Mansion	2	[{"changed": {"fields": ["Featured"]}}]	21	1	2025-03-05 16:54:57.768285+05:45
39	8	AT-AT Driver™ Helmet	2	[{"changed": {"fields": ["Featured"]}}]	21	1	2025-03-05 16:55:45.639808+05:45
40	5	Beanie by Adidas	2	[{"changed": {"fields": ["Featured"]}}]	21	1	2025-03-05 16:55:45.643214+05:45
41	1	Sony PlayStation 5	2	[{"changed": {"fields": ["Featured"]}}]	21	1	2025-03-05 16:55:45.645466+05:45
42	1	TOYSHOP123	1	[{"added": {}}]	16	1	2025-03-05 17:00:18.632751+05:45
43	7	xyvcodasaa	2	[{"changed": {"fields": ["Order placed", "Processing order", "Quality check", "Product shipped", "Product arrived", "Product delivered", "Delivery status"]}}]	13	1	2025-03-05 17:10:13.454186+05:45
44	4	hgmuedraou	2	[{"changed": {"fields": ["Order status"]}}]	12	1	2025-03-05 17:11:36.979964+05:45
45	2	ttemmdzxtq	2	[{"changed": {"fields": ["Order status"]}}]	12	1	2025-03-05 17:11:36.981292+05:45
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	userauths	user
7	userauths	profile
8	store	address
9	store	brand
10	store	cancelledorder
11	store	cart
12	store	cartorder
13	store	cartorderitem
14	store	category
15	store	color
16	store	coupon
17	store	couponusers
18	store	deliverycouriers
19	store	gallery
20	store	notification
21	store	product
22	store	productfaq
23	store	review
24	store	size
25	store	specification
26	store	tag
27	store	wishlist
28	vendor	vendor
29	addon	configsettings
30	addon	tax
31	token_blacklist	blacklistedtoken
32	token_blacklist	outstandingtoken
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	addon	0001_initial	2025-03-05 15:19:52.556908+05:45
2	contenttypes	0001_initial	2025-03-05 15:19:52.561783+05:45
3	contenttypes	0002_remove_content_type_name	2025-03-05 15:19:52.568806+05:45
4	auth	0001_initial	2025-03-05 15:19:52.579379+05:45
5	auth	0002_alter_permission_name_max_length	2025-03-05 15:19:52.586337+05:45
6	auth	0003_alter_user_email_max_length	2025-03-05 15:19:52.59069+05:45
7	auth	0004_alter_user_username_opts	2025-03-05 15:19:52.594646+05:45
8	auth	0005_alter_user_last_login_null	2025-03-05 15:19:52.599306+05:45
9	auth	0006_require_contenttypes_0002	2025-03-05 15:19:52.60107+05:45
10	auth	0007_alter_validators_add_error_messages	2025-03-05 15:19:52.60487+05:45
11	auth	0008_alter_user_username_max_length	2025-03-05 15:19:52.609971+05:45
12	auth	0009_alter_user_last_name_max_length	2025-03-05 15:19:52.615907+05:45
13	auth	0010_alter_group_name_max_length	2025-03-05 15:19:52.622135+05:45
14	auth	0011_update_proxy_permissions	2025-03-05 15:19:52.627857+05:45
15	auth	0012_alter_user_first_name_max_length	2025-03-05 15:19:52.632498+05:45
16	userauths	0001_initial	2025-03-05 15:19:52.647072+05:45
17	admin	0001_initial	2025-03-05 15:19:52.657068+05:45
18	admin	0002_logentry_remove_auto_add	2025-03-05 15:19:52.665169+05:45
19	admin	0003_logentry_add_action_flag_choices	2025-03-05 15:19:52.671783+05:45
20	sessions	0001_initial	2025-03-05 15:19:52.676311+05:45
21	vendor	0001_initial	2025-03-05 15:19:52.685059+05:45
22	store	0001_initial	2025-03-05 15:19:52.706258+05:45
23	store	0002_initial	2025-03-05 15:19:53.088178+05:45
24	token_blacklist	0001_initial	2025-03-05 15:19:53.122789+05:45
25	token_blacklist	0002_outstandingtoken_jti_hex	2025-03-05 15:19:53.136594+05:45
26	token_blacklist	0003_auto_20171017_2007	2025-03-05 15:19:53.155865+05:45
27	token_blacklist	0004_auto_20171017_2013	2025-03-05 15:19:53.172328+05:45
28	token_blacklist	0005_remove_outstandingtoken_jti	2025-03-05 15:19:53.187671+05:45
29	token_blacklist	0006_auto_20171017_2113	2025-03-05 15:19:53.20311+05:45
30	token_blacklist	0007_auto_20171017_2214	2025-03-05 15:19:53.303155+05:45
31	token_blacklist	0008_migrate_to_bigautofield	2025-03-05 15:19:53.327309+05:45
32	token_blacklist	0010_fix_migrate_to_bigautofield	2025-03-05 15:19:53.35089+05:45
33	token_blacklist	0011_linearizes_history	2025-03-05 15:19:53.352954+05:45
34	token_blacklist	0012_alter_outstandingtoken_user	2025-03-05 15:19:53.371801+05:45
35	userauths	0002_alter_profile_user	2025-03-05 15:19:53.389564+05:45
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: store_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_address (id, full_name, mobile, email, state, town_city, address, zip, status, same_as_billing_address, country_id, user_id) FROM stdin;
\.


--
-- Data for Name: store_brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_brand (id, title, image, active) FROM stdin;
1	Sony	user_file/file.jpeg	t
2	BenQ	user_file/file_VBJu3ea.jpeg	t
3	Dolby Digital	user_file/file_3ISaWNj.png	t
4	Lego	user_file/file_7hfeBCV.png	t
5	Coca Cola	user_file/file_LRxKtjV.png	t
6	Cambridge Press	user_file/file_GOUbhIY.png	t
7	Nike	user_file/file.jpg	t
8	Adidas	user_file/file_WXSSxtQ.jpg	t
9	McDonald's	user_file/file.webp	t
10	Pizza Hut	user_file/file_4eXxZIx.png	t
\.


--
-- Data for Name: store_cancelledorder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_cancelledorder (id, email, refunded, orderitem_id, user_id) FROM stdin;
\.


--
-- Data for Name: store_cart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_cart (id, qty, price, sub_total, shipping_amount, service_fee, tax_fee, total, country, size, color, cart_id, date, product_id, user_id) FROM stdin;
\.


--
-- Data for Name: store_cartorder; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_cartorder (id, sub_total, shipping_amount, tax_fee, service_fee, total, payment_status, order_status, initial_total, saved, full_name, email, mobile, address, city, state, country, stripe_session_id, oid, date, buyer_id) FROM stdin;
1	8700	300	0.13	870	9870.13	processing	Pending	9870.13	0	Ram Bhandari	ram.bhandari@yopmail.com	9841254578	Simaltar	Kathmandu	Bagmati	Nepal	\N	klsuitdydy	2025-03-05 16:59:36.294887+05:45	7
2	8700	300	0.13	870	9870.13	paid	Fulfilled	9870.13	0	Ram Bhandari	ram.bhandari@yopmail.com	9841254578	Simaltar	Kathmandu	Bagmati	Nepal	cs_test_a1dNiGuYU9K4dovumncDCa14me82IPTyRCJ9MXQOtdR9vxZku9Cb2zrEgQ	ttemmdzxtq	2025-03-05 17:00:36.138002+05:45	7
3	8700	300	0.13	870	9870.13	processing	Pending	9870.13	0	Ram Bhandari	ram.bhandari@yopmail.com	9841254578	Simaltar	Kathmandu	Bagmati	Nepal	\N	fjaquzvghi	2025-03-05 17:02:47.758916+05:45	7
4	4399.99	500	0.13	500	5400.12	paid	Fulfilled	6000.13	600.01	Ram Bhandari	ram.bhandari@yopmail.com	9841254578	Simaltar	Kathmandu	Bagmati	Nepal	cs_test_a1QWjrJFDHSR4IRRQ6ba5VaPTwtz3OpkdJ7ADG4euCBBFjFR3q58ePWxHq	hgmuedraou	2025-03-05 17:03:24.076935+05:45	7
\.


--
-- Data for Name: store_cartorder_coupons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_cartorder_coupons (id, cartorder_id, coupon_id) FROM stdin;
\.


--
-- Data for Name: store_cartorder_vendor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_cartorder_vendor (id, cartorder_id, vendor_id) FROM stdin;
1	1	3
2	1	2
3	2	3
4	2	2
5	3	3
6	3	2
7	4	3
\.


--
-- Data for Name: store_cartorderitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_cartorderitem (id, qty, color, size, price, sub_total, shipping_amount, tax_fee, service_fee, total, expected_delivery_date_from, expected_delivery_date_to, initial_total, saved, order_placed, processing_order, quality_check, product_shipped, product_arrived, product_delivered, delivery_status, tracking_id, applied_coupon, oid, date, delivery_couriers_id, order_id, product_id, vendor_id) FROM stdin;
1	1	No Size	No Color	8000	8000	200	0	800	9000	\N	\N	9000	0	f	f	f	f	f	f	On Hold	\N	f	zvijqdiisv	2025-03-05 16:59:36.298719+05:45	\N	1	8	3
2	1	No Size	No Color	700	700	100	0.13	70	870.13	\N	\N	870.13	0	f	f	f	f	f	f	On Hold	\N	f	sghlaszlva	2025-03-05 16:59:36.302289+05:45	\N	1	7	2
3	1	No Size	No Color	8000	8000	200	0	800	9000	\N	\N	9000	0	f	f	f	f	f	f	On Hold	8547	f	agbadkztls	2025-03-05 17:00:36.142354+05:45	3	2	8	3
4	1	No Size	No Color	700	700	100	0.13	70	870.13	\N	\N	870.13	0	f	f	f	f	f	f	On Hold	1254	f	xsjllgzlrt	2025-03-05 17:00:36.145965+05:45	2	2	7	2
5	1	No Size	No Color	8000	8000	200	0	800	9000	\N	\N	9000	0	f	f	f	f	f	f	On Hold	\N	f	tqdfrjpjtr	2025-03-05 17:02:47.762509+05:45	\N	3	8	3
6	1	No Size	No Color	700	700	100	0.13	70	870.13	\N	\N	870.13	0	f	f	f	f	f	f	On Hold	\N	f	rzxgusvbmz	2025-03-05 17:02:47.766459+05:45	\N	3	7	2
7	1	No Size	No Color	5000	4399.99	500	0.13	500	5400.12	\N	\N	6000.13	600.01	t	t	t	t	t	t	Delivered	12455557	t	xyvcodasaa	2025-03-05 17:03:24+05:45	1	4	10	3
\.


--
-- Data for Name: store_cartorderitem_coupon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_cartorderitem_coupon (id, cartorderitem_id, coupon_id) FROM stdin;
1	7	1
\.


--
-- Data for Name: store_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_category (id, title, image, active, slug) FROM stdin;
1	Movies	user_file/file.png	t	movies
2	Toys	user_file/file_rINbge1.png	t	toys
3	Soft Drinks	user_file/file_uU9VfBr.png	t	soft-drinks
4	Video Games	user_file/file_bpygPew.png	t	video-games
5	Books	user_file/file_riAhwYc.png	t	books
6	Clothes	user_file/file_NanmLyh.png	t	clothes
7	Foods	user_file/file_LdAI0zM.png	t	foods
\.


--
-- Data for Name: store_color; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_color (id, name, color_code, image, product_id) FROM stdin;
1	Green	#29b90f	user_3/3_HZiHb3P.jpg	4
2	Yellow	#e5ec13	user_3/3_3HeUfPY.jpg	4
3	Red	#b91818	user_3/3.webp	4
4	Orange	#e4700d	user_3/3.png	4
5	Red	#b92525	user_3/3_5FHaoLV.webp	5
6	Green	#5a9e11	user_3/3_FLnTuaM.jpg	5
7	Yellow	#f1d71f	user_3/3_rH96EtP.webp	5
\.


--
-- Data for Name: store_coupon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_coupon (id, code, discount, date, active, cid, vendor_id) FROM stdin;
1	TOYSHOP123	10	2025-03-05 17:00:18.630437+05:45	t	mzjnsebicz	3
\.


--
-- Data for Name: store_coupon_used_by; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_coupon_used_by (id, coupon_id, user_id) FROM stdin;
\.


--
-- Data for Name: store_couponusers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_couponusers (id, full_name, email, mobile, coupon_id, order_id) FROM stdin;
\.


--
-- Data for Name: store_deliverycouriers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_deliverycouriers (id, name, tracking_website, url_parameter) FROM stdin;
1	DHL	https://www.dhl.com/en/express/tracking.html	AWB
2	FedEx	https://www.fedex.com/en-us/tracking.html	trackingnumber
3	UPS	https://www.ups.com/track	trackingnumber
\.


--
-- Data for Name: store_gallery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_gallery (id, image, active, date, gid, product_id) FROM stdin;
1	user_2/2_TAygQFc.webp	t	2025-03-05 16:07:58.3973+05:45	mjsurxjkof	1
2	user_2/2_T5d77tH.webp	t	2025-03-05 16:07:58.397829+05:45	hzriaxxfni	1
3	user_2/2_AtPPvWK.webp	t	2025-03-05 16:07:58.398267+05:45	jfpsmkqita	1
4	user_3/3_ZPbMj1U.png	t	2025-03-05 16:26:22.164122+05:45	enkbjgvkht	4
5	user_3/3_2D6hIDV.webp	t	2025-03-05 16:26:22.164833+05:45	salvgyneie	4
6	user_3/3_luLXpqS.webp	t	2025-03-05 16:26:22.165469+05:45	usvmsuhlrx	4
7	user_3/3_z8ebLYj.jpg	t	2025-03-05 16:26:22.166064+05:45	mokujsmmbn	4
8	user_3/3_MNWX68m.jpg	t	2025-03-05 16:26:22.166495+05:45	vzqijukrem	4
9	user_3/3_HDgLkEj.jpg	t	2025-03-05 16:30:30.018184+05:45	jusmtmzfsu	5
10	user_3/3_JsCzIIO.webp	t	2025-03-05 16:30:30.019046+05:45	dmbqddemsj	5
11	user_6/6_iOspEFD.webp	t	2025-03-05 16:44:50.886826+05:45	bdicykecjh	8
12	user_6/6_hi9YDBf.webp	t	2025-03-05 16:44:50.8885+05:45	pqgsbbqtha	8
13	user_6/6_gowMciN.webp	t	2025-03-05 16:48:33.717432+05:45	jvdvgacgef	9
14	user_6/6_8sPZnLF.webp	t	2025-03-05 16:48:33.718972+05:45	fthedfydvb	9
15	user_6/6_THRbdP2.webp	t	2025-03-05 16:53:12.516002+05:45	aqrzdlrzik	10
16	user_6/6_Coq4dYG.webp	t	2025-03-05 16:53:12.517291+05:45	blqkjgojvf	10
\.


--
-- Data for Name: store_notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_notification (id, seen, date, order_id, order_item_id, user_id, vendor_id) FROM stdin;
1	f	2025-03-05 17:01:14.980422+05:45	2	\N	7	\N
2	f	2025-03-05 17:01:14.986638+05:45	2	4	\N	2
3	f	2025-03-05 17:01:14.99035+05:45	2	3	\N	3
4	f	2025-03-05 17:01:15.007205+05:45	2	\N	7	\N
5	f	2025-03-05 17:01:15.013024+05:45	2	4	\N	2
6	f	2025-03-05 17:01:15.016667+05:45	2	3	\N	3
7	f	2025-03-05 17:03:52.980543+05:45	4	\N	7	\N
8	f	2025-03-05 17:03:52.981019+05:45	4	\N	7	\N
9	f	2025-03-05 17:03:52.985921+05:45	4	7	\N	3
10	f	2025-03-05 17:03:52.990805+05:45	4	7	\N	3
\.


--
-- Data for Name: store_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_product (id, title, image, description, tags, brand, price, old_price, shipping_amount, stock_qty, in_stock, status, type, featured, hot_deal, special_offer, digital, views, orders, saved, rating, sku, pid, slug, date, category_id, vendor_id) FROM stdin;
1	Sony PlayStation 5	user_2/2.webp	Experience next-gen gaming with the Sony PlayStation 5 (PS5). Powered by a custom-designed SSD for ultra-fast load times, stunning 4K graphics, and immersive haptic feedback, the PS5 delivers a truly groundbreaking gaming experience. Featuring the innovative DualSense wireless controller, 3D audio, and exclusive titles like Demon's Souls, Spider-Man: Miles Morales, and Ratchet & Clank: Rift Apart, the PS5 brings your games to life like never before. With its sleek design and cutting-edge hardware, the PS5 is the ultimate console for gamers who demand the best	Video Game	Sony	85000	90000	500	20	t	published	regular	t	f	f	f	0	0	0	\N	SKU50272	tsvevlzeqx	sony-playstation-5-7eus	2025-03-05 16:07:58.393459+05:45	4	1
2	God of War - Ragnarok	user_2/2_SMoDO9t.jpg	God of War Ragnarök is the highly anticipated sequel to the critically acclaimed God of War (2018). This action-adventure game continues the journey of Kratos and his son Atreus as they navigate the tumultuous events leading up to the prophesied end of the world – Ragnarök. Set in the rich and diverse worlds of Norse mythology, players will face powerful enemies, gods, and creatures in a brutal yet emotional story. The game introduces new combat mechanics, including the use of both Kratos' Leviathan Axe and Blades of Chaos, alongside Atreus’ growing powers. With stunning visuals, intricate puzzle-solving, and a deep narrative, God of War Ragnarök promises an unforgettable gaming experience, blending high-octane action with heartfelt moments in the ultimate battle for survival.	Video Game	Sony	4500	5000	200	50	t	published	regular	f	f	f	f	0	0	0	\N	SKU55009	dpkmjeooid	god-of-war-ragnarok-fnfd	2025-03-05 16:10:47.169347+05:45	4	1
3	PS4 Controller	user_2/2_4ugmncL.jpg	The DualShock 4 wireless controller for the PlayStation 4 is designed for comfort, precision, and immersive gameplay. Featuring a sleek, ergonomic design, the controller provides an enhanced gaming experience with its responsive buttons and analog sticks. It includes a touchpad on the front, allowing for innovative gameplay interactions, and a light bar that changes color to reflect in-game actions and player status. The controller also features a built-in speaker for additional audio cues and a 3.5mm headphone jack for private listening. The motion sensors (accelerometer and gyroscope) enable motion-based controls, offering even more ways to engage with the game. With its rechargeable battery, you can easily charge the controller via USB or a charging dock, ensuring endless hours of gaming enjoyment.	Video Game	Sony	4000	4800	100	100	t	published	regular	f	f	f	f	0	0	0	\N	SKU26758	fvigyqguvt	ps4-controller-c4gt	2025-03-05 16:13:09.540694+05:45	4	1
4	Designer Hat	user_3/3_bgoxOXQ.jpg	"Make a bold statement with this stylish designer hat. Crafted from premium materials and designed with precision, this hat combines elegance with functionality. Its unique design showcases sophisticated details, from intricate stitching to signature logos, making it a perfect accessory to elevate any outfit. Whether you're heading to a casual outing or a special event, this designer hat adds a touch of class and exclusivity, making you stand out in any crowd. Stay stylish and protected with this timeless piece.	Clothes, Fashion	Nike	2999	3500	100	20	t	published	regular	f	f	f	f	0	0	0	\N	SKU63779	lrrnebdvus	designer-hat-bfz8	2025-03-05 16:26:22.155463+05:45	6	2
5	Beanie by Adidas	user_3/3_DR7n0u5.webp	Stay warm and stylish with this cozy beanie, the perfect accessory for cold weather. Made from a soft, knitted fabric such as wool or acrylic, this beanie offers both comfort and warmth, keeping you snug during the winter months. Its versatile design features a classic ribbed or slouchy style that pairs effortlessly with any casual outfit. Whether you're heading out for a winter adventure or just running errands, this beanie adds a touch of effortless cool to your look while protecting you from the chill. Available in a variety of colors and styles to suit your personal taste.	Clothes, Fashion	Adidas	1599	1999	100	50	t	published	regular	t	f	f	f	0	0	0	\N	SKU71029	zkcalqqdyt	beanie-by-adidas-bfjf	2025-03-05 16:30:30+05:45	6	2
6	Hoodie by Nike	user_3/3_ev6dnLF.webp	Stay comfortable and stylish with this cozy hoodie, perfect for casual outings or lounging at home. Made from a soft, high-quality cotton blend or fleece material, this hoodie offers warmth and breathability, keeping you comfortable throughout the day. Featuring a drawstring-adjustable hood, a spacious front pocket, and ribbed cuffs and hem, it’s designed for both functionality and style. Whether you're layering it over a t-shirt or wearing it on its own, this hoodie provides a relaxed fit and a timeless look. Available in a variety of colors and designs, it’s the perfect addition to any wardrobe.	Clothes, Fashion	Nike	7000	9000	200	50	t	published	regular	f	f	f	f	0	0	0	\N	SKU75552	msphjqlqyj	hoodie-by-nike-esn3	2025-03-05 16:32:50.521443+05:45	6	2
7	Zoom T-shirt	user_3/3_ObazV2f.webp	Elevate your everyday style with this classic t-shirt, designed for comfort and versatility. Made from soft, breathable cotton or a cotton blend, this t-shirt offers a relaxed fit that's perfect for casual wear. With its simple yet timeless design, it features a crew neck, short sleeves, and a smooth finish that makes it easy to pair with any outfit. Available in a range of colors and sizes, this t-shirt is ideal for layering or wearing on its own. Whether you're dressing up or down, it’s a wardrobe essential for any season.	Clothes, Fashion	Zoom	700	1000	100	200	t	published	regular	f	f	f	f	0	0	0	\N	SKU11526	amkuxiqkth	zoom-t-shirt-frxp	2025-03-05 16:35:01.09439+05:45	6	2
8	AT-AT Driver™ Helmet	user_6/6.webp	Step into the world of Star Wars with the AT-AT Driver™ Helmet LEGO Set! This detailed, highly collectible LEGO helmet features the iconic design of the AT-AT Driver, known for commanding the mighty AT-AT walkers in the Star Wars universe. With over [insert number] pieces, this set allows builders to recreate the intricate details of the helmet, from its sleek visor to the signature details that make it stand out. Once completed, the helmet makes an impressive display piece for any Star Wars fan or LEGO enthusiast. Perfect for those looking to build, display, or add to their Star Wars collection, this LEGO set combines challenge, creativity, and fandom into one epic build.	Toys, Games, Fun	Lego	8000	10000	200	50	t	published	regular	t	f	f	f	0	0	0	\N	SKU66887	epfancxokk	at-at-drivertm-helmet-lawc	2025-03-05 16:44:50.878998+05:45	2	3
9	Batmobile™ Tumbler	user_6/6_mD3dl64.webp	Bring the iconic Batmobile™ to life with this incredible LEGO set! The Batmobile™ Tumbler from The Dark Knight trilogy is an impressive, detailed model designed for collectors and Batman fans. With its sleek armored design, massive wheels, and functional features, this build perfectly captures the spirit of Bruce Wayne's legendary crime-fighting vehicle. Over [insert number] pieces, builders can recreate every aspect of the Tumbler, from the cockpit to the wheels that truly make it stand out. Once completed, this Batmobile™ makes an eye-catching display piece and is a must-have for any LEGO or Batman enthusiast.	Toys, Games, Fun	Lego	10000	12000	500	20	t	published	regular	f	f	f	f	0	0	0	\N	SKU53955	qhzaqobfab	batmobiletm-tumbler-2uai	2025-03-05 16:48:33.710552+05:45	2	3
10	Minions and Gru's Family Mansion	user_6/6_CGVdOpl.webp	Step into the world of Despicable Me with the Minions and Gru's Family Mansion LEGO Set! This fun-filled set brings the iconic mansion from the Despicable Me movies to life with incredible detail and charm. Featuring Gru’s grand home, the set includes several fun, interactive rooms, including Gru’s lair, the laboratory, and more. The set comes with beloved characters like Gru, his Minions, and the family dog, Kyle. With over [insert number] pieces, this set offers hours of creative play and an exciting build. It’s the perfect addition to any LEGO or Despicable Me collection, allowing fans to recreate their favorite scenes and create new adventures for Gru and his Minions	Toys, Games, Fun	Lego	5000	6000	500	20	t	published	regular	t	t	t	f	0	0	0	\N	SKU31873	qfqfkskjso	minions-and-grus-family-mansion-zw5t	2025-03-05 16:53:12.510312+05:45	2	3
\.


--
-- Data for Name: store_productfaq; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_productfaq (id, pid, email, question, answer, active, date, product_id, user_id) FROM stdin;
\.


--
-- Data for Name: store_review; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_review (id, review, reply, rating, active, date, product_id, user_id) FROM stdin;
\.


--
-- Data for Name: store_review_helpful; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_review_helpful (id, review_id, user_id) FROM stdin;
\.


--
-- Data for Name: store_review_not_helpful; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_review_not_helpful (id, review_id, user_id) FROM stdin;
\.


--
-- Data for Name: store_size; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_size (id, name, price, product_id) FROM stdin;
1	S	2999	4
2	M	2999	4
3	L	2999	4
4	S	7000	6
5	M	7050	6
6	L	8100	6
\.


--
-- Data for Name: store_specification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_specification (id, title, content, product_id) FROM stdin;
1	CPU	AMD Ryzen Zen 2, 8-core, 3.5 GHz (variable frequency)	1
2	GPU	AMD RDNA 2, 36 CUs at 2.23 GHz (variable frequency), 10.28 teraflops	1
3	RAM	16 GB GDDR6	1
4	Storage	825 GB custom SSD (expandable via NVMe SSD slot)	1
5	Platform	PlayStation 5, PlayStation 4	2
6	Developer	Santa Monica Studio	2
7	Controller	Full compatibility with DualSense for haptic feedback and adaptive triggers on PS5	2
8	Dimensions	62mm x 52mm x 98mm (L x W x H)	3
9	Compatibility	Compatible with PlayStation 4 and PlayStation 5 (limited functionality on PS5)	3
10	Material	Premium wool, cotton, or felt	4
11	Design	lassic, modern, or custom design	4
12	Additional Features	Packable or crushable for easy storage	4
13	Material	Wool, acrylic, cotton, or a blend of synthetic fibers	5
14	Design	Classic fit, slouchy, or cuffed	5
15	Additional Feature	Lightweight and breathable	5
16	Packaging	Standard LEGO box with instructions for easy assembly	8
17	Display	Adjustable stand to display the helmet at various angles	8
18	Feature	Designed to be an eye-catching collector's item for Star Wars fans	8
19	Material	High-quality LEGO plastic	9
20	Packaging	LEGO branded box with step-by-step instructions	9
21	Display Features	Perfect for fans who want to recreate scenes from The Dark Knight	9
\.


--
-- Data for Name: store_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_tag (id, title, active, slug, category_id) FROM stdin;
1	Film	t	film	1
2	video games	t	video-games	4
\.


--
-- Data for Name: store_wishlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_wishlist (id, date, product_id, user_id) FROM stdin;
1	2025-03-05 16:57:41.423531+05:45	7	7
2	2025-03-05 16:57:48.134111+05:45	2	7
3	2025-03-05 16:57:50.094634+05:45	1	7
\.


--
-- Data for Name: token_blacklist_blacklistedtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token_blacklist_blacklistedtoken (blacklisted_at, token_id, id) FROM stdin;
2025-03-05 15:33:13.58413+05:45	1	1
2025-03-05 15:51:10.417687+05:45	7	2
2025-03-05 16:37:27.068086+05:45	13	3
2025-03-05 16:54:04.393692+05:45	15	4
2025-03-05 17:02:19.788588+05:45	16	5
2025-03-05 23:09:42.708182+05:45	18	6
2025-03-06 08:45:27.833749+05:45	19	9
\.


--
-- Data for Name: token_blacklist_outstandingtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.token_blacklist_outstandingtoken (token, created_at, expires_at, user_id, jti, id) FROM stdin;
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUwNDUzMCwiaWF0IjoxNzQxMTg0NTMwLCJqdGkiOiIzMGZmNTY0YjBlZDA0MDU5ODljYTE3MjFjMWExNDFiMCIsInVzZXJfaWQiOjEsImZ1bGxfbmFtZSI6ImFiaGlzaGVrQGVtYWlsLmNvbSIsImVtYWlsIjoiYWJoaXNoZWtAZW1haWwuY29tIiwidXNlcm5hbWUiOiJhYmhpc2hlayIsInZlbmRvcl9pZCI6Mn0.G7akt2SYz6bHXcco62DmuT_oy7ueraGypQCR29vF2us	\N	2025-04-24 14:22:10+05:45	\N	30ff564b0ed0405989ca1721c1a141b0	1
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUwODg0NSwiaWF0IjoxNzQxMTg4ODQ1LCJqdGkiOiI4ZWIwOGRkNWM0YzQ0YTc2OTI1ZTgyMWE1ZDEyNjIyZiIsInVzZXJfaWQiOjJ9.mvUduCk0xHhM9ocYeLtml88x0GNCiUD_rhfRLwlReY4	2025-03-05 15:34:05.9182+05:45	2025-04-24 15:34:05+05:45	2	8eb08dd5c4c44a76925e821a5d12622f	2
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUwODk4NSwiaWF0IjoxNzQxMTg4OTg1LCJqdGkiOiJjNTU5YzFjNmU5ODk0OWYxYjdkMmIwNjE0MDc0NDAzNCIsInVzZXJfaWQiOjN9.RUI4Qc56iDQQMh94ErjHJgoyM9SkogFWD4PgPnaeVn4	2025-03-05 15:36:25.852051+05:45	2025-04-24 15:36:25+05:45	3	c559c1c6e98949f1b7d2b06140744034	3
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUwOTA4NCwiaWF0IjoxNzQxMTg5MDg0LCJqdGkiOiIzODI3NTUyNGU4ZWI0MzJmOWNjN2U0M2MzMGE3N2U5MCIsInVzZXJfaWQiOjR9.X3mAaUnK1f5iEzidgAgxmKyeMiBud_k8ohu6E4HObYA	2025-03-05 15:38:04.628159+05:45	2025-04-24 15:38:04+05:45	4	38275524e8eb432f9cc7e43c30a77e90	4
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUwOTE0NiwiaWF0IjoxNzQxMTg5MTQ2LCJqdGkiOiI5ZTQyMjZkMDliYjI0ODE2YjdkM2I0YjY3NmQ5OTRjOCIsInVzZXJfaWQiOjV9.wbjn_ouakKFCIzh0QsfaRLV67vSl4RcUYBCEb2ItD_Y	2025-03-05 15:39:06.357703+05:45	2025-04-24 15:39:06+05:45	5	9e4226d09bb24816b7d3b4b676d994c8	5
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUwOTM1NywiaWF0IjoxNzQxMTg5MzU3LCJqdGkiOiJkYTcyNjEzNzg4Njg0ZGZiOTUwZGJhOTA3NjNhM2YxNCIsInVzZXJfaWQiOjZ9.W7zeggcvmNUDkG9oy5_apyTAnUrVRxJ9mwB23ChodhE	2025-03-05 15:42:37.720411+05:45	2025-04-24 15:42:37+05:45	6	da72613788684dfb950dba90763a3f14	6
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUwOTQzNCwiaWF0IjoxNzQxMTg5NDM0LCJqdGkiOiI2MDM1OTY2MzkzNzc0ZTRmOGE2MGU3N2U0NDAxZTJlNiIsInVzZXJfaWQiOjd9.hNHXLOBVDfbJDazs-HumR-QHPb21l1qbrtP43xkdGpg	2025-03-05 15:43:54.693391+05:45	2025-04-24 15:43:54+05:45	7	6035966393774e4f8a60e77e4401e2e6	7
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxMDUxMCwiaWF0IjoxNzQxMTkwNTEwLCJqdGkiOiJjNTA0ODI5MTA4OGQ0MWJkOWI0Y2RkYzZlOWQ5NGVhNyIsInVzZXJfaWQiOjJ9.375gt8LG9m_by0KUFOiiBzyM2DlaqpIvAl8NYIZUppI	2025-03-05 16:01:50.939052+05:45	2025-04-24 16:01:50+05:45	2	c5048291088d41bd9b4cddc6e9d94ea7	8
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxMDY1MSwiaWF0IjoxNzQxMTkwNjUxLCJqdGkiOiJlZDVmNTQ2MTRmZmQ0OGU5YjNjYmUyNTU5NjM2ZDBkOCIsInVzZXJfaWQiOjJ9.j2y9WLGH1djWOu-Vu4eufll4ojvHNrNFqzd6X_lf1jw	2025-03-05 16:04:11.809197+05:45	2025-04-24 16:04:11+05:45	2	ed5f54614ffd48e9b3cbe2559636d0d8	9
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxMTI0MSwiaWF0IjoxNzQxMTkxMjQxLCJqdGkiOiJlYjk4OWYwMjE5YTk0MzA1OWViMzg1ZDU0YTA3MmNhZCIsInVzZXJfaWQiOjJ9.R_o_nONX2ZTLFvy_jr5j4aH9kWCs1gWlnNL4PrH6y_U	2025-03-05 16:14:01.662916+05:45	2025-04-24 16:14:01+05:45	2	eb989f0219a943059eb385d54a072cad	10
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxMTM1NCwiaWF0IjoxNzQxMTkxMzU0LCJqdGkiOiI1N2Q1NDMyYTk3NGU0MmRjYTY2MDQwYWY1YWYxYmYxNCIsInVzZXJfaWQiOjN9.b9MNip78gmx_il-2T0Fe6qiDPi4FchPhuyRMDUpnIg8	2025-03-05 16:15:54.72405+05:45	2025-04-24 16:15:54+05:45	3	57d5432a974e42dca66040af5af1bf14	11
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxMTQzMiwiaWF0IjoxNzQxMTkxNDMyLCJqdGkiOiJhOWJhZTAxMjI3NTA0MDlhYjcyZGE5NDM5NzFmN2UxMSIsInVzZXJfaWQiOjN9.t38HCwnBwd_bSXTWVQmD2KsxHDKlkv-ZkIKMGeo68fQ	2025-03-05 16:17:12.355344+05:45	2025-04-24 16:17:12+05:45	3	a9bae0122750409ab72da943971f7e11	12
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxMTU0NiwiaWF0IjoxNzQxMTkxNTQ2LCJqdGkiOiJjOWQwYmFmMjE4Nzc0MzYzOWNjZWUwMGFjM2U5N2RhMSIsInVzZXJfaWQiOjN9.PcbyAyADvpeCSlnpmOa-y-IxVcmUzFRFlVXassonWQg	2025-03-05 16:19:06.298001+05:45	2025-04-24 16:19:06+05:45	3	c9d0baf2187743639ccee00ac3e97da1	13
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxMjcxMCwiaWF0IjoxNzQxMTkyNzEwLCJqdGkiOiIwNjVhMmJhZDZjMGY0Yzc4YWVkNTlmMjM1ZGIwZDllYiIsInVzZXJfaWQiOjZ9.ARRxNUOsQR8nLKgboodju8JhNiPQ7b2oQY0Qh2wKtIQ	2025-03-05 16:38:30.631946+05:45	2025-04-24 16:38:30+05:45	6	065a2bad6c0f4c78aed59f235db0d9eb	14
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxMjgxMCwiaWF0IjoxNzQxMTkyODEwLCJqdGkiOiIxMDcyMTM3MTA3OTI0YjA5YWE5MDBjZjkwMWJmZjRiMSIsInVzZXJfaWQiOjZ9.cGldAru_QEXozYHps9JU6WIkP92mMoo22415TTSPX2I	2025-03-05 16:40:10.713621+05:45	2025-04-24 16:40:10+05:45	6	1072137107924b09aa900cf901bff4b1	15
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxMzc4OSwiaWF0IjoxNzQxMTkzNzg5LCJqdGkiOiIxYzZkY2ZlOTUzMWI0MmM0OGQyNTVkNTM4M2ZmZDMzZSIsInVzZXJfaWQiOjd9.4qbPhwkWAerj91eVNPLYrs2wUwtRnQFj8IPmiXCKx6c	2025-03-05 16:56:29.428935+05:45	2025-04-24 16:56:29+05:45	7	1c6dcfe9531b42c48d255d5383ffd33e	16
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxNDQwOSwiaWF0IjoxNzQxMTk0NDA5LCJqdGkiOiJlYzdmNjcwZDk4OGY0YzhhOWEzZWU4NTdmMzNmNmU3ZSIsInVzZXJfaWQiOjZ9.qYLCzMHKnyZf7TIRi5-3iBlgFYYLlLWjb29IcTjYrEo	2025-03-05 17:06:49.233582+05:45	2025-04-24 17:06:49+05:45	6	ec7f670d988f4c8a9a3ee857f33f6e7e	17
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxNDgwNiwiaWF0IjoxNzQxMTk0ODA2LCJqdGkiOiJkOTIxM2NkNTg0MjM0ODA0YTk4NDFmMDg0YmEyNWY5MCIsInVzZXJfaWQiOjd9.29EAHbY6fu0T4qQVXPnEUV7w9np8el7_72nRsFGcC-s	2025-03-05 17:13:26.308239+05:45	2025-04-24 17:13:26+05:45	7	d9213cd584234804a9841f084ba25f90	18
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0NTUxNTUxMCwiaWF0IjoxNzQxMTk1NTEwLCJqdGkiOiIzYzlkMzMxMDk1NDU0ZGRiYTFjOGEyYzI4MGU3YzA5OSIsInVzZXJfaWQiOjF9.w3t1RlE47HKOd3dhu5AlzQc-hMhmPFNdYwNVDKqoRlQ	2025-03-05 23:10:10.582687+05:45	2025-04-24 23:10:10+05:45	1	3c9d331095454ddba1c8a2c280e7c099	19
\.


--
-- Data for Name: userauths_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userauths_profile (id, image, full_name, about, gender, country, city, state, address, newsletter, type, date, pid, user_id) FROM stdin;
2	accounts/users/mahadev.png	Jonny Cashing	I am the owner of Game Shop.	\N	Nepal	Kathmandu	Lumbini	Bulbuley	f	\N	2025-03-05 15:34:05.517384+05:45	kttzzieuzk	2
3	accounts/users/youtube.png	Smarika Shrestha	null	\N	Nepal	Kathmandu	Bagmati	Mahankal	f	\N	2025-03-05 15:36:25.540553+05:45	msbtakyopp	3
4	default/default-user.jpg	Shreya Adhikari	I am shreya	female	Nepal	Kathmandu	\N	MIlan Chowk	f	\N	2025-03-05 15:38:04.318355+05:45	kduizvzyny	4
5	accounts/users/logo-grayscale.png	Alika Mishra	I am Alika	\N	Nepal	Lalitpur	Bagmati	Patan	f	\N	2025-03-05 15:39:06.040412+05:45	busncsxmrt	5
6	accounts/users/logo-color.png	Sachin Karki	I am sachin karki	male	Nepal	Kavre	Bagmati	Banepa	t	\N	2025-03-05 15:42:37.41226+05:45	isgzrokban	6
7	accounts/users/81w7IxUhL.jpg	Ram Bhandari	Hello. I am ram bhandari.	male	Nepal	Kathmandu	Bagmati	Simaltar	t	male	2025-03-05 15:43:54.384934+05:45	vaafjfjpsa	7
1	accounts/users/toys.png	Abhishek Timilsina	I am the admin of this page	male	Nepal	Kathmandu	Bagmati	MIlan Chowk	f	male	2025-03-05 15:21:00.242528+05:45	rabclmfjye	1
\.


--
-- Data for Name: userauths_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userauths_user (id, password, last_login, is_superuser, first_name, last_name, is_staff, is_active, date_joined, username, email, full_name, phone, otp, reset_token) FROM stdin;
2	pbkdf2_sha256$600000$gsBEUtadq9oKlfeDvxUrJJ$O4C0BtJS3Z0KTql+EnI63ZjTHh3EpWnZ0pIEj0+DAtA=	\N	f			f	t	2025-03-05 15:34:05.515133+05:45	jonny.cashing2000	jonny.cashing2000@gmail.com	Jonny Cashing	9803922322	\N	\N
3	pbkdf2_sha256$600000$BHeFgH0FiN4Kk3l8IyZB0a$lW4FCxiPqafnvsHHZb+U+jrJ8Idnr37zf0C3hirxuNA=	\N	f			f	t	2025-03-05 15:36:25.535418+05:45	timilsina.abhishek2055	timilsina.abhishek2055@gmail.com	Smarika Shrestha	9822773755		
4	pbkdf2_sha256$600000$jKULB8Dgfd1H8Ly6rSDu9y$eEXwkr10OT5v/+YMOAAZ5fzOQkv8iu4qKPGwouyuGYk=	\N	f			f	t	2025-03-05 15:38:04.316305+05:45	shreya.adhikari	shreya.adhikari@yopmail.com	Shreya Adhikari	9863254578	\N	\N
5	pbkdf2_sha256$600000$167ZQTExQQoDOsI7oNIduJ$J69quKR9gEGMCNVx3etxC/nfQBwCdFmqcOgYXoEue/c=	\N	f			f	t	2025-03-05 15:39:06.035278+05:45	alika.mishra	alika.mishra@yopmail.com	Alika Mishra	9822554578	\N	\N
6	pbkdf2_sha256$600000$6FxkhQS5A0B6rmfRHt5gvQ$3bmlNYCfDmbMY+WYMSJPX2uvU6OqzXAeVhvYbJa+8q8=	\N	f	Sachin	Karki	f	t	2025-03-05 15:42:37+05:45	sachin.karki	sachin.karki@yopmail.com	Sachin Karki	9856457852	\N	\N
7	pbkdf2_sha256$600000$YLD2InGWJ01algFwBieeZ1$zOLbA1TZX49RvHP8NOGEyytJpl1gX2OUcESS7pD2gJg=	\N	f	Ram	Bhandari	f	t	2025-03-05 15:43:54+05:45	ram.bhandari	ram.bhandari@yopmail.com	Ram Bhandari	9841254578	\N	\N
1	pbkdf2_sha256$600000$VgUSSmuY61gNlpIxOocedF$HnKOl3BC/yUdhoIWZQ1tXxkreJDg45zJsTpgCHPslVg=	2025-03-06 08:52:26.31814+05:45	t	Abhishek	Timilsina	t	t	2025-03-05 15:21:00+05:45	Abhishek123	timilsina.abhishek@email.com	Abhishek Timilsina	9840196929	\N	\N
\.


--
-- Data for Name: userauths_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userauths_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: userauths_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userauths_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: vendor_vendor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_vendor (id, image, name, email, description, mobile, verified, active, vid, date, slug, user_id) FROM stdin;
1	user_2/2.jpg	Video Game Store	videogamestore@yopmail.com	Welcome to Video Game Store, your ultimate destination for all things gaming! Whether you're a casual player or a hardcore enthusiast, we offer a wide selection of the latest video games, consoles, accessories, and collectibles. Explore top titles, exclusive deals, and a community of fellow gamers. Get ready to level up your gaming experience with us!	9801122334	f	t	ugrtrlzeof	2025-03-05 16:04:02.913004+05:45	video-game-store	2
2	user_3/3.jpg	Clothing Shop Nepal	clothingshop@yopmail.com	Welcome to Clothing Shop Nepal, your go-to destination for stylish and comfortable fashion! From casual wear to elegant attire, we offer a wide range of clothing for men, women, and children. Whether you're looking for trendy outfits, classic staples, or something unique, we have something to suit every style and occasion. Our curated collections feature high-quality fabrics, excellent craftsmanship, and the latest fashion trends, all at affordable prices. Shop with us and step out in style, feeling confident and comfortable every day!	980365214	f	t	cptayingme	2025-03-05 16:18:56.521345+05:45	clothing-shop-nepal	3
3	user_6/6.jpg	Toy Shop Nepal	toyshopnepal@yopmail.com	Welcome to Toy Shop Nepal, the ultimate destination for toys that spark imagination and fun! We offer a wide variety of high-quality toys for children of all ages, from educational toys that promote learning to exciting games and plush companions. Whether you're shopping for a birthday, holiday, or just because, our store has something to delight every child. Explore our curated collection of creative, safe, and entertaining toys that are sure to bring joy and laughter to your little ones."\r\n\r\nFeel free to replace the placeholder with your shop's name!	9841165011	f	t	hzlmggqvxk	2025-03-05 16:40:02.526736+05:45	toy-shop-nepal	6
\.


--
-- Name: addon_configsettings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addon_configsettings_id_seq', 1, true);


--
-- Name: addon_tax_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addon_tax_id_seq', 2, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 128, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 45, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 32, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 35, true);


--
-- Name: store_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_address_id_seq', 1, true);


--
-- Name: store_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_brand_id_seq', 10, true);


--
-- Name: store_cancelledorder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_cancelledorder_id_seq', 1, true);


--
-- Name: store_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_cart_id_seq', 1, true);


--
-- Name: store_cartorder_coupons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_cartorder_coupons_id_seq', 1, true);


--
-- Name: store_cartorder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_cartorder_id_seq', 4, true);


--
-- Name: store_cartorder_vendor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_cartorder_vendor_id_seq', 7, true);


--
-- Name: store_cartorderitem_coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_cartorderitem_coupon_id_seq', 1, true);


--
-- Name: store_cartorderitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_cartorderitem_id_seq', 7, true);


--
-- Name: store_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_category_id_seq', 7, true);


--
-- Name: store_color_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_color_id_seq', 7, true);


--
-- Name: store_coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_coupon_id_seq', 1, true);


--
-- Name: store_coupon_used_by_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_coupon_used_by_id_seq', 1, true);


--
-- Name: store_couponusers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_couponusers_id_seq', 1, true);


--
-- Name: store_deliverycouriers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_deliverycouriers_id_seq', 3, true);


--
-- Name: store_gallery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_gallery_id_seq', 16, true);


--
-- Name: store_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_notification_id_seq', 10, true);


--
-- Name: store_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_product_id_seq', 10, true);


--
-- Name: store_productfaq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_productfaq_id_seq', 1, true);


--
-- Name: store_review_helpful_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_review_helpful_id_seq', 1, true);


--
-- Name: store_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_review_id_seq', 1, true);


--
-- Name: store_review_not_helpful_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_review_not_helpful_id_seq', 1, true);


--
-- Name: store_size_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_size_id_seq', 6, true);


--
-- Name: store_specification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_specification_id_seq', 21, true);


--
-- Name: store_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_tag_id_seq', 2, true);


--
-- Name: store_wishlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_wishlist_id_seq', 3, true);


--
-- Name: token_blacklist_blacklistedtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_blacklist_blacklistedtoken_id_seq', 9, true);


--
-- Name: token_blacklist_outstandingtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.token_blacklist_outstandingtoken_id_seq', 19, true);


--
-- Name: userauths_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.userauths_profile_id_seq', 7, true);


--
-- Name: userauths_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.userauths_user_groups_id_seq', 1, true);


--
-- Name: userauths_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.userauths_user_id_seq', 7, true);


--
-- Name: userauths_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.userauths_user_user_permissions_id_seq', 1, true);


--
-- Name: vendor_vendor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendor_vendor_id_seq', 3, true);


--
-- Name: django_migrations idx_75789_django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT idx_75789_django_migrations_pkey PRIMARY KEY (id);


--
-- Name: addon_configsettings idx_75796_addon_configsettings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addon_configsettings
    ADD CONSTRAINT idx_75796_addon_configsettings_pkey PRIMARY KEY (id);


--
-- Name: addon_tax idx_75803_addon_tax_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addon_tax
    ADD CONSTRAINT idx_75803_addon_tax_pkey PRIMARY KEY (id);


--
-- Name: django_content_type idx_75810_django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT idx_75810_django_content_type_pkey PRIMARY KEY (id);


--
-- Name: auth_group_permissions idx_75817_auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT idx_75817_auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_permission idx_75822_auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT idx_75822_auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_group idx_75829_auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT idx_75829_auth_group_pkey PRIMARY KEY (id);


--
-- Name: userauths_user idx_75836_userauths_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_user
    ADD CONSTRAINT idx_75836_userauths_user_pkey PRIMARY KEY (id);


--
-- Name: userauths_user_groups idx_75843_userauths_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_user_groups
    ADD CONSTRAINT idx_75843_userauths_user_groups_pkey PRIMARY KEY (id);


--
-- Name: userauths_user_user_permissions idx_75848_userauths_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_user_user_permissions
    ADD CONSTRAINT idx_75848_userauths_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: userauths_profile idx_75853_userauths_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_profile
    ADD CONSTRAINT idx_75853_userauths_profile_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log idx_75860_django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT idx_75860_django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_session idx_75866_sqlite_autoindex_django_session_1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT idx_75866_sqlite_autoindex_django_session_1 PRIMARY KEY (session_key);


--
-- Name: vendor_vendor idx_75872_vendor_vendor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_vendor
    ADD CONSTRAINT idx_75872_vendor_vendor_pkey PRIMARY KEY (id);


--
-- Name: store_address idx_75879_store_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_address
    ADD CONSTRAINT idx_75879_store_address_pkey PRIMARY KEY (id);


--
-- Name: store_brand idx_75886_store_brand_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_brand
    ADD CONSTRAINT idx_75886_store_brand_pkey PRIMARY KEY (id);


--
-- Name: store_cancelledorder idx_75893_store_cancelledorder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cancelledorder
    ADD CONSTRAINT idx_75893_store_cancelledorder_pkey PRIMARY KEY (id);


--
-- Name: store_cartorder idx_75900_store_cartorder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorder
    ADD CONSTRAINT idx_75900_store_cartorder_pkey PRIMARY KEY (id);


--
-- Name: store_category idx_75907_store_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_category
    ADD CONSTRAINT idx_75907_store_category_pkey PRIMARY KEY (id);


--
-- Name: store_color idx_75914_store_color_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_color
    ADD CONSTRAINT idx_75914_store_color_pkey PRIMARY KEY (id);


--
-- Name: store_coupon idx_75921_store_coupon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_coupon
    ADD CONSTRAINT idx_75921_store_coupon_pkey PRIMARY KEY (id);


--
-- Name: store_deliverycouriers idx_75928_store_deliverycouriers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_deliverycouriers
    ADD CONSTRAINT idx_75928_store_deliverycouriers_pkey PRIMARY KEY (id);


--
-- Name: store_gallery idx_75935_store_gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_gallery
    ADD CONSTRAINT idx_75935_store_gallery_pkey PRIMARY KEY (id);


--
-- Name: store_notification idx_75942_store_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_notification
    ADD CONSTRAINT idx_75942_store_notification_pkey PRIMARY KEY (id);


--
-- Name: store_product idx_75947_store_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_product
    ADD CONSTRAINT idx_75947_store_product_pkey PRIMARY KEY (id);


--
-- Name: store_productfaq idx_75954_store_productfaq_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_productfaq
    ADD CONSTRAINT idx_75954_store_productfaq_pkey PRIMARY KEY (id);


--
-- Name: store_review idx_75961_store_review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review
    ADD CONSTRAINT idx_75961_store_review_pkey PRIMARY KEY (id);


--
-- Name: store_size idx_75968_store_size_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_size
    ADD CONSTRAINT idx_75968_store_size_pkey PRIMARY KEY (id);


--
-- Name: store_specification idx_75975_store_specification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_specification
    ADD CONSTRAINT idx_75975_store_specification_pkey PRIMARY KEY (id);


--
-- Name: store_wishlist idx_75982_store_wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_wishlist
    ADD CONSTRAINT idx_75982_store_wishlist_pkey PRIMARY KEY (id);


--
-- Name: store_tag idx_75987_store_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_tag
    ADD CONSTRAINT idx_75987_store_tag_pkey PRIMARY KEY (id);


--
-- Name: store_review_helpful idx_75994_store_review_helpful_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review_helpful
    ADD CONSTRAINT idx_75994_store_review_helpful_pkey PRIMARY KEY (id);


--
-- Name: store_review_not_helpful idx_75999_store_review_not_helpful_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review_not_helpful
    ADD CONSTRAINT idx_75999_store_review_not_helpful_pkey PRIMARY KEY (id);


--
-- Name: store_couponusers idx_76004_store_couponusers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_couponusers
    ADD CONSTRAINT idx_76004_store_couponusers_pkey PRIMARY KEY (id);


--
-- Name: store_coupon_used_by idx_76011_store_coupon_used_by_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_coupon_used_by
    ADD CONSTRAINT idx_76011_store_coupon_used_by_pkey PRIMARY KEY (id);


--
-- Name: store_cartorderitem_coupon idx_76016_store_cartorderitem_coupon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorderitem_coupon
    ADD CONSTRAINT idx_76016_store_cartorderitem_coupon_pkey PRIMARY KEY (id);


--
-- Name: store_cartorderitem idx_76021_store_cartorderitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorderitem
    ADD CONSTRAINT idx_76021_store_cartorderitem_pkey PRIMARY KEY (id);


--
-- Name: store_cartorder_coupons idx_76028_store_cartorder_coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorder_coupons
    ADD CONSTRAINT idx_76028_store_cartorder_coupons_pkey PRIMARY KEY (id);


--
-- Name: store_cartorder_vendor idx_76033_store_cartorder_vendor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorder_vendor
    ADD CONSTRAINT idx_76033_store_cartorder_vendor_pkey PRIMARY KEY (id);


--
-- Name: store_cart idx_76038_store_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cart
    ADD CONSTRAINT idx_76038_store_cart_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_blacklistedtoken idx_76045_token_blacklist_blacklistedtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT idx_76045_token_blacklist_blacklistedtoken_pkey PRIMARY KEY (id);


--
-- Name: token_blacklist_outstandingtoken idx_76050_token_blacklist_outstandingtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT idx_76050_token_blacklist_outstandingtoken_pkey PRIMARY KEY (id);


--
-- Name: idx_75810_django_content_type_app_label_model_76bd3d3b_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75810_django_content_type_app_label_model_76bd3d3b_uniq ON public.django_content_type USING btree (app_label, model);


--
-- Name: idx_75817_auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75817_auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: idx_75817_auth_group_permissions_group_id_permission_id_0cd325b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75817_auth_group_permissions_group_id_permission_id_0cd325b ON public.auth_group_permissions USING btree (group_id, permission_id);


--
-- Name: idx_75817_auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75817_auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: idx_75822_auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75822_auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: idx_75822_auth_permission_content_type_id_codename_01ab375a_uni; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75822_auth_permission_content_type_id_codename_01ab375a_uni ON public.auth_permission USING btree (content_type_id, codename);


--
-- Name: idx_75829_sqlite_autoindex_auth_group_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75829_sqlite_autoindex_auth_group_1 ON public.auth_group USING btree (name);


--
-- Name: idx_75836_sqlite_autoindex_userauths_user_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75836_sqlite_autoindex_userauths_user_1 ON public.userauths_user USING btree (email);


--
-- Name: idx_75843_userauths_user_groups_group_id_2bd3d457; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75843_userauths_user_groups_group_id_2bd3d457 ON public.userauths_user_groups USING btree (group_id);


--
-- Name: idx_75843_userauths_user_groups_user_id_70ad3415; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75843_userauths_user_groups_user_id_70ad3415 ON public.userauths_user_groups USING btree (user_id);


--
-- Name: idx_75843_userauths_user_groups_user_id_group_id_e032b670_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75843_userauths_user_groups_user_id_group_id_e032b670_uniq ON public.userauths_user_groups USING btree (user_id, group_id);


--
-- Name: idx_75848_userauths_user_user_permissions_permission_id_0e980eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75848_userauths_user_user_permissions_permission_id_0e980eb ON public.userauths_user_user_permissions USING btree (permission_id);


--
-- Name: idx_75848_userauths_user_user_permissions_user_id_7dc84ca3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75848_userauths_user_user_permissions_user_id_7dc84ca3 ON public.userauths_user_user_permissions USING btree (user_id);


--
-- Name: idx_75848_userauths_user_user_permissions_user_id_permission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75848_userauths_user_user_permissions_user_id_permission_id ON public.userauths_user_user_permissions USING btree (user_id, permission_id);


--
-- Name: idx_75853_sqlite_autoindex_userauths_profile_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75853_sqlite_autoindex_userauths_profile_1 ON public.userauths_profile USING btree (pid);


--
-- Name: idx_75853_sqlite_autoindex_userauths_profile_2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75853_sqlite_autoindex_userauths_profile_2 ON public.userauths_profile USING btree (user_id);


--
-- Name: idx_75860_django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75860_django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: idx_75860_django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75860_django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: idx_75866_django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75866_django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: idx_75872_sqlite_autoindex_vendor_vendor_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75872_sqlite_autoindex_vendor_vendor_1 ON public.vendor_vendor USING btree (vid);


--
-- Name: idx_75872_sqlite_autoindex_vendor_vendor_2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75872_sqlite_autoindex_vendor_vendor_2 ON public.vendor_vendor USING btree (user_id);


--
-- Name: idx_75872_vendor_vendor_slug_e7b8f5a5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75872_vendor_vendor_slug_e7b8f5a5 ON public.vendor_vendor USING btree (slug);


--
-- Name: idx_75879_store_address_country_id_dcb5f6c7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75879_store_address_country_id_dcb5f6c7 ON public.store_address USING btree (country_id);


--
-- Name: idx_75879_store_address_user_id_34317815; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75879_store_address_user_id_34317815 ON public.store_address USING btree (user_id);


--
-- Name: idx_75893_store_cancelledorder_orderitem_id_03e99fa3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75893_store_cancelledorder_orderitem_id_03e99fa3 ON public.store_cancelledorder USING btree (orderitem_id);


--
-- Name: idx_75893_store_cancelledorder_user_id_075bc397; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75893_store_cancelledorder_user_id_075bc397 ON public.store_cancelledorder USING btree (user_id);


--
-- Name: idx_75900_store_cartorder_buyer_id_cda2eba0; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75900_store_cartorder_buyer_id_cda2eba0 ON public.store_cartorder USING btree (buyer_id);


--
-- Name: idx_75907_store_category_slug_2d349264; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75907_store_category_slug_2d349264 ON public.store_category USING btree (slug);


--
-- Name: idx_75914_store_color_product_id_19509c41; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75914_store_color_product_id_19509c41 ON public.store_color USING btree (product_id);


--
-- Name: idx_75921_store_coupon_vendor_id_4935676a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75921_store_coupon_vendor_id_4935676a ON public.store_coupon USING btree (vendor_id);


--
-- Name: idx_75935_store_gallery_product_id_c9f76256; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75935_store_gallery_product_id_c9f76256 ON public.store_gallery USING btree (product_id);


--
-- Name: idx_75942_store_notification_order_id_93b2e17c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75942_store_notification_order_id_93b2e17c ON public.store_notification USING btree (order_id);


--
-- Name: idx_75942_store_notification_order_item_id_9f2bccee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75942_store_notification_order_item_id_9f2bccee ON public.store_notification USING btree (order_item_id);


--
-- Name: idx_75942_store_notification_user_id_19e577b8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75942_store_notification_user_id_19e577b8 ON public.store_notification USING btree (user_id);


--
-- Name: idx_75942_store_notification_vendor_id_e3d029b8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75942_store_notification_vendor_id_e3d029b8 ON public.store_notification USING btree (vendor_id);


--
-- Name: idx_75947_sqlite_autoindex_store_product_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75947_sqlite_autoindex_store_product_1 ON public.store_product USING btree (sku);


--
-- Name: idx_75947_sqlite_autoindex_store_product_2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75947_sqlite_autoindex_store_product_2 ON public.store_product USING btree (pid);


--
-- Name: idx_75947_store_product_category_id_574bae65; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75947_store_product_category_id_574bae65 ON public.store_product USING btree (category_id);


--
-- Name: idx_75947_store_product_slug_6de8ee4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75947_store_product_slug_6de8ee4b ON public.store_product USING btree (slug);


--
-- Name: idx_75947_store_product_vendor_id_f9abf9af; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75947_store_product_vendor_id_f9abf9af ON public.store_product USING btree (vendor_id);


--
-- Name: idx_75954_sqlite_autoindex_store_productfaq_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75954_sqlite_autoindex_store_productfaq_1 ON public.store_productfaq USING btree (pid);


--
-- Name: idx_75954_store_productfaq_product_id_c0e6d70c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75954_store_productfaq_product_id_c0e6d70c ON public.store_productfaq USING btree (product_id);


--
-- Name: idx_75954_store_productfaq_user_id_2a9e4a01; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75954_store_productfaq_user_id_2a9e4a01 ON public.store_productfaq USING btree (user_id);


--
-- Name: idx_75961_store_review_product_id_abc413b2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75961_store_review_product_id_abc413b2 ON public.store_review USING btree (product_id);


--
-- Name: idx_75961_store_review_user_id_cc54d86d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75961_store_review_user_id_cc54d86d ON public.store_review USING btree (user_id);


--
-- Name: idx_75968_store_size_product_id_e115db4c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75968_store_size_product_id_e115db4c ON public.store_size USING btree (product_id);


--
-- Name: idx_75975_store_specification_product_id_b56e860b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75975_store_specification_product_id_b56e860b ON public.store_specification USING btree (product_id);


--
-- Name: idx_75982_store_wishlist_product_id_8af1333d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75982_store_wishlist_product_id_8af1333d ON public.store_wishlist USING btree (product_id);


--
-- Name: idx_75982_store_wishlist_user_id_afcc4e88; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75982_store_wishlist_user_id_afcc4e88 ON public.store_wishlist USING btree (user_id);


--
-- Name: idx_75987_sqlite_autoindex_store_tag_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75987_sqlite_autoindex_store_tag_1 ON public.store_tag USING btree (slug);


--
-- Name: idx_75987_store_tag_category_id_7248f299; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75987_store_tag_category_id_7248f299 ON public.store_tag USING btree (category_id);


--
-- Name: idx_75994_store_review_helpful_review_id_be0fd3c9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75994_store_review_helpful_review_id_be0fd3c9 ON public.store_review_helpful USING btree (review_id);


--
-- Name: idx_75994_store_review_helpful_review_id_user_id_856b0e2c_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75994_store_review_helpful_review_id_user_id_856b0e2c_uniq ON public.store_review_helpful USING btree (review_id, user_id);


--
-- Name: idx_75994_store_review_helpful_user_id_c7e5a6c7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75994_store_review_helpful_user_id_c7e5a6c7 ON public.store_review_helpful USING btree (user_id);


--
-- Name: idx_75999_store_review_not_helpful_review_id_d8b517be; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75999_store_review_not_helpful_review_id_d8b517be ON public.store_review_not_helpful USING btree (review_id);


--
-- Name: idx_75999_store_review_not_helpful_review_id_user_id_6a818773_u; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_75999_store_review_not_helpful_review_id_user_id_6a818773_u ON public.store_review_not_helpful USING btree (review_id, user_id);


--
-- Name: idx_75999_store_review_not_helpful_user_id_229748b4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_75999_store_review_not_helpful_user_id_229748b4 ON public.store_review_not_helpful USING btree (user_id);


--
-- Name: idx_76004_store_couponusers_coupon_id_cf5780af; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76004_store_couponusers_coupon_id_cf5780af ON public.store_couponusers USING btree (coupon_id);


--
-- Name: idx_76004_store_couponusers_order_id_a8eb9e82; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76004_store_couponusers_order_id_a8eb9e82 ON public.store_couponusers USING btree (order_id);


--
-- Name: idx_76011_store_coupon_used_by_coupon_id_ce45372a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76011_store_coupon_used_by_coupon_id_ce45372a ON public.store_coupon_used_by USING btree (coupon_id);


--
-- Name: idx_76011_store_coupon_used_by_coupon_id_user_id_d8a2966c_uniq; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_76011_store_coupon_used_by_coupon_id_user_id_d8a2966c_uniq ON public.store_coupon_used_by USING btree (coupon_id, user_id);


--
-- Name: idx_76011_store_coupon_used_by_user_id_0d2797b3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76011_store_coupon_used_by_user_id_0d2797b3 ON public.store_coupon_used_by USING btree (user_id);


--
-- Name: idx_76016_store_cartorderitem_coupon_cartorderitem_id_812de46a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76016_store_cartorderitem_coupon_cartorderitem_id_812de46a ON public.store_cartorderitem_coupon USING btree (cartorderitem_id);


--
-- Name: idx_76016_store_cartorderitem_coupon_cartorderitem_id_coupon_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_76016_store_cartorderitem_coupon_cartorderitem_id_coupon_id ON public.store_cartorderitem_coupon USING btree (cartorderitem_id, coupon_id);


--
-- Name: idx_76016_store_cartorderitem_coupon_coupon_id_8a77d85d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76016_store_cartorderitem_coupon_coupon_id_8a77d85d ON public.store_cartorderitem_coupon USING btree (coupon_id);


--
-- Name: idx_76021_store_cartorderitem_delivery_couriers_id_b8a60505; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76021_store_cartorderitem_delivery_couriers_id_b8a60505 ON public.store_cartorderitem USING btree (delivery_couriers_id);


--
-- Name: idx_76021_store_cartorderitem_order_id_a85aaf9d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76021_store_cartorderitem_order_id_a85aaf9d ON public.store_cartorderitem USING btree (order_id);


--
-- Name: idx_76021_store_cartorderitem_product_id_c4ff9e60; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76021_store_cartorderitem_product_id_c4ff9e60 ON public.store_cartorderitem USING btree (product_id);


--
-- Name: idx_76021_store_cartorderitem_vendor_id_54ca6100; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76021_store_cartorderitem_vendor_id_54ca6100 ON public.store_cartorderitem USING btree (vendor_id);


--
-- Name: idx_76028_store_cartorder_coupons_cartorder_id_77852714; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76028_store_cartorder_coupons_cartorder_id_77852714 ON public.store_cartorder_coupons USING btree (cartorder_id);


--
-- Name: idx_76028_store_cartorder_coupons_cartorder_id_coupon_id_25c53a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_76028_store_cartorder_coupons_cartorder_id_coupon_id_25c53a ON public.store_cartorder_coupons USING btree (cartorder_id, coupon_id);


--
-- Name: idx_76028_store_cartorder_coupons_coupon_id_d0b91671; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76028_store_cartorder_coupons_coupon_id_d0b91671 ON public.store_cartorder_coupons USING btree (coupon_id);


--
-- Name: idx_76033_store_cartorder_vendor_cartorder_id_86c58fb8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76033_store_cartorder_vendor_cartorder_id_86c58fb8 ON public.store_cartorder_vendor USING btree (cartorder_id);


--
-- Name: idx_76033_store_cartorder_vendor_cartorder_id_vendor_id_afcf269; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_76033_store_cartorder_vendor_cartorder_id_vendor_id_afcf269 ON public.store_cartorder_vendor USING btree (cartorder_id, vendor_id);


--
-- Name: idx_76033_store_cartorder_vendor_vendor_id_3da95e97; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76033_store_cartorder_vendor_vendor_id_3da95e97 ON public.store_cartorder_vendor USING btree (vendor_id);


--
-- Name: idx_76038_store_cart_product_id_b219c080; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76038_store_cart_product_id_b219c080 ON public.store_cart USING btree (product_id);


--
-- Name: idx_76038_store_cart_user_id_99e99107; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76038_store_cart_user_id_99e99107 ON public.store_cart USING btree (user_id);


--
-- Name: idx_76045_sqlite_autoindex_token_blacklist_blacklistedtoken_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_76045_sqlite_autoindex_token_blacklist_blacklistedtoken_1 ON public.token_blacklist_blacklistedtoken USING btree (token_id);


--
-- Name: idx_76050_sqlite_autoindex_token_blacklist_outstandingtoken_1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_76050_sqlite_autoindex_token_blacklist_outstandingtoken_1 ON public.token_blacklist_outstandingtoken USING btree (jti);


--
-- Name: idx_76050_token_blacklist_outstandingtoken_user_id_83bc629a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_76050_token_blacklist_outstandingtoken_user_id_83bc629a ON public.token_blacklist_outstandingtoken USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id);


--
-- Name: auth_group_permissions auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id);


--
-- Name: auth_permission auth_permission_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: django_admin_log django_admin_log_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id);


--
-- Name: django_admin_log django_admin_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: store_address store_address_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_address
    ADD CONSTRAINT store_address_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.addon_tax(id);


--
-- Name: store_address store_address_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_address
    ADD CONSTRAINT store_address_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: store_cancelledorder store_cancelledorder_orderitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cancelledorder
    ADD CONSTRAINT store_cancelledorder_orderitem_id_fkey FOREIGN KEY (orderitem_id) REFERENCES public.store_cartorderitem(id);


--
-- Name: store_cancelledorder store_cancelledorder_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cancelledorder
    ADD CONSTRAINT store_cancelledorder_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: store_cart store_cart_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cart
    ADD CONSTRAINT store_cart_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.store_product(id);


--
-- Name: store_cart store_cart_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cart
    ADD CONSTRAINT store_cart_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: store_cartorder store_cartorder_buyer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorder
    ADD CONSTRAINT store_cartorder_buyer_id_fkey FOREIGN KEY (buyer_id) REFERENCES public.userauths_user(id);


--
-- Name: store_cartorder_coupons store_cartorder_coupons_cartorder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorder_coupons
    ADD CONSTRAINT store_cartorder_coupons_cartorder_id_fkey FOREIGN KEY (cartorder_id) REFERENCES public.store_cartorder(id);


--
-- Name: store_cartorder_coupons store_cartorder_coupons_coupon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorder_coupons
    ADD CONSTRAINT store_cartorder_coupons_coupon_id_fkey FOREIGN KEY (coupon_id) REFERENCES public.store_coupon(id);


--
-- Name: store_cartorder_vendor store_cartorder_vendor_cartorder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorder_vendor
    ADD CONSTRAINT store_cartorder_vendor_cartorder_id_fkey FOREIGN KEY (cartorder_id) REFERENCES public.store_cartorder(id);


--
-- Name: store_cartorder_vendor store_cartorder_vendor_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorder_vendor
    ADD CONSTRAINT store_cartorder_vendor_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendor_vendor(id);


--
-- Name: store_cartorderitem_coupon store_cartorderitem_coupon_cartorderitem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorderitem_coupon
    ADD CONSTRAINT store_cartorderitem_coupon_cartorderitem_id_fkey FOREIGN KEY (cartorderitem_id) REFERENCES public.store_cartorderitem(id);


--
-- Name: store_cartorderitem_coupon store_cartorderitem_coupon_coupon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorderitem_coupon
    ADD CONSTRAINT store_cartorderitem_coupon_coupon_id_fkey FOREIGN KEY (coupon_id) REFERENCES public.store_coupon(id);


--
-- Name: store_cartorderitem store_cartorderitem_delivery_couriers_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorderitem
    ADD CONSTRAINT store_cartorderitem_delivery_couriers_id_fkey FOREIGN KEY (delivery_couriers_id) REFERENCES public.store_deliverycouriers(id);


--
-- Name: store_cartorderitem store_cartorderitem_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorderitem
    ADD CONSTRAINT store_cartorderitem_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.store_cartorder(id);


--
-- Name: store_cartorderitem store_cartorderitem_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorderitem
    ADD CONSTRAINT store_cartorderitem_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.store_product(id);


--
-- Name: store_cartorderitem store_cartorderitem_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_cartorderitem
    ADD CONSTRAINT store_cartorderitem_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendor_vendor(id);


--
-- Name: store_color store_color_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_color
    ADD CONSTRAINT store_color_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.store_product(id);


--
-- Name: store_coupon_used_by store_coupon_used_by_coupon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_coupon_used_by
    ADD CONSTRAINT store_coupon_used_by_coupon_id_fkey FOREIGN KEY (coupon_id) REFERENCES public.store_coupon(id);


--
-- Name: store_coupon_used_by store_coupon_used_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_coupon_used_by
    ADD CONSTRAINT store_coupon_used_by_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: store_coupon store_coupon_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_coupon
    ADD CONSTRAINT store_coupon_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendor_vendor(id);


--
-- Name: store_couponusers store_couponusers_coupon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_couponusers
    ADD CONSTRAINT store_couponusers_coupon_id_fkey FOREIGN KEY (coupon_id) REFERENCES public.store_coupon(id);


--
-- Name: store_couponusers store_couponusers_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_couponusers
    ADD CONSTRAINT store_couponusers_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.store_cartorder(id);


--
-- Name: store_gallery store_gallery_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_gallery
    ADD CONSTRAINT store_gallery_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.store_product(id);


--
-- Name: store_notification store_notification_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_notification
    ADD CONSTRAINT store_notification_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.store_cartorder(id);


--
-- Name: store_notification store_notification_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_notification
    ADD CONSTRAINT store_notification_order_item_id_fkey FOREIGN KEY (order_item_id) REFERENCES public.store_cartorderitem(id);


--
-- Name: store_notification store_notification_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_notification
    ADD CONSTRAINT store_notification_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: store_notification store_notification_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_notification
    ADD CONSTRAINT store_notification_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendor_vendor(id);


--
-- Name: store_product store_product_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_product
    ADD CONSTRAINT store_product_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.store_category(id);


--
-- Name: store_product store_product_vendor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_product
    ADD CONSTRAINT store_product_vendor_id_fkey FOREIGN KEY (vendor_id) REFERENCES public.vendor_vendor(id);


--
-- Name: store_productfaq store_productfaq_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_productfaq
    ADD CONSTRAINT store_productfaq_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.store_product(id);


--
-- Name: store_productfaq store_productfaq_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_productfaq
    ADD CONSTRAINT store_productfaq_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: store_review_helpful store_review_helpful_review_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review_helpful
    ADD CONSTRAINT store_review_helpful_review_id_fkey FOREIGN KEY (review_id) REFERENCES public.store_review(id);


--
-- Name: store_review_helpful store_review_helpful_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review_helpful
    ADD CONSTRAINT store_review_helpful_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: store_review_not_helpful store_review_not_helpful_review_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review_not_helpful
    ADD CONSTRAINT store_review_not_helpful_review_id_fkey FOREIGN KEY (review_id) REFERENCES public.store_review(id);


--
-- Name: store_review_not_helpful store_review_not_helpful_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review_not_helpful
    ADD CONSTRAINT store_review_not_helpful_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: store_review store_review_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review
    ADD CONSTRAINT store_review_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.store_product(id);


--
-- Name: store_review store_review_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_review
    ADD CONSTRAINT store_review_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: store_size store_size_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_size
    ADD CONSTRAINT store_size_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.store_product(id);


--
-- Name: store_specification store_specification_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_specification
    ADD CONSTRAINT store_specification_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.store_product(id);


--
-- Name: store_tag store_tag_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_tag
    ADD CONSTRAINT store_tag_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.store_category(id);


--
-- Name: store_wishlist store_wishlist_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_wishlist
    ADD CONSTRAINT store_wishlist_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.store_product(id);


--
-- Name: store_wishlist store_wishlist_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_wishlist
    ADD CONSTRAINT store_wishlist_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: token_blacklist_blacklistedtoken token_blacklist_blacklistedtoken_token_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_blacklistedtoken
    ADD CONSTRAINT token_blacklist_blacklistedtoken_token_id_fkey FOREIGN KEY (token_id) REFERENCES public.token_blacklist_outstandingtoken(id);


--
-- Name: token_blacklist_outstandingtoken token_blacklist_outstandingtoken_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token_blacklist_outstandingtoken
    ADD CONSTRAINT token_blacklist_outstandingtoken_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: userauths_profile userauths_profile_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_profile
    ADD CONSTRAINT userauths_profile_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: userauths_user_groups userauths_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_user_groups
    ADD CONSTRAINT userauths_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.auth_group(id);


--
-- Name: userauths_user_groups userauths_user_groups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_user_groups
    ADD CONSTRAINT userauths_user_groups_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: userauths_user_user_permissions userauths_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_user_user_permissions
    ADD CONSTRAINT userauths_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id);


--
-- Name: userauths_user_user_permissions userauths_user_user_permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userauths_user_user_permissions
    ADD CONSTRAINT userauths_user_user_permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- Name: vendor_vendor vendor_vendor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_vendor
    ADD CONSTRAINT vendor_vendor_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.userauths_user(id);


--
-- PostgreSQL database dump complete
--

