`capwords` <-
function(x, 
	special.words = c("ELA", "II", "III", "IV", "EMH", "HS", "MS", "ES", "SES", "IEP", "ELL", "MAD", "SD", "US", "SGP")) {

	trim <- function (x) gsub("^\\s+|\\s+$", "", x)

	if (is.null(x)) return(NULL)
	x <- gsub("_", " ", x)
	x <- gsub("[.]", " ", x)
	x <- trim(x)
	my.split <- function(words, split.character) {
		tmp.split <- unlist(strsplit(words, split=split.character))
		tmp.split.special.words.index <- which(!tmp.split %in% special.words)
		return(list(tmp.split=tmp.split, tmp.split.special.words.index=tmp.split.special.words.index))
	}
	s <- my.split(x, " ")
	s[[1]][s[[2]]] <- paste(toupper(substring(s[[1]][s[[2]]],1,1)), tolower(substring(s[[1]][s[[2]]],2)), sep="")
	s.new <- paste(s[[1]], collapse=" ")
	s.new <- unlist(strsplit(s.new, split="-"))
	if (length(s.new) > 1) s.new <- paste(toupper(substring(s.new,1,1)), substring(s.new,2), sep="", collapse="-")
	if (length(unlist(strsplit(s.new, split="'"))) > 1 & nchar(unlist(strsplit(s.new, split="'"))[2]) > 1) {
		s.new <- unlist(strsplit(s.new, split="'"))
		s.new <- paste(toupper(substring(s.new,1,1)), substring(s.new,2), sep="", collapse="'")
	}
	s.new <- unlist(strsplit(s.new, split="[.]"))
	if (length(s.new) > 1) s.new <- paste(toupper(substring(s.new,1,1)), substring(s.new,2), sep="", collapse=".")
	return(s.new)
} ### END capwords
