Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BnKrE-0003XQ-MW for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jul 2004 10:26:20 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BnKrE-0003vM-1w for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jul 2004 10:26:20 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Fixing the 2.4 bugs - patches against 2.4.24-1um -
	new ones
References: <200407012050.14867.blaisorblade_spam@yahoo.it>
In-Reply-To: <200407012050.14867.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407211927.54810.blaisorblade_spam@yahoo.it>
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
Date: Wed, 21 Jul 2004 19:27:53 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

Alle 20:50, gioved=EC 1 luglio 2004, BlaisorBlade ha scritto:
> I've started working also on UML/2.4.
>
> Today I've split the changes between 2.4.24-1um and 2.4.24-2um into sever=
al
> patches; the HUMFS ones are carefully split out, but I've separated even
> the others. Now I need testers. Lots of people cannot use UML patches lat=
er
> than 2.4.24-1um, since they contain a lot of Hostfs bugs and some stabili=
ty
> issues. Now, if you use just some patches, you'll avoid the bugs in the
> other.

I've caught up until 2.4.26-2um, and I'm distributing the new tarball in my=
=20
homepage:

http://www.user-mode-linux.org/~blaisorblade/patches/UML-splitout-2.4.26-2.=
tar.bz2

The instructions stay the same; I'm not attaching the description because I=
=20
have no time; there should be no bug with a known fix...

> The actual patches can be found inside the patches/ subdir in the tarball,
> and the "series" file contains the order.

THEY ARE AGAINST 2.4.26 vanilla + 2.4.24-1uml patch: the fixlet for 2.4.26 =
is=20
included (so please unapply it before applying this patchset).

> But you should move the content of 2.4.24-2-inc-split/ folder into the ro=
ot
> of the linux tree (i.e. under Uml-linux) and then run "pushpatch 30" after
> installing patch-scripts.

The folder name changed, and now use pushpatch 100

> Here you can download patch-scripts; to install them you must just expand
> the tarball into /usr/local/bin (or any folder you like; remember to upda=
te
> the path if needed).
>
> http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.18/

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
