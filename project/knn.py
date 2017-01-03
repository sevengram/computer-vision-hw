import pickle

from sklearn.cluster import KMeans
from collections import Counter

descriptors = []

with open('raw.pkl', 'rb') as data:
    documents = pickle.load(data)
    for d in documents:
        descriptors.extend(d['features'])
    kmeans = KMeans(n_clusters=120, random_state=0).fit(descriptors)

    n = 0
    for d in documents:
        d['words'] = kmeans.labels_[n:n + d['nf']]
        n += d['nf']
        d['freq'] = Counter(d['words'])

    with open('freqs.pkl', 'wb') as output:
        pickle.dump(documents, output)
