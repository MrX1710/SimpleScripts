from abc import ABC, abstractmethod
import colors
class Name:
    def __init__(self, name, age, adress):
        self.name = name
        self.age = age
        self.adress = adress

class Emotions:
    def Fellings(self):
        emotions = True
        print("Have Emotions :", emotions)

class Biological_Functions:
    @abstractmethod
    def Metabolism(self):
        pass

    @abstractmethod
    def Respiration(self):
        pass

    @abstractmethod
    def Reproduction(self):
        pass


class Human(Name, Emotions, Biological_Functions):
    pass
    def Humanity(self):
        print(f"Hy my name is {self.name}, i have {self.age} years old and i live in {self.adress}")
    def Metabolism(self):
        print(colors.bold("Metabolism:"))
        print("""Humans have a more complex metabolism that allows for a varied diet,\nincluding the ability to digest a wide range of carbohydrates, proteins, and fats.\n""")
    def Respiration(self):
        print(colors.bold("Respiration:"))
        print(""""Humans primarily use lungs for gas exchange, with a diaphragm that aids in breathing.\n""")
    def Reproduction(self):
        print(colors.bold("Reproduction:"))
        print("""Humans have a complex reproductive system with internal fertilization and a prolonged gestation period.\n""")


class Animal(Name, Emotions, Biological_Functions):
    pass
    def animalia(self):
        print(f"This animal's name is {self.name}, ha have {self.age} years old and he lives in {self.adress}")

    def Metabolism(self):
        print(colors.bold("Metabolism:"))
        print("""Different animal species have specialized metabolic processes based on their diets (herbivores, carnivores, omnivores) and environments.\nFor example, ruminants like cows have specialized stomachs for digesting cellulose.\n""")
    def Respiration(self):
        print(colors.bold("Respiration:"))
        print("""Many animals have different respiratory systems. Fish use gills, insects have a tracheal system,
        and amphibians can use both lungs and skin for respiration\n""")
    def Reproduction(self):
        print(colors.bold("Reproduction:"))
        print("""Reproductive strategies vary widely among animals, including external fertilization in many fish and amphibians,
        and different gestation lengths and parental care strategies.\n""")