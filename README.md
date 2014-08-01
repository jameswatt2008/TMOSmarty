TMOSmarty
=========

TMOSmarty is a template engine for iOS Apps.

Smarty PHP was originally written using a template engine, is one of the industry's most famous PHP template engine. It separates the logic code and external content, provides an easy to manage and use the method used to originally mixed with PHP code and HTML code for logical separation. Simply speaking, the purpose is to make PHP programmer with separate front-end staff, enables programmers to change the logical content of the program will not affect the front page design staff, the front-end staff re-edit the page without affecting the program logic program, which in the multiplayer cooperative project was particularly important. 

Smarty in PHP is widely used, making our Smarty ported to iOS with great interest, so we wrote this one open source library TMOSmarty. 

TMOSmarty could have done 

* 1 Embedded references 

Embedded references, Model any type of object can be converted to NSString, and automatically rendered to various UI elements. 

* 2 custom function processing 

Since the use of defined functions can be a complex system can be used for string manipulation methods to encapsulate and use very simple method call. 

* 3.Model / View linkage (using KVO) 

In the past, we need to create a bunch of IBOutlet in Interface Builder and .m file references, will cease to exist, at the same time, with the Model / View linkage technology, Model changes will be immediate feedback to View, and you only need one line of code to complete all operations. 

=== 

Use TMOSmarty, you can liberate your hands, reduced by at least 30% of meaningless code. Meanwhile, View (StoryBoard, Interface Builder) and Controller, Model separation will be more thorough.

===

If you want to know more, please see wiki.

### 简体中文

* [何谓模板引擎](何谓模板引擎)
* [基础用法](基础用法)
* [模板语法](模板语法)
* [Model绑定](Model绑定)
* [函数使用](函数使用)

### English

* [Template Engine](Template-Engine)
* [Usage](Usage)
* [Parse](Parse)
* [Model Binding](Model-Binding)
* [Use Function](Use-Function)
