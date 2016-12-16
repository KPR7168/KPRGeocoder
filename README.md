# KPRGeocoder

This is a very simple to use geocoder which require limit amount of knowledge of address to lat long translation.

## Installation

Just drag the folder "KPRGeocoder" into your existing project and Link CoreLocation framwork.
It's that easy.

## Usage
Refer to example project for testing.

To convert latitude and longitude to address
```swift
KPRGeocoder().latLongToAddress(latitude: -37.816448,
                            longitude: 144.961166,
                            completion: {(result, error) -> Void in
    if error == nil{
        print("address: ", result!)
    }
    else{
        print(error!.description)
    }
})
```

To convert address to latitude and longitude
```swift
KPRGeocoder().addressToLatLong(address: "49 Balgowlah Avenue, Keysborough VIC 3173, Australia", completion: {(result, error) -> Void in
    if error == nil{
        print("latitude: ", result!.latitude)
        print("longitude: ", result!.longitude)
    }
    else{
        print(error!.description)
    }
})
```

To find out distance between two addresses
```swift
KPRGeocoder().distance(fromAddress: "49 Balgowlah Avenue, Keysborough VIC 3173, Australia",
                        toAddress: "85–91 Queen Street, Melbourne VIC 3000, Australia",
                        requestUnit: UnitLength.kilometers,
                        completion: {(result, error) -> Void in
    if error == nil{
        print("distance is ", result!, UnitLength.kilometers.symbol)
    }
    else{
        print(error!.description)
    }
})
```
To find out distance between two latitude and longitude
```swift
KPRGeocoder().distance(fromLocation: (-37.816448, 144.961166),
                        toLocation: (-37.817058, 144.996443),
                        requestUnit: UnitLength.kilometers,
                        completion: {(result, error) -> Void in
    if error == nil{
        print("distance is ", result!, UnitLength.kilometers.symbol)
    }
    else{
        print(error!.description)
    }
})
```

You can alter return length unit according to your needs.

## Credits
[Pichratanak Ky](https://github.com/KPR7168 "Pichratanak Ky's Github")

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
