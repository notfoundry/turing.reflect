## The code introspection and reflection framework for the Turing interpreter

### What is it?
turing.reflect provides an API for reflectively accessing and analyzing classes, functions, and fields in the Turing runtime.
This is done by analyzing the internal representations of running code to reconstruct what its source-level equivalent would be, along with manipulating the interpreter to run certain dynamically-generated instructions that would otherwise be unable to exist.

### How does it work?
The first thing you'll need to do to get started with turing.reflect is copy the *reflect* folder of this project to the main directory of your Turing interpreter (where the Turing executable is located), or if you are using the newer Qt-based OpenTuring editor, the upper-level support directory containing all the Qt DLLs and the larger OpenTuring executable.
Once that is complete, you can import turing.reflect into your project by inserting this line into a source file header
> import "%oot/reflect/universe"

From there, you will have access to the **reflectc** and **reflectf** functions for reflecting classes and functions/procedures respectively. *reflectc* takes either a pointer to a class instance or the class itself (as shown below) as a argument, whereas *reflectf* takes the function/procedure to be reflected as an argument.
To reflect a class, get a *TClass* instance as such
```turing
  import "%oot/reflect/universe"
  
  class MyClass
    export greetMe
    
    proc greetMe()
      put "Hello World!"
    end greeetMe
  end MyClass
  
  var clazz := reflectc(MyClass)
```

Here we have a class, *MyClass*, with a single procedure that will print "Hello World!". If we wanted to make an instance of that class, we could do the following
```turing
  var instance := clazz -> newInstance()
  
  MyClass(instance).greetMe() /* prints "Hello World!" */
```

If we wanted to invoke that *greetMe* procedure directly, we could also do it without making an instance of the container class by doing this
```turing
    clazz -> getDeclaredFunction(1) -> invoke(0, nil) /* also prints "Hello World!" */
```

The code above will find the first declared procedure in the class above and invoke it with both an instance address of *nil* and a return address of 0. If *greetMe* returned a value, the return address would be the location in memory for the result to be put. Furthermore, if *greetMe* relied on any instance fields in *MyClass*, the instance address would specify the instance to use for that invocation.

##Working with Annotations
A common use of reflection is retrieving metadata associated with specific code constructs in projects. Java and C# do this through the use of *annotations* and *attributes* respectively, but they both boil down to being small snippets of code that can be put next to code constructs to give them certain metadata.

The Turing language does not support these kinds of constructs out of the box, but turing.reflect supplements this shortcoming by allowing you to define custom annotations that can be applied to various parts of your code. To do this, we first have to include the **annotations** module by adding the following snippet to the import line of your file header
> "%oot/reflect/annotations"

From there, you can create annotations by putting the word *annotation* before a declared empty procedure
```turing
  annotation proc test
  end test
  
  annotation proc named(name: string)
  end named
```

Both *test* and *named* can now be scanned for as annotations by turing.reflect's reflective objects. In this example
```turing
class TestSuite
  test
  proc testDoingSomething()
  
  end testDoingSomething
  
  test
  named ("test for doing something else")
  proc testDoingSomethingElse()
  
  end testDoingSomethingElse
end TestSuite
```

we can scan the TestSuite class for all functions annotated with *test*, and print the names of all those functions also annotated as *named*
```turing
  const clazz := reflectc(TestSuite)
  
  for i: 1..clazz -> getFunctionCount()
    const func := clazz -> getFunction(i)
    if (func -> isAnnotationPresent(test) & func -> isAnnotationPresent(named)) then
      const name := func -> getDeclaredAnnotation(named)
      put string @ (name -> getElement(1))  /* prints "test for doing something else" */
    end if
  end for
```

The annotation reflection API also allows you enumerate all annotations present on any given code construct, along with the number of elements that annotation has.

### Invoking functions with arguments reflectively
To invoke functions that take arguments of some kind, **TFunction**'s *invoke* function isn't good enough. Instead, *TFunction* defines a separate function *invokeArgs* to accomplish this. Similar to *invoke*, you pass arguments defining the function return address and class instance address to use for the invocation (these are ignored if the function has no return value or is not in a class, respectively).
Take the example of this greeting function
```turing
fcn deliverGreeting(greeting: string, recipient: string, allCaps: boolean, repetitions: int): string
  var s := "to " + recipient + ": "
  for i: 1..repetitions
      if (allCaps) then
          s += Str.Upper(greeting)
      else
          s += greeting
      end if
  end for
  result s
end deliverGreeting
```

To invoke this, we first have to include the **invoke** module by adding the following snippet to the import line of your file header
> "%oot/reflect/invoke"

From there, invoking the function is simple

```turing
var greeting: string
var func := reflectf(deliverGreeting)

func -> invokeArgs(addr(greeting), nil)
        -> with(stringArg("yo"))
        -> with(stringArg("Mike"))
        -> with(booleanArg(true))
        -> with(intArg(5))
        -> do()
        
put greeting /* prints "to Mike: YOYOYOYOYO" */
```

As you can see, the syntax for these invocations is fluent and simple. We provide four arguments to the **invocation context** through the *with* function, and call *do* to finally perform the invocation. This has the happy side effect of allowing arguments for invocation to be accumulated over time prior to invocation, instead of passing them all at once.

### Features
turing.reflect has a fairly broad feature set, closely mimicking Java's reflection API, including
  * class instance creation
  * class assignability checks
  * annotation creation, placement and retrieval
  * function invocation
  * function return type resolution
  * class function enumeration
  * class field enumeration
  
Lower-level details regarding any reflected object are available through *CodeContext* objects, giving you details regarding the internal start and end positions of constructs, how many operations they are composed of, and how many lines of source code they equate to.
