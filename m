Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By8G8-0004Ai-VF for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 05:12:40 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1By8G7-0006Gk-8F for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 05:12:40 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] PATCH -- Was: link error MODE_SKAS and ! MODE_TT in
	2.4.26-2 + uml.sf.net patches
References: <C28780ABC637504896EB86B4FB75FFBFA26E71@MAANDMBX1.ets.enterasys.com>
	<200408092352.i79Nq8QW026728@ccure.user-mode-linux.org>
In-Reply-To: <200408092352.i79Nq8QW026728@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200408201408.39192.blaisorblade_spam@yahoo.it>
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
Date: Fri, 20 Aug 2004 14:08:39 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, "Bahi, David" <dbahi@enterasys.com>, user-mode-linux-user@lists.sourceforge.net

Alle 01:52, marted=EC 10 agosto 2004, Jeff Dike ha scritto:
> dbahi@enterasys.com said:
> > i don't suppose there is some depencency checking  that could be
> > improved to fix this - requiring a  clean seems obsessive-compulsive
> > <grin>.
>
> Probably.  The UML build is in need of a good reaming.  The other major
> symptom of this is when you try a -j make.
I've fixed that very properly in my tree. Please don't work on that right n=
ow,=20
I'll be back in a week or two. However I'm uploading a snapshot (2.6.7-bb6)=
=20
just now. You will find it here, but please be careful (read comments in th=
e=20
series file). And remember I've worked onto 2.6.6-um1, so there is still a =

lot of common stuff.=20
http://www.user-mode-linux.org/~blaisorblade/patches/bb/uml-2.6.7-bb6.tar.b=
z2

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
