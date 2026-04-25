# Package index

## Iniciar consulta

El primer paso del flujo de trabajo es iniciar un objecto de consulta

- [`iniciar_transparencia_economica()`](https://perutranspaeconomica.samuelenrique.com/reference/iniciar_transparencia_economica.md)
  : Iniciar consulta de transparencia economica

## Elegir parámetros

Una vez iniciado el objeto de consulta se debe elegir parámetros
adicionales. Se aplican validaciones de forma y contenido, con mensajes
de error amigables.

### Periodo anual

- [`elegir_periodo_anual()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_periodo_anual.md)
  : Elegir periodo anual de consulta

### Otros parámetros

- [`elegir_destino()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_destino.md)
  [`elegir_en_que_se_gasta()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_destino.md)
  : Elegir destino de uso del presupuesto.
- [`elegir_estructura()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_estructura.md)
  [`elegir_como_se_estructura_gasto()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_estructura.md)
  [`elegir_como_se_estructura_recaudacion()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_estructura.md)
  : Elegir la estructura con la que se usa el presupuesto
- [`elegir_institucion()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_institucion.md)
  [`elegir_quien_gasta()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_institucion.md)
  [`elegir_quien_recauda()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_institucion.md)
  : Elegir la institucion que utiliza el presupuesto
- [`elegir_lugar()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_lugar.md)
  [`elegir_donde_se_gasta()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_lugar.md)
  : Elegir lugar de uso del presupuesto
- [`elegir_origen()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_origen.md)
  [`elegir_con_que_se_financia()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_origen.md)
  [`elegir_fuentes_de_recaudacion()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_origen.md)
  : Elegir el origen del presupuesto
- [`elegir_tiempo()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_tiempo.md)
  [`elegir_cuando_se_hizo_gasto()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_tiempo.md)
  [`elegir_cuando_se_hizo_recaudacion()`](https://perutranspaeconomica.samuelenrique.com/reference/elegir_tiempo.md)
  : Elegir el tiempo en que se usa el presupuesto

## Ejecutar consulta

Con los parámetros de consulta definidos, se ejecuta la consulta. De ser
exitosa, se obtiene un dataframe con los datos obtenidos.

- [`consultar()`](https://perutranspaeconomica.samuelenrique.com/reference/consultar.md)
  : Ejecutar consulta de seguimiento a la ejecución presupuestal
