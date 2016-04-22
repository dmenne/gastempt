# Libraries are included to keep intellisense quiet
library(shinyjs)
library(shinyAce)
library(shinyBS)

shinyServer(function(input, output, session) {

  getData = reactive({
    # Read and pre-process editor data
    data = input$data
    # Replace multiple spaces or tabs by single tab
    data = str_replace_all(data,"([\t ]+)","\t")
    data = str_replace_all(data,",",".")
    if (nchar(data) < 10) return(NULL)
    tc = textConnection(data)
    d = na.omit(read.table(tc, sep = "\t", header = TRUE))
    close(tc)
    validate(
      need(nrow(d) > 20, "At least 20 data values required"),
      need(nlevels(d$record) > 3, "At least 3 records required")
    )
    comment = paste(unlist(str_extract_all(data, "^#.*\\n")), collapse = "\n")
    comment = str_replace_all(comment,"\\t", " ")
    comment(d) = comment
    d
  })

  pc = reactive({
    # Compute fit
    d = getData();
    if (is.null(d)) return(NULL)
    model = eval(parse(text = input$model_a))
    variant = input$variant
    ng = nlme_gastempt(d, model = model, variant = variant )
    comment(ng) = comment(d)
    ng
  })

  observe({
    # Create dependency on all numeric fields
    preset  = input$preset
    if (is.null(preset)) return(NULL)
    ss = presets %>% filter(id == preset)
    num_presets = ss[,numcols]
    lapply(seq_along(num_presets), function(i){
      name = names(num_presets)[i]
      updateNumericInput(session, name, value = num_presets[[name]] )
    })
    updateSelectInput(session, "model_s", selected =  ss$model_s)
  })

  observe({
    # Clear ace editor
    if (input$clearButton == 0)
      return(NULL)
    updateAceEditor(session, "data",value = 1)
  })

  observe({
    # Create simulated data
    n_records = input$n_records
    v0_mean = input$v0_mean
    v0_std = input$v0_std_perc*input$v0_mean/100
    tempt_mean = input$tempt_mean
    tempt_std = input$tempt_std_perc*tempt_mean/100
    kappa_mean = input$kappa_beta_mean
    kappa_std = input$kappa_beta_std_perc*kappa_mean/100
    beta_mean = kappa_mean
    beta_std = kappa_std
    noise = input$noise_perc*v0_mean/100.
    student_t_df = as.integer(input$student_t_df)
    missing = as.double(input$missing)/100.
    model_name = input$model_s
    model = eval(parse(text = model_name))
    set.seed(input$seed)
    # Compute simulated data
    d = simulate_gastempt(n_records, v0_mean, v0_std, tempt_mean,
      tempt_std, kappa_mean, kappa_std, beta_mean, beta_std, noise,
      student_t_df, missing, model)
    # Copy simulated data to editor
    tc = textConnection("dt","w")
    writeLines(paste0("# ", comment(d$data)), con = tc)
    suppressWarnings(write.table(d$data, file = tc, append = TRUE,
                row.names = FALSE, sep = "\t", quote = FALSE))
    updateAceEditor(session, "data", value = paste(dt, collapse = "\n") )
    close(tc)
  })

  observe({
    # Update preset popover TODO: does not work reliably
    removePopover(session, "preset")
    addPopover(session, "preset",  "Simulated Sample Data",
               preset_description(input$preset), "right")

  })

  output$fitplot = renderPlot({
    p = pc()
    if (is.null(p)) return(NULL)
    plot(p)
  }, height =  500, width = 700) # Make height variable

  output$table = DT::renderDataTable({
    p1 = pc()
    if (is.null(p1)) return(NULL)
    p = coef(p1, signif = 3)
    if (is.null(p)) return(NULL)
    DT::datatable(p, rownames = FALSE, caption = comment(p1),
      options = list(
        paging = FALSE,
        searching = FALSE
      ))
  })

  output$download_coef = downloadHandler(
    filename = function() {
      paste('gastempt_', Sys.Date(), '.csv', sep='')
    },
    content = function(con) {
      p = pc()
      if (is.null(p)) {
        writeLines(paste0("# No valid data"), con = con)
        return(NULL)
      }
      cf = coef(p, signif = 3)
      comment = comment(p)
      if (!is.null(comment) || comment != "")
        writeLines(paste0("# ", comment), con = con)
      suppressWarnings(write.table(cf, file = con, append = TRUE,
               row.names = FALSE, sep = ",", quote = FALSE))
    }
  )

})