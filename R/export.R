##' tpl.export.outputs
##'
##' List of all available output formats (from ascii package).
tpl.export.outputs <- function() setdiff(sort(unique(unlist(ascii:::asciiOpts(".outputs")))), "")
##' tpl.export.backends
##'
##' List of all available backend formats (from ascii package).
tpl.export.backends <- function() ascii:::asciiOpts(".backends")

##' Export rapport class
##'
##' This function exports rapport class objects to various formats based on ascii package.
##' Note that no error/warning messages will be shown!
##' By default this function tries to export the report to HTML with pandoc. Some default styles are applied. If you do not need those default settings, use your own \code{options}.
##' @param rp a rapport class object or list of rapport class objects
##' @param file filename (NULL returns a tempfile)
##' @param append FALSE (new report created) or an R object (class of "Report") to which the new report will be added
##' @param create should export really happen? It might be handy if you want to append several reports.
##' @param open open the exported document? Default set to TRUE.
##' @param date character string as the date field of the report. If not set, current time will be set.
##' @param desc add Description of the rapport class (template)? Default set to TRUE.
##' @param format format of the wanted report, see: \code{ascii:::asciiOpts(".outputs")}
##' @param backend backend for the format conversions, see: \code{scii:::asciiOpts(".backends")}
##' @param options command line options passed to backend
##' @examples \dontrun{
##'
##' ## eval some template
##' x <- rapport('univar-descriptive', data=mtcars, var="hp")
##'
##' ## try basic parameters
##' tpl.export(x)
##' tpl.export(x, file='demo')
##' tpl.export(x, file='demo', format='odt')
##'
##' ### append reports
##' # 1) Create a report object with the first report and do not export (optional)
##' report <- tpl.export(x, create=F)
##' # 2) Append some other reports without exporting (optional)
##' report <- tpl.export(x, create=F, append=report)
##' # 3) Export it!
##' tpl.export(append=report)
##' # 4) Export it to other formats too! (optional)
##' tpl.export(append=report, format='rst')
##'
##' ### exporting multiple reports at once
##' tpl.export(tpl.example('example', 'all'))
##' tpl.export(tpl.example('example', 'all'), format='odt')
##' tpl.export(list(rapport('univar-descriptive', data=mtcars, var="hp"),
##'     rapport('univar-descriptive', data=mtcars, var="mpg")))
##'
##' ### Never do this as being dumb:
##' tpl.export()
##'
##' ### Adding own custom CSS to exported HTML
##' tpl.export(x, options=sprintf('-c %s', system.file('templates/css/default.css', package='rapport')))
##' ## For other formats check out backend specific documentation!
##' ## Eg. pandoc uses "--reference-odt" as styles reference for odt exports.
##'}
##' @export
tpl.export <- function(rp=NULL, file=NULL, append=FALSE, create=TRUE, open=TRUE, date=format(Sys.time(), getOption('rp.date.format')), desc=TRUE, format='html', backend='pandoc', options=NULL) {

    ## dummy checks and config parameters set
    if (!(format %in% tpl.export.outputs()))
        stop('Invalid format specified. See: rapport.report.outputs()')
    if (!(backend %in% tpl.export.backends()))
        stop(paste("Wrong backend. Please choose: ", paste(tpl.export.backends(), collapse = ", "), ".", sep = ""))
    if (!(format %in% ascii:::asciiOpts(".outputs")[[backend]])) {
        backends <- lapply(ascii:::asciiOpts(".outputs"), function(x) format %in% x)
        backends <- names(backends[as.numeric(which(backends==TRUE))])
        warning(paste('Wrong backend provided, using instead:', backends[1], '\nAll compatible backends:', paste(backends, collapse=', ')))
        backend <- backends[1]
    }
    if (!is.null(file))
        if (!is.character(file))
            stop('Wrong file parameter!')
    if (!is.logical(append)) {
        ## if (!(deparse(substitute(append)) %in% ls(envir = .GlobalEnv))) stop('Not existing object given as append parameter!')
        if (class(append) != 'Report') stop('Wrong class (!="Report") found in append parameter!')
        r <- append
    } else {
        if (append != 'FALSE') stop('Wrong append parameter!')
        if (is.null(rp)) stop('There is no sense in exporting a blank report :)')
        r <- Report$new()
        r$title <- as.character(rp$metadata['title'])
        r$author <- as.character(getOption('rp.user'))
        r$email <- as.character(getOption('rp.email'))
    }
    if (!is.logical(create)) stop('Wrong create (!=TRUE|FALSE) parameter!')

    ## a == NULL
    #if (is.null(rp)) return(r$create(file=file))  #############################################BUG

    ## exporting multiple rapport classes at once
    if (class(rp) == 'list') {
        if (all(lapply(rp, class) == 'rapport')) {
            r$title <- as.character(rp[[1]]$metadata['title'])
            for (i in 1:length(rp)) {
            	r <- tpl.export(rp[[i]], file=file, append=r, create=FALSE, open=FALSE, date=date)
            }
        } else
            stop('Wrong rp parameter!')
    }

    r$backend <- backend
    r$format <- format

    ## header stuff #############################################BUG
    if (!is.null(rp))
        if(class(rp) == 'rapport') {
            if (desc) {
                r$addSection('Description', 2)
                r$add(paragraph(as.character(rp$metadata['desc'])))
            }

            ## body
            lapply(rp$report, function(x) {
                if (x$type=='heading') r$addSection(x$text$eval, 2+x$level)
                if (x$type=='inline')
                    r$add(paragraph(ifelse(is.null(unlist(x$chunks$raw)),
                                           unlist(x$text$raw),
                                           unlist(x$text$eval))
                                    )
                          )
                if (x$type=='block' & !is.null(x$robjects[[1]]$type)) {
                    ## if (any(x$robjects[[1]]$type == 'error'))        # error handling is done in rapport
                    ##     r$add(paragraph(as.character(x$robjects[[1]]$msg$errors)))
                    if (any(x$robjects[[1]]$type == 'image')) r$addFig(file=x$robjects[[1]]$output)    # no nested rapport classes (halleluja)
                    #if (is.list(x$robjects[[1]]$output)) {
                    #    if (all(lapply(x$robjects[[1]]$output, class) == 'rapport')) {
                    #        for (i in 1:length(x$robjects[[1]]$output)) {
                    #            r <- tpl.export(x$robjects[[1]]$output[[i]], file=file, append=r, create=FALSE, open=FALSE, date=date, desc=FALSE)
                    #        }
                    #   }
                    #}
                    if (all(x$robjects[[1]]$type != c('image', 'error')))
                        r$add(paragraph(rp.prettyascii(x$robjects[[1]]$output)))
                    if (!is.null(x$robjects[[1]]$msg$warnings))
                        r$add(paragraph(as.character(x$robjects[[1]]$msg$warnings)))
                    }
            })
        }

    ## create report or return the Report class
    if (create) {
        ## if pandoc is converting to HTML then apply default styles
        if (is.null(options) & format == 'html' & backend == 'pandoc') {
            if (!file.exists(sprintf('%s%s', tempdir(), '/rapport-header.html')))
                cat(gsub('"templates/', sprintf('"%s/templates/', system.file(package='rapport')), readLines(system.file('templates/html/header.html', package='rapport'))), sep='\n', file=sprintf('%s%s', tempdir(), '/rapport-header.html'))
            options <- sprintf('-H %s -A %s', sprintf('%s%s', tempdir(), '/rapport-header.html'), system.file('templates/html/footer.html', package='rapport'))
        }
        r$create(file=file, open=open, options=options, date=date)
    } else
        return(r)
}

##' Rapport to HTML
##'
##' This is a simple wrapper around \code{\link{rapport}} and \code{\link{tpl.export}}. Basically it works like \code{\link{rapport}} but the returned class is exported at one go.
##' @param ... parameters passed directly to \code{\link{rapport}} 
##' @export
rapport.html <- function(...) tpl.export(rapport(...))

##' Rapport to odt
##'
##' This is a simple wrapper around \code{\link{rapport}} and \code{\link{tpl.export}}. Basically it works like \code{\link{rapport}} but the returned class is exported at one go.
##' @param ... parameters passed directly to \code{\link{rapport}} 
##' @export
rapport.odt <- function(...) tpl.export(rapport(...), format='odt')