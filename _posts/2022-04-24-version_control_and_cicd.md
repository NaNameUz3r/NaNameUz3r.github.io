---
title: "Версионный контроль и непрерывная DevOps'ятина"
tags: "Инструменты"
lang: ru
show_edit_on_github: false
comment: true
license: false
modify_date: "2022-04-24"
show_subscribe: false
article_header:
  theme: dark
  type: overlay
  align: left
  background_image:
    src: /header_images/git_and_cicd.jpg
---

Как сделать свою жизнь проще. Пост про git и DevOps.
<!--more--> 

Первая попытка написать про git провалилась. Была она почти на самом старте блога, и пост просто "не пошел". Вторая попытка закончилась тем, что я ~~забыл выпить свои таблетки~~ ударился в философию набредовав несколько нечитаемых абзацев [тут](/2022/04/03/laziness.html).

Вообще там было несколько мыслей, одна из который о том, что *время самый главый ресурс* или один из них. Прежде чем я вернусь к этой арке, давайте поговорим про версионный контроль. 

## Помогите смержить dev

Если вы разработчик или инженер, который хоть каким-то боком заходит в редактор кода, и при этом не используете инструменты версионного контроля — у меня для вас плохие новости. Вас либо не существует, либо вы 2 дня в индустрии, либо чекисты закрыли вас в бункере в 83 году и вы до сих пор в нем сидите и паяете какую нибудь Нафаню.

Ладно, отставим дешевый троллинг.

Люди пишут программы. А ещё люди постоянно ошибаются. И в программах, и по жизни вообще. Раньше код резервиловали копировав его на несколько носителей, ну, дискетка там, и так далее. Это всё равно не надежная история, и сейчас как для резервирования кода, его версионирования, и других полезных штук используются специальные инструменты. Например [git](https://git-scm.com/). 

Я не хочу писать о других системах версионного контроля по двум причинам.
Во-первых, я в принципе ламер и с другими системами не работал.
Во-вторых, давайте признаемся честно — git является де-факто стандартным инструментом, его использует все и повсюду. 

### Я в бункере, что такое git?

Очень краткая история появления git:
- Линус Торвальдс родился;
- Линус Торвальдс чуть-чуть вырос и написал ядро linux;
- Линус Торвальдс показал его людям, и людям linux понравился;
- Всё больше и больше людей стали учавствовать в разработке linux;
- Пригорело из за проблем, связанных с пунктом выше (сложно вместе разрабатывать одно и то же! Вася наклепал фичу А, Петя Б, например в том же контексте или модуле, и че делать, как дружить их код?);
- В 2005 году Линус релизнул git и всем стало жить проще.

Git представляет рапределенную систему контроля версий. Что это значит? Есть не абстрактный *репозиторий* — это некоторая совокупность файлов с кодом, которые представляют конкретный проект. Есть его центральная "версия" на git-сервере, где собственно и лежит этот весь код. 

Распределенность заключается в том, что любой разработчик у которого есть доступ к репозиторию может стянуть себе локальную **полную** копию репозитория, *вместе с историей измнений* и так далее.

В этом и заключается смысл распределенности, где ключевое отличие от централизованных систем, в том что в них история и все потроха хранятся в одном месте, а разработчики забирают себе лишь код, грубо говоря.

Таким образом, вся эта история про инструмент, который значительно облегчает совместную разработку какого либо проекта, и представляет ряд полезных фич, таких как само версионирование состояний файлов в репозитории (история измнений).

Git штука сложная, мозговитая, чтобы полностью с ней разобраться потребуется убить достаточно времени. Но это стоит того. Пугаться не надо, начать работать с гитом можно практически с нахрапу освоив ключевые команды и возможности.

### Базовые понятия 

С репозиторием мы уже разобрались. Как выглядит работа с git?

Во-первых, львиную долю в популярность git'а внесла такая штука как GitHub. Гитхаб — это грубо говоря гит-хостинг. Не нужно устанавливать и поддерживать свой собственный сервер git, мы можем зарегистрировать аккаунт, создать репозитории и начать пользоваться всеми прелестями версионного контроля.

##### Ветки, те что branches.

Это возможность создавать копии-ответвления от основной ветки (которая всегда называлась master, пока не полубредовая [история с BLM](https://xakep.ru/2020/06/16/master-slave/)). 

Ветки могут показаться сложной штукой, но на деле ничего сложного тут нет. Представьте себе обычную девовидную структуру. Есть мастер будет стволом дерева, "основной веткой", из которого выростают другие ветви. Другие ветви в момент выростания являются по сути копией кодовой базы из мастера. 

Никто не запрещает из этих веток отщеплять другие, но делать так не надо. 

Теперь немног наркомании. Представьте что отросшие из ствола ветки чуть выше вростают в ствол обратно. Эээм... чего? 

Зачем вообще отщеплять ветки?

##### git-flow, йо, мержим!

git-flow, GitHub flow, и прочие git бла-бла-бла flow это эффективные, полезные (часто и не очень) методики работы с гитом. В частности с ветвлением.

Вспомним что git это в первую очередь для совместного ведения разработки. Чисто теоретически команда может работать в одной ветке, сразу в мастере, пихать туда каждый свои измнения и постоянно решать конфликты, но так никто (надеюсь) не делает.

Нужно предерживаться хорошего стиля и здравого смысла в цикле разработки. Базовых правил. 

Во-первых, в мастере всегда должен быть рабочий код, и мастер должен быть чистым. Для внесения каких-либо измнений мы и делаем форки. Пилими фичи, что-то исправляем, и так далее. 

Так вот вышеупомянутое врастание обратно в "ствол" есть слияние, или merge веток. 

Обычно, хорошим flow считается иметь несколько основных веток: master, staging, develop.

Staging и develop, как правило, являются форками из мастера. В develop, как не сложно догадаться, идет разработка, когда состояние допиливается до какого то рабочего вида, и его нужно протестить на схожем с прод-окружении рантайме — develop сливают в staging, проверяют всё что хотят, убеждаются что оно правда работает и сливают staging в master.

Как я уже сказал, это вообще не табу. Есть другая хорошая практика которой стоит придерживаться. Для каждой отдельной фичи и изменения разработчик делает форк (сделать форк, это на нашем новоязе сиречь отбранчевать ветку), пилит в новой ветке свои измнения, и сливает в изначальную ветку.

Обычно схема получается смешанная. Разработчики форкают фича-ветки из develop, мержат в него свои феноменальные решения, пока develop не сбилдится и не поедет :), а дальше по первому шаблону.

Но что делать если на стейдже все работало, слили в мастер, и прод упал! Ололо!

##### Спокойно, у меня всё осталось

Вот она, основная прелесть версионного контроля! Барабанная дробь... Версии!

Git отслеживает все измнения файлов и хранит их в своей истории. Все эти измнения можно посмотреть в логе репозитория. И откатиться на предыдущие состояния! Мы никогда ничего не теряем. 

Есть продвинутые штуки, которые можно проворачивать с историей. Пока вы не удалили ветку — git будет хранить всю историю её измненей. Вам ничего не мешает вытащить из мастера изначальную версию на момент форка рабочей ветки, или любую другую версию, если вы её, например безвозвратно потеряли или поломали так что не хотите копаться в истории измнений этого файла в текущей, рабочей ветке. 

##### Эй, вася, чекаут делал?

Каждая локальная копия репозитория связанна с "центральным" репозиторием, который называется origin. Если мы неделю назад его склонировали, что-то изменили, значит ли что за прошедшую неделю больше никто ничего там не изменил? Конечно нет. 

Возвращаясь к работе снова и снова нужно всегда, прежде чем приступать к каким то измнениям, подтянуть свежую версию ветки, или всех нужных веток. 
В git это называется pull — выгрузить origin в локальную копию репозитория.

##### Я все сделал, катим в прод!

Обратная pull операция — push, которая обозначет выгрузку локального репозитория в origin. Впрочем пуш служит не только для выгрузки измнений в ветке. Вы могли локально сделать форки каких то веток, из мы "пихаем" в origin тем же пушем.

##### Всё слишком радужно, где подвох?

Да, подвох есть. И этот подвох — конфликты. Скажу честно, даже в моей работе, учитывая что я всё ещё не ололо-мега-сеньор-разработчик в команде из 140 человек, конфликты мерджей бывают той ещё болью в заднице.

Как возникают конфликты? Ну, например, в репозитории могли вести **очень корявый flow**, давно не мержить dev в staging. А при этом, параллельно ещё и в staging что то меняли на протяжении целого месяца. И вот у вас возникла ситуация когда надо донести всё в master, да при этом сначала из dev в stage. 

В такой момент просто хочется убить причастных к такому флоу товарищей.

Но по простому, что такое конфликт? Если из моих перлов выше непонятно, то конфликт возникает тогда, когда у нас есть изменения одних и тех же участков (строк) в файлах, которые мы пытаемся слить. Как бы не хотелось, git и вычислительная техника не настолько умны чтобы понять какой код правильный, о чем и будет сообщено в ошибках при попытке слияния. 

Всех этих проблем можно избежать следуя чистому, хорошему flow в репозитории. Помимо этого, очень важно называть ветки адекватно, и писать информативные и коротки commit мессаджи. 

А ещё важнее: **коммитить как можно чаще, и как можно более мелкие измненеия в коде**. Не каждое измнение строки, но каждое маленькое, осмысленное и обособленное само в себе измнение-фичу.

##### Упс

До меня только что дошло что я не упомянул коммит. Это опять же про то, как работает гит. Очень поверхностно:

Когда мы стянули репозиторий и сделали какое то измнение, или набор измнений (я надеюсь их не много!) их нужно *зафиксировать* в репозитории.

В git это делается следующим образом. Сначала нужно добавить необходимые для фиксирования файлы, мы можем добавить все или выборочно. Делается это командой git add. После этого, прежде чем пушить измнения в origin нужно сделать commit.

Commit's — это не что иное как кирпичики самого версионного контроля. Это своего рода снимки или снапшоты состояния, которые хранятся в истории, к ним мы можем откатываться и так далее. Создаются они коммандой git commit -m 'Я сделал кнопку в админке'. 

У каждого комита есть свой уникальный идентификатор — хэш, который мы можем найти в истории.

## Goto введение

Я обещал вернуться к словоблудию по поводу времени. В общем этот тред больше про DevOps.

Давайте ещё раз подумаем, вспомним про время. Почему время так ценно? Ну кроме того что мы все умрем.

Вермя — деньги. Это правда. IT — это бизнес. Это тоже, как правило, почти всегда правда. Бизнес делает деньги. Иначе что это за бизнес?

И ещё одно — дедлайны **всегда** горят. Клиент, директор, Вася Пупкин с фриланс биржи, кто бы то ни был, если он руководит вами и дает вам работу, очень часто хочет чтобы продукт был готов как можно быстрее, фича была готова как можно быстрее. Спринт был закрыт всегда воворемя и цикл разработки работал как часы.

Здесь можно отступить в тему методолгий разработки, но это кроличья нора, которая заслуживает отдельного поста и я в этом вообще не очень компетентен на данный момент. 

### Ребят а что мы тут вообще делаем?

Кто нибудь знает что вообще такое DevOps. Одни говорят одно, другие про козу. А HR's вообще ищут devops-инженероа. Чего?... 

Кто-то скажет что devops обязательно должен уметь рулить кубернетисом, кто-то, что если devops не компилировал linux и вообще не гуру сисадмин, то никакой он не девопс. Иные будут бить себя кулаками в грудь, доказывая что девопс должен помогать их разработчикам дебажить говнокод на php, и так далее.

Во-первых, devops никому ничего не должен. Потому что devops — это набор практик, или ещё точнее — философия. DevOps в больше мере вылез из Agile методолгии, и ставит как главную ценность людей как индивиды, так и коллектив. DevOps признан быть некоторого рода интерфейсом между разрабами и админами, которые рулят инфраструктурой, чтобы был мир, дружба, жвачка, бизнес получал свои деньги и фичи вовремя, никто не грызся, дедлайны не горели и вот это вот всё. 

### Ты в трудовую свою посмотри, клоун!

Всё ты врешь! У меня в трудовой написано что я младший devops-инженер, я постоянно всем должен и все меня мучают кучей задач, горят и дедлайны и моя пятая точка.

Ну если что то горит, значит ты не девопс инженер, а обычный админ, которому в скоуп повесили кучу технологий кроме привычной узкой админской специализации, платят тебе на 20к больше, а мучают на все 100 сверху.

Но всё таки, кто же такой devops-инженер, и что он должен уметь?

Это сложный вопрос. DevOps инженер это в первую очередь инфраструктурный инжинер, который должен понимать понемногу во всем, быть и админом и чуть-чуть (или не чуть-чуть) программистом одновременно. Скоуп технологий с которым работает такой инженер разнится, и зависит от компании и инфраструктуры. 

Разумеется, что всё таки в первую очередь, и самую главную очередь, такой инженер должен быть хорошим админом, понимать что-то в архитектуре сетей, и быть в курсе всех передовых технологий направленных на эту самую дружбу Dev и Ops — контейнеризация, пупернетисы эти ваши, и... ci-cd инструментарий.

### Ладно, а что такое ci-cd.

**Никто** не знает что такое continuous integration и continuous delivery. По русски — непрерывная интеграция и непрерывная доставка. Вы можете нагуглить просто тонну инфы про эти штуки, вам там ещё расскажут про непрерывное развёртывание (continuous deployment)... И про прочую девпос чертовщину, софистику.

Можно немного почитать, но не рекомендую убиваться в эту дичь, потому что... это по большому счету пустая трата **времени**. Лучше пойти выучить что-то новое из прикладных навыков, и стать эффективнее в том же "dev" или "ops", или "devops" %)

Во всех этих трех... тысячах терминов чаще всего встречается одно и то же слово — continuous, *непрерывный*. И это, наверное, самое главное что нужно хорошо понять. 

Это снова про методологию, про непрерывную методолгию разработки, сборки, доставки артефактов сборки в инфраструктуру, разворачиванию этих артефактов и так далее. Без горений, четко как часики... 

***Автоматически** настолько, насолько это возможно*. 

Кто-то, наверняка начитавшийся того-самого, может спорить, но devops это правда во многом, если не в первую очередь, про автоматизацию. 

В частности поэтому в вакансиях часто можно увидеть ansible, puppet, chef и вот это всё. 

Потому что правильная, качественная, короче — рабочая автоматизация это прагматично с любой точки зрения, и разумеется с точки экономии времени, ресурсов.

В частности, там где по настоящему есть и практикуется devops можно найти много общего с воплощением так называемого "Бережливого производство" или Lean. 

Lean это такая менежментская концепция предприятия, ноги которой растут из Тойотовской операционной модели — "The Toyota Way", которая направленна, простыми словами, на повышление эффективности предприятия в целом, путем *устранения утечек ресурсов*. 

И устранение это очень человеческое, мудрое. Устранение проивзодственных утечек ведет к устранению утечек времени, которое тратится на починку косяков. А правильно, эффективно работающий конвейер (pipeline) работает без узких горлышек (bottleneck), что тоже ведет к сохранению ресурсов, времени, и вообще общему счастью :)  

Рекомендую посмотереть обе части интервью с Полом Экерсом, который очень четко и правильно внедрил этот самый Lean в своем производстве.
Вот ссылка на первую часть -> [тык](https://www.youtube.com/watch?v=oarLDeAFSj4), вторую найдете в закрепе, если интересно.

Вот и получается, что devops инженер в большей степени не имеет права делать херак-херак и в продакшен, в плане архитектурных решений и конфигурирования пайплайна разработки и развертывания. На самом деле, херак-херак не должен делать никто, и это то к чему должен стремиться DevOps и методологии, которые внедряются и применяются. 

DevOps начинается и заканчивается в голове. Этот soft навык у инженера не менее, а иногда и более значим чем почти любой hardskill — уметь видеть костыли и исправлять их, или замечать попытку внедрения костылей разработчиками или другими инженерами, и делать все чтобы этого недопустить или сгладить.

К сожалению, далеко не всегда получается избежать костылей... Но по крайней мере мы должны помнить где эти костыли есть, и фиксить их как только такая возможность будет (появилась новая технология как решения костыля, идея, и так далее). 

### Так статья же про git была изначально?

Да, git это ещё один фундаментально базовый навык, обязательный для любого devops-инженера. Если узко специализированные админы операционных сетей или баз данных могут спокойно жить и работать ничего не зная про git и связанные технологии, то devops без этого не может никак.

Во-первых, это диктуеся тем что devops инженер часто в той или иной степени имеет доступ к коду, как минимум — общается с разработчиками.
В ситуация когда devops инженер начинает мутировать в SRE-инженера, он может уже во всю кодить сам.

Во-вторых, инструменты, такие как Helm сейчас вяжутся напрямую с репозиториями проектов. Сам по себе helm это всего лишь менеджер пакетов для k8s, который эти самые пакеты описывает как чарты (chart) — набор из yaml манифестов в которых описаны состояния ресурсов для деплоя в кубы.

Но очень крутая методолгия, которую в частности проповедуем мы во Фланте это так называемый *гитерминизм*. Это игра слов от git и детерминизм. Коротко говоря, смысл гитерминизма в том, чтобы сделать состояние деплоя максимально детерминированным состоянием git репозитория. 

Достигая это орекстом каких-то инструментов, один из примеров это gitlab ci-cd + werf (тулза для сборки и деплоя, разрабатываемая во Фланте), работающий с классическими helm чартами. 

Другой пример гитерминизм тулзы для деплоя это ArgoCD, который сейчас упорно хайпят — он тоже "смотрит" в скормленную репу, и своими средствами пытается "зеркалировать" её состояние, изменения, в указанный неймспейс кластера k8s. Работает тоже поверх helm.

Helm чарт, плюс файл сборки werf (грубо говоря аналог докерфайла, но там все намного круче и хитрее :), как и gitlab-cicd.yaml хранятся в одном репозитории с кодом приложения, которое из этого репозитория "деплоится".

Это достаточно глубокая тема, как минимум каждый из инструментов можно рассматривать отдельно, и тут я скорее привожу как пример в контексте важности навыка работы с git для инфраструктурных инженеров. 


## Короче, учите git! 

Я там выше сказал про gitlab. Gitlab, это в общем оупенсорсный (есть энтерпрайз версия) продукт для разворачивания своего гит репозитория... И не только. У Gitlab очень крутая нативная поддержка cicd инструментов, в часотности интеграцию с исполнителями пайплайнов (runners), которые ставятся на отдельный (хотя можно и на тот же сервер), и обрабатывают пайплайны — деплоят манифесты в кубы, разворачивают докер-компоузы, или просто докерфайлы. Ну в общем там можно много ерунды костыльной нагородить, если не захотеть сделать красиво в духе Lean и лучших практик :) 

В gitlab много фич, познакомиться с которыми вы можете сами.

Справедливости ради, GitHub, BitBucket и другие git-хостинги тоже имеют свои средства cicd автоматизации, но имхо (и не только) — Gitlab выглядит самым удобным и гибким. А может он просто привычен. 

У всех этих систем есть веб интерфейс, через который, в принципе можно пользоваться прелестями git'а, но я настоятельно рекомендую работать с git'ом через cli. Пусть GitLab умеет "умно" по всякому мержить ветки, и решать некоторые простые конфликты... К этому интерфейсу можно привыкнуть и попасть в иллюзию компетентности, которая рано или поздно **обязательно** больно аукнется.

Обязательно случится так что gitlab скажет вам что-то вроде "не могу помержить, помержи локально". Или "не могу помержить, надо делать ребейз!"
И тут вы такие... А что такое ребейз...

## На десерт

Что такое ребейз и как работать с git вы можете узнать из *тонны* источников в сети. Это очень поплуярная штука. Просто загуглите. 
С упорством поиска в пару минут вы найдете видео материалы, и интерактивные тренажеры для знакомства с git. 

Если вас забанили в гугле, то вот интерактивные тренажеры:

- [Вот этот;](https://www.katacoda.com/courses/git)
- [Или этот;](https://gitimmersion.com/)
- [Тут можно разобраться с ветками;](https://learngitbranching.js.org/)

Лучше всего почитать документацию-учебник "Pro Git":
- [Вся книга онлайн и беслатно без регистрации и смс](https://git-scm.com/book/en/v2)

Там же найдете её на русском, если вдруг надо.
Всех благ, миру мир! 
А я пойду запушу этот пост в GitHub :)


