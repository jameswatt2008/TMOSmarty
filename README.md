TMOSmarty
=========

TMOSmarty is a template engine for iOS Apps.

Smarty is a PHP template engine. TMOSmarty all thoughts are inherited from the Smarty, we migrate Smarty to Objective-C, so there TMOSmarty.

You might think this is all very complicated, but in fact, we have to do is to simplify. We did in the past need to be complicated XIB file documents associated with .m things, the use of Smarty encapsulated rendering.

---

Usage

`pod TMOSmarty`

---

## Let's have a simply try!

Here we create an xib, and we have an object, we are wondering fill text into xib's UILabels.

* Let's see what we want.

![](https://raw.githubusercontent.com/flymwy/myself/master/TMOSmarty/old_1.png)

## In the **past**, we did it like this.

![](https://raw.githubusercontent.com/flymwy/myself/master/TMOSmarty/old_2.png)

We will create many labels in xib.

![](https://raw.githubusercontent.com/flymwy/myself/master/TMOSmarty/old_3.png)

We have to create IBOutlet in .m file.

![](https://raw.githubusercontent.com/flymwy/myself/master/TMOSmarty/old_4.png)

We should use NSString method to fill text into labels.

## But Now! With TMOSmarty, it's **not necessary**!

![](https://raw.githubusercontent.com/flymwy/myself/master/TMOSmarty/new_1.png)

We create labels as normal, and pay attention please, we use "name:<{myName}>", which means, theObject.myName will fill into label automatically.

![](https://raw.githubusercontent.com/flymwy/myself/master/TMOSmarty/new_3.png)

We create an object, set some data in it.(Dictionary,array,NSObject is OK!)

![](https://raw.githubusercontent.com/flymwy/myself/master/TMOSmarty/new_2.png)

We just type one line code. It's done! No IBOutlet, No NSString parse.

---

Is it really magically? I say, it's really the simplest usage. TMOSmarty provide much more functions than this. Download the source code, you will find a whole demo.
