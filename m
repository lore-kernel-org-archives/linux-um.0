Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BicRo-0001lA-I5 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jul 2004 10:12:36 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BicRn-000591-UV for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jul 2004 10:12:36 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-user] Re: [uml-devel] Fixing the 2.4 bugs - patches against
	2.4.24-1um
References: <200407012050.14867.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.58.0407071420550.9924@tuxrocks.com>
In-Reply-To: <Pine.LNX.4.58.0407071420550.9924@tuxrocks.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407081832.39138.blaisorblade_spam@yahoo.it>
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
Date: Thu, 8 Jul 2004 18:38:30 +0200
Content-Transfer-Encoding: quoted-printable
To: Frank Sorenson <frank@tuxrocks.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

Alle 22:51, mercoled=EC 7 luglio 2004, Frank Sorenson ha scritto:
> On Thu, 1 Jul 2004, BlaisorBlade wrote:
> > I've started working also on UML/2.4.
> >
> > Today I've split the changes between 2.4.24-1um and 2.4.24-2um into
> > several patches; the HUMFS ones are carefully split out, but I've
> > separated even the others. Now I need testers. Lots of people cannot use
> > UML patches later than 2.4.24-1um, since they contain a lot of Hostfs
> > bugs and some stability issues. Now, if you use just some patches, you'=
ll
> > avoid the bugs in the other.
> >
> > You should apply surely the first 3 patches, IMHO; the other ones should
> > not hurt; inside txt/ there is a description of them.

> BlaisorBlade,
>
> Thank you for splitting these patches out.  Using them, I was able to
> track down and squash a kernel panic issue I've had with all 2.4 patch
> versions after 2.4.24-1um!
>
> My panic, for reference -
> http://marc.theaimsgroup.com/?l=3Duser-mode-linux-devel&m=3D1083444732262=
17&w=3D2
>
> In this case, the problem was actualy in the first 'mini-changes' patch,
> and the fix (diff to the 2.4.24-2um patch):
> --- uml-patch-2.4.24-2  2004-04-07 14:31:13.000000000 -0600
> +++ uml-patch-2.4.24-2_frank    2004-07-07 14:26:49.000000000 -0600
> @@ -35588,7 +35588,7 @@
>  +
>  +ARCH_CFLAGS =3D -U__$(SUBARCH)__ -U$(SUBARCH)
>  +
> -+ifeq ($(CONFIG_GPROF),n)
> ++ifneq ($(CONFIG_GPROF),y)
>  +ARCH_CFLAGS +=3D -DUM_FASTCALL
>  +endif
>  +
>
> The configuration program will either set CONFIG_GPROF to 'y', or it will
> put "# CONFIG_GPROF is not set" into the .config file.  CONFIG_GPROF will
> never be 'n', at least in my understanding.

Yes, you are right. Compliments for that - I would have never seen such a=20
panic (I understand you perfectly, but I missed it and would have missed it=
=20
again). So thanks a lot for helping with it - I'll save that for when I'm=20
back (I'm leaving now, so have no time at all to do anything). Your catch a=
lso=20
means that UML will break without -DUM_FASTCALL, which is not nice: the bug=
gy=20
change you see has actually uncovered some other bug; if it weren't so, the=
=20
bug you have fixed would only have hurted performance.

> I believe this bug may affect stability for a number of people, and it has
> existed since 2.4.24-2um first came out.  It may not solve any underlying
> problems, but I'd like to hear if it helps anyone else.
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
