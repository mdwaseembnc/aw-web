print("Welcome To Bike Shop")
bikes = ["MTB", "Geared", "Non-Geared", "With Training Wheels", "For Trial Riding"]

a = 0
net = 0
while (a < 4):
        bill = 0
        print("Chooses any of the following Services\n")
        a = int(input("1: View Bike onsale \n2: View Prices \n3: Place orders \n4: Exit \n"))
        if a == 1:
                print("The Bikes Avail are\n")
                for i in bikes:
                        print(i)                   
        elif a == 2:
                print("The prices at our store are: \n1. Hourly----100\n2. Daily----500\n3. Weekly---2500\n Family pack gets 30% discount on 3-5 bikes\n")
        elif a == 3:
                print("Choose your rental type:\n1. Hourly\n2. Daily\n3. Weekly\n")	
                c = int(input("Enter your option:\n"))
                d = int(input("Enter the number of bikes(put within 3-5 to avail family pack option):\n"))	
                if c == 1:
                        bill += 100*d
                        print("Your actuall Bill is ", bill)
                        print("-----------------------------")
                elif c == 2:
                        bill += 500*d
                        print("Your actuall Bill is ", bill)
                        print("-----------------------------")
                elif c == 3:
                        bill += 2500*d
                        print("Your actuall Bill is ", bill)
                        print("-----------------------------")
                else:
                        print("Enter a valid option")
                        print("-----------------------------")
                if d in range(3,6):
                        print("Do you wanna avail family pack discount?\n")
                        dis = input("y for YES\nn for NO\n")
                        print("-----------------------------")		
                        if dis == "y":
                                bill = bill*0.7	
                        else:
                                bill = bill
                print("Thanks for purchasing", bill, "is your bill, pay on checkout")	
        else:
                break
