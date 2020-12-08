from pymongo import MongoClient

class DataBase():

    def __init__(self,):
        client = MongoClient()
        db = client.kvs
        self.collection = db.pairs

    def insert(self, key, value):
        result = self.collection.insert_one({'key': key, 'value': value})
        return result.inserted_id

    def find(self, key):
        return self.collection.find_one({'key': key})

    def remove(self, key):
        self.collection.remove({'key': key})

    def get_all(self):
        return self.collection.find()
