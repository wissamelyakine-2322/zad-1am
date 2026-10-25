#!/data/data/com.termux/files/usr/bin/bash
# apply_all24.sh - رياضيات السنة الرابعة متوسط (كتاب الشهاب 2019): البابان 1 و 2 (16 بطاقة) + خرائطها الذهنية
# لا يمسّ مفتاح الترخيص: يضيف ملفات جديدة ووسوم script فقط في index.html بعد نسخة احتياطية.
cd ~/zad-1am/www 2>/dev/null || cd "$(dirname "$0")/www" || { echo "لم أجد مجلد www"; exit 1; }
[ -f index.html.bak_m4 ] || cp index.html index.html.bak_m4
cat > m4_data.js <<'ZAD_EOF'
/* بيانات رياضيات السنة الرابعة متوسط (الشهاب 2019): 16 بطاقة في 2 أبواب */
var M4_MQ={"1": "الأعداد الطبيعية والأعداد الناطقة", "2": "الحساب على الجذور"};
var M4_COL={"1": "#c62828", "2": "#1565c0"};
var M4_ICO={"1": "🔢", "2": "√"};
var M4_DATA=
[{"n": 1, "m": 1, "i": "🔢", "t": "القاسم والمضاعف", "B": [["التعريف", ["a و b عددان طبيعيان و `b≠0`", "b قاسم للعدد a يعني وجود عدد طبيعي q حيث `a=b×q`", "أي أن باقي القسمة الإقليدية لـ a على b يساوي 0"]], ["مثال", ["`143=11×13` إذن 11 قاسم لـ 143", "`120=6×20` إذن 6 قاسم لـ 120 و 20 قاسم لـ 120"]], ["عبارات لها المعنى نفسه", ["b قاسم لـ a", "b يقسم a", "a يقبل القسمة على b", "a مضاعف لـ b"]], ["ملاحظات", ["1 قاسم لكل عدد طبيعي", "كل عدد طبيعي غير معدوم يقبل القسمة على نفسه `a=a×1`"]]], "K": "b قاسم لـ a معناه `a=b×q` والباقي 0؛ نقول أيضا a مضاعف لـ b.", "M": ["أتحقق بالقسمة: الباقي يساوي 0", "أكتب `a=b×q` لإثبات القسمة", "أتذكر أن 1 والعدد نفسه قاسمان دائما"], "X": "نقول إن b يقسم a إذا استطعنا توزيع a على مجموعات متساوية كل منها b دون أن يبقى شيء. مثلا 143 تُوزَّع على 11 مجموعة من 13.", "EX": [["هل 11 قاسم للعدد 143؟", "نقسم 143 على 11. `143=11×13`. الباقي 0. إذن نعم 11 قاسم لـ 143"], ["أكمل بعبارة مناسبة: 120 هو ... للعدد 6.", "`120=6×20`. إذن 120 مضاعف للعدد 6 وهو يقبل القسمة على 6"]]}, {"n": 2, "m": 1, "i": "🔍", "t": "تعيين قواسم عدد طبيعي", "B": [["الفكرة", ["إذا كان d قاسما لـ n فإن `n/d` قاسم آخر له", "القواسم تأتي في أزواج `n=d×q`"]], ["الطريقة", ["أجد العددين المتتاليين `k` و `k+1` اللذين مربعاهما يحصران n", "أختبر قسمة n على الأعداد من 1 إلى k", "لكل قاسم أكتب القاسم المقترن به"]], ["قواعد القابلية للقسمة", ["على 2: رقم الآحاد زوجي", "على 3 أو 9: مجموع الأرقام يقبل القسمة عليه", "على 5: الآحاد 0 أو 5", "على 4: العددان الأخيران يقبلان القسمة على 4"]], ["مثال: قواسم 105", ["105 بين `10^{2}` و `11^{2}`", "نختبر 1 إلى 10: يقسمه 1 و 3 و 5 و 7", "الأزواج: 1×105 و 3×35 و 5×21 و 7×15"]]], "K": "اختبر القسمة حتى الجذر التقريبي للعدد، وكل قاسم يعطي قاسما مقترنا.", "M": ["أحدد حدّ الاختبار بالمربعات", "أكتب الأزواج في جدول", "أرتب القواسم تصاعديا في الآخر"], "X": "لا داعي لاختبار كل الأعداد حتى n. يكفي أن نختبر حتى العدد الذي مربعه قريب من n، لأن كل قاسم أكبر يقابله قاسم أصغر وجدناه.", "EX": [["عيّن كل قواسم العدد 105.", "`10^{2}<105<11^{2}`. نختبر من 1 إلى 10: يقسمه 1 و 3 و 5 و 7. `105=1×105=3×35=5×21=7×15`. القواسم: 1 و 3 و 5 و 7 و 15 و 21 و 35 و 105"], ["عيّن قواسم العدد 84.", "`9^{2}=81<84<10^{2}`. نختبر 1 إلى 9: يقسمه 1 و 2 و 3 و 4 و 6 و 7. الأزواج: `1×84` و `2×42` و `3×28` و `4×21` و `6×14` و `7×12`. القواسم: 1 و 2 و 3 و 4 و 6 و 7 و 12 و 14 و 21 و 28 و 42 و 84"]]}, {"n": 3, "m": 1, "i": "⚙️", "t": "خواص قواسم عدد طبيعي", "B": [["الخاصية 1", ["a و b و n أعداد طبيعية غير معدومة", "إذا كان n يقسم a و b فإنه يقسم `a+b` و `a-b` (حيث `a≥b`)", "وإذا كان n يقسم a فإنه يقسم `k×a` لكل عدد طبيعي k"]], ["الخاصية 2", ["`a>b`", "إذا كان n يقسم a و b فإنه يقسم باقي القسمة الإقليدية لـ a على b"]], ["مثال", ["9 يقسم 90 و 900 فيقسم 810 و 990", "5 يقسم 90 و 25 فيقسم 15 باقي قسمة 90 على 25"]], ["كيف أبرهن «إذا ... فإن ...»؟", ["أفترض صحة الشرط", "أكتب الأعداد بدلالة القاسم `a=n×q`", "أستنتج النتيجة بالتعويض"]]], "K": "إذا قسم n العددين a وb فإنه يقسم مجموعهما وفرقهما وباقي قسمة a على b.", "M": ["لإثبات أن d يقسم m أكتب `m=d×k`", "أستعمل الخاصيتين لتجنب الحسابات الكبيرة", "أكتب المعطيات والمطلوب قبل البرهان"], "X": "إذا كان عدد يقسم عددين فهو يقسم كل ما يُصنع منهما بالجمع والطرح والضرب في عدد، وكذلك باقي القسمة. هذا يعطينا حيلا لتجنب الحسابات الطويلة.", "EX": [["بيّن أن 11 من قواسم 14300. ثم استنتج أن 11 من قواسم 14322.", "`14300=11×1300`. إذن 11 يقسم 14300. `14322=14300+22`. 11 يقسم 14300 ويقسم 22. إذن 11 يقسم المجموع 14322"], ["بيّن أن 7 من قواسم 217. ثم استنتج أن 7 من قواسم 21700000.", "`217=7×31`. إذن 7 يقسم 217. `21700000=217×100000`. فهو مضاعف لـ 217. إذن 7 يقسم 21700000"]]}, {"n": 4, "m": 1, "i": "🤝", "t": "القاسم المشترك الأكبر PGCD", "B": [["القواسم المشتركة", ["القواسم المشتركة لعددين هي القواسم التي تقسمهما معا", "مثال: قواسم 12 هي 1 و 2 و 3 و 4 و 6 و 12 وقواسم 18 هي 1 و 2 و 3 و 6 و 9 و 18", "المشتركة: 1 و 2 و 3 و 6"]], ["التعريف", ["أكبر قاسم مشترك لـ a و b يسمى PGCD(a;b)", "مثال: `PGCD(28;42)=14`", "القواسم المشتركة لعددين هي قواسم PGCD"]], ["نتائج مباشرة", ["`PGCD(a;a)=a` و `PGCD(a;0)=a`", "`PGCD(a;b)=PGCD(b;a)`", "إذا كان b قاسما لـ a فإن `PGCD(a;b)=b`"]], ["الطريقة", ["أعيّن قواسم كل من العددين", "أحدد المشتركة منها", "أختار أكبرها"]]], "K": "PGCD(a;b) هو أكبر عدد يقسم a و b معا.", "M": ["أكتب قواسم العددين مرتبة", "أضع علامة على المشتركة", "أختار الأكبر"], "X": "نبحث عن أكبر عدد يقسم العددين في آن واحد. مثلا لتوزيع 28 و 42 على حقائب متماثلة بأكبر عدد ممكن من الحقائب نستعمل PGCD.", "EX": [["عيّن `PGCD(42;60)`.", "قواسم 42: 1 و 2 و 3 و 6 و 7 و 14 و 21 و 42. قواسم 60: 1 و 2 و 3 و 4 و 5 و 6 و 10 و 12 و 15 و 20 و 30 و 60. المشتركة: 1 و 2 و 3 و 6. إذن `PGCD(42;60)=6`"], ["عيّن `PGCD(27;36)`.", "قواسم 27: 1 و 3 و 9 و 27. قواسم 36: 1 و 2 و 3 و 4 و 6 و 9 و 12 و 18 و 36. المشتركة: 1 و 3 و 9. إذن `PGCD(27;36)=9`"]]}, {"n": 5, "m": 1, "i": "➖", "t": "خوارزمية الفروق المتتابعة", "B": [["الخاصية", ["`a≥b`", "`PGCD(a;b)=PGCD(b;a-b)`", "لأن القواسم المشتركة للعددين هي نفسها قواسم الفرق"]], ["الطريقة", ["أطرح الأصغر من الأكبر", "أعيد العملية على العددين الجديدين (الأصغر والفرق)", "أتوقف عندما أحصل على عددين متساويين أو على الصفر"]], ["النتيجة", ["PGCD هو آخر فرق غير معدوم", "يمكن الاكتفاء بحساب الفروق فقط"]], ["مثال", ["`PGCD(117;91)`", "`117-91=26` ثم `91-26=65` ثم `65-26=39` ثم `39-26=13` ثم `26-13=13`", "آخر فرق غير معدوم 13"]]], "K": "اطرح الأصغر من الأكبر باستمرار؛ آخر فرق غير معدوم هو PGCD.", "M": ["أرتب العددين دائما: الأكبر أولا", "أكتب سطرا لكل خطوة", "أتوقف عند فرق معدوم"], "X": "نكرر عملية الطرح حتى يتساوى العددان. العدد الذي يتكرر هو أكبر قاسم مشترك. طريقة بسيطة تعتمد على الطرح فقط.", "EX": [["احسب `PGCD(117;91)` بخوارزمية الفروق.", "`117-91=26`. `91-26=65`. `65-26=39`. `39-26=13`. `26-13=13`. `13-13=0`. آخر فرق غير معدوم 13. إذن `PGCD(117;91)=13`"], ["احسب `PGCD(252;140)`.", "`252-140=112`. `140-112=28`. `112-28=84`. `84-28=56`. `56-28=28`. `28-28=0`. إذن `PGCD(252;140)=28`"]]}, {"n": 6, "m": 1, "i": "🧮", "t": "خوارزمية إقليدس", "B": [["الخاصية", ["`PGCD(a;b)=PGCD(b;r)`", "r هو باقي القسمة الإقليدية لـ a على b"]], ["الطريقة", ["أقسم a على b وأكتب `a=b×q+r`", "أعيد القسمة على العددين `b` و `r`", "أتوقف عندما يكون الباقي 0"]], ["النتيجة", ["PGCD هو آخر باقٍ غير معدوم", "طريقة أسرع من الفروق عندما يكون الفرق كبيرا"]], ["مثال", ["`PGCD(1938;836)`", "`1938=836×2+266`", "`836=266×3+38`", "`266=38×7+0` إذن 38"]]], "K": "كرّر القسمة الإقليدية حتى الباقي 0؛ آخر باقٍ غير معدوم هو PGCD.", "M": ["أكتب كل قسمة بصيغة `a=bq+r`", "المقسوم عليه الجديد هو الباقي السابق", "آخر باقٍ غير معدوم هو الجواب"], "X": "خوارزمية إقليدس أسرع من الفروق لأننا نطرح عدة مرات دفعة واحدة بالقسمة. ننتهي عند الباقي الذي لا يتبعه شيء.", "EX": [["احسب `PGCD(1938;836)` بخوارزمية إقليدس.", "`1938=836×2+266`. `836=266×3+38`. `266=38×7+0`. آخر باقٍ غير معدوم 38. إذن `PGCD(1938;836)=38`"], ["احسب `PGCD(765;135)`.", "`765=135×5+90`. `135=90×1+45`. `90=45×2+0`. آخر باقٍ غير معدوم 45. إذن `PGCD(765;135)=45`"]]}, {"n": 7, "m": 1, "i": "🧩", "t": "العددان الأوليان فيما بينهما", "B": [["التعريف", ["a و b أوليان فيما بينهما يعني `PGCD(a;b)=1`", "أي أن قاسمهما المشترك الوحيد هو 1"]], ["مثال", ["قواسم 22: 1 و 2 و 11 و 22", "قواسم 15: 1 و 3 و 5 و 15", "`PGCD(15;22)=1` فهما أوليان فيما بينهما"]], ["تنبيه", ["الأوليان فيما بينهما لا يلزم أن يكونا أوليين", "مثال: 15 و 22 ليسا أوليين لكنهما أوليان فيما بينهما", "عددان متتاليان دائما أوليان فيما بينهما"]], ["كيف أتحقق؟", ["أحسب PGCD بإقليدس", "إن كان 1 فهما أوليان فيما بينهما"]]], "K": "أوليان فيما بينهما معناه PGCD يساوي 1.", "M": ["أحسب PGCD أولا", "أفرّق بين «أولي» و«أوليان فيما بينهما»", "عدد زوجي وعدد فردي قد يكونان أوليين فيما بينهما"], "X": "عددان لا يتقاسمان إلا العدد 1 يسميان أوليين فيما بينهما، كشخصين لا يشتركان في شيء إلا الوحدة.", "EX": [["هل 143 و 153 أوليان فيما بينهما؟", "`153=143×1+10`. `143=10×14+3`. `10=3×3+1`. `3=1×3+0`. آخر باقٍ غير معدوم 1. إذن `PGCD=1` ونعم هما أوليان فيما بينهما"], ["هل العددان 27 و 36 أوليان فيما بينهما؟", "`PGCD(27;36)=9`. 9 يختلف عن 1. إذن لا، ليسا أوليين فيما بينهما"]]}, {"n": 8, "m": 1, "i": "➗", "t": "الكسور غير القابلة للاختزال", "B": [["التعريف", ["الكسر `a/b` غير قابل للاختزال إذا كان a و b أوليين فيما بينهما", "أي `PGCD(a;b)=1`"]], ["مثال", ["`15/22` غير قابل للاختزال لأن `PGCD(22;15)=1`", "`28/42` قابل للاختزال لأن `PGCD(28;42)=14`", "`28/42=(14×2)/(14×3)=2/3`"]], ["الطريقة", ["أحسب PGCD(a;b)", "أقسم البسط والمقام عليه", "أحصل على كسر غير قابل للاختزال"]], ["ملاحظة", ["القسمة على PGCD تعطي الكسر غير القابل للاختزال مباشرة", "القسمة على قاسم أصغر تحتاج لاختزال آخر"]]], "K": "اقسم البسط والمقام على PGCD فتحصل على الكسر غير القابل للاختزال.", "M": ["أحسب PGCD بخوارزمية إقليدس", "أقسم البسط والمقام عليه", "أتحقق أن الكسر الجديد أولي البسط والمقام"], "X": "اختزال الكسر هو تبسيطه حتى لا يمكن تبسيطه أكثر. نقسم الطرفين على أكبر قاسم مشترك مرة واحدة.", "EX": [["اكتب `595/560` على شكل كسر غير قابل للاختزال.", "`595=560×1+35`. `560=35×16+0`. إذن `PGCD(595;560)=35`. `595/560=(595÷35)/(560÷35)=17/16`"], ["اجعل `915/372` غير قابل للاختزال.", "`915=372×2+171`. `372=171×2+30`. `171=30×5+21`. `30=21×1+9`. `21=9×2+3`. `9=3×3+0`. إذن `PGCD(915;372)=3`. `915/372=305/124`"]]}, {"n": 9, "m": 1, "i": "🏛️", "t": "وضعية إدماجية: ترميم قصر الرياس", "B": [["المعطيات", ["عدد قطع الخزف ≤ 2443", "رقم العشرات = رقم المئات = ضعف رقم الآلاف", "يقبل القسمة على 4 وعلى 8 وعلى 10"]], ["تحليل", ["القسمة على 10 تعني أن رقم الآحاد 0", "رقم الآلاف 1 أو 2 لأن العدد ≤ 2443", "العدد من الشكل `a(2a)(2a)0`"]], ["الحالات", ["`a=1`: العدد 1220", "`a=2`: العدد 2440"]], ["الاختبار", ["`1220÷8=152,5` مرفوض", "`2440÷8=305` و `2440÷4=610` و `2440÷10=244` مقبول"]]], "K": "اكتب شروط الأرقام، ثم اختبر الحالات القليلة بقواعد القسمة.", "M": ["أحدد الشكل العام للعدد", "أحصر الاحتمالات", "أختبر القابلية للقسمة"], "X": "المسألة تطلب عددا يحقق عدة شروط معا. نحوّل كل شرط إلى قيد على الأرقام فتبقى حالتان نختبرهما.", "EX": [["ما عدد القطع الخزفية المطلوب؟", "رقم الآحاد 0 لأن العدد مضاعف لـ 10. الآلاف a: العدد ≤ 2443 فـ `a=1` أو `a=2`. العدد `1220` أو `2440`. `1220÷8=152,5` غير صحيح. `2440÷8=305`. و 2440 يقبل القسمة على 4 وعلى 10. إذن العدد 2440"], ["تحقق من أن العدد 2440 يحقق كل الشروط.", "رقم الآلاف 2 والمئات 4 والعشرات 4 وضعف 2 هو 4. الآحاد 0. `2440≤2443`. `2440=4×610=8×305=10×244`. كل الشروط محققة"]]}, {"n": 10, "m": 2, "i": "√", "t": "الجذر التربيعي لعدد موجب", "B": [["التعريف", ["a عدد موجب", "الجذر التربيعي لـ a هو العدد الموجب الذي مربعه a", "نرمز له `√a`"]], ["أمثلة", ["`√4=2` لأن `2^{2}=4`", "`√25=5` و `√0=0` و `√1=1`", "`√0,04=0,2` لأن `0,2^{2}=0,04`"]], ["خواص (a موجب)", ["`(√a)^{2}=a`", "`√(a^{2})=a`", "`(√5)^{2}=5` و `√(3^{2})=3`"]], ["تنبيه", ["الجذر التربيعي دائما موجب", "`√7` هو العدد الموجب الذي مربعه 7", "`√a` لا معنى له إذا كان a سالبا"]]], "K": "`√a` هو العدد الموجب الذي مربعه a، ولدينا `(√a)²=a` و `√(a²)=a`.", "M": ["لا أقول `√9=±3` بل `√9=3`", "`√(a²)=a` فقط إذا كان a موجبا", "أستعمل المربعات الكاملة المعروفة"], "X": "الجذر التربيعي يعكس عملية التربيع: إذا ربعنا ثم أخذنا الجذر عدنا إلى العدد الموجب.", "EX": [["احسب `1-4b^{2}+√(16b^{4})` (b عدد كيفي).", "`16b^{4}=(4b^{2})^{2}` و `4b^{2}` موجب دائما. إذن `√(16b^{4})=4b^{2}`. `1-4b^{2}+4b^{2}=1`"], ["خزان على شكل متوازي مستطيلات قاعدته مربعة، ارتفاعه 1,80 م وسعته 36 م³. أوجد طول ضلع قاعدته بالتدوير إلى 1 سم.", "مساحة القاعدة `36÷1,8=20` م². الضلع `c=√20≈4,47` م. أي حوالي 447 سم"]]}, {"n": 11, "m": 2, "i": "🔤", "t": "الأعداد الناطقة وغير الناطقة", "B": [["العدد الناطق", ["عدد يكتب على الشكل `a/b` مع a و b صحيحين و `b≠0`"]], ["الجذر وعدد ناطق", ["إذا كان a مربع عدد ناطق فإن `√a` عدد ناطق", "مثال: `25/9=(5/3)^{2}` إذن `√(25/9)=5/3`"]], ["غير الناطق", ["إذا لم يكن a مربع عدد ناطق فإن `√a` ليس ناطقا", "`√6` غير ناطق لأنه لا يوجد ناطق مربعه 6", "`√7` غير ناطق أيضا"]], ["تصنيف", ["ناطقة: `√100` و `√9` و `√0,25` و `√(16/9)`", "غير ناطقة: `√7` و `√13` و `√6` و `√(25/13)`"]]], "K": "`√a` ناطق إذا كان a مربع عدد ناطق، وإلا فهو غير ناطق.", "M": ["أبحث عن مربع كامل", "أحوّل الكسور إلى مربعات كسور", "`√n` غير ناطق إذا لم يكن n مربعا كاملا"], "X": "بعض الجذور أعداد عادية مثل 5/3، وبعضها لا يمكن كتابته ككسر مهما حاولنا مثل جذر 6. نميّز بينهما بمعرفة هل تحت الجذر مربع كامل أم لا.", "EX": [["هل `√169` عدد ناطق؟", "`169=13^{2}`. إذن `√169=13`. هو عدد صحيح فهو ناطق"], ["هل `√(25/13)` ناطق؟", "`25/13` ليس مربع عدد ناطق لأن 13 ليس مربعا كاملا. إذن `√(25/13)` غير ناطق"]]}, {"n": 12, "m": 2, "i": "⚖️", "t": "المعادلات من الشكل x² = a", "B": [["خاصية 1", ["a موجب", "يوجد عددان متعاكسان `√a` و `-√a` مربع كل منهما a"]], ["خاصية 2", ["`a>0`: حلان `√a` و `-√a`", "`a=0`: حل واحد هو 0", "`a<0`: لا حل لأن المربع موجب دائما"]], ["أمثلة", ["`x²=9`: الحلان 3 و -3", "`x²=5`: الحلان `√5` و `-√5`", "`x²=-1`: لا حل"]], ["الطريقة", ["أحدد إشارة a", "إن كان موجبا أكتب `x²=(√a)²`", "أستنتج `x=√a` أو `x=-√a`"]]], "K": "`x²=a`: حلان إن كان a موجبا، حل واحد 0 إن كان a صفرا، ولا حل إن كان سالبا.", "M": ["أنقل الحدود لأحصل على `x²=a`", "لا أنسى الحل السالب", "إذا كان الطرف الثاني سالبا فلا حل"], "X": "مربع أي عدد موجب أو سالب لا يكون سالبا. لذلك المعادلة `x²=9` لها حلان متناظران، وإذا كان الطرف الثاني سالبا فلا حل.", "EX": [["حل `x²=5` و `x²=1/4` و `x²=-9`.", "`x²=5`: `x=√5` أو `x=-√5`. `x²=1/4=(1/2)²`: `x=1/2` أو `x=-1/2`. `x²=-9`: المربع لا يكون سالبا. إذن لا حل"], ["حل `1-9x²=0` و `3+x²=0`.", "`1-9x²=0` تعطي `x²=1/9`. إذن `x=1/3` أو `x=-1/3`. `3+x²=0` تعطي `x²=-3`. لا حل"]]}, {"n": 13, "m": 2, "i": "✖️", "t": "جداء وقسمة الجذور التربيعية", "B": [["خاصية 1", ["a و b موجبان", "`√a×√b=√(a×b)`", "مثال: `√12×√3=√36=6`"]], ["خاصية 2", ["a و b موجبان و `b≠0`", "`√a/√b=√(a/b)`", "مثال: `√60/√15=√4=2`"]], ["ملاحظات", ["`√(a²b)=a√b`", "إذا كان العددان سالبين فـ `√(ab)` موجود لكن `√a` و `√b` لا معنى لهما"]], ["تنبيه مهم", ["`√(a+b)≠√a+√b`", "`√(16+9)=5` لكن `√16+√9=7`", "`√(100-36)=8` لكن `√100-√36=4`"]]], "K": "الجذر يتوافق مع الضرب والقسمة، ولا يتوافق مع الجمع والطرح.", "M": ["أستعمل الخاصية في الاتجاهين", "لا أوزّع الجذر على الجمع أو الطرح", "أتأكد أن الأعداد موجبة"], "X": "يمكن أخذ جذر الجداء بجذر كل عامل ثم الضرب، وكذلك القسمة. لكن لا يمكن فعل ذلك مع الجمع، فجذر المجموع ليس مجموع الجذرين.", "EX": [["احسب `√0,9×√0,4` و `√60/√15`.", "`√0,9×√0,4=√(0,9×0,4)=√0,36=0,6`. `√60/√15=√(60/15)=√4=2`"], ["بيّن أن `√(16+9)≠√16+√9`.", "`√(16+9)=√25=5`. `√16+√9=4+3=7`. و `5≠7`. إذن المساواة غير صحيحة"]]}, {"n": 14, "m": 2, "i": "✂️", "t": "كتابة a√b وتبسيط العبارات", "B": [["الكتابة a√b", ["لكتابة `√n` على الشكل `a√b` نبحث عن أكبر مربع كامل `a²` يقسم n", "`n=a²×b` إذن `√n=a√b`", "b أصغر ما يمكن"]], ["أمثلة", ["`√8=√(4×2)=2√2`", "`√18=√(9×2)=3√2`", "`√50=√(25×2)=5√2`", "`√63=3√7`"]], ["جمع وطرح", ["نستعمل التوزيع: `x√b+y√b=(x+y)√b`", "الجذور المتشابهة فقط يمكن جمعها"]], ["جداء جذور", ["`√(50/3)×√2×√12`", "أحسب `√50×√2=√100=10` و `√12=2√3`", "فتجد `10×2√3/√3=20`"]]], "K": "اكتب كل جذر على الشكل `a√b` ثم اجمع الجذور المتشابهة بالتوزيع.", "M": ["أبحث عن أكبر مربع كامل يقسم العدد", "أجمع الجذور التي لها نفس b", "أتحقق بالحاسبة"], "X": "نخرج من تحت الجذر كل ما هو مربع كامل. بعدها تصبح الجذور متشابهة فنجمعها كما نجمع كلمات من نفس النوع.", "EX": [["بسّط `A=√8-3√18+2√50-7√2`.", "`√8=2√2` و `√18=3√2` و `√50=5√2`. `A=2√2-3(3√2)+2(5√2)-7√2`. `=(2-9+10-7)√2`. `=-4√2`"], ["احسب `A=√(50/3)×√2×√12`.", "`A=√(50/3×2×12)`. `50/3×2×12=400`. `A=√400=20`"]]}, {"n": 15, "m": 2, "i": "🎯", "t": "نسبة مقامها عدد غير ناطق", "B": [["الفكرة", ["نحوّل `a/√b` إلى نسبة مقامها عدد ناطق", "نضرب البسط والمقام في `√b`"]], ["القانون", ["`a/√b=(a×√b)/(√b×√b)=a√b/b`", "لأن `√b×√b=b`"]], ["أمثلة", ["`2/√11=2√11/11`", "`√7/(2√5)=√35/10`"]], ["لماذا؟", ["تسهيل المقارنة والحساب", "توحيد شكل النتائج"]]], "K": "اضرب البسط والمقام في الجذر الموجود في المقام.", "M": ["أنظر إلى المقام: هل فيه جذر؟", "أضرب البسط والمقام في العدد نفسه", "أبسّط النتيجة إن أمكن"], "X": "حين يكون في المقام جذر نكتب الكسر بطريقة أخرى تجعل المقام عددا عاديا، فنضرب فوق وتحت في الجذر نفسه فلا تتغير قيمته.", "EX": [["اكتب `2/√11` و `√7/(2√5)` بمقام ناطق.", "`2/√11=(2×√11)/(√11×√11)=2√11/11`. `√7/(2√5)=(√7×√5)/(2√5×√5)=√35/10`"], ["اكتب `4/√7` بمقام ناطق.", "`4/√7=(4×√7)/(√7×√7)=4√7/7`"]]}, {"n": 16, "m": 2, "i": "🧶", "t": "وضعية إدماجية: زربية وادي سوف", "B": [["المعطيات", ["المساحة 24 م²", "الطول ضعف العرض: `L=2ℓ`", "السعر 12000 دج معلومة لا تحتاجها"]], ["العلاقة", ["`24=L×ℓ=2ℓ×ℓ=2ℓ²`", "إذن `ℓ²=12`"]], ["الحل", ["`ℓ=√12=2√3`", "`ℓ≈3,46` م", "`L=2ℓ=4√3≈6,93` م"]], ["النتيجة بالسنتيمتر", ["العرض حوالي 346 سم", "الطول حوالي 693 سم"]]], "K": "أهمل المعطيات الزائدة، واكتب المساحة بدلالة العرض ثم حل `x²=a`.", "M": ["أختار المجهول ℓ", "أكتب المساحة بدلالته", "أحل `ℓ²=12` وأقبل الحل الموجب فقط"], "X": "المسألة بسيطة إذا عرفنا أن الطول ضعف العرض. نجد أن مربع العرض 12 فيكون العرض جذر 12 أي تقريبا 3,46 متر.", "EX": [["جد طول وعرض الزربية (بالتدوير إلى 1 سم).", "نضع ℓ العرض و `L=2ℓ`. `L×ℓ=24` أي `2ℓ²=24`. `ℓ²=12`. `ℓ=√12=2√3≈3,4641` م أي 346 سم. `L=2ℓ≈6,9282` م أي 693 سم"], ["تحقق من النتيجة.", "`346×693=239778` سم². وهذا يساوي تقريبا 23,98 م². وهو قريب من 24 م² بسبب التدوير"]]}];
ZAD_EOF
cat > lessons_4am_math.js <<'ZAD_EOF'
/* دروس رياضيات السنة الرابعة متوسط (كتاب الشهاب 2019). يُحمَّل بعد lessons.js و m4_data.js */
(function(){
  if(typeof LESSONS_DB==='undefined'||typeof M4_DATA==='undefined')return;
  var KEY='__KEY__';
  var SUB={'0':'₀','1':'₁','2':'₂','3':'₃','4':'₄','5':'₅','6':'₆','7':'₇','8':'₈','9':'₉','+':'₊','-':'₋','=':'₌','(':'₍',')':'₎','a':'ₐ','e':'ₑ','h':'ₕ','i':'ᵢ','j':'ⱼ','k':'ₖ','l':'ₗ','m':'ₘ','n':'ₙ','o':'ₒ','p':'ₚ','r':'ᵣ','s':'ₛ','t':'ₜ','u':'ᵤ','v':'ᵥ','x':'ₓ'};
  var SUP={'0':'⁰','1':'¹','2':'²','3':'³','4':'⁴','5':'⁵','6':'⁶','7':'⁷','8':'⁸','9':'⁹','+':'⁺','-':'⁻','=':'⁼','(':'⁽',')':'⁾','n':'ⁿ','i':'ⁱ','k':'ᵏ','p':'ᵖ','a':'ᵃ','m':'ᵐ'};
  function conv(s,map,pre){var o='';for(var i=0;i<s.length;i++){if(!map[s[i]])return pre+'('+s+')';o+=map[s[i]]}return o}
  function fx(s){
    return String(s).replace(/`/g,'').replace(/_\{([^}]*)\}/g,function(m,a){return conv(a,SUB,'_')}).replace(/\^\{([^}]*)\}/g,function(m,a){return conv(a,SUP,'^')});
  }
  function text(c){
    var t=[];
    c.B.forEach(function(b){t.push('▸ '+fx(b[0]));b[1].forEach(function(x){t.push('• '+fx(x))})});
    t.push('▸ للحفظ');t.push('• '+fx(c.K));
    t.push('▸ طرق وقواعد');c.M.forEach(function(x){t.push('• '+fx(x))});
    t.push('▸ شرح مبسط');t.push('• '+fx(c.X));
    t.push('▸ تمارين محلولة');
    c.EX.forEach(function(e,j){t.push('• تمرين '+(j+1)+': '+fx(e[0]));t.push('• الحل: '+fx(e[1]))});
    t.push('▸ المرجع');t.push('• كتاب الرياضيات للسنة الرابعة متوسط (الشهاب 2019) — الباب '+c.m+' — ملخص بتصرف');
    return t.join('\n');
  }
  var L=M4_DATA.map(function(c){var k=c.n<10?'0'+c.n:''+c.n;return {title:k+'. '+fx(c.t),content:text(c)}});
  var A=LESSONS_DB['4AM']=LESSONS_DB['4AM']||{};
  var o=A[KEY]||{};
  o.name=o.name||'الرياضيات';
  o.lessons=L;
  o.maps='m4';
  A[KEY]=o;
})();
ZAD_EOF
cat > maps_m4.html <<'ZAD_EOF'
<!doctype html><html lang="ar" dir="rtl"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>خرائط الرياضيات - الرابعة متوسط</title>
<style>
/* Layout: sticky subject tabs; each lesson = a card with a three-column mind map (branches | centre | branches) joined by SVG curves; one column on phones. */
:root{
  --bg:#f4f5f7; --surface:#ffffff; --fg:#1d2330; --muted:#5d6678; --line:#d9dde5;
  --soft:#eceef3; --tabbg:#ffffff;
  --display:'Segoe UI',Tahoma,'Noto Naskh Arabic','Droid Arabic Naskh',system-ui,sans-serif; --body:'Segoe UI',Tahoma,'Noto Naskh Arabic','Droid Arabic Naskh',system-ui,sans-serif;
}
@media (prefers-color-scheme: dark){:root:not([data-theme="light"]){--bg:#12151c;--surface:#1a1e28;--fg:#e8ebf2;--muted:#a1a9ba;--line:#2f3544;--soft:#232837;--tabbg:#1a1e28;color-scheme:dark}}
:root[data-theme="dark"]{--bg:#12151c;--surface:#1a1e28;--fg:#e8ebf2;--muted:#a1a9ba;--line:#2f3544;--soft:#232837;--tabbg:#1a1e28;color-scheme:dark}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);font-family:var(--body);font-size:15px;line-height:1.7;
  padding-left:max(16px,env(safe-area-inset-left,0px));padding-right:max(16px,env(safe-area-inset-right,0px));padding-block:0 40px}
body::before{content:"";position:fixed;inset:0 0 auto;height:env(safe-area-inset-top,0px);z-index:10;background:var(--tabbg)}
.wrap{max-width:1180px;margin:0 auto}
header{padding:22px 0 8px}
h1{font-family:var(--display);font-size:clamp(24px,4vw,34px);margin:0;line-height:1.3;text-wrap:balance}
header p{margin:4px 0 0;color:var(--muted)}
nav.tabs{position:sticky;top:env(safe-area-inset-top,0px);z-index:9;background:var(--tabbg);border-bottom:1px solid var(--line);
  display:flex;gap:6px;overflow-x:auto;padding:8px 0;margin:8px 0 18px}
nav.tabs button{font:inherit;font-weight:700;border:1px solid var(--line);background:var(--surface);color:var(--fg);padding:6px 16px;border-radius:999px;cursor:pointer;white-space:nowrap}
nav.tabs button[aria-selected="true"]{background:var(--fg);color:var(--bg);border-color:var(--fg)}
button:focus-visible{outline:3px solid #3a6ea5;outline-offset:2px}
.axis{display:flex;align-items:center;gap:10px;margin:34px 0 14px;font-family:var(--display);font-size:22px}
.axis i{font-style:normal;font-size:26px}
.axis span.bar{flex:1;height:3px;border-radius:3px;background:var(--c)}
.axis b{color:var(--c)}
.card{background:var(--surface);border:1px solid var(--line);border-radius:14px;margin-bottom:22px;overflow:hidden}
.card>h2{margin:0;font-family:var(--display);font-size:17px;color:var(--c);padding:10px 16px;border-bottom:1px solid var(--line);display:flex;gap:8px;align-items:center;background:color-mix(in srgb,var(--c) 9%,var(--surface))}
.card>h2 small{color:var(--muted);font-family:var(--body);font-weight:600;font-size:13px;margin-inline-start:auto}
.map{position:relative;display:grid;grid-template-columns:1fr minmax(170px,230px) 1fr;gap:34px;align-items:center;padding:22px 18px}
.map svg{position:absolute;inset:0;width:100%;height:100%;pointer-events:none;overflow:visible}
.col{display:flex;flex-direction:column;gap:16px;position:relative;z-index:1}
.core{position:relative;z-index:1;text-align:center;background:var(--c);color:#fff;border-radius:50%/42%;padding:22px 14px;box-shadow:0 6px 18px color-mix(in srgb,var(--c) 40%,transparent)}
.core .ic{font-size:44px;line-height:1.1;display:block;margin-bottom:4px}
.core strong{font-family:var(--display);font-size:18px;line-height:1.5;display:block;text-wrap:balance}
.br{border:2px solid var(--bc);border-radius:12px;background:color-mix(in srgb,var(--bc) 8%,var(--surface));overflow:hidden}
.br h3{margin:0;background:var(--bc);color:#fff;font-size:14px;font-weight:700;padding:3px 12px}
.br ul{margin:0;padding:8px 12px;list-style:none;font-size:14px;line-height:1.6}
.br li{position:relative;padding-inline-start:14px;margin:2px 0}
.br li::before{content:"";position:absolute;inset-inline-start:0;top:.62em;width:7px;height:7px;border-radius:50%;background:var(--bc)}
.br li.t{padding:0;margin:0}.br li.t::before{display:none}
.br .sub{font-weight:700;color:var(--bc);margin-top:6px;font-size:13px}
.key{margin:0 18px 18px;padding:10px 14px;border-radius:10px;background:color-mix(in srgb,var(--c) 13%,var(--surface));border:1px dashed var(--c);font-weight:600}
.key b{color:var(--c)}
.extra{margin:0 18px 18px}
table{border-collapse:collapse;width:100%;font-size:14px}
th,td{border:1px solid var(--line);padding:5px 10px;text-align:start}
th{background:var(--c);color:#fff}
.tw{overflow-x:auto}
.more{border:1px solid var(--line);border-radius:10px;background:var(--surface)}.more summary{cursor:pointer;font-weight:700;padding:8px 14px;color:var(--c)}.more p{margin:0;padding:4px 14px 8px}.ev{margin:0;padding:0 14px 12px 14px;list-style:none}.ev li{padding:6px 10px;margin-top:6px;border-radius:8px;background:color-mix(in srgb,var(--c) 9%,var(--surface));font-size:16px;line-height:2}
.note{color:var(--muted);font-size:13px;margin-top:30px}
@media (max-width:760px){
  .map{grid-template-columns:1fr;gap:14px;padding:16px 12px}
  .map svg{display:none}
  .core{order:-1;border-radius:20px;padding:16px;display:flex;align-items:center;gap:12px;text-align:start}
  .core .ic{font-size:36px;margin:0}
  .col{gap:14px}
}
@media print{nav.tabs{display:none}}
.m{unicode-bidi:isolate;direction:ltr;font-family:'DejaVu Sans',system-ui,sans-serif;}.st{margin:4px 0;padding-right:10px;border-right:3px solid var(--c)}.m sub,.m sup{font-size:.7em}.ex{margin:10px 0;padding:8px 10px;border-radius:8px;background:color-mix(in srgb,var(--c) 7%,var(--surface))}.sol{margin-top:6px;padding-top:6px;border-top:1px dashed var(--c)}.how{margin-top:8px}</style></head><body>

<div class="wrap" dir="rtl">
<header>
  <h1>الرياضيات - السنة الرابعة متوسط</h1>
  <p>مرتبة بحسب أبواب الكتاب</p>
</header>
<nav class="tabs" id="tabs" role="tablist"></nav>
<main id="main"></main>
<p class="note">ملاحظة: هذه ملخصات ومراجعات مبنية على كتاب الرياضيات للسنة الرابعة متوسط (الشهاب 2019) ومصاغة بتصرف، والأمثلة والتمارين المحلولة من إعداد التطبيق. طابقها مع كتابك وتوجيهات أستاذك.</p>
</div>
<script src="m4_data.js"></script>
<script>
const PAL=['#e4572e','#17a398','#3a6ea5','#c98a00','#8e44ad','#2e9e5b'];
const esc=s=>{
  const e=x=>String(x).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
  return String(s).split('`').map((p,i)=>{
    if(i%2===0)return e(p);
    return '<bdi dir="ltr" class="m">'+e(p).replace(/_\{([^}]*)\}/g,'<sub>$1</sub>').replace(/\^\{([^}]*)\}/g,'<sup>$1</sup>')+'</bdi>';
  }).join('');
};
const steps=t=>t.split(/\.\s+(?=\S)/).map(z=>z.replace(/\.$/,'')).filter(Boolean);
function branch(b,idx){
  const items=b[1].map(it=>'<li>'+esc(it)+'</li>').join('');
  return '<div class="br" data-br style="--bc:'+PAL[idx%PAL.length]+'"><h3>'+esc(b[0])+'</h3><ul>'+items+'</ul></div>';
}
function card(n,c,ic,t,bs,k,x,sub){
  const A=[],B=[];bs.forEach((b,i)=>(i%2?B:A).push(branch(b,i)));
  return '<section class="card" style="--c:'+c+'"><h2><span>'+ic+'</span>'+(n?'<span>'+n+'</span>':'')+'<small>'+(sub||'')+'</small></h2>'
  +'<div class="map"><svg aria-hidden="true"></svg><div class="col">'+A.join('')+'</div>'
  +'<div class="core" data-core><span class="ic">'+ic+'</span><strong>'+esc(t)+'</strong></div><div class="col">'+B.join('')+'</div></div>'
  +'<div class="key"><b>للحفظ:</b> '+esc(k)+'</div>'+(x?x:'')+'</section>';
}
function cardFor(l){
  const ex=l.EX.map((e,j)=>'<div class="ex"><b>تمرين '+(j+1)+':</b> '+esc(e[0])+'<div class="sol"><b>الحل:</b>'+steps(e[1]).map(z=>'<div class="st">'+esc(z)+'</div>').join('')+'</div></div>').join('');
  const x='<div class="extra"><b>طرق وقواعد:</b><ul>'+l.M.map(a=>'<li>'+esc(a)+'</li>').join('')+'</ul><div class="how"><b>شرح مبسط:</b> '+esc(l.X)+'</div></div><div class="extra"><b>تمارين محلولة بالتفصيل:</b>'+ex+'</div>';
  return card(l.n,M4_COL[l.m],l.i,l.t,l.B,l.K,x,'الباب '+l.m);
}
function tab(m){return M4_DATA.filter(l=>l.m===m).map(cardFor).join('')}
const MS=Object.keys(M4_MQ).map(Number);
const tabs=document.getElementById('tabs'),main=document.getElementById('main');
function show(m){
  MS.forEach(i=>{document.getElementById('t-'+i).setAttribute('aria-selected',i===m)});
  main.innerHTML=tab(m);window.scrollTo(0,0);
  try{localStorage.setItem('m4tab',String(m))}catch(e){}
  requestAnimationFrame(draw);
}
MS.forEach(i=>{const b=document.createElement('button');b.id='t-'+i;b.role='tab';b.textContent=M4_ICO[i]+' '+M4_MQ[i];b.onclick=()=>show(i);tabs.appendChild(b)});
function draw(){
  document.querySelectorAll('.map').forEach(m=>{
    const svg=m.querySelector('svg');if(getComputedStyle(svg).display==='none')return;
    const r=m.getBoundingClientRect(),core=m.querySelector('[data-core]').getBoundingClientRect();
    const cx=core.left+core.width/2-r.left,cy=core.top+core.height/2-r.top;let p='';
    m.querySelectorAll('[data-br]').forEach(b=>{
      const q=b.getBoundingClientRect(),bx=q.left+q.width/2-r.left,by=q.top+q.height/2-r.top,right=bx>cx;
      const x1=right?q.left-r.left:q.right-r.left, x0=right?core.right-r.left:core.left-r.left, y0=cy+(by-cy)*0.15;
      const mx=(x0+x1)/2;
      p+='<path d="M'+x0+','+y0+' C'+mx+','+y0+' '+mx+','+by+' '+x1+','+by+'" fill="none" stroke="'+getComputedStyle(b).getPropertyValue('--bc')+'" stroke-width="3" stroke-linecap="round" opacity=".85"/>';
    });
    svg.innerHTML=p;
  });
}
addEventListener('resize',draw);
if(document.fonts&&document.fonts.ready)document.fonts.ready.then(draw);
let first=1;
try{const h=parseInt(location.hash.slice(1).replace(/\D/g,''),10);const s=parseInt(localStorage.getItem('m4tab'),10);if(MS.includes(h))first=h;else if(MS.includes(s))first=s}catch(e){}
show(first);
</script>
</body></html>
ZAD_EOF
cat > maps_m4_hook.js <<'ZAD_EOF'
/* فتح خرائط رياضيات 3AS آداب ولغات (maps:'m4') من maps_m4.html؛ بقية المواد كما كانت. يُحمَّل بعد maps_hg_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='m4'){openWebview('maps_m4.html','🗺️ خرائط الرياضيات - الرابعة متوسط');return}}catch(e){}
    return o(k);
  };
})();
ZAD_EOF

# --- اكتشاف مفتاح مادة الرياضيات للرابعة متوسط في db.js ---
LV=$(tr -d '\n' < db.js | sed 's/"name": *"السنة/\n&/g' | grep 'السنة الرابعة متوسط' | head -1)
KEY=""
for k in math maths mat mth ma m; do
  if printf '%s' "$LV" | grep -q "\"$k\": *{\"links\""; then KEY=$k; break; fi
done
if [ -z "$KEY" ]; then
  KEY=$(printf '%s' "$LV" | grep -o '"key": *"[^"]*", *"name": *"الرياضيات[^"]*"' | head -1 | sed 's/"key": *"\([^"]*\)".*/\1/')
fi
if [ -z "$KEY" ]; then
  KEY=$(printf '%s' "$LV" | grep -o '"name": *"الرياضيات[^"]*", *"key": *"[^"]*"' | head -1 | sed 's/.*"key": *"\([^"]*\)".*/\1/')
fi
if [ -z "$KEY" ]; then
  printf '%s' "$LV" | head -c 3000 > ~/storage/downloads/m4_diag.txt
  echo "لم أجد مادة الرياضيات للرابعة متوسط في db.js. كتبتُ تشخيصا في التنزيلات: m4_diag.txt - أرسله لي."
  echo "لم يُربط شيء بالتطبيق بعد (الملفات الجديدة فقط في www)."
  exit 1
fi
echo "مفتاح المادة: $KEY"
sed -i "s/__KEY__/$KEY/" lessons_4am_math.js

# --- ربط الملفات في index.html (مرة واحدة فقط) ---
if ! grep -q 'lessons_4am_math.js' index.html; then
  LN=$(grep -n '<script src="lessons' index.html | tail -1 | cut -d: -f1)
  if [ -n "$LN" ]; then
    sed -i "${LN}a <script src=\"m4_data.js\"></script>\n<script src=\"lessons_4am_math.js\"></script>" index.html
  else
    echo "تنبيه: لم أجد وسوم lessons في index.html"
  fi
fi
if ! grep -q 'maps_m4_hook.js' index.html; then
  if grep -q 'maps_m3_hook.js' index.html; then
    sed -i '/maps_m3_hook.js/a <script src="maps_m4_hook.js"></script>' index.html
  elif grep -q 'maps_4am_hook.js' index.html; then
    sed -i '/maps_4am_hook.js/a <script src="maps_m4_hook.js"></script>' index.html
  else
    sed -i '/maps_hg_hook.js/a <script src="maps_m4_hook.js"></script>' index.html
  fi
fi

echo "---- تحقق ----"
ls -l m4_data.js lessons_4am_math.js maps_m4.html maps_m4_hook.js
grep -n 'm4_data.js\|lessons_4am_math.js\|maps_m4_hook.js' index.html
echo "تم. نسخة احتياطية: index.html.bak_m4"
