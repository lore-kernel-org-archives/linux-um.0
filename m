Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BCHbL-0005Mi-5J for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 05:28:47 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BCHbK-0004ie-DO for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 05:28:46 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml responsivenes or "AS vs DEADLINE Scheduler on
	uml-host" - was: [uml-user] Network lags
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
	<195901c41e61$3132cb90$2000000a@schlepptopp>
In-Reply-To: <195901c41e61$3132cb90$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200404101428.36306.blaisorblade_spam@yahoo.it>
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
Date: Sat, 10 Apr 2004 14:28:36 +0200
Content-Transfer-Encoding: quoted-printable
To: roland <for_spam@gmx.de>, Jeff Dike <jdike@addtoit.com>
Cc: Joern Bredereck <jb@bw-networx.net>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu

Alle 20:33, venerd=EC 9 aprile 2004, roland ha scritto:
> Hi !
> I think i found an interesting "scheduling issue" which led me to switch
> the subject of the thread.

1) Well, you switched from AS to deadline and got a significant IO performa=
nce=20
improvement, which made UML faster since it was Disk-bound. The problem wit=
h=20
AS is that it uses an heuristic, which assumes sequential reads.

But "find /" is very seeky, so it is slow with AS. So if you remove this bg=
=20
thread, you should get significantly different results.

Also, AS has had some changes in later kernels, so you should probably upgr=
ade=20
your host kernel to the latest version. A security hole (a local exploit to=
=20
become root) has also been fixed after 2.6.0.

2) In your last email, you speak about hogging the UML CPU. If Jeff guessed=
=20
correctly what happens, then avoiding that UML is idle will decrease the=20
worst-case ping response times.

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
