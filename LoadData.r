#library(qdap)
Sys.setenv(LANG = "en")
library(tokenizers)
library(stopwords)
library(tm)
library(text2vec)

data = read.csv("mbti_1.csv")


INTJ <- data[data$type=="INTJ",]
INTP <- data[data$type=="INTP",]
ENTJ <- data[data$type=="ENTJ",]
ENTP <- data[data$type=="ENTP",]
INFJ <- data[data$type=="INFJ",]
INFP <- data[data$type=="INFP",]
ENFJ <- data[data$type=="ENFJ",]
ENFP <- data[data$type=="ENFP",]
ISTJ <- data[data$type=="ISTJ",]
ISFJ <- data[data$type=="ISFJ",]
ESTJ <- data[data$type=="ESTJ",]
ESFJ <- data[data$type=="ESFJ",]
ISTP <- data[data$type=="ISTP",]
ISFP <- data[data$type=="ISFP",]
ESTP <- data[data$type=="ESTP",]
ESFP <- data[data$type=="ESFP",]
length(INTJ[,1])
length(INTP[,1])
#summary(data)
#data[1,]
#data[,1]

#replaces URLs with word "link"
data$posts <- gsub('http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|(?:%[0-9a-fA-F][0-9a-fA-F]))+', 'link', data$posts)

#removes all noise from text
data$posts <- gsub('[^a-zA-Z]', " ", data$posts)

#removes more than 1 space
data$posts <- gsub('[ ]{2,}', " ", data$posts)

#word tokenization and stemming
data$posts <- tokenize_word_stems(data$posts, stopwords = stopwords::stopwords("en"))

#create dictionary
it_train = itoken(data$posts)
vocab = create_vocabulary(it_train)

pruned_vocab = prune_vocabulary(vocab, 
                                 term_count_min = 10, 
                                 doc_proportion_max = 0.8,
                                 doc_proportion_min = 0.001)

#document term matrix
vectorizer = vocab_vectorizer(pruned_vocab)
dtm_train = create_dtm(it_train, vectorizer)

#(Term Co-occurrence Matrix)
tcm = create_tcm(it_train, vectorizer, skip_grams_window = 5L)

##########
# TF-IDF #
##########

tf_idf = TfIdf$new()

# fit tf-idf to training data
doc_term_train_tfidf = fit_transform(dtm_train, tf_idf)

# apply pre-trained tf-idf transformation to testing data
#doc_term_test_tfidf  = transform(doc_term_test, tf_idf)

##########
# glove #
##########
glove = GlobalVectors$new(rank = 50, x_max = 10)
wv_main = glove$fit_transform(tcm, n_iter = 10, convergence_tol = 0.01, n_threads = 8)


dim(doc_term_train_tfidf)
dim(dtm_train)
dim(wv_main)
wv_context = glove$components
dim(wv_context)

#word_vectors = wv_main + t(wv_context)
#wv = glove$get_word_vectors()
#dim(wv)
#wv