% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/elegir_en_que_se_gasta.R
\name{elegir_en_que_se_gasta}
\alias{elegir_en_que_se_gasta}
\title{Definir la seccion de '¿En qué se gasta?'}
\usage{
elegir_en_que_se_gasta(
  x,
  categoria_presupuestal = NULL,
  producto = NULL,
  actividad = NULL,
  funcion = NULL,
  division_funcional = NULL,
  grupo_funcional = NULL,
  meta = NULL
)
}
\arguments{
\item{x}{Objeto de clase 'sep_df' recipiente de los parámetros de la consulta deseada}

\item{categoria_presupuestal}{chr. Código de programa presupuestal de forma "XXXX" (4).
Para Acciones Centrales usar "9001" y para APnoP usar "9002".}

\item{producto}{chr. Código de producto o proyecto de inversión de forma "XXXXXXX" (7).}

\item{actividad}{chr. Código de actividad, acción de inversión u obra, de forma "XXXXXXX" (7).}

\item{funcion}{chr. Código de función de forma "XX" (2).}

\item{division_funcional}{chr. Código de división funcional de forma "XXX" (3).}

\item{grupo_funcional}{chr. Código de grupo funcional de forma "XXXX" (4).}

\item{meta}{chr. Código de meta. No tiene forma estandarizada.}
}
\value{
Una lista con nombres correspondientes a los endpoints de la API
}
\description{
Definir la seccion de '¿En qué se gasta?'
}
