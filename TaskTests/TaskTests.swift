import XCTest

class TaskTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLoginPasswordValidatio() throws {
        func testTrueValidation (login: String, password: String) {
            let user = User(login: login, password: password)
            XCTAssert(user.validation(), user.error)
        }
        func testFalseValidation (login: String, password: String) {
            let user = User(login: login, password: password)
            XCTAssert(!user.validation(), user.error)
        }
        
        testTrueValidation(login: "test@test.ru", password: "asdf1A")
        testTrueValidation(login: "trest@test.ru", password: "1212sdf1A")
        testTrueValidation(login: "testo@testo.com", password: "aASDGH111df1A")
        testTrueValidation(login: "est@testo.com", password: "gbgbgbgb1212123123DDD")
        
        testFalseValidation(login: "test@@test.ru", password: "asdf1A")
        testFalseValidation(login: "test@test", password: "asdf1A")
        testFalseValidation(login: "test@test.ru", password: "asd")
        testFalseValidation(login: "test@test.ru", password: "asdf1")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
