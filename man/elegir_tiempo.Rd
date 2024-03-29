% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/elegir_tiempo.R
\name{elegir_tiempo}
\alias{elegir_tiempo}
\alias{elegir_cuando_se_hizo_gasto}
\alias{elegir_cuando_se_hizo_recaudacion}
\title{Elegir el tiempo en que se usa el presupuesto}
\usage{
elegir_tiempo(x, trimestre = NULL, mes = NULL)

elegir_cuando_se_hizo_gasto(x, trimestre = NULL, mes = NULL)

elegir_cuando_se_hizo_recaudacion(x, trimestre = NULL, mes = NULL)
}
\arguments{
\item{x}{Objeto de clase \verb{<transpaeco>} recipiente de los parámetros de la consulta deseada}

\item{trimestre}{int. Número del 1 al 4}

\item{mes}{int. Número del 1 al 12.}
}
\value{
Un objeto con clase \verb{<transpaeco>}
}
\description{
Estas funciones permiten desglosar la busqueda de acuerdo al tiempo en el periodo anual.
\code{elegir_cuando_se_hizo_gasto()} y \code{elegir_cuando_se_hizo_recaudacion()} sirven los módulos de gasto e ingresos, respectivamente.
\code{elegir_tiempo()} es una versión agnóstica que sirve para ámbos módulos.
Al desglosar por mes o trimestre se pierde información de PIA, PIM
y porcentaje de avance (en \emph{gasto}).
}
\examples{
iniciar_transparencia_economica(modulo = "gasto") \%>\%
    elegir_periodo_anual(2022) \%>\%
    elegir_cuando_se_hizo_gasto(mes = "todos")

iniciar_transparencia_economica(modulo = "gasto") \%>\%
    elegir_periodo_anual(2022) \%>\%
    elegir_cuando_se_hizo_gasto(mes = "todos") \%>\%
    consultar()

# se emite mensaje de error si se intenta elegir periodos no abarcados
tryCatch({
    iniciar_transparencia_economica(modulo = "gasto") \%>\%
        elegir_periodo_anual(periodo = 2022) \%>\%
        elegir_cuando_se_hizo_gasto(trimestre = "5")
        
}, error = function(e) print(e))

}
