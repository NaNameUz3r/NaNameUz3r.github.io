---
title: "Программирование высшего порядка. Процедурные абстракции."
tags: "Программирование Отчеты Декларативная_модель"
lang: ru
show_edit_on_github: false
comment: true
license: false
modify_date: "2022-03-13"
show_subscribe: false
article_header:
  theme: dark
  type: overlay
  align: left
  background_image:
    src: /header_images/declarative_5.jpg
---

Врубаемся в Декларативную модель — Часть 5. 
<!--more--> 

## Колдуем по взрослому

Программирование высшего порядка. Что может прийти на ум сперва...

{:refdef: style="text-align: center;"}
![АрхиКодер!](/images/high_order.jpg)
{: refdef}
*<center>Архи-кодер владеющий программированием высшего порядка</center>*

А теперь серьезно. Программирование высшего порядка — это такие методы программирования с использованием процедур (функций) высшего порядка (или "первого" класса). Ага! А что это за порядок такой, если речь не про сакрально-волшебные сверхсилы просветленного программиста? 

Сперва нужно рассмотреть такую штуку, как *лексическое замыкание*. 

Собственно, замыкание — это такая функция, в которой есть ссылки на объекты (например переменные), объявленные вне тела этой функции. В коде это выглядит как объявление функции в другой функции. Вот эта последняя, "внутренняя" функция, фактически имеет доступ ко внешним, по отношению к ней объектам — переменным объявленным в теле "функции-обертки", её аргументам. 

**Бугурт алерт!** Здесь и далее примеры на пайтонопсевдокоде! Помните, что мы сейчас изучаем Декларативную модель, *т е о р и ю*, а не прикладную практику. Это всё техники, реализация которых на одном языке будет выглядеть так, на другом иначе.

Пример:

    # "замыкающая", внешняя функция
    def mad_printer(some_new_law):

        # вложенная функция
        def actual_printer():
            print(some_new_law)

        return actual_printer

    emergency_law = mad_printer("freedom is slavery")
    emergency_law()

На выходе будет получена строка, переданная в замыкающую функцию - "freedom is slavery".

Хотя функция actual_printer и не имеет в своем теле переменной some_new_law, мы видим что такой код работает без проблем. Можно сказать, что в примере выше мы привязываем определенное замыкание к переменной emergency_law. И это замыкание включает в себя *возвращаемую функцию actual_printer и доступное ей окружение*. 

Замыкание — это некоторая форма *записи* которая хранит в себе *функцию первого порядка* вместе с её окружением.
{:.info} 


Ладно, ладно. А что такое функция первого порядка, не только в декларативной модели, а в программировании вообще?

Можно сказать, что система (язык программирования) имеет функции первого *класса*, если функции рассматриваются как *объекты первого класса*. Объект первого класса — это "элементы", а по сути типы, которые могут передаваться как параметры, возвращаться их функций или присваиваться как значение переменным. 

Иными словами, функция первого класса означает, что есть такой тип как функция, и любая реально объявляемая функция автоматически становится значением соответствующего типа. 

Сам термин *высшего порядка* исходит от концепции *порядка процедуры*. Если у какой то процедуры в аргументах нет других процедур — это функция нулевого порядка. Процедура, у которой есть хотя бы один аргумент-процедура — процедура первого порядка. Порядок процедуры можно определить как n + 1, если у этой процедуры есть хотя бы один аргумент n порядка, и нет других аргументов *более высокого порядка*. 

Получатся что функция может быть функцией первого класса, так как в системе есть вышеупомянутые критерии, но может не быть функцией первого порядка, если не имеет в аргументах других функций. В таком случае это, можно сказать, функция первого класса нулевого порядка :)

Короче говоря, программирование высшего порядка, по сути, это о том что процедуры могут быть любого порядка. Никакой магии, но надеюсь вы уже начали понимать, что потенциал у этой техники очень большой.


## Основные заклинания

В основе всех программистских техник высшего порядка лежат следующие четыре операции:

1. Процедурная абстракция;
2. Обобщение;
3. Инстанцирование;
4. Встраивание.

### Процедурная абстракция

На самом деле мы уже давно говорили о процедурных абстракциях. Настала пора четко декларировать термин.

Процедурная абстракция — это, по существу, определение процедуры. Мы оборачиваем программные инструкции в процедуру, внутрь заголовка процедуры, и в результате получаем блок кода (процедурное значение — замыкание), который не выполняется до тех пор, пока не будет вызван. 

Вызов процедуры приводит к тому же результату, к которому приведет выполнение инструкций из её тела. 

У процедурных абстракций существуют параметры, которые влияют на выполнение тела процедуры.

Фактически это основа основ парадигмы программирования высшего порядка, поддерживается во многих языках, а так же лежит в основе ООП.

Процедурные абстракции позволяют представить любую программную логику как значение процедуры.
{:.info} 

### Обобщение

Обобщить функцию — обозначает, что любая операция или значение может становиться *аргументом в теле функции*. Мы абстрагируем эту сущность от тела функции, а её (сущности) значение задается когда функция явно вызывается. Каждый раз, при вызове обобщенной функции, может задаваться другая сущность. 

Вернемся назад к итеративным вычислениям, и разберем обобщение на примере функции, суммирующей значения элементов списка. Например, мы можем написать такую декларативную функцию:

    def function summary_list_values(some_list)
        if some_list == []:
            return 0
        end

        list_head = some_list[0]
        list_tail = some_list[1:]
        return list_head + summary_list_values(list_tail)
    end

Тут есть два нейтральных элемента: 0, который мы возвращаем если some_list опустел, и операция сложения. Эти нейтральные элементы можно обобщить, сделав более универсальную функцию. Например, из примера выше можно сделать функцию FoldR. Такая функция есть во многих функциональных языках, это *функция-свертка*, схема рекурсивных вызовов которой раскручивается в цепочку, пока не будет достигнуто самое право, по сути последнее в списке, значение, после чего начнутся сами вычисления. Есть ещё FoldL, в которой вычисления начинаются СРАЗУ, то есть с "левой ассоциацией", считаем сразу и не ждем "правого конца".

Обобщим функцию, которую написали ранее следующим образом:

    def FoldR(some_list, some_function, some_element)
        if some_list == []:
            return some_element
        end

        list_head = some_list[0]
        list_tail = some_list[1:]
        return some_function(list_head, FoldR(list_tail, some_function, some_element))
    end

Обобщенная функция может получать на вход не только список, а функцию, которой будут обрабатываться вычисления среди элементов, и нейтральный элемент some_element. Эту функцию можно использовать для любых похожих ассоциативных вычислений, когда порядок аргументов some_function не важен для результата. 

### Инстанцирование

О, это очень классная штука! Инстанцирование обозначает возможность возвращать процедуру\функцию как результата вызова другой процедуры\функции. 
Инстанцирование реализуется с помощью *фабрик* или *генераторов функций*. 

Очень простой и грубый пример:

    # генератор
    def factory_function(calc_function):
        def inner_function(x,y):
            return calc_function(x,y)
        return inner_function

    # какая то функция с вычислениями, которую скормим генератору
    def addition(a,b):
        return a+b

    # генерируем функцию
    f = factory_function(addition)

    # вернет 2
    print(f(1, 1))


Очевидно что вычисления и логика внутри генератора может быть намного сложнее. Что нам это вообще дает? В первую очередь, это дает гибкость реализации каких то частей программы, которые если нужно мы можем менять на лету без особых проблем. 

Например, у нас может быть универсальная функция-фабрика для сортировки списков. Мы можем передавать в неё конкретный алгоритм сортировки, получая на выходе функцию, реализующую этот алгоритм.

### Встраивание

Примером реализации техники встраивания являются *ленивые* вычисления. Это такие вычисления, когда вместо того, чтобы вычислять сразу всё (жадно), генерируется лишь необходимый "кусок" данных. Иными словами, техника встраивания заключается в постепенном выстраивании структуры данных, по мере запросов к элементам этой структуры. Реализуется это, собственно "встраиванием" в структуру данных некоторого кода, который генерирует соответствующие структуре и запросу данные. 

## Абстракция цикла

Ранее мы разбирали рекурсии и итеративные вычисления. Грубо говоря, итеративные вычисления это и есть циклы. Но в декларативной модели описание таких вычислений выходит громоздким, так как требуются явные рекурсивные вызовы. Мы уже разобрали процедурную абстракцию и обобщение. Так почему бы не сделать циклы более лаконичными, выразительными?

Например, классический цикл for — это целочисленный цикл, который получает на вход четыре параметра: начальное значение, конечное значение, шак, и процедуру для вычислений в каждой итерации:

    def my_for(start_value, end_value, step, procedure):

        if start_value > end_value:
            return

        procedure(start_value)

        my_for(start_value + step, end_value, step, procedure)   


Цикл, для вычислений по элементам списка, можно выразить так:

    def for_list_elements(some_list, procedure):
        if some_list == []:
            return

        list_head = some_list[0]
        list_tail = some_list[1:]

        procedure(list_head)
        for_list_elements(list_tail, procedure)

Это всё хорошо. Но что если нам нужно сделать какие-то более прикладные вычисления, а не просто вывести данные, или применить процедуру к каждому элементу? Ну например, хотя бы снова суммировать все элементы списка, или перемножить? Помните *аккумуляторы* из [Части 3](/2022/02/20/hack_in_declarative_model_3.html)? 


    def my_for_acc(start_value, end_value, step, procedure, accumulator):
        if start_value > end_value:
            return accumulator

        accumulator = procedure(accumulator, start_value)
        my_for_acc(start_value + step, end_value, step, procedure, accumulator)   
        

Передадим туда, процедурой, например такой "сумматор":

    def my_sum(x,y):
        return x + y

И вызовем как-то так:

    print(my_for_acc(1, 10, 1, my_sum, 0))


Обработка списков с аккумулятором может выглядеть так:

    def for_list_elements_acc(some_list, procedure, accumulator)
        if some_list == []:
            return accumulator

        list_head = some_list[0]
        list_tail = some_list[1:]
        accumulator = procedure(accumulator, list_head)

        for_list_elements_acc(list_tail, procedure, accumulator)


    def my_sum(x,y)
        return x + y


    print(for_list_elements_acc([3,2,1], my_sum, 0))
    
Это будет работать как функция FoldL, о которой упоминалось ранее.

### Всё дело в "переменной"

Так вот, про Folr, а точнее про *folding* — это схема цикла с аккумулятором для обработки списков, суть которой заключается во внедрении операций между значениями списка. 

На самом деле способ вычисления этой конструкции зависит от компилятора, и зачастую на выходе мы получаем хорошую производительность благодаря распараллеливанию вычислений. 

Во многих языках программирования цикл, например for, лингвистически выглядит почти одинаково — мы пишем, собственно for и следом имя для цикла. 

Фактически это объявление то же самое, что передача тела цикла, следующего за определением в отдельную процедуру, которая многократно вызывается на основании счетчика-аргумента передаваемого в объявлении цикла. 

Хотя такое лингвистическое определение внешне может ничем не отличаться как в декларативных языках или иных других, например императивных, имеется очень важное отличие. Мы уже подробно изучали декларативные переменные, речь здесь идет как раз об этом — в императивных языках счетчик цикла является *изменяемой переменной*, тогда как декларативных цикл работает совсем иначе.

В декларативном цикле на каждой итерации объявляется *новая переменная*, обращение к которым происходит по *одному* идентификатору. Благодаря такой модели все итерации полностью независимы друг от друга, могут выполняться одновременно, а результат вычислений будет детерминирован. 

Такой финт в императивной модели провернуть нельзя, так как внутри параллельных итераций вообще нет никакой уверенности в том что мы получаем доступ к правильному значению счетчика. 

---

Все совпадения с "реальностью" случайны. В следующий раз поговорим о Data-driven и абстрактных типах данных. 

Enough for today! See y'all. Peace and love. 


