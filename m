Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BAcEs-0004pY-I7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Apr 2004 15:06:42 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BAcEr-0001zm-V3 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Apr 2004 15:06:42 -0700
Message-ID: <138b01c41b57$f52a47b0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <JA8AAAAAAUwi+gABYQABj6DB09hU@proteusworld.com>
	<004301c41a30$4fc80f00$0201a8c0@hawk>
	<JA8AAAAAAUwjJQABYQABj6DB09hU@proteusworld.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] Re: Re(6): [uml-user] Performance with 2.4/2.6 guest and
	tmpfs
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
Date: Mon, 5 Apr 2004 23:50:04 +0200
To: user-mode-linux-user@lists.sourceforge.net, Sebastian Paul Avarvarei <proteus@proteusworld.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

hi!
there is a performance patch at:
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107802853222733&w=2

it would be interesting to see, how much performance benefit you get from this.
(AFAIK, there have not been done much performance comparisons yet with this patch)

perhaps you have some time for further testing and posting the results ?!

regards
roland

ps:
unfortunately, it looks like a patch for a 2.4 host kernel - dont know if it can
be used with 2.6 kernel


----- Original Message ----- 
From: "Sebastian Paul Avarvarei" <proteus@proteusworld.com>
To: <user-mode-linux-user@lists.sourceforge.net>
Sent: Monday, April 05, 2004 12:29 AM
Subject: Re(6): [uml-user] Performance with 2.4/2.6 guest and tmpfs


Hello,

Christopher S. Aker  (4/4/2004  12:33 PM):
>Too bad.  I'd be very interested to see the benchmark against a SKAS
>enabled host and UML

Ok, I have made the tests with SKAS. Please see below the results. For comparison, I list all the results. Any suggestions for
performance improvements are welcome.

For each configuration you'll see two time values. On first access the groupware server responds a little slower, but afterwards
it's faster because it caches some of its database indexes.

Each test consists of opening about 600 messages from the groupware server, connecting over TCP/IP. Except for the first set, in all
others the groupware server runs inside UML:

1. Server running on 2.6.4 host: 18s / 5s
2. 2.4.23 UML, no tmpfs, no SKAS: 51s / 44s
3. 2.6.4 UML, no tmpfs, no SKAS: 60s / 49s
4. 2.4.23 UML, tmpfs, no SKAS: 50s / 43s
5. 2.6.4 UML, tmpfs, no SKAS: 58s / 49s
6. 2.4.23 UML, tmpfs, SKAS: 26s / 20s
7. 2.6.4 UML, tmpfs, SKAS: 29s / 24s
8. 2.6.4 UML, no tmpfs, SKAS: 30s / 24s


Couple of things seem to stand out from these test results, as far as this groupware server software is concerned:

- Using SKAS doubles the performance (e.g. from 58/49 to 29/24 sec.)

- UML 2.6 is slower than UML 2.4 (e.g. from 58/49 to 50/43 sec. w/o SKAS, from 29/24 to 26/20 src. w/ SKAS)

- Using tmpfs brings little improvement with 2.4 UML and almost no improvement at all with 2.6 UML

- Even with the fastest UML (2.4 with tmpfs and SKAS), the groupware server still runs about 4 times slower inside UML (5s vs. 20s).
Probably because the server does a lot of disk read/writes, which seem to be slow inside UML - even when using directly partitions
from the host (e.g. /dev/hda3).

Any comments appreciated.


Best regards,
Sebatian



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id70&alloc_id638&op=ick
_______________________________________________
User-mode-linux-user mailing list
User-mode-linux-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
