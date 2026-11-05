#!/data/data/com.termux/files/usr/bin/bash
# apply_all42.sh - الإعلام الآلي للأولى ثانوي: الجزء 1 = 26 بطاقة + الخرائط الذهنية (زر 🗺️)
# لا يمسّ مفتاح الترخيص: يضيف ملفات جديدة ووسوم script فقط في index.html بعد نسخة احتياطية.
cd ~/zad-1am/www 2>/dev/null || cd "$(dirname "$0")/www" || { echo "لم أجد مجلد www"; exit 1; }
[ -f index.html.bak_in1 ] || cp index.html index.html.bak_in1

# --- اكتشاف مفتاح مادة الإعلام الآلي في الأولى ثانوي (كل الشعب) من db.js ---
CH=$(tr -d '\n' < db.js | sed 's/"AS1": *{"name"/\n&/' | tail -1 | sed 's/"AS2": *{"name".*//')
KI=$(printf '%s' "$CH" | grep -o '"key": *"[^"]*", *"name": *"[^"]*\(الإعلام الآلي\|الاعلام الآلي\|الإعلام الالي\|الاعلام الالي\|المعلوماتية\)[^"]*"' | sed 's/"key": *"\([^"]*\)".*/\1/' | sort -u)
if [ -z "$KI" ]; then
  printf '%s' "$CH" | head -c 4000 > ~/storage/downloads/in1_diag.txt
  echo "لم أجد مادة الإعلام الآلي للأولى ثانوي في db.js. كتبتُ تشخيصا في التنزيلات: in1_diag.txt - أرسله لي."
  echo "لم يُغيَّر شيء."
  exit 1
fi
JI=$(printf '%s\n' $KI | sed 's/.*/"&"/' | paste -sd, | sed 's/^/[/;s/$/]/')
echo "مفاتيح الإعلام الآلي: $JI"

cat > in1_data.js <<'ZAD_EOF'
/* بيانات الإعلام الآلي للسنة الأولى ثانوي: 26 بطاقة */
var IN1_MQ={"i1": "الفصل 1 — مفاهيم أولية", "i2": "الفصل 2 — Windows XP", "i3": "الفصل 3 — معالج النصوص Word"};
var IN1_COL={"i1": "#1565c0", "i2": "#2e7d32", "i3": "#ef6c00"};
var IN1_ICO={"i1": "🖥️", "i2": "🪟", "i3": "📄"};
var IN1_SUB={"i1": "الإعلام الآلي — مفاهيم أولية", "i2": "الإعلام الآلي — Windows XP", "i3": "الإعلام الآلي — Word"};
var IN1_DATA=
[{"m": 1, "i": "💻", "t": "تعريف الإعلام الآلي والكمبيوتر", "B": [["الإعلام الآلي (Informatique)", ["علم يسمح بمعالجة المعلومات بطريقة آلية", "أي باستعمال الكمبيوتر وباتباع برنامج مخزن مسبقا"]], ["جزآن أساسيان متكاملان", ["العتاد (Matériel) = الكمبيوتر نفسه", "البرمجيات (Logiciels) = البرامج التي تسمح باستعمال الكمبيوتر"]], ["الكمبيوتر", ["جهاز يسمح باستقبال المعلومات وتخزينها ومعالجتها وإخراج النتائج المطلوبة", "مخطط: معطيات (مدخلات) ← معالجة ← نتائج (مخرجات)"]]], "K": "الإعلام الآلي = العتاد + البرمجيات؛ الكمبيوتر: مدخلات ← معالجة ← مخرجات.", "M": ["لا يعمل العتاد دون برنامج، ولا قيمة للبرنامج دون عتاد"], "X": "الكمبيوتر كالطباخ: تعطيه المكونات (معطيات)، يطبخ حسب الوصفة (البرنامج)، فيعطيك الطبق (النتائج).", "EX": [["ما جزآ الإعلام الآلي؟", "العتاد (الكمبيوتر) والبرمجيات (البرامج)."], ["ما مراحل عمل الكمبيوتر؟", "إدخال المعطيات، معالجتها، ثم إخراج النتائج."]], "n": 1, "s": "i", "k": "i1"}, {"m": 1, "i": "⌨️", "t": "المكونات الأساسية: لوحة المفاتيح والشاشة", "B": [["تصنيف المكونات", ["مكونات أساسية ومكونات ثانوية"]], ["لوحة المفاتيح (Clavier)", ["وحدة إدخال المعلومات في الكمبيوتر"]], ["الشاشة (Ecran)", ["وحدة إخراج وإظهار المعلومات المخزنة في الكمبيوتر"]]], "K": "لوحة المفاتيح = إدخال؛ الشاشة = إخراج.", "M": ["وحدة إدخال: لوحة المفاتيح، الفأرة، الماسح الضوئي", "وحدة إخراج: الشاشة، الطابعة، مكبر الصوت"], "X": "لوحة المفاتيح تسمع للكمبيوتر ما نريد، والشاشة تُريه لنا ما فعل.", "EX": [["ما دور لوحة المفاتيح؟", "إدخال المعلومات إلى الكمبيوتر."], ["ما دور الشاشة؟", "إظهار المعلومات والنتائج."]], "n": 2, "s": "i", "k": "i1"}, {"m": 1, "i": "🖥️", "t": "الوحدة المركزية: المظهر الخارجي واللوحة الأم", "B": [["المظهر الخارجي (أمامي)", ["زر التشغيل / إيقاف التشغيل", "زر إعادة التشغيل (Reset)", "قارئ الأقراص المرنة وقارئ الأقراص المضغوطة"]], ["الجهة الخلفية", ["تحوي الروابط اللازمة لربط الوحدة المركزية بالوحدات الأخرى", "والمأخذ الكهربائي"]], ["المكونات الداخلية", ["اللوحة الأم (Carte mère): أكبر قطعة في الكمبيوتر", "تحوي أساسا: المعالج، القرص الصلب، الذاكرة المركزية"]]], "K": "الوحدة المركزية تضم اللوحة الأم التي تحمل المعالج والذاكرة والقرص الصلب.", "M": ["الجهة الأمامية: أزرار وقارئات؛ الخلفية: الروابط والمأخذ الكهربائي"], "X": "اللوحة الأم كالمدينة التي تُبنى عليها كل المرافق (المعالج، الذاكرة، القرص) وتصلها الطرق.", "EX": [["أين نجد زر Reset؟", "في الواجهة الأمامية للوحدة المركزية."], ["ما أكبر قطعة داخل الكمبيوتر؟", "اللوحة الأم (Carte mère)."]], "n": 3, "s": "i", "k": "i1"}, {"m": 1, "i": "🧠", "t": "المعالج والقرص الصلب", "B": [["المعالج (Processeur)", ["دارة مندمجة (Circuit Intégré)", "هو عقل الكمبيوتر: يسيّر ويراقب وينسق كل المهام داخله", "سرعته كبيرة وتحسب بالـ Mhz أو Ghz"]], ["القرص الصلب (Disque Dur)", ["قرص ثابت ذو سعة كبيرة", "موضوع داخل الوحدة المركزية"]], ["مثال", ["Intel Pentium 4: مثال على معالج"]]], "K": "المعالج = عقل الكمبيوتر (Mhz/Ghz)؛ القرص الصلب = تخزين كبير ثابت.", "M": ["Ghz أكبر من Mhz (1 Ghz = 1000 Mhz)"], "X": "المعالج هو المدير الذي يوزع الأعمال، والقرص الصلب هو المخزن الكبير للأرشيف.", "EX": [["بماذا تقاس سرعة المعالج؟", "بالـ Mhz أو الـ Ghz."], ["أين يوجد القرص الصلب؟", "داخل الوحدة المركزية."]], "n": 4, "s": "i", "k": "i1"}, {"m": 1, "i": "🧮", "t": "الذاكرة المركزية: RAM و ROM", "B": [["RAM (الذاكرة الحية)", ["Random Access Memory", "تخزن المعلومات أثناء المعالجة", "تُمحى بمجرد انقطاع التيار الكهربائي (Mémoire volatile)"]], ["ROM (الذاكرة الميتة)", ["Read Only Memory", "تحتوي معلومات ضرورية لتشغيل الكمبيوتر (BIOS)", "لا يمكن تغيير محتواها، ولا تُمحى بانقطاع التيار (non volatile)"]], ["الفرق", ["RAM: مؤقتة وقابلة للتغيير · ROM: دائمة للقراءة فقط"]]], "K": "RAM مؤقتة (volatile)، ROM دائمة (non volatile) وفيها BIOS.", "M": ["الذاكرة المركزية = RAM + ROM"], "X": "RAM كطاولة العمل: تُمسح عند الانتهاء. ROM كدليل التعليمات المطبوع: لا يتغير.", "EX": [["ماذا يحدث لـ RAM عند انقطاع الكهرباء؟", "تُمحى المعلومات (ذاكرة متطايرة)."], ["ماذا تحتوي ROM؟", "BIOS: معلومات ضرورية لتشغيل الكمبيوتر."]], "n": 5, "s": "i", "k": "i1"}, {"m": 1, "i": "💾", "t": "الذاكرات الثانوية (الأقراص)", "B": [["القرص المرن (Disquette)", ["قرص صغير يقرأ بقارئ الأقراص المرنة المثبت في الوحدة المركزية"]], ["القرص المضغوط (Cd-Rom)", ["سعته أكبر بكثير من المرن", "يقرأ بقارئ الأقراص المضغوطة"]], ["القرص فلاش (Disque flash)", ["سعة كبيرة، قابل للقراءة والكتابة", "يتصل بالوحدة المركزية عبر المنفذ USB"]]], "K": "الذاكرات الثانوية تخزن المعلومات بصفة دائمة: مرن، مضغوط، فلاش، صلب.", "M": ["السعات: مرن ≈ 1,44 ميغا · مضغوط ≈ 650 ميغا · صلب 40–80 جيغا · فلاش 128–256 ميغا (حسب الكتاب)"], "X": "هي صناديق الحفظ الدائم: تبقى معلوماتها حتى بعد إطفاء الجهاز.", "EX": [["بأي منفذ يتصل قرص الفلاش؟", "منفذ USB."], ["رتب حسب السعة: مرن، مضغوط، صلب.", "المرن (1,44 ميغا) < المضغوط (650 ميغا) < الصلب (عشرات الجيغا)."]], "n": 6, "s": "i", "k": "i1"}, {"m": 1, "i": "📏", "t": "وحدات قياس الذاكرة", "B": [["الأوكتي (Octet, الرمز Ø)", ["الموضع الواحد في الذاكرة يسع حرفا (caractère) واحدا: حرف أو رقم أو رمز"]], ["المضاعفات", ["1 كيلو أوكتي = 2^10 أوكتي", "1 ميغا أوكتي = 2^20 أوكتي", "1 جيغا أوكتي = 2^30 أوكتي", "1 تيرا أوكتي = 2^40 أوكتي"]], ["أمثلة السعات", ["مرن 1,44 ميغا · مضغوط ≈ 650 ميغا", "صلب 40–80 جيغا · فلاش 128–256 ميغا · RAM 256–512 ميغا"]]], "K": "الأوكتي = حرف واحد؛ ثم كيلو، ميغا، جيغا، تيرا (كل مرة ×2^10).", "M": ["2^10 = 1024"], "X": "كل مضاعف أكبر من سابقه بنحو ألف مرة: كيلو < ميغا < جيغا < تيرا.", "EX": [["كم حرفا يسع 1 أوكتي؟", "حرفا واحدا."], ["أيهما أكبر: ميغا أوكتي أم جيغا أوكتي؟", "الجيغا أوكتي."]], "n": 7, "s": "i", "k": "i1"}, {"m": 1, "i": "🖱️", "t": "المحيطات (Périphériques)", "B": [["التعريف", ["كل جهاز يوصل بالكمبيوتر ويقوم بدور معين"]], ["أمثلة (1)", ["الفأرة (Souris): تسهل العمل وتعوض بعض أعمال لوحة المفاتيح؛ زر أيمن وأيسر وعجلة", "مكبر الصوت (Haut-parleur): نسمع به الملفات الصوتية المخزنة"]], ["أمثلة (2)", ["الطابعة (Imprimante): تطبع المعلومات على الورق", "الماسح الضوئي (Scanner): إدخال الصور لتخزينها أو تغييرها أو إرسالها", "مخزن الطاقة (Onduleur): يغذي الكمبيوتر عند انقطاع التيار"]]], "K": "المحيطات: أجهزة موصولة بالكمبيوتر لكل منها دور (فأرة، طابعة، ماسح...).", "M": ["Scanner = إدخال صور؛ Imprimante = إخراج على ورق"], "X": "المحيطات كأعضاء مساعدة حول الجسم الرئيسي، لكل منها وظيفة.", "EX": [["ما دور Onduleur؟", "يخزن الطاقة ويغذي الكمبيوتر عند انقطاع التيار الكهربائي."], ["ما دور الماسح الضوئي؟", "إدخال الصور إلى الكمبيوتر لتخزينها أو تغييرها أو إرسالها."]], "n": 8, "s": "i", "k": "i1"}, {"m": 1, "i": "📜", "t": "البرمجيات: البرنامج ونظام التشغيل والتطبيقات", "B": [["البرنامج (Programme)", ["مجموعة من التعليمات المتسلسلة تسمح بأداء مهمة معينة", "مثال: حساب أ × ب + ج: إعطاء القيم ← حساب أ×ب = د ← حساب د+ج = هـ ← إظهار النتيجة هـ"]], ["نظام التشغيل (Système d'exploitation)", ["برامج تسمح باستغلال الكمبيوتر وملحقاته وتنفيذ البرامج الأخرى", "أمثلة: Unix، Windows"]], ["البرامج التطبيقية", ["كل البرامج المستعملة في ميادين مختلفة", "معالج النصوص WORD · المجدول EXCEL · برنامج الرسم · برنامج التسيير"]]], "K": "برنامج = تعليمات متسلسلة؛ نظام التشغيل يسيّر الجهاز؛ التطبيقات للأعمال (Word، Excel).", "M": ["الترتيب: تعليمات متسلسلة (خوارزمية بسيطة)"], "X": "نظام التشغيل هو المسيّر، والتطبيقات هي الأدوات التي نعمل بها فوقه.", "EX": [["اذكر نظامي تشغيل.", "Windows و Unix."], ["اذكر برنامجين تطبيقيين.", "Word (معالج نصوص) و Excel (مجدول)."]], "n": 9, "s": "i", "k": "i1"}, {"m": 1, "i": "🌐", "t": "مفهوم الشبكة", "B": [["التعريف", ["عدة أجهزة كمبيوتر متصلة ببعضها بأسلاك (câbles) أو بدونها (بهوائي / antenne)"]], ["الفائدة", ["تبادل المعلومات بين مستعملي الأجهزة", "تسهيل مشاركة الموارد (برامج أو ملحقات)"]], ["المخطط", ["الأجهزة (Ordinateur de bureau) موصولة بموزع HUB في الوسط"]]], "K": "الشبكة = أجهزة متصلة لتبادل المعلومات ومشاركة الموارد.", "M": ["HUB = موزع الشبكة"], "X": "كأن عدة أجهزة تتحدث وتتشارك الطابعة عبر خط واحد.", "EX": [["ما فائدة الشبكة؟", "تبادل المعلومات ومشاركة الموارد كالبرامج والطابعة."], ["بماذا تتصل أجهزة الشبكة؟", "بأسلاك أو لاسلكيا عبر هوائي."]], "n": 10, "s": "i", "k": "i1"}, {"m": 1, "i": "🕰️", "t": "نبذة تاريخية: الأجيال الثلاثة الأولى", "B": [["البدايات", ["الصينيون: جهاز الكريات (boulier chinois) منذ نحو 2000 سنة قبل الميلاد", "1643: Blaise Pascal اخترع آلة ميكانيكية تجمع وتطرح فقط", "أول كمبيوتر ظهر بعد الحرب العالمية الثانية"]], ["الجيل الأول (الخمسينيات)", ["كمبيوتر UNIVAC", "صمامات مفرغة: حرارة عالية، استهلاك كبير للطاقة، حجم كبير ووزن ثقيل", "سرعة بطيئة (≈ 20 ألف عملية/ثانية)، لغة الآلة (النظام الثنائي)، برامج معقدة"]], ["الجيل الثاني (1959–1965)", ["الترانزستور بدل الصمامات: أصغر حجما وأطول عمرا، طاقة أقل", "سرعة مئات الآلاف في الثانية، أشرطة ممغنطة وأقراص صلبة، لغات راقية: Cobol، Fortran"]], ["الجيل الثالث (1965–1970)", ["دوائر متكاملة من السيليكون: حجم أصغر وتكلفة أقل", "حاسبات IBM 360، شاشات ملونة وأجهزة قراءة ضوئية، حواسيب متوسطة بأجهزة طرفية (terminaux)"]]], "K": "جيل1: صمامات · جيل2: ترانزستور · جيل3: دوائر متكاملة (IBM 360).", "M": ["سرعة جيل3 تقاس بعدد العمليات/نانوثانية"], "X": "كل جيل أصغر وأسرع وأرخص من سابقه بفضل تقنية جديدة.", "EX": [["ما التقنية المميزة للجيل الثاني؟", "الترانزستور بدل الصمامات المفرغة."], ["ما الحاسب المشهور للجيل الثالث؟", "سلسلة IBM 360."]], "n": 11, "s": "i", "k": "i1"}, {"m": 1, "i": "🚀", "t": "نبذة تاريخية: الجيلان الرابع والخامس", "B": [["الجيل الرابع (1970–1980)", ["ثورة في العتاد والبرمجيات معا", "دوائر متكاملة كبيرة LSI", "صغر الحجم وزيادة السرعة والدقة والوثوقية وسعة الذاكرة وقلة التكلفة", "السرعة تقاس بملايين العمليات في الثانية"]], ["ما ظهر في الجيل الرابع", ["الذاكرة العشوائية RAM والدائمة ROM", "أجهزة إدخال/إخراج أكثر تطورا", "نظم التشغيل، الحاسبات الشخصية، لغات المستوى الراقي", "الأقراص الصلبة المصغرة والمرنة والراسمات"]], ["الجيل الخامس", ["زيادة هائلة في السرعات وسعات التخزين", "الذكاء الاصطناعي ولغات متطورة جدا", "حواسيب عملاقة بدقة عالية جدا؛ يتعامل معها الإنسان مباشرة (مدخلات محكية ومكتوبة ومرسومة)"]]], "K": "جيل4: LSI والحاسب الشخصي؛ جيل5: الذكاء الاصطناعي.", "M": ["الحاسبات الشخصية ظهرت بفضل تطور نظم التشغيل"], "X": "من آلة ضخمة لغرفة كاملة إلى حاسوب في الجيب وذكاء اصطناعي.", "EX": [["ما اختصار LSI؟", "الدوائر المتكاملة الكبيرة."], ["ما ميزة الجيل الخامس؟", "الذكاء الاصطناعي وسرعات وسعات تخزين هائلة."]], "n": 12, "s": "i", "k": "i1"}, {"m": 2, "i": "🪟", "t": "تعريف Windows وتقديم الشاشة", "B": [["Windows", ["نظام تشغيل بياني يسمح باستعمال الكمبيوتر وملحقاته (الأقراص، الطابعة، الماسح...)", "ويسمح بتشغيل البرامج الأخرى", "آخر إصدار (في الكتاب): Windows XP"]], ["الشاشة", ["سطح المكتب (Bureau): أكبر مساحة، تظهر عليه الأيقونات", "الأيقونات · شريط المهام · الزر Démarrer"]], ["الأيقونات (Icônes)", ["رموز تمثل ملفات أو مجلدات أو برامج أو أقراصا أو طابعات", "أنواعها: أيقونة نظام (سلة المحذوفات، جهاز الكمبيوتر) · أيقونة ملف أو برنامج · الاختصار (سهم صغير أسفلها)"]]], "K": "Windows نظام تشغيل بياني؛ سطح المكتب يضم الأيقونات وشريط المهام وزر Démarrer.", "M": ["الاختصار يُعرف بسهم صغير في الأسفل"], "X": "سطح المكتب كطاولة مكتبك: عليها أدواتك (الأيقونات)، وفي أسفلها شريط المهام.", "EX": [["كيف نميز الاختصار؟", "بسهم صغير في أسفل الأيقونة."], ["ما هو سطح المكتب؟", "المساحة الأكبر في الشاشة التي تظهر عليها الأيقونات وشريط المهام وزر Démarrer."]], "n": 13, "s": "i", "k": "i2"}, {"m": 2, "i": "🖱️", "t": "العمليات على الأيقونات والنقر", "B": [["فتح أيقونة", ["بالنقر المزدوج بالزر الأيسر للفأرة، فتظهر نافذة"]], ["سحب أيقونة", ["بالضغط على الزر الأيسر مع تحريك الفأرة دون رفع اليد"]], ["النقر بالزر الأيمن", ["تظهر قائمة (menu contextuel) فيها كل العمليات الممكنة: Ouvrir, Couper, Créer un raccourci, Supprimer, Renommer, Propriétés"]]], "K": "نقر مزدوج = فتح؛ سحب = نقل؛ نقر أيمن = قائمة سياقية.", "M": ["الزر الأيسر للاختيار والفتح؛ الأيمن للقائمة"], "X": "النقر الأيمن يعطيك قائمة بكل ما يمكنك فعله بهذا العنصر.", "EX": [["كيف نفتح أيقونة؟", "بالنقر المزدوج بالزر الأيسر."], ["ماذا يظهر عند النقر بالزر الأيمن؟", "القائمة السياقية (menu contextuel) بالعمليات الممكنة."]], "n": 14, "s": "i", "k": "i2"}, {"m": 2, "i": "🗑️", "t": "سلة المحذوفات وجهاز الكمبيوتر", "B": [["سلة المحذوفات (Corbeille)", ["مكان تخزين الملفات المحذوفة مؤقتا لاسترجاعها عند الخطأ", "للاسترجاع: نحدد الملف ثم Restaurer", "للتفريغ: Vider la corbeille"]], ["جهاز الكمبيوتر (Poste de travail)", ["بنقرتين نحصل على نافذة تظهر محتويات الجهاز ومحركات الأقراص وإدارة الملفات", "A: القرص المرن · C: القرص الصلب · D: القرص المضغوط (حسب الكتاب)"]], ["عرض محتوى قرص", ["نتأكد من وجوده داخل الكمبيوتر ثم ننقر مزدوجا على رمزه (مثل C:)"]]], "K": "Corbeille للاسترجاع/التفريغ؛ Poste de travail لعرض الأقراص والملفات.", "M": ["Restaurer = استرجاع · Vider la corbeille = تفريغ"], "X": "السلة كسلة مهملات مكتبك: يمكنك استرجاع ما رميته قبل أن تفرغها.", "EX": [["كيف نسترجع ملفا محذوفا؟", "نفتح Corbeille، نحدد الملف، ثم نختار Restaurer."], ["أي حرف يرمز للقرص الصلب والمرن؟", "C للقرص الصلب، A للقرص المرن."]], "n": 15, "s": "i", "k": "i2"}, {"m": 2, "i": "🪟", "t": "شريط المهام والنافذة وعلبة الحوار", "B": [["شريط المهام (Barre des tâches)", ["أسفل سطح المكتب: الزر Démarrer يسارا، الوقت يمينا، رمز اللغة، البرامج النشطة"]], ["النافذة (Fenêtre)", ["شريط العنوان · شريط القوائم · أزرار: تصغير، تكبير/استرجاع، إغلاق · شريطا التمرير العمودي والأفقي"]], ["علبة الحوار (Boîte de dialogue)", ["نافذة خاصة بأزرار (OK, Annuler, Oui, Non) تسمح بالحوار مع النظام", "مثال: Voulez-vous enregistrer les modifications ?"]]], "K": "النافذة: عنوان + قوائم + أزرار (تصغير/تكبير/إغلاق)؛ علبة الحوار: OK/Annuler/Oui/Non.", "M": ["Oui = نعم · Non = لا · Annuler = إلغاء · OK = موافق"], "X": "كل برنامج يفتح في نافذة بنفس العناصر، وعلبة الحوار تسألك سؤالا فتجيب بزر.", "EX": [["اذكر ثلاثة أزرار في النافذة.", "التصغير، التكبير/الاسترجاع، الإغلاق."], ["ما فائدة علبة الحوار؟", "الحوار مع النظام لتأكيد عملية أو اختيار خيار."]], "n": 16, "s": "i", "k": "i2"}, {"m": 2, "i": "🚀", "t": "قائمة Démarrer وتنفيذ البرامج", "B": [["قائمة Démarrer", ["تظهر بالنقر على الزر Démarrer أو بمفتاح Windows أو Ctrl + Esc", "يسارا: اختصارات لبرامج + Tous les programmes", "يمينا: Mes documents, Poste de travail, Panneau de configuration, Rechercher, Exécuter..."]], ["إيقاف التشغيل", ["في الأسفل زران: Fermer la session و Arrêter l'ordinateur"]], ["تنفيذ برنامج", ["Démarrer ← Tous les programmes ← Accessoires (مثلا) ← اختيار البرنامج", "بعد الانتهاء ننقر على زر الإغلاق"]]], "K": "برنامج: Démarrer ← Tous les programmes ← Accessoires ← البرنامج.", "M": ["للقائمة التقليدية: انقر يمين Démarrer ← Propriétés ← menu classique ← OK"], "X": "Démarrer هو باب الدخول لكل ما في الكمبيوتر.", "EX": [["كيف نشغل Calculatrice؟", "Démarrer ← Tous les programmes ← Accessoires ← Calculatrice."], ["ما اختصار فتح قائمة Démarrer من لوحة المفاتيح؟", "مفتاح Windows أو Ctrl + Esc."]], "n": 17, "s": "i", "k": "i2"}, {"m": 2, "i": "📝", "t": "برامج Windows: الآلة الحاسبة، WordPad، Paint", "B": [["الآلة الحاسبة (Calculatrice)", ["برنامج حساب ضمن Accessoires"]], ["WordPad", ["معالج نصوص بسيط مثبت مع Windows", "شريط القوائم، أداة الحفظ، تغيير الخط/الحجم/النمط، اتجاه الكتابة", "الحفظ: أداة الحفظ ← مكان الحفظ ← اسم الملف ← Enregistrer"]], ["Paint", ["برنامج للرسم بأشكال وأدوات وألوان", "شريط الأدوات · منطقة الرسم · شريط الألوان", "الرسم: اختر أداة ولونا ثم اسحب الفأرة (زر أيسر مضغوط) في منطقة الرسم"]]], "K": "WordPad للنصوص، Paint للرسم، Calculatrice للحساب: كلها في Accessoires.", "M": ["الحفظ بنفس الطريقة في Paint و WordPad"], "X": "WordPad دفتر للكتابة، و Paint لوحة للرسم.", "EX": [["أين نجد WordPad؟", "Démarrer ← Tous les programmes ← Accessoires ← WordPad."], ["كيف نرسم في Paint؟", "نختار أداة (الفرشاة) ولونا ثم نسحب الفأرة بالزر الأيسر مضغوطا في منطقة الرسم."]], "n": 18, "s": "i", "k": "i2"}, {"m": 2, "i": "🗂️", "t": "مفهوم الملف والمجلد وإنشاؤهما", "B": [["الملف (Fichier)", ["كل عمل نقوم به ونخزنه في الأقراص يسمى ملفا (نص، صورة، صوت، برنامج...)", "يعرف باسمه وشكل أيقونته: Internet, Word, Excel, image, sons"]], ["المجلد (Dossier)", ["ننظم به الأقراص: توضع فيه الملفات المترابطة", "يمكن إنشاء مجلدات فرعية داخل المجلد"]], ["إنشاء مجلد جديد", ["نحدد مكانه (قرص/مجلد/سطح المكتب)", "نقر أيمن في الفراغ ← Nouveau ← Dossier ← نكتب الاسم ← Entrée"]], ["إنشاء ملف جديد", ["نفتح المجلد ← نقر أيمن في الفراغ ← Nouveau ← نوع الملف (وثيقة، صورة...)"]]], "K": "الملف = عمل مخزن؛ المجلد = حاوية للملفات؛ أنشئهما بـ Nouveau من القائمة اليمنى.", "M": ["لكل ملف اسم وأيقونة تدل على نوعه"], "X": "المجلد كحقيبة تضع فيها ملفات متشابهة لتجدها بسهولة.", "EX": [["كيف ننشئ مجلدا على سطح المكتب؟", "نقر أيمن ← Nouveau ← Dossier ← كتابة الاسم ← Entrée."], ["ما الفرق بين الملف والمجلد؟", "الملف عمل مخزن (نص/صورة...)، والمجلد مكان ينظم الملفات."]], "n": 19, "s": "i", "k": "i2"}, {"m": 2, "i": "✂️", "t": "تغيير الاسم، الحذف، النسخ والنقل، البحث", "B": [["تغيير الاسم", ["نقر أيمن على الملف/المجلد ← Renommer ← كتابة الاسم ← Entrée"]], ["الحذف", ["نقر أيمن ← Supprimer"]], ["النسخ والنقل", ["النسخ: نسخة في مكان آخر (Copier ثم Coller)", "النقل: تغيير المكان (Couper ثم Coller)"]], ["البحث", ["Démarrer ← Rechercher ← Fichiers ou dossiers ← كتابة الاسم وموقع البحث"]]], "K": "Renommer · Supprimer · Copier/Couper ثم Coller · Rechercher.", "M": ["Copier ≠ Couper: الأول يبقي الأصل، الثاني ينقله"], "X": "النسخ يصنع نسخة، والقص ينقل الأصل من مكان لآخر.", "EX": [["ما الفرق بين Copier و Couper؟", "Copier ينسخ ويبقي الأصل، Couper ينقل الملف من مكانه."], ["كيف نبحث عن ملف؟", "Démarrer ← Rechercher ← Fichiers ou dossiers ثم نكتب اسمه."]], "n": 20, "s": "i", "k": "i2"}, {"m": 2, "i": "💿", "t": "العمليات على الأقراص: نسخ وتثبيت", "B": [["النسخ من الصلب إلى المرن", ["نقر أيمن على الملف/المجلد ← Envoyer vers ← Disquette 3½ (A:)"]], ["نسخة من قرص مرن", ["نفتح Poste de travail ← نقر أيمن على رمز القرص المرن ← Copie de disquette ← Démarrer ← إدخال القرص المصدر ثم OK ← إدخال القرص الفارغ ثم OK"]], ["تثبيت الأقراص المضغوطة", ["النوع 1: يشتغل تلقائيا فنتبع الخطوات", "النوع 2: لا يشتغل تلقائيا: Poste de travail ← القرص المضغوط ← Setup أو Install ← نتبع الخطوات"]], ["نسخ الأقراص المضغوطة", ["تحتاج ناسخا (Graveur) وبرنامجا مثل Nero Burning Rom", "نسخ قرص كامل: CD Copy ← Copy، أو نسخ معطيات: Nouveau ثم سحب الملفات ثم Ecrire"]]], "K": "نسخ المرن: Envoyer vers؛ التثبيت: Setup/Install؛ نسخ CD: Graveur + Nero.", "M": ["الاستعمال بعد التثبيت: Démarrer ← Programmes"], "X": "تثبيت برنامج = تركيبه على القرص الصلب ليشتغل.", "EX": [["ما اسم ملف التثبيت في القرص المضغوط؟", "Setup أو Install."], ["ما الذي نحتاجه لنسخ CD؟", "ناسخ أقراص (Graveur) وبرنامج مثل Nero Burning Rom."]], "n": 21, "s": "i", "k": "i2"}, {"m": 3, "i": "📄", "t": "معالج النصوص Word: التعريف والتشغيل والشاشة", "B": [["المقصود", ["برنامج يسمح بكتابة نص وتخزينه في القرص وفتحه عند الحاجة لقراءته أو تغييره", "ويسمح بتنسيق النص وطبعه على الأوراق", "Microsoft Word من أشهر معالجات النصوص، يعمل على Windows"]], ["التشغيل", ["Démarrer ← Tous les programmes ← Microsoft Word"]], ["عناصر الشاشة", ["شريط العنوان · شريط القوائم · شريط الأدوات · المسطرتان الأفقية والعمودية", "شريطا التمرير · شريط الرسم · شريط المعلومات"]], ["ملاحظات", ["القوائم: بالنقر على أسمائها نحصل على تعليمات", "الأدوات: اختصارات للتعليمات؛ نظهر أشرطة أكثر من Affichage ← Barres d'outils", "المشيرة: علامة سوداء تظهر وتختفي تبين موضع الكتابة", "نختار اللغة (Ar أو Fr) من أسفل الشاشة قبل الكتابة"]]], "K": "Word: يشغل من Démarrer؛ المشيرة تبين موضع الكتابة؛ اختر لغة الكتابة Ar/Fr.", "M": ["المشيرة = curseur"], "X": "Word ورقة بيضاء إلكترونية بأدوات للتنسيق.", "EX": [["كيف نشغل Word؟", "Démarrer ← Tous les programmes ← Microsoft Word."], ["ما دور المشيرة؟", "تبين موضع الكتابة."]], "n": 22, "s": "i", "k": "i3"}, {"m": 3, "i": "⌨️", "t": "دور المفاتيح في الكتابة", "B": [["مفاتيح التحرير", ["المسافة (Espace): فراغ بين الكلمات", "← (Retour arrière): حذف ما قبل المشيرة", "Suppr: حذف ما بعد المشيرة", "Entrée: الرجوع إلى السطر عند نهاية الفقرة"]], ["التنقل", ["الأسهم: التنقل في كل الاتجاهات", "Début: بداية السطر مباشرة", "Fin: نهاية السطر مباشرة"]], ["الحروف الكبيرة", ["Shift (⇧): للحروف الكبيرة أو الرموز العليا مع الحرف", "Verr. Maj (قفل الحروف الكبيرة): ضغطة واحدة فتكتب كبيرة مباشرة"]]], "K": "Espace=فراغ، ←=حذف قبل، Suppr=حذف بعد، Entrée=سطر/فقرة جديدة.", "M": ["الرجوع إلى السطر تلقائي داخل الفقرة؛ Entrée فقط لنهاية الفقرة"], "X": "تعلّم مفاتيح التحرير يجعل الكتابة أسرع.", "EX": [["ما الفرق بين ← و Suppr؟", "← يحذف ما قبل المشيرة، Suppr يحذف ما بعدها."], ["ما دور مفتاح Shift؟", "الكتابة بالحروف الكبيرة أو الرموز العليا."]], "n": 23, "s": "i", "k": "i3"}, {"m": 3, "i": "💾", "t": "حفظ الوثيقة وإغلاقها وفتحها", "B": [["الحفظ", ["Fichier ← Enregistrer، أو أداة الحفظ، أو Ctrl+S", "تظهر علبة حوار: نختار المكان (عادة Mes documents) ونكتب الاسم في Nom de fichier ثم Enregistrer"]], ["الإغلاق", ["Fichier ← Fermer"]], ["الفتح", ["Fichier ← Ouvrir (أو Ctrl+O أو أداة الفتح)", "نحدد المكان والاسم ثم ننقر Ouvrir"]], ["وثيقة جديدة", ["Fichier ← Nouveau (Ctrl+N)"]]], "K": "حفظ: Fichier ← Enregistrer (Ctrl+S)؛ فتح: Ouvrir (Ctrl+O).", "M": ["Enregistrer sous: حفظ باسم أو مكان آخر"], "X": "لا تنس الحفظ، وإلا ضاع العمل عند انقطاع الكهرباء (RAM).", "EX": [["اذكر اختصار لوحة المفاتيح للحفظ.", "Ctrl+S."], ["أين يُحفظ الملف عادة؟", "في المجلد Mes documents."]], "n": 24, "s": "i", "k": "i3"}, {"m": 3, "i": "✅", "t": "المدقق الإملائي وتنسيق الخط", "B": [["المدقق الإملائي", ["Outils ← Grammaire et orthographe أو أداة ABC", "تظهر الكلمة الخاطئة وSuggestions: نختار المناسبة ثم Modifier", "الأخطاء تظهر مسطرة بالأحمر؛ نقر أيمن عليها للتصحيح"]], ["تنسيق الخط", ["يتحكم في: الخط (النوع) والنمط والحجم واللون", "قبل الكتابة: Format ← Police", "بعدها: نحدد الجزء بالفأرة (يتلون بالأسود) ثم نغير الخط"]], ["عناصر نافذة Police", ["نوع الخط · نمط الخط (Normal, Italique, Gras) · حجم الخط", "قسم للاتينية وقسم للعربية", "الاختصارات: G غامق · I مائل · S تحته خط"]]], "K": "Format ← Police للخط؛ Outils ← Grammaire et orthographe للتدقيق.", "M": ["Gras = غامق · Italique = مائل · Souligné = مسطر"], "X": "حدد النص أولا ثم غير شكله.", "EX": [["كيف نغير نمط جزء من النص؟", "نحدده بالفأرة ثم Format ← Police ونختار النمط (أو G / I / S)."], ["ماذا تعني الكلمة المسطرة بالأحمر؟", "خطأ إملائي محتمل، نصححه بالمدقق أو بالنقر الأيمن."]], "n": 25, "s": "i", "k": "i3"}, {"m": 3, "i": "📐", "t": "تنسيق الفقرة والتعداد النقطي والرقمي", "B": [["الفقرة", ["كل ما يكتب إلى غاية الضغط على Entrée", "Format ← Paragraphe (نقر داخل الفقرة أولا)"]], ["عناصر التنسيق", ["المحاذاة: يمين / يسار / وسط / كشيدة (Justifié)", "المسافة البادئة: المسافة قبل أو بعد الفقرة", "تباعد الأسطر: المسافة بين أسطر الفقرة (عادي/مزدوج)"]], ["التعداد", ["للنص ذي المراحل أو النقاط: Format ← Puces et numéros", "نختار Puces (نقطي) أو numéros (رقمي) ثم شكلا ثم OK", "تظهر الأشكال تلقائيا بعد Entrée"]]], "K": "Paragraphe: محاذاة، مسافة بادئة، تباعد؛ Puces et numéros للتعداد.", "M": ["للتنسيق السريع استعمل الاختصارات في شريط التنسيق"], "X": "الفقرة وحدة النص؛ ننسق شكلها كاملا من مكان واحد.", "EX": [["ما الفرق بين المحاذاة وتباعد الأسطر؟", "المحاذاة وضع الفقرة (يمين/يسار/وسط/كشيدة)، والتباعد المسافة بين أسطرها."], ["كيف ننشئ قائمة نقطية؟", "Format ← Puces et numéros ← Puces ← شكل ← OK."]], "n": 26, "s": "i", "k": "i3"}];
ZAD_EOF
cat > lessons_as1_in.js <<'ZAD_EOF'
/* دروس الإعلام الآلي للسنة الأولى ثانوي. يُحمَّل بعد lessons.js و in1_data.js */
(function(){
  if(typeof LESSONS_DB==='undefined'||typeof IN1_DATA==='undefined')return;
  var KI=__KI__;
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
    t.push('▸ المرجع');t.push('• كتاب الإعلام الآلي للسنة الأولى ثانوي — '+(IN1_MQ[c.k]||'')+' — ملخص بتصرف');
    return t.join('\n');
  }
  var A=LESSONS_DB.AS1=LESSONS_DB.AS1||{};
  KI.forEach(function(KEY){
    var L=[];
    IN1_DATA.forEach(function(c){
      var k=c.n<10?'0'+c.n:''+c.n;
      L.push({title:k+'. '+fx(c.t),content:text(c)});
    });
    var o=A[KEY]||{};
    o.name=o.name||'الإعلام الآلي';
    o.lessons=L;
    o.maps='in1';
    A[KEY]=o;
  });
})();
ZAD_EOF
cat > maps_in1.html <<'ZAD_EOF'
<!doctype html><html lang="ar" dir="rtl"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>خرائط الإعلام الآلي - الأولى ثانوي</title>
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
  <h1>الإعلام الآلي - السنة الأولى ثانوي</h1>
  <p>مرتبة بحسب محاور الكتاب</p>
</header>
<nav class="tabs" id="tabs" role="tablist"></nav>
<main id="main"></main>
<p class="note">ملاحظة: هذه ملخصات ومراجعات مبنية على كتاب الإعلام الآلي للسنة الأولى ثانوي ومصاغة بتصرف؛ والتمارين المحلولة من إعداد التطبيق. طابقها مع كتابك وتوجيهات أستاذك.</p>
</div>
<script src="in1_data.js"></script>
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
  return card(l.n,IN1_COL[l.k],l.i,l.t,l.B,l.K,x,(IN1_SUB[l.k]||''));
}
function tab(m){return IN1_DATA.filter(l=>l.k===m).map(cardFor).join('')}
const MS=Object.keys(IN1_MQ);
const tabs=document.getElementById('tabs'),main=document.getElementById('main');
function show(m){
  MS.forEach(i=>{document.getElementById('t-'+i).setAttribute('aria-selected',i===m)});
  main.innerHTML=tab(m);window.scrollTo(0,0);
  try{localStorage.setItem('in1tab',String(m))}catch(e){}
  requestAnimationFrame(draw);
}
MS.forEach(i=>{const b=document.createElement('button');b.id='t-'+i;b.role='tab';b.textContent=IN1_ICO[i]+' '+IN1_MQ[i];b.onclick=()=>show(i);tabs.appendChild(b)});
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
let first=MS[0];
try{const s=localStorage.getItem('in1tab');if(MS.includes(s))first=s}catch(e){}
show(first);
</script>
</body></html>
ZAD_EOF
cat > maps_in1_hook.js <<'ZAD_EOF'
/* فتح خرائط الإعلام الآلي 1AS (maps:'in1') من maps_in1.html؛ يُحمَّل بعد maps_en1_hook.js */
(function(){
  if(typeof openMaps!=='function')return;
  var o=openMaps;
  window.openMaps=function(k){
    try{var d=getSubjectData(k);if(d&&d.maps==='in1'){
      openWebview('maps_in1.html','🗺️ خرائط الإعلام الآلي - الأولى ثانوي');return}}catch(e){}
    return o(k);
  };
})();

ZAD_EOF
sed -i "s/__KI__/$JI/" lessons_as1_in.js

# --- ربط الملفات في index.html (مرة واحدة فقط) ---
if ! grep -q 'lessons_as1_in.js' index.html; then
  LN=$(grep -n '<script src="lessons' index.html | tail -1 | cut -d: -f1)
  if [ -n "$LN" ]; then
    sed -i "${LN}a <script src=\"in1_data.js\"></script>\n<script src=\"lessons_as1_in.js\"></script>" index.html
  else
    echo "تنبيه: لم أجد وسوم lessons في index.html"
  fi
fi
if ! grep -q 'maps_in1_hook.js' index.html; then
  for P in en1 fr1 is1 hg1 t1 p1 m1 s1 n4 p4 m4; do
    if grep -q "maps_${P}_hook.js" index.html; then
      sed -i "/maps_${P}_hook.js/a <script src=\"maps_in1_hook.js\"></script>" index.html
      FOUND=1; break
    fi
  done
  if [ -z "$FOUND" ]; then
    sed -i '/maps_hg_hook.js/a <script src="maps_in1_hook.js"></script>' index.html
  fi
fi
grep -q 'maps_in1_hook.js' index.html || echo "تنبيه: لم يُضف وسم الخرائط؛ أرسل لي: grep -n 'script src' ~/zad-1am/www/index.html"
echo "تم: 26 بطاقة عن الإعلام الآلي. أعد بناء/فتح التطبيق وجرّب الزر 🗺️."
