Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgoCH-0001JJ-PV for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 10:21:05 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BgoCG-0002bN-NK for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 Jul 2004 10:21:05 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] performance problem
References: <OF78A78532.F1B0D905-ONC1256EC5.005E41A3-C1256EC5.00604452@mpsa.com>
In-Reply-To: <OF78A78532.F1B0D905-ONC1256EC5.005E41A3-C1256EC5.00604452@mpsa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407031927.31347.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 3 Jul 2004 19:27:31 +0200
Content-Transfer-Encoding: quoted-printable
To: pierre.gentile@mpsa.com, user-mode-linux-devel@lists.sourceforge.net

Alle 19:31, venerd=EC 2 luglio 2004, pierre.gentile@mpsa.com ha scritto:
> Hello all
>
>  Seems i've got a problem !
>
>  Host :
>  Compaq proliant ML570 (4 700 MHz cpus, 4 GB memory)
>
>  Host kernel:
>  generic 2.4.26 + skas patch from Blaisorbalde + sysemu patch + cpucap
>  patch + Device Mapper patch for EVMS ans EVMS compementary patchs
>
>  UML kernel:
>  generic 2.4.26 + uml-2.4.26 patch + sysemu patch
>
>  The problem is summarized by the 2 following results from unixbench 4.10.
>  The hostname of the host is pyaqqe, the one of the UML VM id pyaqqe02
>
>   (See attached file: bench1.txt)
>
>  A huge lost of performance isn't it ?
>
>  pyaqqe02 was the only one active during the bench
>
>  Questions 1:
>  Do you think it is normal that my VM performs so bad  ?
>
>  Question 2:
>  A soon as I launch 2 benchs simultaneously on 2 VMs, I encounter
>  segmentation faults during sleeps (reproductible). I thought may MVs were
>  waterproof. Do you have an explanation ?
Where do you get the segfaults? Have you checked for any kernel panic on th=
e=20
host in /var/log/messages?
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
