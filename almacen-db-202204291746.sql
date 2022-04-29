--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7
-- Dumped by pg_dump version 12.7

-- Started on 2022-04-29 17:46:38

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

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3004 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 268 (class 1255 OID 43509)
-- Name: disminuir_stock(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.disminuir_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 

BEGIN
update productos set stock = stock - new.cantidad WHERE num_sec = new.nsec_prodcuto;
return new;
END
$$;


ALTER FUNCTION public.disminuir_stock() OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 43285)
-- Name: sp_abm_categorias(integer, bigint, character varying, character varying, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_abm_categorias(accion integer, _num_sec bigint, _nombre character varying DEFAULT NULL::character varying, _descripcion character varying DEFAULT NULL::character varying, _estado character DEFAULT NULL::bpchar) RETURNS TABLE(status text, response text, numsec text)
    LANGUAGE plpgsql
    AS $$
declare
    filasAfectadas bigint;
    v_id bigint;
    v_date timestamp;
   	v_dato text;
   	aux_respuesta RECORD;
begin
    case accion	
        -- REGISTRAR
        when 1 then
        begin
            --Valida Datos
            
            --INSERTA DATOS
            insert into categorias(
				nombre
				,descripcion
				,estado
				) 
            values (
				trim(_nombre)
				,trim(_descripcion)
				,'A'
				)
            RETURNING num_sec INTO v_id;		
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Guardar', '0';
                return ;
            end if;
           ---------------------------------------------------
        end;

        --MODIFICAR
      	when 2 then
      	begin
          	--Valida Datos
            
            --ACTUALIZA DATOS
            UPDATE categorias SET 
				nombre = trim(_nombre)
				,descripcion = trim(_descripcion)
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Modificar', '0';	
                return ;
            end if;
           ---------------------------------------------------
        end;
    
        --CAMBIA DE ESTADO
        when 3 then
        begin			
            perform num_sec from categorias where estado = 'BA' and num_sec = _num_sec::bigint limit 1;
            if found then
                return QUERY select 'error', 'El Registro ya ha sido Eliminado', '0';	
                return;
            end if;
            update categorias
            set estado = 'B' 
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
           		return QUERY select 'error', 'El Registro no se pudo Eliminar', '0'; 
                return ;
            end if;
           ---------------------------------------------------
        end;
        else 
            return QUERY select 'error', 'Ninguna Accion coincide', '0';
        
    end case;

    return QUERY select 'success', 'OK', v_id::text;

END;
$$;


ALTER FUNCTION public.sp_abm_categorias(accion integer, _num_sec bigint, _nombre character varying, _descripcion character varying, _estado character) OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 43286)
-- Name: sp_abm_clientes(integer, bigint, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_abm_clientes(accion integer, _num_sec bigint, _nombre character varying DEFAULT NULL::character varying, _tipo_documento character varying DEFAULT NULL::character varying, _num_documento character varying DEFAULT NULL::character varying, _direccion character varying DEFAULT NULL::character varying, _telefono character varying DEFAULT NULL::character varying, _email character varying DEFAULT NULL::character varying) RETURNS TABLE(status text, response text, numsec text)
    LANGUAGE plpgsql
    AS $$
declare
    filasAfectadas bigint;
    v_id bigint;
    v_date timestamp;
   	v_dato text;
   	aux_respuesta RECORD;
begin
    case accion	
        -- REGISTRAR
        when 1 then
        begin
            --Valida Datos
            
            --INSERTA DATOS
            insert into clientes(
				nombre
				,tipo_documento
				,num_documento
				,direccion
				,telefono
				,email
				) 
            values (
				trim(_nombre)
				,trim(_tipo_documento)
				,trim(_num_documento)
				,trim(_direccion)
				,trim(_telefono)
				,trim(_email)
				)
            RETURNING num_sec INTO v_id;		
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Guardar', '0';
                return ;
            end if;
           ---------------------------------------------------
        end;

        --MODIFICAR
      	when 2 then
      	begin
          	--Valida Datos
            
            --ACTUALIZA DATOS
            UPDATE clientes SET 
				nombre = trim(_nombre)
				,tipo_documento = trim(_tipo_documento)
				,num_documento = trim(_num_documento)
				,direccion = trim(_direccion)
				,telefono = trim(_telefono)
				,email = trim(_email)
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Modificar', '0';	
                return ;
            end if;
           ---------------------------------------------------
        end;
    
        --CAMBIA DE ESTADO
        when 3 then
        begin			
            perform num_sec from clientes where estado = 'BA' and num_sec = _num_sec::bigint limit 1;
            if found then
                return QUERY select 'error', 'El Registro ya ha sido Eliminado', '0';	
                return;
            end if;
            update clientes
            set estado = 'BA' 
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
           		return QUERY select 'error', 'El Registro no se pudo Eliminar', '0'; 
                return ;
            end if;
           ---------------------------------------------------
        end;
        else 
            return QUERY select 'error', 'Ninguna Accion coincide', '0';
        
    end case;

   
    return QUERY select 'success', 'OK', v_id::text;

END;
$$;


ALTER FUNCTION public.sp_abm_clientes(accion integer, _num_sec bigint, _nombre character varying, _tipo_documento character varying, _num_documento character varying, _direccion character varying, _telefono character varying, _email character varying) OWNER TO postgres;

--
-- TOC entry 244 (class 1255 OID 43287)
-- Name: sp_abm_detalle_ingresos(integer, bigint, bigint, bigint, integer, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_abm_detalle_ingresos(accion integer, _num_sec bigint, _nsec_ingreso bigint DEFAULT NULL::bigint, _nsec_producto bigint DEFAULT NULL::bigint, _cantidad integer DEFAULT NULL::integer, _precio numeric DEFAULT NULL::numeric) RETURNS TABLE(status text, response text, numsec text)
    LANGUAGE plpgsql
    AS $$
declare
    filasAfectadas bigint;
    v_id bigint;
    v_date timestamp;
   	v_dato text;
   	aux_respuesta RECORD;
begin
    case accion	
        -- REGISTRAR
        when 1 then
        begin
            --Valida Datos
            
            --INSERTA DATOS
            insert into detalle_ingresos(
				nsec_ingreso
				,nsec_producto
				,cantidad
				,precio
				) 
            values (
				_nsec_ingreso:: bigint
				,_nsec_producto:: bigint
				,_cantidad
				,_precio
				)
            RETURNING num_sec INTO v_id;		
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Guardar', '0';
                return ;
            end if;
           ---------------------------------------------------
        end;

        --MODIFICAR
      	when 2 then
      	begin
          	--Valida Datos
            
            --ACTUALIZA DATOS
            UPDATE detalle_ingresos SET 
				nsec_ingreso = _nsec_ingreso:: bigint
				,nsec_producto = _nsec_producto:: bigint
				,cantidad = _cantidad
				,precio = _precio
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Modificar', '0';	
                return ;
            end if;
           ---------------------------------------------------
        end;
    
        --CAMBIA DE ESTADO
        when 3 then
        begin			
            perform num_sec from detalle_ingresos where estado = 'BA' and num_sec = _num_sec::bigint limit 1;
            if found then
                return QUERY select 'error', 'El Registro ya ha sido Eliminado', '0';	
                return;
            end if;
            update detalle_ingresos
            set estado = 'BA' 
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
           		return QUERY select 'error', 'El Registro no se pudo Eliminar', '0'; 
                return ;
            end if;
           ---------------------------------------------------
        end;
        else 
            return QUERY select 'error', 'Ninguna Accion coincide', '0';
        
    end case;

  
    return QUERY select 'success', 'OK', v_id::text;

END;
$$;


ALTER FUNCTION public.sp_abm_detalle_ingresos(accion integer, _num_sec bigint, _nsec_ingreso bigint, _nsec_producto bigint, _cantidad integer, _precio numeric) OWNER TO postgres;

--
-- TOC entry 245 (class 1255 OID 43288)
-- Name: sp_abm_detalle_ventas(integer, bigint, bigint, bigint, integer, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_abm_detalle_ventas(accion integer, _num_sec bigint, _nsec_venta bigint DEFAULT NULL::bigint, _nsec_prodcuto bigint DEFAULT NULL::bigint, _cantidad integer DEFAULT NULL::integer, _precio numeric DEFAULT NULL::numeric, _descuento numeric DEFAULT NULL::numeric) RETURNS TABLE(status text, response text, numsec text)
    LANGUAGE plpgsql
    AS $$
declare
    filasAfectadas bigint;
    v_id bigint;
    v_date timestamp;
   	v_dato text;
   	aux_respuesta RECORD;
begin
    case accion	
        -- REGISTRAR
        when 1 then
        begin
            --Valida Datos
            
            --INSERTA DATOS
            insert into detalle_ventas(
				nsec_venta
				,nsec_prodcuto
				,cantidad
				,precio
				,descuento
				
				) 
            values (
				_nsec_venta:: bigint
				,_nsec_prodcuto:: bigint
				,_cantidad
				,_precio
				,_descuento
				
				)
            RETURNING num_sec INTO v_id;		
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Guardar', '0';
                return ;
            end if;
           ---------------------------------------------------
        end;

        --MODIFICAR
      	when 2 then
      	begin
          	--Valida Datos
            
            --ACTUALIZA DATOS
            UPDATE detalle_ventas SET 
				nsec_venta = _nsec_venta:: bigint
				,nsec_prodcuto = _nsec_prodcuto:: bigint
				,cantidad = _cantidad
				,precio = _precio
				,descuento = _descuento
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Modificar', '0';	
                return ;
            end if;
           ---------------------------------------------------
        end;
    
        --CAMBIA DE ESTADO
        when 3 then
        begin			
            perform num_sec from detalle_ventas where estado = 'BA' and num_sec = _num_sec::bigint limit 1;
            if found then
                return QUERY select 'error', 'El Registro ya ha sido Eliminado', '0';	
                return;
            end if;
            update detalle_ventas
            set estado = 'BA' 
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
           		return QUERY select 'error', 'El Registro no se pudo Eliminar', '0'; 
                return ;
            end if;
           ---------------------------------------------------
        end;
        else 
            return QUERY select 'error', 'Ninguna Accion coincide', '0';
        
    end case;

   
   
    return QUERY select 'success', 'OK', v_id::text;

END;
$$;


ALTER FUNCTION public.sp_abm_detalle_ventas(accion integer, _num_sec bigint, _nsec_venta bigint, _nsec_prodcuto bigint, _cantidad integer, _precio numeric, _descuento numeric) OWNER TO postgres;

--
-- TOC entry 246 (class 1255 OID 43289)
-- Name: sp_abm_facturas(integer, bigint, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_abm_facturas(accion integer, _num_sec bigint, _nsec_cliente integer DEFAULT NULL::integer, _nsec_usuario integer DEFAULT NULL::integer, _nro_factura character varying DEFAULT NULL::character varying) RETURNS TABLE(status text, response text, numsec text)
    LANGUAGE plpgsql
    AS $$
declare
    filasAfectadas bigint;
    v_id bigint;
    v_date timestamp;
   	v_dato text;
   	aux_respuesta RECORD;
begin
    case accion	
        -- REGISTRAR
        when 1 then
        begin
            --Valida Datos
            
            --INSERTA DATOS
            insert into facturas(
				nsec_cliente
				,nsec_usuario
				,nro_factura
				
				) 
            values (
				_nsec_cliente
				,_nsec_usuario
				,trim(_nro_factura)
				
				)
            RETURNING num_sec INTO v_id;		
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Guardar', '0';
                return ;
            end if;
           ---------------------------------------------------
        end;

        --MODIFICAR
      	when 2 then
      	begin
          	--Valida Datos
            
            --ACTUALIZA DATOS
            UPDATE facturas SET 
				nsec_cliente = _nsec_cliente
				,nsec_usuario = _nsec_usuario
				,nro_factura = trim(_nro_factura)
				
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Modificar', '0';	
                return ;
            end if;
           ---------------------------------------------------
        end;
    
        --CAMBIA DE ESTADO
        when 3 then
        begin			
            perform num_sec from facturas where estado = 'BA' and num_sec = _num_sec::bigint limit 1;
            if found then
                return QUERY select 'error', 'El Registro ya ha sido Eliminado', '0';	
                return;
            end if;
            update facturas
            set estado = 'BA' 
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
           		return QUERY select 'error', 'El Registro no se pudo Eliminar', '0'; 
                return ;
            end if;
           ---------------------------------------------------
        end;
        else 
            return QUERY select 'error', 'Ninguna Accion coincide', '0';
        
    end case;

 
   
    return QUERY select 'success', 'OK', v_id::text;

END;
$$;


ALTER FUNCTION public.sp_abm_facturas(accion integer, _num_sec bigint, _nsec_cliente integer, _nsec_usuario integer, _nro_factura character varying) OWNER TO postgres;

--
-- TOC entry 265 (class 1255 OID 43498)
-- Name: sp_abm_ingresos(integer, bigint, bigint, bigint, character varying, character varying, character varying, numeric, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_abm_ingresos(accion integer, _num_sec bigint, _nsec_proveedor bigint, _nsec_ususario bigint, _tipo_comprobante character varying, _serie_comprobante character varying, _num_comprobante character varying, _impuesto numeric, _total_ingresos numeric, _estado character varying) RETURNS TABLE(status text, response text, numsec text)
    LANGUAGE plpgsql
    AS $$
declare
    filasAfectadas bigint;
    v_id bigint;
    v_date timestamp;
   	v_dato text;
   	aux_respuesta RECORD;
begin
    case accion	
        -- REGISTRAR
        when 1 then
        begin
            --Valida Datos
            
            --INSERTA DATOS
            insert into ingresos(
				nsec_proveedor
				,nsec_ususario
				,tipo_comprobante
				,serie_comprobante
				,num_comprobante
				,impuesto
				,total_ingresos
				,estado
				) 
            values (
				_nsec_proveedor:: bigint
				,_nsec_ususario:: bigint
				,trim(_tipo_comprobante)
				,trim(_serie_comprobante)
				,trim(_num_comprobante)
				,_impuesto
				,_total_ingresos
				,'A'
				)
            RETURNING num_sec INTO v_id;		
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Guardar', '0';
                return ;
            end if;
           ---------------------------------------------------
        end;

        --MODIFICAR
      	when 2 then
      	begin
          	--Valida Datos
            
            --ACTUALIZA DATOS
            UPDATE ingresos SET 
				nsec_proveedor = _nsec_proveedor:: bigint
				,nsec_ususario = _nsec_ususario:: bigint
				,tipo_comprobante = trim(_tipo_comprobante)
				,serie_comprobante = trim(_serie_comprobante)
				,num_comprobante = trim(_num_comprobante)
				,impuesto = _impuesto
				,total_ingresos = _total_ingresos
				
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Modificar', '0';	
                return ;
            end if;
           ---------------------------------------------------
        end;
    
        --CAMBIA DE ESTADO
        when 3 then
        begin			
            perform num_sec from ingresos where estado = 'B' and num_sec = _num_sec::bigint limit 1;
            if found then
                return QUERY select 'error', 'El Registro ya ha sido Eliminado', '0';	
                return;
            end if;
            update ingresos
            set estado = 'B' 
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
           		return QUERY select 'error', 'El Registro no se pudo Eliminar', '0'; 
                return ;
            end if;
           ---------------------------------------------------
        end;
        else 
            return QUERY select 'error', 'Ninguna Accion coincide', '0';
        
    end case;

   
    return QUERY select 'success', 'OK', v_id::text;

END;
$$;


ALTER FUNCTION public.sp_abm_ingresos(accion integer, _num_sec bigint, _nsec_proveedor bigint, _nsec_ususario bigint, _tipo_comprobante character varying, _serie_comprobante character varying, _num_comprobante character varying, _impuesto numeric, _total_ingresos numeric, _estado character varying) OWNER TO postgres;

--
-- TOC entry 248 (class 1255 OID 43291)
-- Name: sp_abm_marcas(integer, bigint, character varying, character varying, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_abm_marcas(accion integer, _num_sec bigint, _nombre character varying DEFAULT NULL::character varying, _descripcion character varying DEFAULT NULL::character varying, _estado character DEFAULT NULL::bpchar) RETURNS TABLE(status text, response text, numsec text)
    LANGUAGE plpgsql
    AS $$
declare
    filasAfectadas bigint;
    v_id bigint;
    v_date timestamp;
   	v_dato text;
   	aux_respuesta RECORD;
begin
    case accion	
        -- REGISTRAR
        when 1 then
        begin
            --Valida Datos
            
            --INSERTA DATOS
            insert into marcas(
				nombre
				,descripcion
				,estado
				) 
            values (
				trim(_nombre)
				,trim(_descripcion)
				,'A'
				)
            RETURNING num_sec INTO v_id;		
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Guardar', '0';
                return ;
            end if;
           ---------------------------------------------------
        end;

        --MODIFICAR
      	when 2 then
      	begin
          	--Valida Datos
            
            --ACTUALIZA DATOS
            UPDATE marcas SET 
				nombre = trim(_nombre)
				,descripcion = trim(_descripcion)
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Modificar', '0';	
                return ;
            end if;
           ---------------------------------------------------
        end;
    
        --CAMBIA DE ESTADO
        when 3 then
        begin			
            perform num_sec from marcas where estado = 'B' and num_sec = _num_sec::bigint limit 1;
            if found then
                return QUERY select 'error', 'El Registro ya ha sido Eliminado', '0';	
                return;
            end if;
            update marcas
            set estado = 'B' 
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
           		return QUERY select 'error', 'El Registro no se pudo Eliminar', '0'; 
                return ;
            end if;
           ---------------------------------------------------
        end;
        else 
            return QUERY select 'error', 'Ninguna Accion coincide', '0';
        
    end case;

   
    return QUERY select 'success', 'OK', v_id::text;

END;
$$;


ALTER FUNCTION public.sp_abm_marcas(accion integer, _num_sec bigint, _nombre character varying, _descripcion character varying, _estado character) OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 43292)
-- Name: sp_abm_personas(integer, bigint, bigint, character varying, character varying, character varying, character varying, character varying, character varying, text, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_abm_personas(accion integer, _num_sec bigint, _nsec_rol bigint DEFAULT NULL::bigint, _nombre character varying DEFAULT NULL::character varying, _tipo_documento character varying DEFAULT NULL::character varying, _num_documento character varying DEFAULT NULL::character varying, _direccion character varying DEFAULT NULL::character varying, _telefono character varying DEFAULT NULL::character varying, _email character varying DEFAULT NULL::character varying, _password text DEFAULT NULL::text, _estado character DEFAULT NULL::bpchar) RETURNS TABLE(status text, response text, numsec text)
    LANGUAGE plpgsql
    AS $$
declare
    filasAfectadas bigint;
    v_id bigint;
    v_date timestamp;
   	v_dato text;
   	aux_respuesta RECORD;
begin
    case accion	
        -- REGISTRAR
        when 1 then
        begin
            --Valida Datos
            
            --INSERTA DATOS
            insert into personas(
				nsec_rol
				,nombre
				,tipo_documento
				,num_documento
				,direccion
				,telefono
				,email
				,password
				,estado
				) 
            values (
				_nsec_rol:: bigint
				,trim(_nombre)
				,trim(_tipo_documento)
				,trim(_num_documento)
				,trim(_direccion)
				,trim(_telefono)
				,trim(_email)
				,_password
				,'A'
				)
            RETURNING num_sec INTO v_id;		
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Guardar', '0';
                return ;
            end if;
           ---------------------------------------------------
        end;

        --MODIFICAR
      	when 2 then
      	begin
          	--Valida Datos
            
            --ACTUALIZA DATOS
            UPDATE personas SET 
				nsec_rol = _nsec_rol:: bigint
				,nombre = trim(_nombre)
				,tipo_documento = trim(_tipo_documento)
				,num_documento = trim(_num_documento)
				,direccion = trim(_direccion)
				,telefono = trim(_telefono)
				,email = trim(_email)
				,password = _password
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Modificar', '0';	
                return ;
            end if;
           ---------------------------------------------------
        end;
    
        --CAMBIA DE ESTADO
        when 3 then
        begin			
            perform num_sec from personas where estado = 'B' and num_sec = _num_sec::bigint limit 1;
            if found then
                return QUERY select 'error', 'El Registro ya ha sido Eliminado', '0';	
                return;
            end if;
            update personas
            set estado = 'B' 
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
           		return QUERY select 'error', 'El Registro no se pudo Eliminar', '0'; 
                return ;
            end if;
           ---------------------------------------------------
        end;
        else 
            return QUERY select 'error', 'Ninguna Accion coincide', '0';
        
    end case;


   
    return QUERY select 'success', 'OK', v_id::text;

END;
$$;


ALTER FUNCTION public.sp_abm_personas(accion integer, _num_sec bigint, _nsec_rol bigint, _nombre character varying, _tipo_documento character varying, _num_documento character varying, _direccion character varying, _telefono character varying, _email character varying, _password text, _estado character) OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 43293)
-- Name: sp_abm_productos(integer, bigint, bigint, bigint, text, text, character varying, numeric, integer, character varying, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_abm_productos(accion integer, _num_sec bigint, _nsec_categoria bigint DEFAULT NULL::bigint, _nsec_marca bigint DEFAULT NULL::bigint, _codigo text DEFAULT NULL::text, _ruta text DEFAULT NULL::text, _nombre character varying DEFAULT NULL::character varying, _precio_venta numeric DEFAULT NULL::numeric, _stock integer DEFAULT NULL::integer, _descripcion character varying DEFAULT NULL::character varying, _estado character DEFAULT NULL::bpchar) RETURNS TABLE(status text, response text, numsec text)
    LANGUAGE plpgsql
    AS $$
declare
    filasAfectadas bigint;
    v_id bigint;
    v_date timestamp;
   	v_dato text;
   	aux_respuesta RECORD;
begin
    case accion	
        -- REGISTRAR
        when 1 then
        begin
            --Valida Datos
            
            --INSERTA DATOS
            insert into productos(
				nsec_categoria
				,nsec_marca
				,codigo
				,ruta
				,nombre
				,precio_venta
				,stock
				,descripcion
				,estado
				) 
            values (
				_nsec_categoria:: bigint
				,_nsec_marca:: bigint
				,_codigo
				,_ruta
				,trim(_nombre)
				,_precio_venta
				,_stock
				,trim(_descripcion)
				,'A'
				)
            RETURNING num_sec INTO v_id;		
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Guardar', '0';
                return ;
            end if;
           ---------------------------------------------------
        end;

        --MODIFICAR
      	when 2 then
      	begin
          	--Valida Datos
            
            --ACTUALIZA DATOS
            UPDATE productos SET 
				nsec_categoria = _nsec_categoria:: bigint
				,nsec_marca = _nsec_marca:: bigint
				,codigo = _codigo
				,ruta = _ruta
				,nombre = trim(_nombre)
				,precio_venta = _precio_venta
				,stock = _stock
				,descripcion = trim(_descripcion)
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Modificar', '0';	
                return ;
            end if;
           ---------------------------------------------------
        end;
    
        --CAMBIA DE ESTADO
        when 3 then
        begin			
            perform num_sec from productos where estado = 'B' and num_sec = _num_sec::bigint limit 1;
            if found then
                return QUERY select 'error', 'El Registro ya ha sido Eliminado', '0';	
                return;
            end if;
            update productos
            set estado = 'B' 
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
           		return QUERY select 'error', 'El Registro no se pudo Eliminar', '0'; 
                return ;
            end if;
           ---------------------------------------------------
        end;
        else 
            return QUERY select 'error', 'Ninguna Accion coincide', '0';
        
    end case;


   
    return QUERY select 'success', 'OK', v_id::text;

END;
$$;


ALTER FUNCTION public.sp_abm_productos(accion integer, _num_sec bigint, _nsec_categoria bigint, _nsec_marca bigint, _codigo text, _ruta text, _nombre character varying, _precio_venta numeric, _stock integer, _descripcion character varying, _estado character) OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 43294)
-- Name: sp_abm_rol(integer, bigint, character varying, character varying, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_abm_rol(accion integer, _num_sec bigint, _nombre character varying DEFAULT NULL::character varying, _descripcion character varying DEFAULT NULL::character varying, _estado character DEFAULT NULL::bpchar) RETURNS TABLE(status text, response text, numsec text)
    LANGUAGE plpgsql
    AS $$
declare
    filasAfectadas bigint;
    v_id bigint;
    v_date timestamp;
   	v_dato text;
   	aux_respuesta RECORD;
begin
    case accion	
        -- REGISTRAR
        when 1 then
        begin
            --Valida Datos
            
            --INSERTA DATOS
            insert into rol(
				nombre
				,descripcion
				,estado
				) 
            values (
				trim(_nombre)
				,trim(_descripcion)
				,'A'
				)
            RETURNING num_sec INTO v_id;		
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Guardar', '0';
                return ;
            end if;
           ---------------------------------------------------
        end;

        --MODIFICAR
      	when 2 then
      	begin
          	--Valida Datos
            
            --ACTUALIZA DATOS
            UPDATE rol SET 
				nombre = trim(_nombre)
				,descripcion = trim(_descripcion)
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Modificar', '0';	
                return ;
            end if;
           ---------------------------------------------------
        end;
    
        --CAMBIA DE ESTADO
        when 3 then
        begin			
            perform num_sec from rol where estado = 'B' and num_sec = _num_sec::bigint limit 1;
            if found then
                return QUERY select 'error', 'El Registro ya ha sido Eliminado', '0';	
                return;
            end if;
            update rol
            set estado = 'B' 
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
           		return QUERY select 'error', 'El Registro no se pudo Eliminar', '0'; 
                return ;
            end if;
           ---------------------------------------------------
        end;
        else 
            return QUERY select 'error', 'Ninguna Accion coincide', '0';
        
    end case;

   
   
    return QUERY select 'success', 'OK', v_id::text;

END;
$$;


ALTER FUNCTION public.sp_abm_rol(accion integer, _num_sec bigint, _nombre character varying, _descripcion character varying, _estado character) OWNER TO postgres;

--
-- TOC entry 254 (class 1255 OID 43295)
-- Name: sp_abm_ventas(integer, bigint, integer, integer, character varying, character varying, character varying, numeric, numeric, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_abm_ventas(accion integer, _num_sec bigint, _nsec_cliente integer DEFAULT NULL::integer, _nsec_usuario integer DEFAULT NULL::integer, _tipo_comprobante character varying DEFAULT NULL::character varying, _serie_comprobante character varying DEFAULT NULL::character varying, _num_comprobante character varying DEFAULT NULL::character varying, _impuesto numeric DEFAULT NULL::numeric, _total_venta numeric DEFAULT NULL::numeric, _estado character varying DEFAULT NULL::character varying) RETURNS TABLE(status text, response text, numsec text)
    LANGUAGE plpgsql
    AS $$
declare
    filasAfectadas bigint;
    v_id bigint;
    v_date timestamp;
   	v_dato text;
   	aux_respuesta RECORD;
begin
    case accion	
        -- REGISTRAR
        when 1 then
        begin
            --Valida Datos
            
            --INSERTA DATOS
            insert into ventas(
				nsec_cliente
				,nsec_usuario
				,tipo_comprobante
				,serie_comprobante
				,num_comprobante
				,impuesto
				,total_venta
				,estado
				) 
            values (
				_nsec_cliente
				,_nsec_usuario
				,trim(_tipo_comprobante)
				,trim(_serie_comprobante)
				,trim(_num_comprobante)
				,_impuesto
				,_total_venta
				,'A'
				)
            RETURNING num_sec INTO v_id;		
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Guardar', '0';
                return ;
            end if;
           ---------------------------------------------------
        end;

        --MODIFICAR
      	when 2 then
      	begin
          	--Valida Datos
            
            --ACTUALIZA DATOS
            UPDATE ventas SET 
				nsec_cliente = _nsec_cliente
				,nsec_usuario = _nsec_usuario
				,tipo_comprobante = trim(_tipo_comprobante)
				,serie_comprobante = trim(_serie_comprobante)
				,num_comprobante = trim(_num_comprobante)
				,impuesto = _impuesto
				,total_venta = _total_venta
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
                return QUERY select 'error', 'El Registro no se pudo Modificar', '0';	
                return ;
            end if;
           ---------------------------------------------------
        end;
    
        --CAMBIA DE ESTADO
        when 3 then
        begin			
            perform num_sec from ventas where estado = 'B' and num_sec = _num_sec::bigint limit 1;
            if found then
                return QUERY select 'error', 'El Registro ya ha sido Eliminado', '0';	
                return;
            end if;
            update ventas
            set estado = 'B' 
		where num_sec = _num_sec::bigint;			
            v_id:= _num_sec;
            ------Valida si se afectaron filas----------------
            GET DIAGNOSTICS filasAfectadas = ROW_COUNT;	
            if filasAfectadas = 0 then
           		return QUERY select 'error', 'El Registro no se pudo Eliminar', '0'; 
                return ;
            end if;
           ---------------------------------------------------
        end;
        else 
            return QUERY select 'error', 'Ninguna Accion coincide', '0';
        
    end case;


   
    return QUERY select 'success', 'OK', v_id::text;

END;
$$;


ALTER FUNCTION public.sp_abm_ventas(accion integer, _num_sec bigint, _nsec_cliente integer, _nsec_usuario integer, _tipo_comprobante character varying, _serie_comprobante character varying, _num_comprobante character varying, _impuesto numeric, _total_venta numeric, _estado character varying) OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 43296)
-- Name: sp_listado_categorias(character varying, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_listado_categorias(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) RETURNS TABLE(num_sec bigint, nombre character varying, descripcion character varying, estado character, created_at timestamp without time zone, updated_at timestamp without time zone, total bigint)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
begin
	--Si se trata de una busqueda con un parametro y valor variable
	
	sql = 'select 
		c.num_sec
		,c.nombre
		,c.descripcion
		,c.estado
		,c.created_at
		,c.updated_at
		,count(*) over () as total
		from categorias c 
		where estado in (''A'')';
	sql = sql || ' and upper(cast('|| parametro_bus ||' as varchar)) like ' || '''' || '%' || upper(valor_bus) || '%' || '''';
	
	sql = sql || ' order by num_sec ASC';
	
	if cantidadmostrar >  0 then
	sql = sql || ' limit ' || cantidadMostrar || ' offset ' || cantidadMostrar*numeroPaginaActual;
	end if;

	

	-- 	raise notice 'Value: %', sql;
	
	RETURN QUERY EXECUTE sql;
	
end
$$;


ALTER FUNCTION public.sp_listado_categorias(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 43297)
-- Name: sp_listado_clientes(character varying, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_listado_clientes(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) RETURNS TABLE(num_sec bigint, nombre character varying, tipo_documento character varying, num_documento character varying, direccion character varying, telefono character varying, email character varying, created_at timestamp without time zone, updated_at timestamp without time zone, total bigint)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
begin
	--Si se trata de una busqueda con un parametro y valor variable
	
	sql = 'select 
		c.num_sec
		,c.nombre
		,c.tipo_documento
		,c.num_documento
		,c.direccion
		,c.telefono
		,c.email
		,c.created_at
		,c.updated_at
		,count(*) over () as total
		from clientes c 
		where ';
	sql = sql || '  upper(cast('|| parametro_bus ||' as varchar)) like ' || '''' || '%' || upper(valor_bus) || '%' || '''';
	
	sql = sql || ' order by num_sec ASC';
	
	if cantidadmostrar >  0 then
	sql = sql || ' limit ' || cantidadMostrar || ' offset ' || cantidadMostrar*numeroPaginaActual;
	end if;

	

	-- 	raise notice 'Value: %', sql;
	
	RETURN QUERY EXECUTE sql;
	
end
$$;


ALTER FUNCTION public.sp_listado_clientes(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) OWNER TO postgres;

--
-- TOC entry 267 (class 1255 OID 43503)
-- Name: sp_listado_detalle_ingresos(character varying, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_listado_detalle_ingresos(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) RETURNS TABLE(num_sec bigint, nsec_ingreso bigint, nsec_producto bigint, cantidad integer, precio numeric, nombre character varying, created_at timestamp without time zone, updated_at timestamp without time zone, total bigint)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
begin
	--Si se trata de una busqueda con un parametro y valor variable
	
	sql = 'select 
		d.num_sec
		,d.nsec_ingreso
		,d.nsec_producto
		,d.cantidad
		,d.precio
	    ,p.nombre
		,d.created_at
		,d.updated_at
		,count(*) over () as total
		from detalle_ingresos d join productos p on p.num_sec = d.nsec_producto 
		where ';
	sql = sql || '  upper(cast('|| parametro_bus ||' as varchar)) like ' || '''' || '%' || upper(valor_bus) || '%' || '''';
	
	sql = sql || ' order by num_sec ASC';
	
	if cantidadmostrar >  0 then
	sql = sql || ' limit ' || cantidadMostrar || ' offset ' || cantidadMostrar*numeroPaginaActual;
	end if;

	

	-- 	raise notice 'Value: %', sql;
	
	RETURN QUERY EXECUTE sql;
	
end
$$;


ALTER FUNCTION public.sp_listado_detalle_ingresos(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 43299)
-- Name: sp_listado_detalle_ventas(character varying, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_listado_detalle_ventas(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) RETURNS TABLE(num_sec bigint, nsec_venta bigint, nsec_prodcuto bigint, cantidad integer, precio numeric, descuento numeric, created_at timestamp without time zone, updated_at timestamp without time zone, total bigint)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
begin
	--Si se trata de una busqueda con un parametro y valor variable
	
	sql = 'select 
		d.num_sec
		,d.nsec_venta
		,d.nsec_prodcuto
		,d.cantidad
		,d.precio
		,d.descuento
		,d.created_at
		,d.updated_at
		,count(*) over () as total
		from detalle_ventas d 
		where  ';
	sql = sql || ' and upper(cast('|| parametro_bus ||' as varchar)) like ' || '''' || '%' || upper(valor_bus) || '%' || '''';
	
	sql = sql || ' order by num_sec ASC';
	
	if cantidadmostrar >  0 then
	sql = sql || ' limit ' || cantidadMostrar || ' offset ' || cantidadMostrar*numeroPaginaActual;
	end if;

	

	-- 	raise notice 'Value: %', sql;
	
	RETURN QUERY EXECUTE sql;
	
end
$$;


ALTER FUNCTION public.sp_listado_detalle_ventas(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) OWNER TO postgres;

--
-- TOC entry 247 (class 1255 OID 43300)
-- Name: sp_listado_facturas(character varying, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_listado_facturas(valor_bus character varying, parametro_bus character varying DEFAULT ''::character varying, numeropaginaactual integer DEFAULT 0, cantidadmostrar integer DEFAULT 0) RETURNS TABLE(num_sec bigint, nsec_cliente integer, nsec_usuario integer, nro_factura character varying, total bigint)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
begin
	--Si se trata de una busqueda con un parametro y valor variable
	
	sql = 'select 
		f.num_sec
		,f.nsec_cliente
		,f.nsec_usuario
		,f.nro_factura
		,f.created_at
		,f.updated_at
		,count(*) over () as total
		from facturas f 
		where ';
	sql = sql || '  upper(cast('|| parametro_bus ||' as varchar)) like ' || '''' || '%' || upper(valor_bus) || '%' || '''';
	
	sql = sql || ' order by num_sec ASC';
	
	if cantidadmostrar >  0 then
	sql = sql || ' limit ' || cantidadMostrar || ' offset ' || cantidadMostrar*numeroPaginaActual;
	end if;

	

	-- 	raise notice 'Value: %', sql;
	
	RETURN QUERY EXECUTE sql;
	
end
$$;


ALTER FUNCTION public.sp_listado_facturas(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) OWNER TO postgres;

--
-- TOC entry 266 (class 1255 OID 43502)
-- Name: sp_listado_ingresos(character varying, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_listado_ingresos(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) RETURNS TABLE(num_sec bigint, nsec_proveedor bigint, proveedor character varying, nsec_ususario bigint, usuario character varying, tipo_comprobante character varying, serie_comprobante character varying, num_comprobante character varying, impuesto numeric, total_ingresos numeric, estado character varying, created_at timestamp without time zone, total bigint)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
begin
	--Si se trata de una busqueda con un parametro y valor variable
	
	sql = 'select 
		i.num_sec
		,i.nsec_proveedor
		,p.nombre  as proveedor
		,i.nsec_ususario
		,p2.nombre as usuario
		,i.tipo_comprobante
		,i.serie_comprobante
		,i.num_comprobante
		,i.impuesto
		,i.total_ingresos
		,i.estado
		,i.created_at
		,count(*) over () as total
		from ingresos i join personas p on p.num_sec = i.nsec_proveedor join personas p2 on p2.num_sec = i.nsec_ususario 
		where i.estado in (''A'')';
	sql = sql || ' and upper(cast('|| parametro_bus ||' as varchar)) like ' || '''' || '%' || upper(valor_bus) || '%' || '''';
	
	sql = sql || ' order by i.num_sec ASC';
	
	if cantidadmostrar >  0 then
	sql = sql || ' limit ' || cantidadMostrar || ' offset ' || cantidadMostrar*numeroPaginaActual;
	end if;

	

	-- 	raise notice 'Value: %', sql;
	
	RETURN QUERY EXECUTE sql;
	
end
$$;


ALTER FUNCTION public.sp_listado_ingresos(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) OWNER TO postgres;

--
-- TOC entry 258 (class 1255 OID 43302)
-- Name: sp_listado_marcas(character varying, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_listado_marcas(valor_bus character varying, parametro_bus character varying DEFAULT ''::character varying, numeropaginaactual integer DEFAULT 0, cantidadmostrar integer DEFAULT 0) RETURNS TABLE(num_sec bigint, nombre character varying, descripcion character varying, estado character, total bigint)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
begin
	--Si se trata de una busqueda con un parametro y valor variable
	
	sql = 'select 
		m.num_sec
		,m.nombre
		,m.descripcion
		,m.estado
		,count(*) over () as total
		from marcas m 
		where estado in (''A'')';
	sql = sql || ' and upper(cast('|| parametro_bus ||' as varchar)) like ' || '''' || '%' || upper(valor_bus) || '%' || '''';
	
	sql = sql || ' order by num_sec ASC';
	
	if cantidadmostrar >  0 then
	sql = sql || ' limit ' || cantidadMostrar || ' offset ' || cantidadMostrar*numeroPaginaActual;
	end if;

	

	-- 	raise notice 'Value: %', sql;
	
	RETURN QUERY EXECUTE sql;
	
end
$$;


ALTER FUNCTION public.sp_listado_marcas(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 43303)
-- Name: sp_listado_productos(character varying, character, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_listado_productos(valor_bus character varying, parametro_bus character, numeropaginaactual integer, cantidadmostrar integer) RETURNS TABLE(num_sec bigint, nsec_categoria bigint, categoria character varying, nsec_marca bigint, marca character varying, codigo text, ruta text, nombre character varying, precio_venta numeric, stock integer, descripcion character varying, estado character, total bigint)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
begin
	--Si se trata de una busqueda con un parametro y valor variable
	
	sql = 'select 
		p.num_sec
		,p.nsec_categoria
		,c.nombre as categoria
		,p.nsec_marca
		,m.nombre  as marca
		,p.codigo
		,p.ruta
		,p.nombre
		,p.precio_venta
		,p.stock
		,p.descripcion
		,p.estado
		,count(*) over () as total
		from productos p join marcas m on m.num_sec = p.nsec_marca join categorias c on c.num_sec = p.nsec_categoria 
		where p.estado in (''A'')';
	sql = sql || ' and upper(cast('|| parametro_bus ||' as varchar)) like ' || '''' || '%' || upper(valor_bus) || '%' || '''';
	
	sql = sql || ' order by num_sec ASC';
	
	if cantidadmostrar >  0 then
	sql = sql || ' limit ' || cantidadMostrar || ' offset ' || cantidadMostrar*numeroPaginaActual;
	end if;

	

	-- 	raise notice 'Value: %', sql;
	
	RETURN QUERY EXECUTE sql;
	
end
$$;


ALTER FUNCTION public.sp_listado_productos(valor_bus character varying, parametro_bus character, numeropaginaactual integer, cantidadmostrar integer) OWNER TO postgres;

--
-- TOC entry 260 (class 1255 OID 43304)
-- Name: sp_listado_rol(character varying, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_listado_rol(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) RETURNS TABLE(num_sec bigint, nombre character varying, descripcion character varying, estado character, total bigint)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
begin
	--Si se trata de una busqueda con un parametro y valor variable
	
	sql = 'select 
		r.num_sec
		,r.nombre
		,r.descripcion
		,r.estado
		,count(*) over () as total
		from rol r 
		where estado in (''A'')';
	sql = sql || ' and upper(cast('|| parametro_bus ||' as varchar)) like ' || '''' || '%' || upper(valor_bus) || '%' || '''';
	
	sql = sql || ' order by num_sec ASC';
	
	if cantidadmostrar >  0 then
	sql = sql || ' limit ' || cantidadMostrar || ' offset ' || cantidadMostrar*numeroPaginaActual;
	end if;

	

	-- 	raise notice 'Value: %', sql;
	
	RETURN QUERY EXECUTE sql;
	
end
$$;


ALTER FUNCTION public.sp_listado_rol(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) OWNER TO postgres;

--
-- TOC entry 261 (class 1255 OID 43305)
-- Name: sp_listado_ventas(character varying, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_listado_ventas(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) RETURNS TABLE(num_sec bigint, nsec_cliente integer, nsec_usuario integer, tipo_comprobante character varying, serie_comprobante character varying, num_comprobante character varying, impuesto numeric, total_venta numeric, estado character varying, total bigint)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
begin
	--Si se trata de una busqueda con un parametro y valor variable
	
	sql = 'select 
		v.num_sec
		,v.nsec_cliente
		,v.nsec_usuario
		,v.tipo_comprobante
		,v.serie_comprobante
		,v.num_comprobante
		,v.impuesto
		,v.total_venta
		,v.estado
		,count(*) over () as total
		from ventas v 
		where estado in (''A'')';
	sql = sql || ' and upper(cast('|| parametro_bus ||' as varchar)) like ' || '''' || '%' || upper(valor_bus) || '%' || '''';
	
	sql = sql || ' order by num_sec ASC';
	
	if cantidadmostrar >  0 then
	sql = sql || ' limit ' || cantidadMostrar || ' offset ' || cantidadMostrar*numeroPaginaActual;
	end if;

	

	-- 	raise notice 'Value: %', sql;
	
	RETURN QUERY EXECUTE sql;
	
end
$$;


ALTER FUNCTION public.sp_listado_ventas(valor_bus character varying, parametro_bus character varying, numeropaginaactual integer, cantidadmostrar integer) OWNER TO postgres;

--
-- TOC entry 262 (class 1255 OID 43306)
-- Name: sp_traer_categorias(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_traer_categorias(_num_sec bigint) RETURNS TABLE(num_sec bigint, nombre character varying, descripcion character varying, estado character, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
BEGIN
	
	RETURN QUERY 
	select
		c.num_sec
		,c.nombre
		,c.descripcion
		,c.estado
		,c.created_at
		,c.updated_at
	from categorias c
	where c.num_sec = _num_sec::bigint;
end;
$$;


ALTER FUNCTION public.sp_traer_categorias(_num_sec bigint) OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 43307)
-- Name: sp_traer_clientes(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_traer_clientes(_num_sec bigint) RETURNS TABLE(num_sec bigint, nombre character varying, tipo_documento character varying, num_documento character varying, direccion character varying, telefono character varying, email character varying)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
BEGIN
	
	RETURN QUERY 
	select
		c.num_sec
		,c.nombre
		,c.tipo_documento
		,c.num_documento
		,c.direccion
		,c.telefono
		,c.email
	from clientes c
	where c.num_sec = _num_sec::bigint;
end;
$$;


ALTER FUNCTION public.sp_traer_clientes(_num_sec bigint) OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 43308)
-- Name: sp_traer_detalle_ingresos(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_traer_detalle_ingresos(_num_sec bigint) RETURNS TABLE(num_sec bigint, nsec_ingreso bigint, nsec_producto bigint, cantidad integer, precio numeric)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
BEGIN
	
	RETURN QUERY 
	select
		d.num_sec
		,d.nsec_ingreso
		,d.nsec_producto
		,d.cantidad
		,d.precio
	from detalle_ingresos d
	where d.num_sec = _num_sec::bigint;
end;
$$;


ALTER FUNCTION public.sp_traer_detalle_ingresos(_num_sec bigint) OWNER TO postgres;

--
-- TOC entry 252 (class 1255 OID 43309)
-- Name: sp_traer_detalle_ventas(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_traer_detalle_ventas(_num_sec bigint) RETURNS TABLE(num_sec bigint, nsec_venta bigint, nsec_prodcuto bigint, cantidad integer, precio numeric, descuento numeric)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
BEGIN
	
	RETURN QUERY 
	select
		d.num_sec
		,d.nsec_venta
		,d.nsec_prodcuto
		,d.cantidad
		,d.precio
		,d.descuento
	from detalle_ventas d
	where d.num_sec = _num_sec::bigint;
end;
$$;


ALTER FUNCTION public.sp_traer_detalle_ventas(_num_sec bigint) OWNER TO postgres;

--
-- TOC entry 224 (class 1255 OID 43310)
-- Name: sp_traer_facturas(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_traer_facturas(_num_sec bigint) RETURNS TABLE(num_sec bigint, nsec_cliente integer, nsec_usuario integer, nro_factura character varying, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
BEGIN
	
	RETURN QUERY 
	select
		f.num_sec
		,f.nsec_cliente
		,f.nsec_usuario
		,f.nro_factura
		,f.created_at
		,f.updated_at
	from facturas f
	where f.num_sec = _num_sec::bigint;
end;
$$;


ALTER FUNCTION public.sp_traer_facturas(_num_sec bigint) OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 43311)
-- Name: sp_traer_ingresos(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_traer_ingresos(_num_sec bigint) RETURNS TABLE(num_sec bigint, nsec_proveedor bigint, nsec_ususario bigint, tipo_comprobante character varying, serie_comprobante character varying, num_comprobante character varying, impuesto numeric, total_ingresos numeric, estado character varying)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
BEGIN
	
	RETURN QUERY 
	select
		i.num_sec
		,i.nsec_proveedor
		,i.nsec_ususario
		,i.tipo_comprobante
		,i.serie_comprobante
		,i.num_comprobante
		,i.impuesto
		,i.total_ingresos
		,i.estado
	from ingresos i
	where i.num_sec = _num_sec::bigint;
end;
$$;


ALTER FUNCTION public.sp_traer_ingresos(_num_sec bigint) OWNER TO postgres;

--
-- TOC entry 226 (class 1255 OID 43312)
-- Name: sp_traer_marcas(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_traer_marcas(_num_sec bigint) RETURNS TABLE(num_sec bigint, nombre character varying, descripcion character varying, estado character, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
BEGIN
	
	RETURN QUERY 
	select
		m.num_sec
		,m.nombre
		,m.descripcion
		,m.estado
		,m.created_at
		,m.updated_at
	from marcas m
	where m.num_sec = _num_sec::bigint;
end;
$$;


ALTER FUNCTION public.sp_traer_marcas(_num_sec bigint) OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 43313)
-- Name: sp_traer_personas(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_traer_personas(_num_sec bigint) RETURNS TABLE(num_sec bigint, nsec_rol bigint, nombre character varying, tipo_documento character varying, num_documento character varying, direccion character varying, telefono character varying, email character varying, password text, estado character, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
BEGIN
	
	RETURN QUERY 
	select
		p.num_sec
		,p.nsec_rol
		,p.nombre
		,p.tipo_documento
		,p.num_documento
		,p.direccion
		,p.telefono
		,p.email
		,p.password
		,p.estado
		,p.created_at
		,p.updated_at
	from personas p
	where p.num_sec = _num_sec::bigint;
end;
$$;


ALTER FUNCTION public.sp_traer_personas(_num_sec bigint) OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 43314)
-- Name: sp_traer_productos(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_traer_productos(_num_sec bigint) RETURNS TABLE(num_sec bigint, nsec_categoria bigint, nsec_marca bigint, codigo text, ruta text, nombre character varying, precio_venta numeric, stock integer, descripcion character varying, estado character, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
BEGIN
	
	RETURN QUERY 
	select
		p.num_sec
		,p.nsec_categoria
		,p.nsec_marca
		,p.codigo
		,p.ruta
		,p.nombre
		,p.precio_venta
		,p.stock
		,p.descripcion
		,p.estado
		,p.created_at
		,p.updated_at
	from productos p
	where p.num_sec = _num_sec::bigint;
end;
$$;


ALTER FUNCTION public.sp_traer_productos(_num_sec bigint) OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 43315)
-- Name: sp_traer_rol(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_traer_rol(_num_sec bigint) RETURNS TABLE(num_sec bigint, nombre character varying, descripcion character varying, estado character, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
BEGIN
	
	RETURN QUERY 
	select
		r.num_sec
		,r.nombre
		,r.descripcion
		,r.estado
		,r.created_at
		,r.updated_at
	from rol r
	where r.num_sec = _num_sec::bigint;
end;
$$;


ALTER FUNCTION public.sp_traer_rol(_num_sec bigint) OWNER TO postgres;

--
-- TOC entry 264 (class 1255 OID 43316)
-- Name: sp_traer_ventas(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_traer_ventas(_num_sec bigint) RETURNS TABLE(num_sec bigint, nsec_cliente integer, nsec_usuario integer, tipo_comprobante character varying, serie_comprobante character varying, num_comprobante character varying, impuesto numeric, total_venta numeric, estado character varying, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
declare
	sql VARCHAR;
BEGIN
	
	RETURN QUERY 
	select
		v.num_sec
		,v.nsec_cliente
		,v.nsec_usuario
		,v.tipo_comprobante
		,v.serie_comprobante
		,v.num_comprobante
		,v.impuesto
		,v.total_venta
		,v.estado
		,v.created_at
		,v.updated_at
	from ventas v
	where v.num_sec = _num_sec::bigint;
end;
$$;


ALTER FUNCTION public.sp_traer_ventas(_num_sec bigint) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 202 (class 1259 OID 43317)
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    num_sec bigint NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(256),
    estado character(1) DEFAULT 'A'::bpchar,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 43323)
-- Name: categorias_num_sec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.categorias ALTER COLUMN num_sec ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.categorias_num_sec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 204 (class 1259 OID 43325)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    num_sec bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo_documento character varying(20),
    num_documento character varying(20),
    direccion character varying(70),
    telefono character varying(20),
    email character varying(50),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 43330)
-- Name: clientes_num_sec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.clientes ALTER COLUMN num_sec ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.clientes_num_sec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 206 (class 1259 OID 43332)
-- Name: detalle_ingresos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_ingresos (
    num_sec bigint NOT NULL,
    nsec_ingreso bigint NOT NULL,
    nsec_producto bigint NOT NULL,
    cantidad integer NOT NULL,
    precio numeric(11,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.detalle_ingresos OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 43337)
-- Name: detalle_ingresos_num_sec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.detalle_ingresos ALTER COLUMN num_sec ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.detalle_ingresos_num_sec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 208 (class 1259 OID 43339)
-- Name: detalle_ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalle_ventas (
    num_sec bigint NOT NULL,
    nsec_venta bigint NOT NULL,
    nsec_prodcuto bigint NOT NULL,
    cantidad integer NOT NULL,
    precio numeric(11,2) NOT NULL,
    descuento numeric(11,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.detalle_ventas OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 43344)
-- Name: detalle_ventas_num_sec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.detalle_ventas ALTER COLUMN num_sec ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.detalle_ventas_num_sec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 210 (class 1259 OID 43346)
-- Name: facturas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facturas (
    num_sec bigint NOT NULL,
    nsec_cliente integer NOT NULL,
    nsec_usuario integer NOT NULL,
    nro_factura character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.facturas OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 43351)
-- Name: facturas_num_sec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.facturas ALTER COLUMN num_sec ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.facturas_num_sec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 212 (class 1259 OID 43353)
-- Name: ingresos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingresos (
    num_sec bigint NOT NULL,
    nsec_proveedor bigint NOT NULL,
    nsec_ususario bigint NOT NULL,
    tipo_comprobante character varying(20) NOT NULL,
    serie_comprobante character varying(7),
    num_comprobante character varying(10) NOT NULL,
    impuesto numeric(4,2) NOT NULL,
    total_ingresos numeric(11,2) NOT NULL,
    estado character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ingresos OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 43358)
-- Name: ingresos_num_sec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ingresos ALTER COLUMN num_sec ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ingresos_num_sec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 214 (class 1259 OID 43360)
-- Name: marcas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marcas (
    num_sec bigint NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(256),
    estado character(1) DEFAULT 'A'::bpchar,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.marcas OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 43366)
-- Name: marcas_num_sec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.marcas ALTER COLUMN num_sec ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.marcas_num_sec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 43368)
-- Name: personas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personas (
    num_sec bigint NOT NULL,
    nsec_rol bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo_documento character varying(20),
    num_documento character varying(20),
    direccion character varying(70),
    telefono character varying(20),
    email character varying(50) NOT NULL,
    password text NOT NULL,
    estado character(1) DEFAULT 'A'::bpchar,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.personas OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 43377)
-- Name: personas_num_sec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.personas ALTER COLUMN num_sec ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.personas_num_sec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 43379)
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    num_sec bigint NOT NULL,
    nsec_categoria bigint NOT NULL,
    nsec_marca bigint NOT NULL,
    codigo text,
    ruta text,
    nombre character varying(150) NOT NULL,
    precio_venta numeric(11,2) NOT NULL,
    stock integer NOT NULL,
    descripcion character varying(256),
    estado character(1) DEFAULT 'A'::bpchar,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 43388)
-- Name: productos_num_sec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.productos ALTER COLUMN num_sec ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.productos_num_sec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 43390)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol (
    num_sec bigint NOT NULL,
    nombre character varying(30) NOT NULL,
    descripcion character varying(100),
    estado character(1) DEFAULT 'A'::bpchar,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.rol OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 43396)
-- Name: rol_num_sec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.rol ALTER COLUMN num_sec ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.rol_num_sec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 43398)
-- Name: ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventas (
    num_sec bigint NOT NULL,
    nsec_cliente integer NOT NULL,
    nsec_usuario integer NOT NULL,
    tipo_comprobante character varying(20) NOT NULL,
    serie_comprobante character varying(7),
    num_comprobante character varying(10) NOT NULL,
    impuesto numeric(4,2) NOT NULL,
    total_venta numeric(11,2) NOT NULL,
    estado character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ventas OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 43403)
-- Name: ventas_num_sec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ventas ALTER COLUMN num_sec ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ventas_num_sec_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 2977 (class 0 OID 43317)
-- Dependencies: 202
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (num_sec, nombre, descripcion, estado, created_at, updated_at) FROM stdin;
2	CHAMARRA	CHAM	A	2022-04-28 21:59:59.468273	2022-04-28 21:59:59.468273
3	PANTALONAS	PANTALONAS	A	2022-04-28 22:00:34.781209	2022-04-28 22:00:34.781209
1	BLUSAS	BLUSA	A	2022-04-27 18:24:25.083404	2022-04-27 18:24:25.083404
4	SHOR	SHOR	B	2022-04-28 22:01:17.195803	2022-04-28 22:01:17.195803
\.


--
-- TOC entry 2979 (class 0 OID 43325)
-- Dependencies: 204
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (num_sec, nombre, tipo_documento, num_documento, direccion, telefono, email, created_at, updated_at) FROM stdin;
1	JOAQUIN CORTEZ	CI	9050588	CALLE FALSA 123	75057977	joakincortez8@gmail.com	2022-04-27 19:16:18.706771	2022-04-27 19:16:18.706771
\.


--
-- TOC entry 2981 (class 0 OID 43332)
-- Dependencies: 206
-- Data for Name: detalle_ingresos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_ingresos (num_sec, nsec_ingreso, nsec_producto, cantidad, precio, created_at, updated_at) FROM stdin;
1	9	1	45	5.00	2022-04-29 16:39:42.690046	2022-04-29 16:39:42.690046
\.


--
-- TOC entry 2983 (class 0 OID 43339)
-- Dependencies: 208
-- Data for Name: detalle_ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalle_ventas (num_sec, nsec_venta, nsec_prodcuto, cantidad, precio, descuento, created_at, updated_at) FROM stdin;
3	1	1	5	6.95	0.00	2022-04-29 17:44:31.897177	2022-04-29 17:44:31.897177
\.


--
-- TOC entry 2985 (class 0 OID 43346)
-- Dependencies: 210
-- Data for Name: facturas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.facturas (num_sec, nsec_cliente, nsec_usuario, nro_factura, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 2987 (class 0 OID 43353)
-- Dependencies: 212
-- Data for Name: ingresos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingresos (num_sec, nsec_proveedor, nsec_ususario, tipo_comprobante, serie_comprobante, num_comprobante, impuesto, total_ingresos, estado, created_at, updated_at) FROM stdin;
9	3	2	FACTURA	0X0X	123	13.00	1300.00	A	2022-04-29 10:02:26.224723	2022-04-29 10:02:26.224723
\.


--
-- TOC entry 2989 (class 0 OID 43360)
-- Dependencies: 214
-- Data for Name: marcas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.marcas (num_sec, nombre, descripcion, estado, created_at, updated_at) FROM stdin;
1	H&M	MARCA ESPAÑOLA	A	2022-04-28 22:38:27.300181	2022-04-28 22:38:27.300181
2	ADIDAS	MARCA DEPORTIVA	B	2022-04-28 22:38:53.577016	2022-04-28 22:38:53.577016
\.


--
-- TOC entry 2991 (class 0 OID 43368)
-- Dependencies: 216
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personas (num_sec, nsec_rol, nombre, tipo_documento, num_documento, direccion, telefono, email, password, estado, created_at, updated_at) FROM stdin;
1	1	MARIO CORTEZ	CI	989789	CALLE FALSE 123	789461	M@GMAIL.COM	123456	A	2022-04-29 08:46:23.526228	2022-04-29 08:46:23.526228
2	2	JOAQUIN ANTELO	CI	989789	CALLE FALSE 123	789461	M@GMAIL.COM	123456	A	2022-04-29 08:47:19.621687	2022-04-29 08:47:19.621687
3	3	JUAN PEREZ	CI	989789	CALLE FALSE 123	789461	M@GMAIL.COM	123456	A	2022-04-29 08:47:21.408018	2022-04-29 08:47:21.408018
\.


--
-- TOC entry 2993 (class 0 OID 43379)
-- Dependencies: 218
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (num_sec, nsec_categoria, nsec_marca, codigo, ruta, nombre, precio_venta, stock, descripcion, estado, created_at, updated_at) FROM stdin;
3	3	1	86b6a9d0-c7ec-1	ruta/img	PANTALONAS ROSADAS	0.00	0	DESC	A	2022-04-29 14:45:40.686837	2022-04-29 14:45:40.686837
2	1	1	0fb30870-c782-1	ruta/img	NUEVA BLUSA	0.00	0	DESCRIPCION	A	2022-04-29 02:03:33.622919	2022-04-29 02:03:33.622919
1	2	1	1bc28aa0-c778-1	ruta/img	CHAMARA DEPORTIVA	6.90	40	MODA	A	2022-04-29 00:53:39.019034	2022-04-29 00:53:39.019034
\.


--
-- TOC entry 2995 (class 0 OID 43390)
-- Dependencies: 220
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rol (num_sec, nombre, descripcion, estado, created_at, updated_at) FROM stdin;
1	ADMINISTRADOR		A	2022-04-29 08:41:58.646486	2022-04-29 08:41:58.646486
2	VENDEDOR		A	2022-04-29 08:42:01.017417	2022-04-29 08:42:01.017417
3	PROVEEDOR		A	2022-04-29 08:42:01.019856	2022-04-29 08:42:01.019856
\.


--
-- TOC entry 2997 (class 0 OID 43398)
-- Dependencies: 222
-- Data for Name: ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventas (num_sec, nsec_cliente, nsec_usuario, tipo_comprobante, serie_comprobante, num_comprobante, impuesto, total_venta, estado, created_at, updated_at) FROM stdin;
1	1	2	FACTURA	010203	555	13.00	34.75	A	2022-04-29 17:39:39.621517	2022-04-29 17:39:39.621517
\.


--
-- TOC entry 3005 (class 0 OID 0)
-- Dependencies: 203
-- Name: categorias_num_sec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_num_sec_seq', 4, true);


--
-- TOC entry 3006 (class 0 OID 0)
-- Dependencies: 205
-- Name: clientes_num_sec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_num_sec_seq', 1, true);


--
-- TOC entry 3007 (class 0 OID 0)
-- Dependencies: 207
-- Name: detalle_ingresos_num_sec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_ingresos_num_sec_seq', 1, true);


--
-- TOC entry 3008 (class 0 OID 0)
-- Dependencies: 209
-- Name: detalle_ventas_num_sec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalle_ventas_num_sec_seq', 3, true);


--
-- TOC entry 3009 (class 0 OID 0)
-- Dependencies: 211
-- Name: facturas_num_sec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.facturas_num_sec_seq', 1, false);


--
-- TOC entry 3010 (class 0 OID 0)
-- Dependencies: 213
-- Name: ingresos_num_sec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ingresos_num_sec_seq', 9, true);


--
-- TOC entry 3011 (class 0 OID 0)
-- Dependencies: 215
-- Name: marcas_num_sec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.marcas_num_sec_seq', 2, true);


--
-- TOC entry 3012 (class 0 OID 0)
-- Dependencies: 217
-- Name: personas_num_sec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personas_num_sec_seq', 3, true);


--
-- TOC entry 3013 (class 0 OID 0)
-- Dependencies: 219
-- Name: productos_num_sec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_num_sec_seq', 3, true);


--
-- TOC entry 3014 (class 0 OID 0)
-- Dependencies: 221
-- Name: rol_num_sec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rol_num_sec_seq', 3, true);


--
-- TOC entry 3015 (class 0 OID 0)
-- Dependencies: 223
-- Name: ventas_num_sec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ventas_num_sec_seq', 1, true);


--
-- TOC entry 2810 (class 2606 OID 43406)
-- Name: categorias categorias_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_nombre_key UNIQUE (nombre);


--
-- TOC entry 2812 (class 2606 OID 43408)
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (num_sec);


--
-- TOC entry 2814 (class 2606 OID 43410)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (num_sec);


--
-- TOC entry 2816 (class 2606 OID 43412)
-- Name: detalle_ingresos detalle_ingresos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ingresos
    ADD CONSTRAINT detalle_ingresos_pkey PRIMARY KEY (num_sec);


--
-- TOC entry 2818 (class 2606 OID 43414)
-- Name: detalle_ventas detalle_ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_pkey PRIMARY KEY (num_sec);


--
-- TOC entry 2820 (class 2606 OID 43416)
-- Name: facturas facturas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_pkey PRIMARY KEY (num_sec);


--
-- TOC entry 2822 (class 2606 OID 43418)
-- Name: ingresos ingresos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingresos
    ADD CONSTRAINT ingresos_pkey PRIMARY KEY (num_sec);


--
-- TOC entry 2824 (class 2606 OID 43420)
-- Name: marcas marcas_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marcas
    ADD CONSTRAINT marcas_nombre_key UNIQUE (nombre);


--
-- TOC entry 2826 (class 2606 OID 43422)
-- Name: marcas marcas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marcas
    ADD CONSTRAINT marcas_pkey PRIMARY KEY (num_sec);


--
-- TOC entry 2828 (class 2606 OID 43424)
-- Name: personas personas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (num_sec);


--
-- TOC entry 2830 (class 2606 OID 43426)
-- Name: productos productos_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_nombre_key UNIQUE (nombre);


--
-- TOC entry 2832 (class 2606 OID 43428)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (num_sec);


--
-- TOC entry 2834 (class 2606 OID 43430)
-- Name: rol rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (num_sec);


--
-- TOC entry 2836 (class 2606 OID 43432)
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (num_sec);


--
-- TOC entry 2850 (class 2620 OID 43510)
-- Name: detalle_ventas insertar_detalle_venta; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insertar_detalle_venta AFTER INSERT ON public.detalle_ventas FOR EACH ROW EXECUTE FUNCTION public.disminuir_stock();


--
-- TOC entry 2837 (class 2606 OID 43433)
-- Name: detalle_ingresos detalle_ingresos_nsec_ingreso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ingresos
    ADD CONSTRAINT detalle_ingresos_nsec_ingreso_fkey FOREIGN KEY (nsec_ingreso) REFERENCES public.ingresos(num_sec) ON DELETE CASCADE;


--
-- TOC entry 2838 (class 2606 OID 43438)
-- Name: detalle_ingresos detalle_ingresos_nsec_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ingresos
    ADD CONSTRAINT detalle_ingresos_nsec_producto_fkey FOREIGN KEY (nsec_producto) REFERENCES public.productos(num_sec);


--
-- TOC entry 2839 (class 2606 OID 43443)
-- Name: detalle_ventas detalle_ventas_nsec_prodcuto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_nsec_prodcuto_fkey FOREIGN KEY (nsec_prodcuto) REFERENCES public.productos(num_sec);


--
-- TOC entry 2840 (class 2606 OID 43448)
-- Name: detalle_ventas detalle_ventas_nsec_venta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_nsec_venta_fkey FOREIGN KEY (nsec_venta) REFERENCES public.ventas(num_sec) ON DELETE CASCADE;


--
-- TOC entry 2841 (class 2606 OID 43453)
-- Name: facturas facturas_nsec_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_nsec_cliente_fkey FOREIGN KEY (nsec_cliente) REFERENCES public.clientes(num_sec);


--
-- TOC entry 2842 (class 2606 OID 43458)
-- Name: facturas facturas_nsec_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_nsec_usuario_fkey FOREIGN KEY (nsec_usuario) REFERENCES public.personas(num_sec);


--
-- TOC entry 2843 (class 2606 OID 43463)
-- Name: ingresos ingresos_nsec_proveedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingresos
    ADD CONSTRAINT ingresos_nsec_proveedor_fkey FOREIGN KEY (nsec_proveedor) REFERENCES public.personas(num_sec);


--
-- TOC entry 2844 (class 2606 OID 43468)
-- Name: ingresos ingresos_nsec_ususario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingresos
    ADD CONSTRAINT ingresos_nsec_ususario_fkey FOREIGN KEY (nsec_ususario) REFERENCES public.personas(num_sec);


--
-- TOC entry 2845 (class 2606 OID 43473)
-- Name: personas personas_nsec_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT personas_nsec_rol_fkey FOREIGN KEY (nsec_rol) REFERENCES public.rol(num_sec);


--
-- TOC entry 2846 (class 2606 OID 43478)
-- Name: productos productos_nsec_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_nsec_categoria_fkey FOREIGN KEY (nsec_categoria) REFERENCES public.categorias(num_sec);


--
-- TOC entry 2847 (class 2606 OID 43483)
-- Name: productos productos_nsec_marca_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_nsec_marca_fkey FOREIGN KEY (nsec_marca) REFERENCES public.marcas(num_sec);


--
-- TOC entry 2848 (class 2606 OID 43488)
-- Name: ventas ventas_nsec_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_nsec_cliente_fkey FOREIGN KEY (nsec_cliente) REFERENCES public.clientes(num_sec);


--
-- TOC entry 2849 (class 2606 OID 43493)
-- Name: ventas ventas_nsec_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_nsec_usuario_fkey FOREIGN KEY (nsec_usuario) REFERENCES public.personas(num_sec);


-- Completed on 2022-04-29 17:46:39

--
-- PostgreSQL database dump complete
--

