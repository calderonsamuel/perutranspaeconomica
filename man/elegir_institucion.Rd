% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/elegir_institucion.R
\name{elegir_institucion}
\alias{elegir_institucion}
\alias{elegir_quien_gasta}
\alias{elegir_quien_recauda}
\title{Elegir la institucion que utiliza el presupuesto}
\usage{
elegir_institucion(
  x,
  nivel = NULL,
  sector = NULL,
  pliego = NULL,
  unidad_ejecutora = NULL,
  goblocal_o_manc = NULL,
  mancomunidad = NULL,
  departamento = NULL,
  provincia = NULL,
  municipalidad = NULL
)

elegir_quien_gasta(
  x,
  nivel = NULL,
  sector = NULL,
  pliego = NULL,
  unidad_ejecutora = NULL,
  goblocal_o_manc = NULL,
  mancomunidad = NULL,
  departamento = NULL,
  provincia = NULL,
  municipalidad = NULL
)

elegir_quien_recauda(
  x,
  nivel = NULL,
  sector = NULL,
  pliego = NULL,
  unidad_ejecutora = NULL,
  goblocal_o_manc = NULL,
  mancomunidad = NULL,
  departamento = NULL,
  provincia = NULL,
  municipalidad = NULL
)
}
\arguments{
\item{x}{Objeto de clase \verb{<transpaeco>} recipiente de los parámetros de la consulta deseada}

\item{nivel}{chr. Nivel de gobierno. Puede ser "E" (gobierno nacional),
"M" (gobiernos locales) o "R" (gobiernos regionales). Si es "E" o "R",
le corresponde \code{sector}. Si es "M", le corresponde \code{goblocal_o_manc}.}

\item{sector}{chr. Codigo de sector, de forma "00" (2 digitos).}

\item{pliego}{chr. Código de pliego, de forma "000" (3 digitos).}

\item{unidad_ejecutora}{chr. Código de Unidad Ejecutora.
No tiene forma estandar, puede tener entre uno (1) y seis (6) digitos.}

\item{goblocal_o_manc}{chr. Escoger entre "M" (gobierno local)
o "N" (mancomunidad). Si es "M", puede desglosarse por \code{departamento}, \code{provincia} y \code{municipalidad}.
Si es "N", le corresponde \code{mancomunidad}.}

\item{mancomunidad}{chr. Código de mancomunidad, de forma "000000" (6 digitos).}

\item{departamento}{chr. Código de departamento, de forma "00" (2 digitos).
El valor "07" corresponde a Callao.}

\item{provincia}{chr. Código de provincia, de forma "00" (2 digitos).
El valor "01" corresponde a capital de departamento.}

\item{municipalidad}{chr. Código de municipalidad, de forma "000000" (6 digitos).
\strong{No es lo mismo que el ubigeo}. Los dos primeros digitos deben ser "30".}
}
\value{
Un objeto con clase \verb{<transpaeco>}
}
\description{
Estas funciones permiten desglosar la busqueda haciendo uso del clasificador institucional.
\code{elegir_quien_gasta()} y \code{elegir_quien_recauda()} sirven los módulos de gasto e ingresos, respectivamente.
\code{elegir_institucion()} es una versión agnóstica que sirve para ámbos módulos.
}
\details{
Estas funciones aplicarán una validación de  la forma para cada argumento
mediante expresiones regulares. Sumado a ello, se aplica una validación
para evitar valores anómalos.
}
\examples{
iniciar_transparencia_economica(modulo = "gasto") \%>\%
    elegir_periodo_anual(2022) \%>\%
    elegir_quien_gasta(nivel = "todos")

# informacion de todas las UEs del Ministerio de Educacion
iniciar_transparencia_economica(modulo = "gasto") \%>\%
    elegir_periodo_anual(2022) \%>\%
    elegir_quien_gasta(
        nivel = "E", 
        sector = "10",
        pliego = "010",
        unidad_ejecutora = "todos"
    ) \%>\%
    consultar()

# informacion de todas las provincias de Amazonas.
# notese que devuelve codigos de provincia de 4 digitos.
iniciar_transparencia_economica(modulo = "gasto") \%>\%
    elegir_periodo_anual(2022) \%>\%
    elegir_quien_gasta(
        nivel = "M", 
        goblocal_o_manc = "M",
        departamento = "01",
        provincia = "todos"
    ) \%>\%
    consultar()

# para desglosar por provincia, deben usarse solo dos digitos.
# por ejemplo, para ver los municipios de la provincia de Bagua
# debe usarse "02"
iniciar_transparencia_economica(modulo = "gasto") \%>\%
    elegir_periodo_anual(2022) \%>\%
    elegir_quien_gasta(
        nivel = "M", 
        goblocal_o_manc = "M",
        departamento = "01",
        provincia = "02",
        municipalidad = "todos"
    ) \%>\%
    consultar()

# cuando no se respeta la forma, el mensaje de error
# muestra la expresion regular esperada
tryCatch({
    iniciar_transparencia_economica(modulo = "gasto") \%>\%
        elegir_periodo_anual(2022) \%>\%
        elegir_quien_gasta(
            nivel = "M", 
            goblocal_o_manc = "M",
            departamento = "01",
            provincia = "0102",
            municipalidad = "todos"
        )
}, error = function(e) print(e))

}
