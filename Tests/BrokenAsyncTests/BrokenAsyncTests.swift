import XCTest
@testable import BrokenAsync

final class BrokenAsyncTests: XCTestCase {
    func testExample() throws {
        let task1Entered = XCTestExpectation(description: "first task has started")
        let task2Finished = XCTestExpectation(description: "second task has finished")

        let lock = DispatchSemaphore(value: 0)

        // Task 1
        Task
        {
            task1Entered.fulfill()

            lock.signal()
        }

        lock.wait()

        // Task 2
        Task
        {
            task2Finished.fulfill()
        }

        wait(for: [task1Entered, task2Finished])
    }
}
