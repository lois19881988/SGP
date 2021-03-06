`checksplineMatrix` <-
function(list.of.splineMatrix,
	sgp_object=NULL,
	state=NULL,
	content_area=NULL,
	year=NULL) {

	if (is.splineMatrix(list.of.splineMatrix)) {
		list.of.splineMatrix <- list(list.of.splineMatrix)
	}
	for (i in names(list.of.splineMatrix)) {
		if (length(grep("BASELINE", i))==0 | is.null(state) || is.null(SGPstateData[[state]][['Baseline_splineMatrix']])) {
			splineMatrix.tf <- sapply(list.of.splineMatrix[[i]], validObject, test=TRUE)==TRUE
			if (!all(splineMatrix.tf)) {
				content_area <- unlist(strsplit(i, "[.]"))[1]; year <- unlist(strsplit(i, "[.]"))[2]
				for (j in names(list.of.splineMatrix[[i]])[!splineMatrix.tf]) {
					message(paste("\tNOTE: Updating Coefficient Matrix", i, j, "to new splineMatrix class."))
					list.of.splineMatrix[[i]][[j]] <- 
						as.splineMatrix(matrix_argument=list.of.splineMatrix[[i]][[j]], matrix_argument_name=j, content_area=content_area, year=year, sgp_object=sgp_object)
				}
			}
			list.of.splineMatrix[[i]] <- unique.splineMatrix(list.of.splineMatrix[[i]])
		} else {
			list.of.splineMatrix[[i]] <- SGPstateData[[state]][['Baseline_splineMatrix']][['Coefficient_Matrices']][[i]]
		}
	}
	return(list.of.splineMatrix)
} ### END checksplineMatrix
