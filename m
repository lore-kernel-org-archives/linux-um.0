Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bf07e-0005Gd-Vq for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 10:40:50 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bf07e-00082a-DA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Jun 2004 10:40:50 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] backtrace of uml crash on mysql-server start
References: <40DDDB91.9050304@exse.net>
	<200406271803.50551.blaisorblade_spam@yahoo.it>
	<40DF2ECE.80306@exse.net>
In-Reply-To: <40DF2ECE.80306@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200406281954.05698.blaisorblade_spam@yahoo.it>
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
Date: Mon, 28 Jun 2004 19:54:05 +0200
Content-Transfer-Encoding: quoted-printable
To: Sebastian =?iso-8859-1?q?B=F6hm?= <seb@exse.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 22:32, domenica 27 giugno 2004, Sebastian B=F6hm ha scritto:
> BlaisorBlade wrote:
> Can I exit gdb now ? Or is there something more ?
Well, maybe you can. There is a patch onto the ML (not from me), with this =

title:

[uml-devel] Patch for arch/um/kernel/trap_kern.c to fix bad panic

And I think it could fix exactly your problem. At least, retry with that=20
applied; and say me whether things become safe or not. However, I'm not sur=
e=20
it does relate to that bug.

> I posted the complete output to user-mode-linux-devel, did you noticed th=
at=20
?

I received all your mails, now, but I'm not always online so when I wrote t=
hat=20
mail I hadn't it yet.

Bye
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
