SeguimientoEjecucion <- R6::R6Class(
    classname = "SeguimientoEjecucion",
    public = list(
    ),
    private = list(
        years = NULL,
        actualizacion = NULL,
        quien_gasta = NULL,
        en_que_se_gasta = NULL,
        con_que_se_financia = NULL,
        como_se_estructura = NULL,
        donde_se_gasta = NULL,
        cuando_se_hizo_gasto = NULL
    )
)

SeguimientoEjecucion$set("public", "initialize", function(
        actualizacion = "diaria",
        years = NULL,
        quien_gasta = NULL,
        en_que_se_gasta = NULL,
        con_que_se_financia = NULL,
        como_se_estructura = NULL,
        donde_se_gasta = NULL,
        cuando_se_hizo_gasto = NULL
        ) {
    private$actualizacion = actualizacion
    private$years <- years
    private$quien_gasta = quien_gasta
    private$en_que_se_gasta = en_que_se_gasta
    private$con_que_se_financia = con_que_se_financia
    private$como_se_estructura = como_se_estructura
    private$donde_se_gasta = donde_se_gasta
    private$cuando_se_hizo_gasto = cuando_se_hizo_gasto
})

SeguimientoEjecucion$set("public", "print", function() {
    cli::cli_h1("Seguimiento a la ejecución presupuestal ({.emph {private$actualizacion}})")
    cli::cli_h2("Parámetros de búsqueda")
    cli::cli_ul()
    # cli::cli_li("Actualización: {private$actualizacion}")
    private$cli_years()
    private$cli_quien_gasta()
    private$cli_en_que_se_gasta()
    private$cli_con_que_se_financia()
    private$cli_como_se_estructura()
    private$cli_donde_se_gasta()
    private$cli_cuando_se_hizo_gasto()
})

SeguimientoEjecucion$set(
    which = "private",
    name = "cli_li_optional",
    value =  function(x, label) {
        # print as list item if not null
        if(!is.null(x)) cli::cli_li("{label}: {x}")
    }
)

## years ----

SeguimientoEjecucion$set("public", "set_years", function(years) {
    private$years <- years
    self
})

SeguimientoEjecucion$set("private", "cli_years", function() {
    if (is.null(private$years)) {
        cli::cli_li("Años: Sin definir")
    } else {
        cli::cli_li("Años: {private$years}")
        # listado <- cli::cli_ul()
        # private$years |>
        #     purrr::walk(cli::cli_li)
        # cli::cli_end(listado)
    }
})

## quien gasta ----

SeguimientoEjecucion$set(
    which = "private",
    name = "cli_quien_gasta",
    value =  function() {
        consulta <- private$quien_gasta
        if (is.null(consulta)) return(NULL)
        cli::cli_li("¿Quién gasta?:")
        sublista <- cli::cli_ul()
        private$cli_li_optional(consulta$nivel, "Nivel de gobierno")
        private$cli_li_optional(consulta$sector, "Sector")
        private$cli_li_optional(consulta$pliego, "Pliego")
        private$cli_li_optional(consulta$unidad_ejecutora, "Unidad Ejecutora")
        private$cli_li_optional(consulta$goblocal_o_manc, "Gobierno local o mancomunidad")
        private$cli_li_optional(consulta$mancomunidad, "Mancomunidad")
        private$cli_li_optional(consulta$departamento, "Departamento")
        private$cli_li_optional(consulta$provincia, "Provincia")
        private$cli_li_optional(consulta$municipalidad, "Municipalidad")
    }
)

SeguimientoEjecucion$set(
    which = "public",
    name = "set_quien_gasta",
    value = function(nivel = NULL,
                     sector = NULL,
                     pliego = NULL,
                     unidad_ejecutora = NULL,
                     goblocal_o_manc = NULL,
                     mancomunidad = NULL,
                     departamento = NULL,
                     provincia = NULL,
                     municipalidad = NULL) {
        private$quien_gasta <- list(
            nivel = nivel,
            sector = sector,
            pliego = pliego,
            unidad_ejecutora = unidad_ejecutora,
            goblocal_o_manc = goblocal_o_manc,
            mancomunidad = mancomunidad,
            departamento = departamento,
            provincia = provincia,
            municipalidad = municipalidad
        )
        self

    }
)




## en qué se gasta ----

SeguimientoEjecucion$set("private", "cli_en_que_se_gasta", function() {
    if(is.null(private$en_que_se_gasta)) return(NULL)
    cli::cli_li("¿En qué se gasta?: ")
    sublista <- cli::cli_ul()
    private$cli_li_optional(private$en_que_se_gasta$categoria_presupuestal, "Categoría presupuestal")
    private$cli_li_optional(private$en_que_se_gasta$producto, "Producto")
    private$cli_li_optional(private$en_que_se_gasta$actividad, "Actividad")
    private$cli_li_optional(private$en_que_se_gasta$meta, "Meta")
    private$cli_li_optional(private$en_que_se_gasta$funcion, "Función")
    private$cli_li_optional(private$en_que_se_gasta$division_funcional, "División funcional")
    private$cli_li_optional(private$en_que_se_gasta$grupo_funcional, "Grupo funcional")
})

SeguimientoEjecucion$set(
    which = "public",
    name = "set_en_que_se_gasta",
    value = function(categoria_presupuestal = NULL,
                     producto = NULL,
                     actividad = NULL,
                     funcion = NULL,
                     division_funcional = NULL,
                     grupo_funcional = NULL,
                     meta = NULL) {
        private$en_que_se_gasta <- list(
            categoria_presupuestal = categoria_presupuestal,
            producto = producto,
            actividad = actividad,
            funcion = funcion,
            division_funcional = division_funcional,
            grupo_funcional = grupo_funcional,
            meta = meta
        )
        self
    })

## con que se financia ----

SeguimientoEjecucion$set("private", "cli_con_que_se_financia", function() {
    if(is.null(private$con_que_se_financia)) return(NULL)
    cli::cli_li("¿Con qué se financia?:")
})

SeguimientoEjecucion$set("private", "cli_como_se_estructura", function() {
    if(is.null(private$como_se_estructura)) return(NULL)
    cli::cli_li("¿Cómo se estructura gasto?:")
})

SeguimientoEjecucion$set("private", "cli_donde_se_gasta", function() {
    if(is.null(private$donde_se_gasta)) return(NULL)
    cli::cli_li("¿Dónde se gasta?:")
})

SeguimientoEjecucion$set("private", "cli_cuando_se_hizo_gasto", function() {
    if(is.null(private$cuando_se_hizo_gasto)) return(NULL)
    cli::cli_li("¿Cuándo se hizo gasto?:")
})


