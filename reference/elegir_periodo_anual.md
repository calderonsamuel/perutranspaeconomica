# Elegir periodo anual de consulta

Elegir periodo anual de consulta

## Usage

``` r
elegir_periodo_anual(x, periodo = NULL)
```

## Arguments

- x:

  Objeto de clase `<transpaeco>` recipiente de los parámetros de la
  consulta deseada

- periodo:

  numeric. Periodo anual de consulta. Actualmente solo se puede
  consultar a partir del 2012.

## Value

Un objeto con clase `<transpaeco>`

## Examples

``` r
iniciar_transparencia_economica() %>%
    elegir_periodo_anual(periodo = 2022)
#> 
#> ── Seguimiento al gasto presupuestal (actualizacion diaria) ────────────────────
#> 
#> ── Parametros de consulta ──
#> 
#> • Periodo anual: 2022
#> 
#> ── Data ──
#> 
#> ℹ No se ha ejecutado ninguna consulta

# pueden consultarse multiples periodos al mismo tiempo
# por ejemplo, los dos primeros años de pandemia por Covid 19
iniciar_transparencia_economica() %>%
    elegir_periodo_anual(periodo = 2020:2021) %>%
    consultar()
#> ℹ Iniciando consulta
#> ⠙ 1/2 ETA:  1s | Ejecutando consulta  
#> ℹ Unificando consultas...
#> ✔ Consultas realizadas y unificadas
#> # A tibble: 2 × 10
#>   periodo total          pia          pim certificacion compromiso_anual
#>     <int> <chr>        <dbl>        <dbl>         <dbl>            <dbl>
#> 1    2020 TOTAL 177367859707 217254208912  199474118005     191606503720
#> 2    2021 TOTAL 183029770158 227932217391  212450014781     205013665381
#> # ℹ 4 more variables: atencion_de_compromiso_mensual <dbl>, devengado <dbl>,
#> #   girado <dbl>, avance_percent <dbl>

# se emite mensaje de error si se intenta elegir periodos no abarcados
tryCatch({
    iniciar_transparencia_economica(modulo = "gasto") %>%
        elegir_periodo_anual(periodo = 2011)
}, error = function(e) print(e))
#> <error/rlang_error>
#> Error in `elegir_periodo_anual()`:
#> ! Periodo anual debe estar entre 2012 y 2026
#> ---
#> Backtrace:
#>      ▆
#>   1. ├─pkgdown::build_site_github_pages(new_process = FALSE, install = FALSE)
#>   2. │ └─pkgdown::build_site(...)
#>   3. │   └─pkgdown:::build_site_local(...)
#>   4. │     └─pkgdown::build_reference(...)
#>   5. │       ├─pkgdown:::unwrap_purrr_error(...)
#>   6. │       │ └─base::withCallingHandlers(...)
#>   7. │       └─purrr::map(...)
#>   8. │         └─purrr:::map_("list", .x, .f, ..., .progress = .progress)
#>   9. │           ├─purrr:::with_indexed_errors(...)
#>  10. │           │ └─base::withCallingHandlers(...)
#>  11. │           ├─purrr:::call_with_cleanup(...)
#>  12. │           └─pkgdown (local) .f(.x[[i]], ...)
#>  13. │             ├─base::withCallingHandlers(...)
#>  14. │             └─pkgdown:::data_reference_topic(...)
#>  15. │               └─pkgdown:::run_examples(...)
#>  16. │                 └─pkgdown:::highlight_examples(code, topic, env = env)
#>  17. │                   └─downlit::evaluate_and_highlight(...)
#>  18. │                     └─evaluate::evaluate(code, child_env(env), new_device = TRUE, output_handler = output_handler)
#>  19. │                       ├─base::withRestarts(...)
#>  20. │                       │ └─base (local) withRestartList(expr, restarts)
#>  21. │                       │   ├─base (local) withOneRestart(withRestartList(expr, restarts[-nr]), restarts[[nr]])
#>  22. │                       │   │ └─base (local) doWithOneRestart(return(expr), restart)
#>  23. │                       │   └─base (local) withRestartList(expr, restarts[-nr])
#>  24. │                       │     └─base (local) withOneRestart(expr, restarts[[1L]])
#>  25. │                       │       └─base (local) doWithOneRestart(return(expr), restart)
#>  26. │                       ├─evaluate:::with_handlers(...)
#>  27. │                       │ ├─base::eval(call)
#>  28. │                       │ │ └─base::eval(call)
#>  29. │                       │ └─base::withCallingHandlers(...)
#>  30. │                       ├─base::withVisible(eval(expr, envir))
#>  31. │                       └─base::eval(expr, envir)
#>  32. │                         └─base::eval(expr, envir)
#>  33. │                           ├─base::tryCatch(...)
#>  34. │                           │ └─base (local) tryCatchList(expr, classes, parentenv, handlers)
#>  35. │                           │   └─base (local) tryCatchOne(expr, names, parentenv, handlers[[1L]])
#>  36. │                           │     └─base (local) doTryCatch(return(expr), name, parentenv, handler)
#>  37. │                           └─iniciar_transparencia_economica(modulo = "gasto") %>% ...
#>  38. └─perutranspaeconomica::elegir_periodo_anual(., periodo = 2011)
```
