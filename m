Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AQt0g-0003BN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 01 Dec 2003 10:43:02 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AQt0f-0006lO-Pu
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 01 Dec 2003 10:43:01 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] process start time in future
References: <a06010201bbec00ce8036@[192.168.1.10]> <007501c3b535$79848d10$2000000a@schlepptopp>
In-Reply-To: <007501c3b535$79848d10$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200311282042.09602.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 28 Nov 2003 20:42:09 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 23:26, gioved=EC 27 novembre 2003, roland ha scritto:
> btw: is jeff the only person doing development or patchmerging/bugfixing
> most of the time?
He is not the only one who develops UML: there is a whole bunch of patches =

coming in, even if he is the only one with write access to the official=20
CVS/BitKeeper(I don't know which one) repository, as long as I know. Just a=
s=20
the main kernel.
> is uml primarily a "one man" thing and uml dies, if jeff
> looses interest one day? i don`t hope so... but i really wonder anyway,
> that there is so few traffic on the mailinglists.

That's not true, provided you don't compare to the LKML...
> is uml still so "exotic"
> that so few people actually seem to be interested?
A few people? It's inside Debian(Matt Zimmerman is the maintainer), it's=20
bundled inside SuSE 9.0(we have often mail from SuSE labs)

1) it is very interesting: some things simply can't be done without it.

For instance, if you have a switched LAN, instead than one with a hub, to=20
install NIDS you normally need hardware support(i.e. a port on the switch, =

connected to the NIDS, replicating what goes out from another port); and th=
en=20
a devoted machine, only to run Snort...

2) it's widely used and will be more, since it has been included inside=20
official 2.6(even if you still need some patches :-( ); there are various=20
hosting providers providing virtual servers using it; in Italy, for instanc=
e,=20
one of these advertises on a lot of widely distributed informatic reviews..=
.;=20
I've also read a lot of articles speaking about it.
> maybe everybody has
> vmware already... ;)
VMware is not free software and since it goes emulating hardware, it should=
=20
have more overhead; said that, I have no benchmark to show this. But if UML=
=20
were slower, it would only need tuning. Note that normally, UML memory is p=
ut=20
on a disk file, so it IS slower. But if you put /tmp on tmpfs(i.e. in RAM),=
=20
this goes away.
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
