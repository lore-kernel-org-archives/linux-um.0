Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDVJo-0007SX-DC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Apr 2004 14:19:44 -0700
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BDVJn-0002ct-O2 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Apr 2004 14:19:43 -0700
Message-ID: <1fb601c4219d$ee592c20$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
	<195901c41e61$3132cb90$2000000a@schlepptopp>
	<200404101428.36306.blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml responsivenes or "AS vs DEADLINE Scheduler on
	uml-host" - was: [uml-user] Network lags
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Tue, 13 Apr 2004 23:26:03 +0200
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>
Cc: Joern Bredereck <jb@bw-networx.net>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

hi!

>1) Well, you switched from AS to deadline and got a significant IO perform=
ance
>improvement, which made UML faster since it was Disk-bound. The problem wi=
th
>AS is that it uses an heuristic, which assumes sequential reads.
mmhh - i didn`t really recognize that i got a big improvement of i/o perfor=
mance
in general. i just recognized, that my uml was more responsive to ping (no =
more
"sendmsg: no buffer space available,no network lags of values like 60s anym=
ore).
btw: my uml didn`t access the disk at all, while answering the pings (why s=
hould it?
all that network-stuff happens in uml-kernel space)

>But "find /" is very seeky, so it is slow with AS. So if you remove this bg
>thread, you should get significantly different results.
no - that doesn`t really matter. ok - it took some more time that i got net=
work lags
with my uml and "sendmsg:..."-ping-errors. but the errors were the same and=
 happened
regardless of the 10 parallel "find /" threads, i started on the host.

>Also, AS has had some changes in later kernels, so you should probably upg=
rade
>your host kernel to the latest version. A security hole (a local exploit to
thats a point. will try that if i find some time. does somebody have some m=
ore details
what was changed exactly? (i dont know much about bitkeeper - but maybe i c=
an view the
changelog like in cvs, for every single file?)

>2) In your last email, you speak about hogging the UML CPU. If Jeff guessed
>correctly what happens, then avoiding that UML is idle will decrease the
>worst-case ping response times.
i think he guessed wrong. it doesnt matter if my uml is idle or not - no di=
fference
if i run a vmstat (and some more) inside my uml( i.e. it is not idle) while=
 pinging.
the effect i experience doesnt`t seem to be an effect which is caused by a =
uml being
swapped out and in again - because i didn`t see a single byte being swapped=
 out/in on
the host. so this effect remains....strange for me.

regards
roland





----- Original Message -----=20
From: "BlaisorBlade" <blaisorblade_spam@yahoo.it>
To: "roland" <for_spam@gmx.de>; "Jeff Dike" <jdike@addtoit.com>
Cc: "Joern Bredereck" <jb@bw-networx.net>; <user-mode-linux-user@lists.sour=
ceforge.net>;
<user-mode-linux-devel@lists.sourceforge.net>; <mingo@elte.hu>
Sent: Saturday, April 10, 2004 2:28 PM
Subject: Re: [uml-devel] uml responsivenes or "AS vs DEADLINE Scheduler on =
uml-host" - was: [uml-user] Network lags


Alle 20:33, venerd=EC 9 aprile 2004, roland ha scritto:
> Hi !
> I think i found an interesting "scheduling issue" which led me to switch
> the subject of the thread.

1) Well, you switched from AS to deadline and got a significant IO performa=
nce
improvement, which made UML faster since it was Disk-bound. The problem with
AS is that it uses an heuristic, which assumes sequential reads.

But "find /" is very seeky, so it is slow with AS. So if you remove this bg
thread, you should get significantly different results.

Also, AS has had some changes in later kernels, so you should probably upgr=
ade
your host kernel to the latest version. A security hole (a local exploit to
become root) has also been fixed after 2.6.0.

2) In your last email, you speak about hogging the UML CPU. If Jeff guessed
correctly what happens, then avoiding that UML is idle will decrease the
worst-case ping response times.

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dick
_______________________________________________
User-mode-linux-user mailing list
User-mode-linux-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
