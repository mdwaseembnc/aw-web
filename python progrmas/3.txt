# Define the initial dictionary
agencies = {
    "CBI": "Central Bureau of Investigation",
    "FBI": "Foreign Direct Investment",
    "NIA": "National Investigation Agency",
    "SSB": "Service Selection Board",
    "WPA": "Works Progress Administration"
}


print("Initial dictionary:")
print(agencies)


agencies["BSE"] = "Bombay Stock Exchange"


agencies["SSB"] = "Social Security Administration"


agencies.pop("CBI", None)  
agencies.pop("WPA", None)


print("\nFinal dictionary after modifications:")
print(agencies)