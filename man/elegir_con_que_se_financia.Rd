% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/elegir_con_que_se_financia.R
\name{elegir_con_que_se_financia}
\alias{elegir_con_que_se_financia}
\title{Definir la sección '¿Con qué se financian los gastos?'}
\usage{
elegir_con_que_se_financia(
  x,
  fuente_financiamiento = NULL,
  rubro = NULL,
  tipo_de_recurso = NULL
)
}
\arguments{
\item{x}{Objeto de clase 'sep_df' recipiente de los parámetros de la consulta deseada}

\item{fuente_financiamiento}{int. Código de fuente de financiamiento.
En su versión más reciente va del 1 al 5.}

\item{rubro}{chr. código de rubro, de  forma "XX" (2).}

\item{tipo_de_recurso}{chr, Código de tipo de recurso.
No tiene forma estandar, puede ser de uno o dos caracteres, que pueden
ser letras o números.}
}
\value{
Una lista con nombres correspondientes a los endpoints de la API
}
\description{
Definir la sección '¿Con qué se financian los gastos?'
}
