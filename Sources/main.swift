import Kitura
import SwiftyJSON

#if os(Linux)
    import Glibc
    srand(UInt32(time(nil)))
#else
    import Darwin.C
#endif

// create router
let router = Router()

// create salutations
let salutations: [String] = [
    "Your number one, Dude",
    "What is up my man?",
    "What's goin on",
    "Heyyy"
]

// handle HTTP GET requests to /salutation
router.get("/salutation") {
    request, response, next in
#if os(Linux)
    let idx = Int(random() % salutations.count)
#else
    let idx = Int(arc4random_uniform(UInt32(salutations.count)))
#endif
    response.send(json: JSON(["text": salutations[idx]]))
    next()
}

// add HTTP server and connect it to router
Kitura.addHTTPServer(onPort: 8080, with: router)

// start Kitura runloop (this call never returns)
Kitura.run()
