Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BiGEs-0005XE-2W for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 10:29:46 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BiGEr-00065D-Ee for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 10:29:45 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Unable to handle kernel paging request ...
References: <20040707090621.GA6094@bakunin.copyleft.de>
In-Reply-To: <20040707090621.GA6094@bakunin.copyleft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407071929.46294.blaisorblade_spam@yahoo.it>
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
Date: Wed, 7 Jul 2004 19:29:46 +0200
Content-Transfer-Encoding: quoted-printable
To: Michael Koehne <kraehe@copyleft.de>, user-mode-linux-devel@lists.sourceforge.net

Alle 11:06, mercoled=EC 7 luglio 2004, Michael Koehne ha scritto:
> Moin Guru's,
>
>   i have 2.6.x host crashes, and I dont know, if they are related to
>   UML. I have a perfectly running 2.4.22 SKAS system on a dual PPro,
>   and a laptop who requires a 2.6.x kernel because of hardware. This
>   laptop is prepared to run UML's - but it seldom does.

>   But the laptop crashes about once or twice a week. This sometimes
>   happens on operations like `find . -print | while read x; do diff
>   ../foo/$x $x; done` or rsync over large directory trees. And sometimes
>   on idle state - e.g. tonight at crontime with a 'postmaster' crash.
>   I've talked to people on IRC, and they dont encounter those kind of
>   ext3 crashes on 2.6 kernels. I dont had a camera for a screenshot,
>   but dump was in ext3 area.
What you mean with "ext3 crash"? "The dump was in ext3 area"? I don't=20
understand you, sorry.

>   So it might be something with SKAS host patch - even if the system
>   also crashes, if no UML is running.
Well, the UML patch should have no influence, if you don't run UML on it (i=
f=20
it happens after you have run UML at least once, there is still a chance
>      33240033 Feb  3 06:41 linux-2.6.1.tar.bz2
>    +    15570 Feb  4 02:36 host-2.6.1-skas3.patch
>   or 34896138 May 25 20:45 linux-2.6.6.tar.bz2
>    +    16182 May 25 20:35 host-skas3-2.6.6-v1.patch

Well, since you experience them so often, try compiling a vanilla kernel,=20
without the SKAS patch. Also, I'm highly suspicious of the 2.6.1 patch: it'=
s=20
likely it is an old, buggy version. Is that from Stephen D. Williams,=20
distributed at this URL: http://sdw.st/src/uml/linux-2.6.1-skas3.patch? Tha=
t=20
is a buggy one, known to cause crashes... the second one is safe enough=20
(though somebody experience memory leaks... as reported on=20
http://www.user-mode-linux.org/~blaisorblade; however, they seldom happen).

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
