Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BiGTm-0008Pv-3v for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 10:45:10 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BiGTl-0000rF-Gx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 10:45:10 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Unable to handle kernel paging request ...
References: <20040707090621.GA6094@bakunin.copyleft.de>
In-Reply-To: <20040707090621.GA6094@bakunin.copyleft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407071945.30015.blaisorblade_spam@yahoo.it>
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
Date: Wed, 7 Jul 2004 19:45:29 +0200
Content-Transfer-Encoding: quoted-printable
To: Michael Koehne <kraehe@copyleft.de>, user-mode-linux-devel@lists.sourceforge.net

Alle 11:06, mercoled=EC 7 luglio 2004, Michael Koehne ha scritto:
> Moin Guru's,
>
>   i have 2.6.x host crashes, and I dont know, if they are related to
>   UML. I have a perfectly running 2.4.22 SKAS system on a dual PPro,
>   and a laptop who requires a 2.6.x kernel because of hardware. This
>   laptop is prepared to run UML's - but it seldom does.
>
>   But the laptop crashes about once or twice a week. This sometimes
>   happens on operations like `find . -print | while read x; do diff
>   ../foo/$x $x; done` or rsync over large directory trees. And sometimes
>   on idle state - e.g. tonight at crontime with a 'postmaster' crash.
>   I've talked to people on IRC, and they dont encounter those kind of
>   ext3 crashes on 2.6 kernels. I dont had a camera for a screenshot,
>   but dump was in ext3 area.

You say in the title "Unable to handle kernel paging request". It means you=
=20
got a panic... Have you saved somewhere the complete message? Have you=20
checked if it's inside /var/log/messages? Does "dump was in ext3 area" mean=
s=20
that the call trace mentioned ext3_ <something>? If it speaks about=20
__init_new_context, proc_mm or such things then the SKAS patch is likely to=
=20
be at fault, if not it's unlikely...
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
