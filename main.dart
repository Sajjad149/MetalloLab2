import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MetalloLabApp());

const bg = Color(0xFF06111F);
const panel = Color(0xFF0D1D31);
const panel2 = Color(0xFF122844);
const blue = Color(0xFF2196F3);
const cyan = Color(0xFF00C8D7);
const purple = Color(0xFF8B5CF6);
const orange = Color(0xFFFF9800);

class MetalloLabApp extends StatelessWidget {
  const MetalloLabApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MetalloLab',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(primary: blue, secondary: cyan),
        textTheme: GoogleFonts.vazirmatnTextTheme(ThemeData.dark().textTheme),
      ),
      home: const Shell(),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override State<Shell> createState() => _ShellState();
}
class _ShellState extends State<Shell> {
  int index = 0;
  final pages = const [HomePage(), CoursesPage(), LabPage(), LibraryPage(), ProfilePage()];
  @override Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(child: pages[index]),
        bottomNavigationBar: NavigationBar(
          backgroundColor: const Color(0xFF081522),
          selectedIndex: index,
          onDestinationSelected: (v) => setState(() => index = v),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'خانه'),
            NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'آموزش'),
            NavigationDestination(icon: Icon(Icons.science_outlined), selectedIcon: Icon(Icons.science), label: 'آزمایشگاه'),
            NavigationDestination(icon: Icon(Icons.image_search_outlined), selectedIcon: Icon(Icons.image_search), label: 'تصاویر'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'پروفایل'),
          ],
        ),
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  final String title; const AppBarTitle(this.title,{super.key});
  @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.symmetric(horizontal:16),child:Row(children:[Container(width:38,height:38,decoration:BoxDecoration(color:blue.withOpacity(.15),borderRadius:BorderRadius.circular(12)),child:const Icon(Icons.biotech,color:cyan)),const SizedBox(width:10),Text(title,style:const TextStyle(fontWeight:FontWeight.w800,fontSize:20))]));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children:[
    Row(children:[const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('سلام، سجاد 👋',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),SizedBox(height:4),Text('آماده‌ای امروز متالوگرافی یاد بگیری؟',style:TextStyle(color:Colors.white70))])),CircleAvatar(backgroundColor:panel2,child:const Icon(Icons.person))]),
    const SizedBox(height:20),
    CardBox(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('ادامه یادگیری',style:TextStyle(fontSize:17,fontWeight:FontWeight.bold)),const SizedBox(height:8),const Text('فصل ۳ • آماده‌سازی نمونه',style:TextStyle(color:Colors.white70)),const SizedBox(height:12),ClipRRect(borderRadius:BorderRadius.circular(8),child:const LinearProgressIndicator(value:.78,minHeight:8)),const SizedBox(height:8),Row(children:[const Text('۷۸٪'),const Spacer(),ElevatedButton.icon(onPressed:null,icon:const Icon(Icons.arrow_back),label:const Text('ادامه درس'))])])),
    const SizedBox(height:16),
    const Text('دسترسی سریع',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),const SizedBox(height:10),
    Row(children:[Quick('آموزش',Icons.school,blue),Quick('آزمایشگاه',Icons.science,cyan),Quick('تصاویر',Icons.image, purple),Quick('آزمون',Icons.quiz,orange)]),
    const SizedBox(height:20),
    CardBox(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('درس امروز',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),const SizedBox(height:8),const Text('چرا نمونه متالوگرافی باید به‌درستی پولیش شود؟',style:TextStyle(fontSize:16)),const SizedBox(height:12),FilledButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const LessonPage())),child:const Text('شروع درس'))])),
    const SizedBox(height:20),
    const Text('پیشرفت شما',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),const SizedBox(height:10),
    Row(children:[Progress('آموزش',.72,blue),Progress('آزمایشگاه',.45,cyan),Progress('تشخیص',.61,purple),Progress('آزمون',.80,orange)]),
  ]);
}

Widget Quick(String t, IconData i, Color c)=>Expanded(child:Padding(padding:const EdgeInsets.symmetric(horizontal:4),child:Container(height:90,decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(18),border:Border.all(color:c.withOpacity(.35))),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(i,color:c,size:30),const SizedBox(height:6),Text(t,style:const TextStyle(fontSize:12))]))));
Widget Progress(String t,double v,Color c)=>Expanded(child:Column(children:[SizedBox(width:58,height:58,child:CircularProgressIndicator(value:v,strokeWidth:6,color:c,backgroundColor:Colors.white10)),const SizedBox(height:6),Text(t,style:const TextStyle(fontSize:11))]));

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});
  final chapters = const [
    ('مبانی متالوگرافی','مفاهیم پایه، فاز، دانه و مرزدانه',Icons.school,blue),
    ('آماده‌سازی نمونه','برش، مانت، سنباده‌زنی، پولیش و اچ',Icons.build_circle,cyan),
    ('میکروسکوپی','نور، بزرگنمایی، فوکوس و مشاهده',Icons.biotech,purple),
    ('ریزساختارها','فریت، پرلیت، مارتنزیت، بینیت و بیشتر',Icons.grid_4x4,orange),
    ('عملیات حرارتی','آنیل، نرماله، کوئنچ و تمپر',Icons.local_fire_department,Colors.redAccent),
    ('دیاگرام‌های فازی','Fe-C و مبانی دیاگرام‌های فازی',Icons.account_tree,Colors.tealAccent),
  ];
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[const AppBarTitle('دوره متالوگرافی'),const SizedBox(height:16),TextField(decoration:InputDecoration(hintText:'جستجو در دوره‌ها...',prefixIcon:const Icon(Icons.search),filled:true,fillColor:panel,border:OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(16)),borderSide:BorderSide.none))),const SizedBox(height:16),...chapters.asMap().entries.map((e){final x=e.value;return Padding(padding:const EdgeInsets.only(bottom:12),child:CardBox(child:ListTile(leading:CircleAvatar(backgroundColor:(x.$4).withOpacity(.18),child:Icon(x.$3,color:x.$4)),title:Text(x.$1,style:const TextStyle(fontWeight:FontWeight.bold)),subtitle:Text(x.$2),trailing:const Icon(Icons.chevron_left),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>LessonPage(title:x.$1))))));})]);
}

class LessonPage extends StatelessWidget {
  final String title; const LessonPage({super.key,this.title='Grinding و آماده‌سازی سطح'});
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:Text(title)),body:ListView(padding:const EdgeInsets.all(18),children:[Text('۳ / ۷',style:TextStyle(color:cyan,fontWeight:FontWeight.bold)),const SizedBox(height:8),ClipRRect(borderRadius:BorderRadius.circular(10),child:const LinearProgressIndicator(value:.43,minHeight:7)),const SizedBox(height:20),const Text('هدف درس',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),const SizedBox(height:8),const Text('آشنایی با هدف Grinding و نقش آن در حذف آسیب‌های سطحی و آماده‌سازی نمونه برای پولیش.',style:TextStyle(fontSize:16,height:1.8)),const SizedBox(height:18),CardBox(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('نکته مهم ⚠️',style:TextStyle(color:orange,fontWeight:FontWeight.bold,fontSize:17)),const SizedBox(height:8),const Text('هدف Grinding ایجاد سطح نهایی نیست؛ بلکه حذف تدریجی خطوط و آسیب‌های ناشی از مرحله قبل است.',style:TextStyle(height:1.8))])),const SizedBox(height:18),const Text('مراحل پیشنهادی',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),const SizedBox(height:8),...['بررسی سطح پس از برش','انتخاب سنباده مناسب','حرکت یکنواخت و کنترل‌شده','شست‌وشو بین مراحل','عبور تدریجی به دانه‌های ظریف‌تر'].map((s)=>ListTile(leading:const Icon(Icons.check_circle,color:cyan),title:Text(s))),const SizedBox(height:10),FilledButton.icon(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const QuizPage())),icon:const Icon(Icons.quiz),label:const Text('سؤال سریع'))]));
}

class LabPage extends StatefulWidget { const LabPage({super.key}); @override State<LabPage> createState()=>_LabPageState(); }
class _LabPageState extends State<LabPage>{int step=0;final choices=['اره','برش ساینده','Wire EDM'];int selected=1;@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[const AppBarTitle('آزمایشگاه مجازی'),const SizedBox(height:16),CardBox(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('سناریوی آزمایش',style:TextStyle(fontSize:19,fontWeight:FontWeight.bold)),const SizedBox(height:8),const Text('یک نمونه فولادی دارید و هدف، مشاهده ریزساختار آن است.'),const SizedBox(height:12),Text('مرحله ${step+1} از 6',style:const TextStyle(color:cyan))])),const SizedBox(height:16),Text(step==0?'۱. روش برش را انتخاب کنید':step==1?'۲. روش مانت را انتخاب کنید':step==2?'۳. ترتیب سنباده‌زنی را تعیین کنید':'مرحله بعدی آزمایش',style:const TextStyle(fontSize:19,fontWeight:FontWeight.bold)),const SizedBox(height:12),if(step==0)...choices.asMap().entries.map((e)=>RadioListTile<int>(value:e.key,groupValue:selected,onChanged:(v)=>setState(()=>selected=v!),title:Text(e.value),activeColor:cyan,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(14)))),if(step>0)CardBox(child:const Text('در این نسخه آموزشی، انتخاب صحیح و دلیل علمی آن پس از تأیید شما نمایش داده می‌شود.',style:TextStyle(height:1.8))),const SizedBox(height:18),FilledButton(onPressed:()=>setState(()=>step=(step+1)%6),child:Text(step==5?'شروع مجدد':'تأیید و ادامه'))]);}

class LibraryPage extends StatelessWidget { const LibraryPage({super.key}); final data=const [('Ferrite','Steel',Icons.grain),('Pearlite','Steel',Icons.blur_on),('Martensite','Steel',Icons.bolt),('Bainite','Steel',Icons.hub),('Spheroidite','Steel',Icons.circle),('Lamellar Graphite','Grey Cast Iron',Icons.bubble_chart)]; @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[const AppBarTitle('بانک ریزساختار'),const SizedBox(height:16),TextField(decoration:InputDecoration(hintText:'جستجو در ریزساختارها...',prefixIcon:const Icon(Icons.search),filled:true,fillColor:panel,border:OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(16)),borderSide:BorderSide.none))),const SizedBox(height:12),Wrap(spacing:8,children:['همه','فولاد','چدن','آلومینیوم'].map((x)=>Chip(label:Text(x))).toList()),const SizedBox(height:16),GridView.builder(shrinkWrap:true,physics:const NeverScrollableScrollPhysics(),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,crossAxisSpacing:12,mainAxisSpacing:12,childAspectRatio:.9),itemCount:data.length,itemBuilder:(c,i){final x=data[i];return InkWell(onTap:()=>Navigator.push(c,MaterialPageRoute(builder:(_)=>StructurePage(name:x.$1,material:x.$2))),child:Container(decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(18),border:Border.all(color:Colors.white10)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(child:Container(decoration:BoxDecoration(color:Colors.black26,borderRadius:const BorderRadius.vertical(top:Radius.circular(18))),child:Center(child:Icon(x.$3,size:60,color:cyan)))),Padding(padding:const EdgeInsets.all(12),child:Text(x.$1,style:const TextStyle(fontWeight:FontWeight.bold))),Padding(padding:const EdgeInsets.fromLTRB(12,0,12,12),child:Text(x.$2,style:const TextStyle(color:Colors.white60,fontSize:12))) ])));})]);}

class StructurePage extends StatelessWidget {final String name,material;const StructurePage({super.key,required this.name,required this.material});@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:Text(name)),body:ListView(padding:const EdgeInsets.all(18),children:[Container(height:220,decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(20)),child:Center(child:Icon(Icons.image_search,size:90,color:cyan))),const SizedBox(height:18),Text(name,style:const TextStyle(fontSize:28,fontWeight:FontWeight.bold)),Text(material,style:const TextStyle(color:cyan)),const SizedBox(height:18),CardBox(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('چگونه تشخیص بدهیم؟',style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),const SizedBox(height:8),Text('ویژگی‌های مورفولوژیک، زمینه، روش آماده‌سازی و شرایط عملیات حرارتی را هم‌زمان بررسی کنید.',style:const TextStyle(height:1.8))])),const SizedBox(height:14),const Text('نکات تشخیصی',style:const TextStyle(fontSize:19,fontWeight:FontWeight.bold)),const ListTile(leading:Icon(Icons.check_circle,color:cyan),title:Text('به شکل و کنتراست فازها توجه کنید.')),const ListTile(leading:Icon(Icons.check_circle,color:cyan),title:Text('بزرگنمایی و اچ را در تفسیر تصویر در نظر بگیرید.'))]));}

class QuizPage extends StatefulWidget{const QuizPage({super.key});@override State<QuizPage>createState()=>_QuizPageState();}
class _QuizPageState extends State<QuizPage>{int selected=-1;bool checked=false;@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('سؤال سریع')),body:Padding(padding:const EdgeInsets.all(18),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[const Text('چرا از سنباده زبر به سنباده ظریف حرکت می‌کنیم؟',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold,height:1.5)),const SizedBox(height:20),...['برای حذف تدریجی خطوط و آسیب‌های مرحله قبل','برای افزایش دمای نمونه','برای تغییر ترکیب شیمیایی','برای افزایش ضخامت نمونه'].asMap().entries.map((e)=>CardBox(child:RadioListTile<int>(value:e.key,groupValue:selected,onChanged:checked?null:(v)=>setState(()=>selected=v!),title:Text(e.value),activeColor:cyan))),const Spacer(),if(checked)Text(selected==0?'✅ پاسخ صحیح. Grinding باید آسیب سطحی را مرحله‌به‌مرحله کاهش دهد.':'❌ پاسخ صحیح گزینه اول است.',style:TextStyle(color:selected==0?Colors.greenAccent:orange,fontSize:16)),const SizedBox(height:10),FilledButton(onPressed:selected<0?null:()=>setState(()=>checked=true),child:const Text('بررسی پاسخ'))])));}

class ProfilePage extends StatelessWidget {const ProfilePage({super.key});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(16),children:[const SizedBox(height:10),const CircleAvatar(radius:38,backgroundColor:panel2,child:Icon(Icons.person,size:42)),const SizedBox(height:10),const Center(child:Text('Sajjad',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold))),const Center(child:Text('MetalloLab Level 1',style:TextStyle(color:cyan))),const SizedBox(height:20),Row(children:[Stat('درس‌ها','0'),Stat('آزمون‌ها','0'),Stat('امتیاز','0')]),const SizedBox(height:20),const Text('مهارت‌ها',style:TextStyle(fontSize:19,fontWeight:FontWeight.bold)),const SizedBox(height:12),...['Sample Preparation','Microstructure','Heat Treatment','Metallography'].map((x)=>Padding(padding:const EdgeInsets.only(bottom:14),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(x),const SizedBox(height:6),const LinearProgressIndicator(value:.08,minHeight:7)]))),const SizedBox(height:10),const Text('دستاوردها',style:TextStyle(fontSize:19,fontWeight:FontWeight.bold)),const SizedBox(height:12),Row(children:[Badge(Icons.mic_none,'First Microscope'),Badge(Icons.science,'Sample Master')])]);}
Widget Stat(String a,String b)=>Expanded(child:CardBox(child:Column(children:[Text(b,style:const TextStyle(fontSize:22,fontWeight:FontWeight.bold)),Text(a,style:const TextStyle(color:Colors.white60,fontSize:12))])));
Widget Badge(IconData i,String t)=>Expanded(child:CardBox(child:Column(children:[Icon(i,color:orange,size:32),const SizedBox(height:5),Text(t,textAlign:TextAlign.center,style:const TextStyle(fontSize:11))])));

class CardBox extends StatelessWidget {final Widget child;const CardBox({super.key,required this.child});@override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white10)),child:child);}
