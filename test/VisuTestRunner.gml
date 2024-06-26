///@package io.alkapivo.visu

#macro BeanVisuTestRunner "visuTestRunner"
function VisuTestRunner() constructor {
  
  ///@type {Stack<Struct>}
  exceptions = new Stack(Struct)

  ///@type {Map<String, Callable>}
  restoreHooks = new Map(String, Callable)

  ///@return {VisuTestRunner}
  installHooks = function() {
    this.restoreHooks.set("Logger.error", method(this, Logger.error))
    Logger.info(BeanVisuTestRunner, "install hook 'Logger.error'")
    Logger.error = function(context, message) {
      global.__Log(context, "ERROR ", message)

      var runner = Beans.get(BeanVisuTestRunner)
      if (!Core.isType(runner, VisuTestRunner)) {
        return
      }

      runner.exceptions.push({
        timestamp: string(current_year) + "-"
          + string(string_replace(string_format(current_month, 2, 0), " ", "0")) + "-"
          + string(string_replace(string_format(current_day, 2, 0), " ", "0")) + " "
          + string(string_replace(string_format(current_hour, 2, 0), " ", "0")) + ":"
          + string(string_replace(string_format(current_minute, 2, 0), " ", "0")) + ":"
          + string(string_replace(string_format(current_second, 2, 0), " ", "0")),
        context: context,
        message: message,
      })
    }
    
    return this
  }

  ///@return {VisuTestRunner}
  uninstallHooks = function() {
    Logger.info(BeanVisuTestRunner, "uninstall hook 'Logger.error'")
    Logger.error = method(Logger, this.restoreHooks.get("Logger.error"))
    return this
  }

  ///@type {?TestSuite}
  this.testSuite = null

  start = function() {
    var context = this
    var json = FileUtil.readFileSync($"{working_directory}test/VisuControllerTestSuite.json").getData()
    var task = JSON.parserTask(json, {
      callback: function(prototype, json, index, acc) {
        var testSuite = new prototype(json)
        acc.testSuite = testSuite
      },
      acc: context,
    }).update()

    Core.print("status", task.status)

  }
  
  ///@type {TaskExecutor}
  executor = new TaskExecutor(this, { enableLogger: false })

  asd = false
  ///@return {VisuTestRunner}
  update = function() {
    if (Core.isType(this.testSuite, TestSuite)) {
      this.testSuite.update(this.executor)

      if (this.testSuite.finished && !this.asd) {
        this.asd = true
        this.testSuite.report.forEach(function(entry) {
          Logger.info("VisuTestRunner", $"{entry.test} ({entry.description}): {entry.result.status}")
        })
      }
    }
    this.executor.update()
    return this
  }
  
  free = function() {
    this.uninstallHooks()
  }
}


///@param {Struct} [json]
function TestSuite(json = {}) constructor {
  
  ///@type {String}
  name = Assert.isType(Struct.getDefault(json, "name", "Undefined test suite"), String)

  ///@type {Boolean}
  finished = false

  ///@type {Array<Struct>}
  tests = new Array(Struct, Struct.getDefault(json, "tests", []))

  ///@type {Array<Struct>}
  report = new Array(Struct)

  ///@type {Boolean}
  stopAfterFailure = Struct.getDefault(json, "stopAfterFailure", false)

  ///@private
  ///@type {Number}
  pointer = 0

  ///@param {TaskExecutor}
  ///@return TestJob
  update = function(executor) {
    if (this.finished) {
      return this
    }

    if (this.pointer >= this.tests.size()) {
      this.finished = true
      return this
    }

    if (this.pointer == this.report.size()) {
      var test = this.tests.get(this.pointer)
      var task = Callable.run(test.handler, Struct.get(test, "data"))
      executor.add(task)
      this.report.add({
        test: test.handler,
        description: test.description,
        result: task.promise,
      })
    } else {
      var status = this.report.getLast().result.status
      if (this.stopAfterFailure) {
        switch (status) {
          case PromiseStatus.REJECTED: this.finished = true break
          case PromiseStatus.FULLFILLED: this.pointer++ break
        }
      } else if (status != PromiseStatus.PENDING) {
        this.pointer++
      }
    }

    return this
  }
}

