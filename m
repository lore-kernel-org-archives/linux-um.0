Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BO12t-0003Gw-1V for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 14:13:43 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BO12s-0002jG-Cb for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 14:13:42 -0700
Message-ID: <101901c43866$f7e64720$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <200405112032.13202.blaisorblade_spam@yahoo.it>
	<40A13765.5010002@muhlesteins.com>
	<200405122024.22702.blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Patch for 2.6.6
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
Date: Wed, 12 May 2004 23:20:35 +0200
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

hey,
2.6.6-um1 up and running here!
thanks paolo!

this is what i did:

-download 2.6.6 vanilla kernel
-patch with http://www.user-mode-linux.org/~blaisorblade/patches/uml-patch-=
2.6.6-02.bz2
-patch with http://www.user-mode-linux.org/~blaisorblade/patches/patch-2.6.=
6-v2

a while ago i mentioned:
"make allmodconfig ARCH=3Dum" is broken
see: http://marc.theaimsgroup.com/?l=3Duser-mode-linux-user&m=3D10825092631=
9847&w=3D2
any hints for fixing this ?

regards
roland




----- Original Message -----=20
From: "BlaisorBlade" <blaisorblade_spam@yahoo.it>
To: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Wednesday, May 12, 2004 8:24 PM
Subject: Re: [uml-devel] Patch for 2.6.6


Alle 22:28, marted=EC 11 maggio 2004, Dennis Muhlestein ha scritto:
> I got this:
>
> Reversed (or previously applied) patch detected!  Assume -R? [n]
> Apply anyway? [n] y
> Hunk #1 FAILED at 1.
> Hunk #2 FAILED at 19.
> 2 out of 2 hunks FAILED -- saving rejects to file include/asm-um/irq.h.rej
>
> when applying the first patch.  I tried also with not applying that
> part, and get a compile failure pretty early in the build process.
>
> -Dennis

Ok, I botched that part, sorry - try with the patch from Jeff Chua. I'm
posting on the site the corrected version, which I hope should apply
perfectly (I've tested it on apply and unapply - the first one come by maki=
ng
it work on reversing without rejects the Jeff Chua's version).

And, finally, also I should quit editing patches by hand :-), maybe!
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=3Ddnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to=20
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=3Dosdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
