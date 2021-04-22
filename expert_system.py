from pyswip.prolog import Prolog
from pyswip.easy import *

prolog = Prolog()
retractall = Functor("retractall")
known = Functor("known",3)

def write_py(X):
    sys.stdout.flush()
    return True

global semester_n, city_name

def read_py(A,V,Y):
    if isinstance(Y, Variable):
        if str(A)=="city":
            response = input("Are you in the {} of {}? ".format(str(A), str(V)))
            city_name = response
        elif str(A)=="semester":
          if str(V) == "1":
            end = "st"
          elif str(V) == "2":
            end = "nd"
          elif str(V) == "3":
            end = "rd"
          else:
            end = "th"
          response = input("Are you in your {}{} {}? ".format(str(V), end, str(A)))
        elif str(A) == "symptoms":
          response = input("Are you showing any {} {} of COVID? ".format(str(V), str(A)))
        elif str(A) == "planned_city":
          response = input("Are you planning to go to the city of {} next? ".format(str(V)))
        elif str(A) == "nationality":
          response = input("Is your {} {}? ".format(str(A), str(V)))
        elif str(A) == "covid_results":
          response = input("If you've received your {}, is it {}? ".format(str(A), str(V)))
        elif str(A) == "need_help":
          response = input("If you {}, please respond {}. ".format(str(A), str(V)))
        else:
            response = input("Do you have a " + str(V) + " " + str(A) + "? ")
        Y.unify(response)
        return True
    else:
        return False

write_py.arity = 1
read_py.arity = 3

registerForeign(read_py)
registerForeign(write_py)

prolog.consult("expert_system.pl")

print ("Please answer the following questions:")
call(retractall(known))
rotation_ = [s for s in prolog.query("inrotation(X).")]
visa_ = [s for s in prolog.query("visa(X).")]

""" Check if you are in your rotation city. """
if rotation_[0]['X'] == "false":
    print ("You're not in your rotation city :( ")
else:
    print ("You are in your rotation city :) ")

if visa_[0]['X'] == 'true':
  print ("You don't need a visa for your planned city. ")
else:
  print ("Looks like you need a visa for your planned city. ")