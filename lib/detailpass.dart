import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'main.dart';
import 'addreview.dart';
import 'bottomnav.dart';
import 'services/review_service.dart';


class DetailPage extends StatefulWidget {
  final String movieTitle;

  const DetailPage({super.key, required this.movieTitle});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? trailerId; //simpan id vid yt
  YoutubePlayerController? _controller; //controller untuk yt
  List<dynamic> reviews = []; //simpan list movie

  @override
  void initState() {
    super.initState();
    fetchTrailer();
    loadReviews();
  }

  Future<void> fetchTrailer() async { //cari trailer dari yt api
    final response = await http.get(Uri.parse( //hantar req GET ke yt api
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=${widget.movieTitle}+trailer&type=video&key=AIzaSyBCAcUIoEtOPxxmb0P7djzOmYIIEQOfjv0"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final items = data['items'] as List; //amik list vid dari data
      if (items.isNotEmpty) {
        setState(() {
          trailerId = items[0]['id']['videoId'];
          _controller = YoutubePlayerController.fromVideoId( //controller yt
            videoId: trailerId!,       // bukan initialVideoId lagi
            autoPlay: false,           // boleh letak terus
            params: const YoutubePlayerParams(
              showFullscreenButton: true,
            ),
          );

        });
      }
    }
  }

  Future<void> loadReviews() async { //amik review movie
    final allReviews = await ReviewService.getReviews(); //panggil service dptkan semua review
    final movieReviews = allReviews.where( //filter review match ngan movie title
          (rev) => rev['movieTitle'] == widget.movieTitle,
    ).toList();
    setState(() {
      reviews = movieReviews.reversed.toList(); // latest naik atas
    });

  }

  @override
  Widget build(BuildContext context) {
    String poster = "";
    String title = "";
    int year = 0;
    List<String> genre = [];
    String rating = "";
    int runtime = 0;
    String director = "";
    String starring = "";
    String synopsis = "";

    if(widget.movieTitle == "love_disappears"){
      title = "Even If This Love Disappears From World Tonight";
      poster = "images/assets/love_disappears.jpg";
      year = 2022;
      genre = ["Romance", "Drama"];
      rating = "7.4 / 10";
      runtime = 121;
      director = "Takahiro Miki";
      starring = "Shunsuke Michieda, Riko Fukumoto";
      synopsis = "Bullied student Toru falsely confesses feelings to classmate Maori, who has memory loss daily. "
          "As they date, Toru falls for her despite her rule against love. Toru aims to give her happy memories through new experiences each day. "
          "Because of his bullying classmates, Toru Kamiya makes a false confession to his classmate Maori Hino. "
          "Her tells her that he likes her, but she lays out rules for him if they are to date. "
          "One of her rules is that they are not to fall in love with each other. Toru and Maori begin to date and have a good time together. "
          "Soon, Toru breaks his promise and falls in love with Maori because she was so beautiful. "
          "When Toru makes a heartfelt confession to her, Maori informs him that she has a disease. When she wakes up, her disease causes her to have no memory of the day before. "
          "She keeps a diary of what happened the day before and reads it in the morning to be able to recall her memories. Toru decides to bring to her as many happy days as possible.";
    }

    else if (widget.movieTitle == "kings_warden"){
      title = "The King's Warden";
      poster = "images/assets/kings_warden.jpg";
      year = 2026;
      genre = ["Drama", "History" , "Korean"];
      rating = "7.0 / 10";
      runtime = 116;
      director = "Jang Hang-Jun";
      starring = "Yoo Hae Jin . Park Ji-hoon . Yoo Ji-tae";
      synopsis = "Fate entwines a fallen king with the man who becomes his last keeper. "
          "In a remote mountain village of 15th-century Joseon, a humble headman, Heung Do, hears a rumor that any village hosting an exiled nobleman will be blessed with abundance and fortune. Hoping to bring prosperity to his impoverished community, he eagerly submits a petition to host one—unaware that his guest is none other than the fallen monarch, the deposed boy, King Danjong."
          "While an unlikely bond begins to form between the dethroned ruler and the man assigned to watch over him, the quiet village finds itself drawn into the perilous undercurrents of royal intrigue—where loyalty and survival collide.";
    }

    else if (widget.movieTitle == "eyes_tell"){
      title = "Your Eyes Tell";
      poster = "images/assets/eyes_tell.jpg";
      year = 2020;
      genre = ["Japanese" , "Drama" , "Romance"];
      rating = "7.4 / 10";
      runtime = 153 ;
      director = "Takahiro Miki";
      starring = "Yuichi Toyone . Ryusei Yokohama . Kyosuke Yabe";
      synopsis = "After losing her sight and family, Akari finds unexpected connection with Rui, a reclusive ex-kickboxer. "
          "As romance blooms between these wounded souls, their shared past threatens to unravel everything.A tragic accident lead to Akari's blindness, but she clings to life and the smaller pleasures it can still afford her. "
          "Akari has also lost her family. She meets Rui a former kick boxer, misplaces him and the two begin speaking. He too has a past and is disassociated with most of society. One things leads to another and they develop feelings for one another. "
          "However, the too are connected in more than one way. Rui attempts to do what is right.";
    }

    else if (widget.movieTitle == "princess_diaries"){
      title = "The Princess Diaries";
      poster = "images/assets/princess_diaries.jpg";
      year = 2001;
      genre = ["Family","Romance","Comedy"];
      rating = "6.4 / 10";
      runtime = 115;
      director = "Garry Marshall";
      starring = "Julie Andrew . Anne Hathaway . Hector Elizondo";
      synopsis = "Mia Thermopolis (Anne Hathaway) is a shy, geeky teenager who lives with her mom in San Francisco. Her world turns upside down when her grandmother, Queen Clarisse Renaldi (Julie Andrews), reveals that Mia is the heir to the throne of Genovia. "
          "With the help of her best friend Lilly (Heather Matarazzo), Lilly’s brother Michael (Robert Schwartzman), and her loyal bodyguard Joe (Hector Elizondo), Mia begins royal training learning etiquette, style, and how to handle the spotlight."
          "As the media swarms and her classmates react to her sudden fame, Mia struggles to balance her normal teenage life with her new responsibilities. By the time Genovia’s Independence Day Ball arrives, "
          "she must make a life-changing choice: give up her claim and stay ordinary, or embrace her destiny as Princess of Genovia, honoring her father Philippe Renaldi’s legacy.";
    }

    else if (widget.movieTitle == "lalaland"){
      title = "La La Land";
      poster = "images/assets/lalaland.jpg";
      year = 2016;
      genre = ["Comedy","Drama","Musical", "Romance"];
      rating = "8.0 / 10";
      runtime = 128;
      director = "Damien Chazelle";
      starring = "Ryan Gosling . Emma Stone . Rosemarie DeWitt";
      synopsis = "Mia (Emma Stone), an aspiring actress, and Sebastian (Ryan Gosling), a passionate jazz pianist, meet by chance in Los Angeles. Despite a rocky start, they fall in love and inspire each other to chase their dreams."
          "Mia writes and performs her own play, while Sebastian hopes to open a jazz club. As their careers begin to take off, success and ambition create distance between them. Mia eventually lands her big break and becomes a famous actress, while Sebastian achieves his dream of owning a jazz club. "
          "Years later, they meet again, share a bittersweet smile, and realize that although their love shaped their lives, it wasn’t meant to last.";
    }

    else if (widget.movieTitle == "exhuma"){
      title = "Exhuma";
      poster = "images/assets/exhuma.jpg";
      year = 2024;
      genre = ["Korean","Horror","Mystery","Supernatural","Folk"];
      rating = "6.9 / 10";
      runtime = 134;
      director = "Jang Jae-Hyun";
      starring = "Choi Min-Sik . Kim Go-Eun . Yoo Hae-jin";
      synopsis = "A wealthy Korean American family hires shaman Hwa-rim and her protégé Bong-gil to cure their baby’s mysterious illness. She discovers it’s a curse from the family’s ancestor, Park Ji-yong’s grandfather. With help from geomancer Sang-deok and mortician Yeong-geun, they exhume the grave, but a vengeful spirit is released, killing Ji-yong and his parents. "
          "Sang-deok finally cremates the coffin, saving the child.Later, the team uncovers a second grave tied to Japanese colonial-era spiritual spikes. They learn the samurai oni guarding it was created by a shaman called The Fox (Murayama Junji). After a fierce battle, Sang-deok uses a blood-soaked wooden pickaxe to destroy the spirit. He survives, and months later attends his daughter’s wedding with the group.";
    }

    else if (widget.movieTitle == "mat_kilau"){
      title = "Mat Kilau : Kebangkitan Pahlawan";
      poster = "images/assets/mat_kilau.jpg";
      year = 2022;
      genre = ["Martial Art","History","Action","Thriller","Drama","Adventure"];
      rating = "5.5 / 10";
      runtime = 117;
      director = "Syamsul Yusof";
      starring = "Adi Putra . Beto Kusyairy . Fattah Amin";
      synopsis = "Events of the movie is set in 1892, during British colonial rule in Pahang, three years prior to the formation of the Federated Malay States.The British exploited the wealth of Pahang's produce belonging to the Malays, by imposing taxes on traders and reaping the produce of the people, as well as interfering in their customary and religious affairs."
          "The actions taken by the British were done without the consent of the Malays in Pahang, causing them to act against the British in retaliation.In spirit of defending his homeland of Pahang and freeing it from further occupation, Mat Kilau, a Malay warrior, along with his father, Tok Gajah, and his friends, fought against the British administration.Conflict and political pressure were faced by the British and following a plan of resistance by Mat Kilau and his friends, they ultimately clashed with the British in armed battle to determine the fate of Pahang.";
    }

    else if (widget.movieTitle == "showman"){
      title = "The Greatest Showman";
      poster = "images/assets/showman.jpg";
      year = 2017;
      genre = ["Drama","Musical","Pop Musical"];
      rating = "7.5 / 10";
      runtime = 105;
      director = "Michael Gracey";
      starring = "Hugh Jackman . Michelle Williams . Zac Efron";
      synopsis = "P. T. Barnum grows up poor but dreams big. He marries Charity and, after losing his job, opens Barnum’s American Museum. To attract crowds, he recruits unique performers like Lettie Lutz and Charles Stratton, creating “Barnum’s Circus.” With playwright Phillip Carlyle’s help, the show gains fame, though critics and society disapprove.Barnum brings singer Jenny Lind to America, but her scandal and his obsession with success strain his marriage. When the circus burns down, Barnum loses everything. His troupe reminds him they are family, inspiring him to rebuild. "
          "Partnering with Phillip, he creates a tented circus that becomes a huge success. In the end, Barnum steps back to spend more time with Charity and their daughters, leaving Phillip as ringmaster.";
    }

    else if (widget.movieTitle == "train_busan"){
      title = "Train To Busan";
      poster = "images/assets/train_busan.jpg";
      year = 2016;
      genre = ["Action","Tragedy","Horror","Thriller","Korean"];
      rating = "7.6 / 10";
      runtime = 118;
      director = "Yeon Sang-ho";
      starring = "Gong-Yoo . Jung Yu-mi . Ma Dong-Seok";
      synopsis = "Seok-woo, a workaholic father, boards a train to Busan with his daughter Su-an. A zombie outbreak begins when an infected woman sneaks onboard, spreading chaos through the carriages. Survivors include a tough worker Sang-hwa, his pregnant wife Seong-kyeong, a baseball player Yong-guk, his girlfriend Jin-hee, and others. Together they fight to survive as the infection spreads across Korea.Along the way, selfish passengers and ruthless executive Yon-suk worsen the danger. Sang-hwa sacrifices himself, and many others die. "
          "Eventually, only Seok-woo, Su-an, and Seong-kyeong escape onto another train, but Yon-suk—now infected—bites Seok-woo. In his final moments, Seok-woo says goodbye to Su-an before throwing himself off the train.Su-an and Seong-kyeong finally reach Busan, where the army rescues them after hearing Su-an sing “Aloha ʻOe” in memory of her father.";
    }

    else if (widget.movieTitle == "ralph_internet"){
      title = "Ralph Breaks The Internet";
      poster = "images/assets/ralph_internet.jpg";
      year = 2018;
      genre = ["Animation","Adventure","Sci-fi","Action Epic"];
      rating = "7.0 / 10";
      runtime = 112;
      director = "Phil Johnston . Rich Moore";
      starring = "John C.Reilly . Sarah Silverman . Gal Gadot";
      synopsis = "Six years after the first film, Ralph and Vanellope are still best friends. When Vanellope’s game Sugar Rush breaks, they travel into the Internet to buy a new steering wheel on eBay. To raise money, Ralph makes viral videos with the help of Yesss, while Vanellope discovers a new thrill in the dangerous racing game Slaughter Race."
          "Afraid of losing her, Ralph unleashes a virus that spirals out of control, creating thousands of insecure Ralph clones that nearly destroy the Internet. Realizing he must let Vanellope follow her own path, Ralph accepts change and the clones vanish. Vanellope chooses to stay in Slaughter Race, while Ralph returns to the arcade, happy to support her from afar.";
    }

    else if (widget.movieTitle == "boboiboy_galaxy"){
      title = "Boboiboy: The Movie";
      poster = "images/assets/boboiboy_galaxy.jpg";
      year = 2016;
      genre = ["Superhero","Sci-fi","Adventure","Animation","Comedy"];
      rating = "6.8 / 10";
      runtime = 100;
      director = "Nizam Razak";
      starring = "Nur Fathiah Diaz . Dzubir Mohamed Zakaria . Wong Wai Kay";
      synopsis = "A group of alien treasure hunters named The Tengkotak has arrived on earth and kidnapped Ochobot (Mohd Fathi b Diaz) in order to use him to locate an ancient and powerful Sfera Kuasa hiding on earth. BoBoiBoy (Nur Fathiah bt Diaz) and his super friends must now race against time to save Ochobot and uncover the secrets behind the Sfera Kuasa. Their journey will take them on an adventure filled with action, comedy, and beautiful locales.";
    }

    else if (widget.movieTitle == "khabi_khushi"){
      title = "Khabi Khushi Kabhie Gham";
      poster = "images/assets/khabi_khushi.jpg";
      year = 2001;
      genre = ["Hindi","Drama","Musical","Romance"];
      rating = "7.5 / 10";
      runtime = 210;
      director = "Karan Johar";
      starring = "Shah Rukh Khan . Kajol . Kareena Kapoor";
      synopsis = "Rahul, the adopted elder son of wealthy Yash and Nandini Raichand, falls in love with Anjali, a spirited woman from a lower-class background. Yash disapproves, wanting Rahul to marry Naina, and disowns him when he marries Anjali. Heartbroken, Rahul moves to London with Anjali and her sister Pooja, while Nandini silently suffers.Years later, younger son Rohan learns of the estrangement and travels to London, determined to reunite the family. "
          "He befriends Pooja, bonds with Rahul’s son Krish, and eventually reveals his identity. Though Rahul resists, Nandini’s love and Rohan’s persistence bring the family back together. Yash finally admits his mistake, reconciling with Rahul in an emotional reunion.The film ends with celebrations of Rahul and Anjali’s marriage and Rohan’s engagement to Pooja, restoring the Raichand family’s unity.";
    }

    else if (widget.movieTitle == "tangled"){
      title = "Tangled";
      poster = "images/assets/tangled.jpg";
      year = 2010;
      genre = ["Animation","Comedy","Adventure","Romantic","Fairy Tale","Fantasy"];
      rating = "7.7 / 10";
      runtime = 100;
      director = "Nathan Greno . Byron Howard";
      starring = "Mandy Moore . Zachary Levi . Donna Murphy";
      synopsis = "A magical flower gives Rapunzel golden hair with healing powers. Mother Gothel kidnaps her as a baby and hides her in a tower, using the hair to stay young. Every year, Rapunzel sees lanterns released by the kingdom on her birthday and longs to discover their source.When thief Flynn Rider stumbles into her tower, Rapunzel forces him to take her outside in exchange for returning a stolen tiara. "
          "Together they journey through forests, meet ruffians, and grow close. Rapunzel realizes she is the lost princess after seeing the kingdom’s sun symbol in her art. Gothel tries to keep her captive, but Flynn sacrifices himself by cutting Rapunzel’s hair, destroying its magic and causing Gothel to perish. Rapunzel’s tear heals Flynn, and she reunites with her parents.The story ends with Rapunzel restored as princess and happily engaged to Flynn.";
    }

    else if (widget.movieTitle == "kuch_kuch"){
      title = "Kuch Kuch Hota Hai";
      poster = "images/assets/kuch_kuch.jpg";
      year = 1998;
      genre = ["Hindi","Comedy","Drama","Musical","Romance"];
      rating = "7.5 / 10";
      runtime = 185;
      director = "Karan Johar";
      starring = "Shah Rukh Khan . Kajol . Rani Mukerji";
      synopsis = "Rahul (Shahrukh Khan) and tomboyish Anjali (Kajol) are best friends in college. Rahul falls in love with Tina (Rani Mukherji), breaking Anjali’s heart. She leaves, and Rahul marries Tina, who dies after giving birth to their daughter, also named Anjali. Before her death, Tina leaves letters for her daughter, asking her to reunite Rahul with his true love. "
          "Eight years later, young Anjali learns about her father’s best friend and sets out to bring them together. She finds Anjali Sharma, now engaged to Aman (Salman Khan). Rahul and Anjali meet again at summer camp, rekindling their feelings. At the wedding, Aman realizes Anjali truly loves Rahul and steps aside. Rahul and Anjali finally marry, fulfilling Tina’s last wish and restoring happiness to the family.";
    }

    else if (widget.movieTitle == "abigail"){
      title = "Abigail";
      poster = "images/assets/abigail.jpg";
      year = 2024;
      genre = ["Horror","Action","Thriller","Comedy","Drama","Crime"];
      rating = "6.5 / 10";
      runtime = 109;
      director = "Matt Bettinelli-Olpin . Tyler Gillet";
      starring = "Melissa Barrera . Dan Stevens . Alisha Weir";
      synopsis = "A group of six criminals kidnap Abigail, a young ballerina, for ransom. Joey, a former medic, is assigned to watch her but discovers Abigail is actually a centuries-old vampire. The kidnapping is a trap set by her father, crime lord Kristof Lazaar, to eliminate his enemies. One by one, the criminals are killed or turned into vampires. "
          "Joey and Abigail form an uneasy bond, fighting off Lambert and Frank after they betray the group. In the end, Abigail confronts her father, defending Joey for being there when he wasn’t. Lazaar spares Joey, allowing her to leave battered but alive, while Abigail remains with him, torn between loyalty and longing for love.";
    }

    else if (widget.movieTitle == "last_night"){
      title = "Re/Member : The Last Night";
      poster = "images/assets/last_night.jpg";
      year = 2025;
      genre = ["Horror"];
      rating = "7.1 / 10";
      runtime = 94;
      director = "Eiichiro Hasumi";
      starring = "Seira Anzai . Kanna Hashimoto . Marin Honda";
      synopsis = "It's midnight. The same day repeats itself in the 'Body Search' until the dismembered body is found. Just after Asuka and Takahiro finish their 'Body Search,' Asuka disappears from this world right before Takahiro's eyes. "
          "Three years later, Riku and the other five high school students wake up in the middle of the night at an amusement park. A girl covered in blood, the 'Red Person,' appears and brutally murders them. However, when they wake up, it's the same morning... Riku and the others realize they've been chosen to participate in the Body Search."
          "Then, Takahiro appears before them, looking nothing like his former self. Takahiro has been searching for Asuka, the girl he loves, for three years. The six must face the terror of the 'Red Person' to rescue Asuka, who disappeared due to a chain of curses";
    }

    else if (widget.movieTitle == "man_in_love"){
      title = "Man In Love";
      poster = "images/assets/man_in_love.jpg";
      year = 2021;
      genre = ["Mandarin","Drama","Romance"];
      rating = "8.4 / 10";
      runtime = 115;
      director = "Chen Hao Yin";
      starring = "Roy Chiu . Wei Ning Hsu . Zheng Austin";
      synopsis = "A Cheng is a kind-hearted debt collector who meets the debt-ridden Hao Ting. A Cheng becomes deeply attracted to her after seeing her uncomplainingly care for her ailing father and learning that she is shouldering the debt on her own. He eases her burden with a tailor-made repayment scheme: debt reduction in exchange for dates with him. When she has lowered her defenses enough to accept A Cheng's heart, a series of events lead to a bumpy road ahead.";
    }

    else if (widget.movieTitle == "re_member"){
      title = "Re/Member";
      poster = "images/assets/re_member.jpg";
      year = 2022;
      genre = ["Japanese","Drama","Horror","Mystery"];
      rating = "7.4 / 10";
      runtime = 102;
      director = "Eiichiro Hasumi";
      starring = "Kanna Hashimoto . Gordon Maeda . Maika Yamamoto";
      synopsis = "High school student Asuka sees the appearance of a dead student named Haruka and tries to find her body. Asuka and her friends try to find the eight scattered pieces of Haruka's corpse in the school. In doing so, they learn more about the Red Person who is pursuing them. The Red Person hunts down the students who are alone in the school to kill them, and until they exit the school gates, the Red Person will keep appearing before them. When the Red Person kills a student, it scatters the student's body into eight pieces and tasks others to find the pieces in the school. If Asuka does not find Haruka's body, the day will keep repeating and she and her friends will continue to die until they find it.";
    }

    else if (widget.movieTitle == "your_name"){
      title = "Your Name";
      poster = "images/assets/your_name.jpg";
      year = 2016;
      genre = ["Japanese","Anime","Fantasy","Romance"];
      rating = "8.4 / 10";
      runtime = 106;
      director = "Makoto Shinkai";
      starring = "Ryunosuke Kamiki . Mone Kamishiraishi . Ryo Narita";
      synopsis = "Mitsuha, a girl from rural Itomori, and Taki, a boy from Tokyo, mysteriously begin swapping bodies. They learn about each other’s lives and grow close, but the connection suddenly stops. Searching for Mitsuha, Taki discovers her town was destroyed three years earlier by a comet. Drinking her sacred sake, he reconnects with her across time, and together they work to evacuate the town before disaster strikes."
          "At twilight, they meet briefly and try to write their names on each other’s hands, but Mitsuha only finds 'I love you' written by Taki. Though their memories fade, Mitsuha saves her town. Years later, in Tokyo, Taki and Mitsuha finally cross paths again, drawn to each other, and ask for each other’s names.";
    }

    else if (widget.movieTitle == "howl"){
      title = "Howl's Moving Castle";
      poster = "images/assets/howl.jpg";
      year = 2004;
      genre = ["Japanese","Anime","Fantasy","Romance"];
      rating = "8.2  / 10";
      runtime = 119;
      director = "Hayao Miyazaki";
      starring = "Chieko Baisho . Takuya Kimura . Tatsuya Gashuin";
      synopsis = "Sophie, a young hat maker, is cursed by the Witch of the Waste and turned into an old woman. Seeking a cure, she finds Howl’s magical moving castle, where she meets his apprentice Markl and the fire demon Calcifer. Sophie becomes part of Howl’s household, cleaning and caring for them while growing closer to Howl."
          "Meanwhile, war breaks out between nations, and Howl risks his humanity by transforming into a bird-like creature to interfere. Sophie’s love and determination help protect him, even as the castle collapses. She learns Calcifer holds Howl’s heart, and by restoring it, she frees both of them."
          " Turnip Head, a scarecrow who aided Sophie, is revealed to be the missing prince once Sophie gives him a true love’s kiss. With the prince’s return, the war ends. Sophie and Howl, now free, begin a new life together in peace.";
    }

    else if (widget.movieTitle == "spirited_away"){
      title = "Spirited Away";
      poster = "images/assets/spirited_away.jpg";
      year = 2001;
      genre = ["Japanese","Anime","Fairy Tale","Fantasy","Adventure"];
      rating = "8.6 / 10";
      runtime = 124;
      director = "Hayao Miyazaki";
      starring = "Miyu Irino . Rumi Hiiragi . Mari Natsuki";
      synopsis = "Chihiro, a ten‑year‑old girl, stumbles into a magical spirit world where her parents are turned into pigs. To survive, she works at a bathhouse run by the witch Yubaba, who steals her name and calls her Sen. With help from Haku, a mysterious boy bound to Yubaba, and allies like Kamaji, Lin, and No‑Face, Chihiro learns courage and kindness."
          "She restores Haku’s true identity as the spirit of the Kohaku River, resists Yubaba’s final test, and wins back her name. Freed, she reunites with her parents and returns to the human world, carrying the strength and maturity gained from her journey.";
    }

    else if (widget.movieTitle == "interstellar"){
      title = "Interstellar";
      poster = "images/assets/interstellar.jpg";
      year = 2014;
      genre = ["Adventure","Epic","Sci-Fi","Drama","Space Sci-Fi"];
      rating = "8.7 / 10";
      runtime = 169;
      director = "Christopher Nolan";
      starring = "Matthew McConaughey . Anne Hathaway . Jessica Chastain";
      synopsis = "Interstellar is a science fiction film set in a future where Earth is becoming uninhabitable due to crop failure, dust storms, and environmental collapse. Cooper, a former NASA pilot, is recruited for a secret mission to travel through a wormhole in search of a new planet where humanity can survive."
          "Along with a team of astronauts, Cooper explores several distant planets, facing dangerous conditions and the effects of time dilation, where time passes differently because of strong gravity. As the mission becomes more challenging, Cooper struggles with the emotional cost of being separated from his children, especially his daughter, Murph, who works to solve the scientific problems that could save humanity on Earth."
          "The film combines breathtaking space exploration with emotional storytelling, exploring themes of love, sacrifice, hope, and the survival of the human race.";
    }


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded,
              color: Color(0xFFFBC02D), size: 40),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'MOBEEZ',
          textAlign: TextAlign.center,
          style: GoogleFonts.fasterOne(
            fontSize: 50,
            color: const Color(0xFFFBC02D),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFBC02D),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Poster + Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  poster,
                  width: 150,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Year : $year",
                          style: GoogleFonts.nunito(
                              color: Colors.white, fontSize: 18)),
                      const SizedBox(height: 5),
                      Text("Genre : ${genre.join(" / ")}",
                          style: GoogleFonts.nunito(
                              color: Colors.white, fontSize: 18)),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text("Rate : ",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18)),
                          const Icon(Icons.star,
                              color: Color(0xFFFBC02D), size: 18),
                          const SizedBox(width: 5),
                          Text(rating,
                              style: GoogleFonts.nunito(
                                  color: Colors.white, fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text("Runtime : $runtime minutes",
                          style: GoogleFonts.nunito(
                              color: Colors.white, fontSize: 18)),
                      const SizedBox(height: 5),
                      Text("Director : $director",
                          style: GoogleFonts.nunito(
                              color: Colors.white, fontSize: 18)),
                      const SizedBox(height: 5),
                      Text("Starring : $starring",
                          style: GoogleFonts.nunito(
                              color: Colors.white, fontSize: 18)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Buttons
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFBC02D),
                    foregroundColor: Colors.black87,
                  ),
                  onPressed: () {
                    watched.add(widget.movieTitle);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Marked as Watched")),
                    );
                  },
                  icon: const Icon(Icons.remove_red_eye_rounded),
                  label: const Text("Mark as Watched"),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFBC02D),
                    foregroundColor: Colors.black87,
                  ),
                  onPressed: () {
                    watchlist.add(widget.movieTitle);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Added to Watchlist")),
                    );
                  },
                  icon: const Icon(Icons.watch_later_rounded),
                  label: const Text("Add to Watchlist"),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFBC02D),
                    foregroundColor: Colors.black87,
                  ),
                  onPressed: () {
                    favorites.add(widget.movieTitle);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Added to Favorites")),
                    );
                  },
                  icon: const Icon(Icons.favorite),
                  label: const Text("Add to Favorites"),
                ),

                SizedBox(
                  width: 170,   //  ubah ikut saiz yang awak nak
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFBC02D),
                      foregroundColor: Colors.black87,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddReviewPage(movieTitle: widget.movieTitle),
                        ),
                      );
                    },
                    icon: const Icon(Icons.rate_review),
                    label: const Text("Review Movie"),
                  ),
                )
              ],
            ),

            const SizedBox(height: 30),

            //  Tajuk Synopsis
            Center(
              child: Text(
                "Synopsis",
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFBC02D), // kuning
                ),
              ),
            ),

            const SizedBox(height: 10),

// 👉 Isi synopsis
            Text(
              synopsis,
              style: GoogleFonts.nunito(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 30),

            //trailer
            if (_controller != null) ...[
              Text(
                "Watch Trailer",
                style: GoogleFonts.nunito(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFBC02D),
                ),
              ),
              const SizedBox(height: 10),
              // Trailer LAST
              if (_controller != null)
                YoutubePlayerScaffold(
                  controller: _controller!,
                  builder: (context, player) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: player, // jangan letak const, jangan panggil ()
                    );
                  },
                )
              else
                const CircularProgressIndicator(), //kalau loading tunjuk spinner
            ],
            const SizedBox(height: 30),

            Text(
              "Reviews",
              style: GoogleFonts.nunito(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFBC02D),
              ),
            ),

            reviews.isEmpty
                ? const Text("No reviews yet",
                style: TextStyle(color: Colors.white))
                : ListView.builder( //papar review dlm card
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),//x leh scroll sendiri guna parent scroll
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final rev = reviews[index];
                return Card(
                  color: Colors.grey[850],
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Color(0xFFFBC02D)),
                    title: Text("${rev['username']} ⭐ ${rev['rating']}",
                        style: const TextStyle(color: Color(0xFFFBC02D))),
                    subtitle: Text(rev['review'] ?? '',
                        style: const TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),

          ],
        ),
      ),
      bottomNavigationBar: const BottomNavPage(),
    );
  }
}
