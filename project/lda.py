"""
Variational Bayes for LDA
"""

import pickle
import time
import os

import numpy
from numpy import exp, ones
from scipy.special import psi as digam
from shutil import copyfile


def parse_data(corpus):
    word_ids = []
    word_cts = []
    for d in corpus:
        word_ids.append(numpy.array(list(d['freq'].keys())))
        word_cts.append(numpy.array(list(d['freq'].values())))
    print("Successfully imported all documents")
    return word_ids, word_cts


class VariationalBayes:
    """
    Class for learning a topic model using variational inference
    """

    def __init__(self):
        pass

    def init(self, corpus, num_words, num_topics=5, alpha=0.1):
        self._alpha = alpha
        self._num_topics = num_topics
        self._num_words = num_words
        self._corpus = parse_data(corpus)

        # define the total number of document
        self._num_docs = len(self._corpus[0])

        # initialize a D-by-K matrix gamma, valued at N_d/K
        self._gamma = numpy.ones((self._num_docs, self._num_topics))

        # initialize a K-by-V matrix beta, valued at 1/V, subject to the sum
        # over every row is 1
        self._beta = numpy.random.gamma(100., 1. / 100., (self._num_topics, self._num_words))

        self._iteration = 0

    @staticmethod
    def new_phi(gamma, beta, word, count):
        """
        Given gamma vector and complete beta, compute the phi for a word with a
        given count
        """
        phi = beta[:, word] * exp(digam(gamma))
        return phi * count / numpy.sum(phi)

    def e_step(self, local_parameter_iteration=50):
        """
        Run the e step of variational EM.  Compute new phi and gamma for all
        words and documents.
        """
        word_ids = self._corpus[0]
        word_cts = self._corpus[1]

        assert len(word_ids) == len(word_cts), "IDs and counts must match"

        number_of_documents = len(word_ids)

        # initialize a V-by-K matrix phi sufficient statistics
        topic_counts = numpy.zeros((self._num_topics, self._num_words))

        # initialize a D-by-K matrix gamma values
        gamma = numpy.ones((number_of_documents, self._num_topics)) * (
            self._alpha + float(self._num_words) / float(self._num_topics))

        # iterate over all documents
        for doc_id in numpy.random.permutation(number_of_documents):
            # compute the total number of words
            term_ids = word_ids[doc_id]
            term_counts = word_cts[doc_id]
            total_word_count = numpy.sum(term_counts)

            # initialize gamma for this document
            gamma[doc_id, :].fill(self._alpha + float(total_word_count) / float(self._num_topics))

            # update phi and gamma until gamma converges
            for gamma_iteration in range(local_parameter_iteration):
                gamma_update = ones(self._num_topics)
                gamma_update.fill(self._alpha)

                for ww, cc in zip(term_ids, term_counts):
                    contrib = VariationalBayes.new_phi(gamma[doc_id, :], self._beta, ww, cc)
                    gamma_update += contrib

                    # Save the last topic counts
                    if gamma_iteration == local_parameter_iteration - 1:
                        topic_counts[:, ww] += contrib

                gamma[doc_id, :] = gamma_update

            if (doc_id + 1) % 1000 == 0:
                print("Global iteration %i, doc %i" % (self._iteration, doc_id + 1))

        self._gamma = gamma
        return topic_counts

    def m_step(self, topic_counts):
        """
        Run the m step of variational inference, setting the beta parameter from
        the expected counts from the e step in the form of a matrix where each
        topic is a row.
        """
        return topic_counts / numpy.sum(topic_counts, axis=1)[:, numpy.newaxis]

    def run_iteration(self, local_iter):
        """
        Run a complete iteration of an e step and an m step of variational
        inference.
        """
        self._iteration += 1
        clock_e_step = time.time()
        topic_counts = self.e_step(local_iter)
        clock_e_step = time.time() - clock_e_step
        clock_m_step = time.time()
        self._beta = self.m_step(topic_counts)
        clock_m_step = time.time() - clock_m_step
        print("Iteration %i\te_step %d sec, mstep %d sec" % (self._iteration, clock_e_step, clock_m_step))


if __name__ == "__main__":
    import argparse

    argparser = argparse.ArgumentParser()
    argparser.add_argument("--task", help="Task",
                           type=str, default="task1", required=False)
    argparser.add_argument("--documents", help="documents",
                           type=str, default="freqs.pkl", required=False)
    argparser.add_argument("--num_topics", help="Number of topics",
                           type=int, default=4, required=False)
    argparser.add_argument("--num_words", help="Number of words",
                           type=int, default=120, required=False)
    argparser.add_argument("--alpha", help="Alpha hyperparameter",
                           type=float, default=0.1, required=False)
    argparser.add_argument("--iterations", help="Number of outer iterations",
                           type=int, default=20, required=False)
    argparser.add_argument("--inner_iter", help="Number of inner iterations",
                           type=int, default=10, required=False)
    flags = argparser.parse_args()

    with open(flags.documents, 'rb') as data:
        documents = pickle.load(data)
        vb = VariationalBayes()
        vb.init(documents, flags.num_words, flags.num_topics, flags.alpha)

        for ii in range(flags.iterations):
            vb.run_iteration(flags.inner_iter)

        groups = [[] for i in range(flags.num_topics)]
        for i, d in enumerate(documents):
            groups[vb._gamma[i].argmax()].append(d['name'])

        print(groups)

        os.mkdir("result")
        for i, images in enumerate(groups):
            group_dir = "result/group%d" % i
            os.mkdir(group_dir)
            for img in images:
                copyfile("%s/%s" % (flags.task, img), "%s/%s" % (group_dir, img))
