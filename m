Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By6Lj-00053n-06 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:10:19 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1By6Li-0000hp-BT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:10:18 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] make mrproper leaves some files around ....
References: <OF61F78B76.DD6FCAF5-ON85256ED8.00777608-04256ED8.007798C0@us.ibm.com>
	<200407222012.25767.blaisorblade_spam@yahoo.it>
In-Reply-To: <200407222012.25767.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200408132309.50015.blaisorblade_spam@yahoo.it>
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
Date: Fri, 13 Aug 2004 23:09:50 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Himanshu Raj <hraj@us.ibm.com>

Alle 20:12, gioved=EC 22 luglio 2004, BlaisorBlade ha scritto:
> Alle 23:48, mercoled=EC 21 luglio 2004, Himanshu Raj ha scritto:
> > Hi Folks,
> >
> > When I do
> > make mrproper ARCH=3Dum
> >
> > executables mk_task and mk_conatant don't go away from arch/um/util. I
> > tried putting the following lines in the arch/um/util/Makefile:
> >
> > clean :
> >         $(RM) -f $(host-progs)
> >
> > mrproper : clean
> >
> >
> > But that doesn't work. I tried finding where I can add a target for
> > CLEAN, but I don't understand the new kbuild process really well. Can
> > anyone take a shot at this?
>
> Read Documentation/kbuild/makefiles.txt and add something like this:
>
> clean-files :=3D $(host-progs)
No, sorry, those executables should already go away because listed in=20
$(always); the problem is that Kbuild does not descend in that folder; kbui=
ld=20
goes to clean where in dirs listed in core-y, libs-y, drivers-y and net-y. =


The fix is below (but it's a copy-and-paste, so apply by hand). It will be =
in=20
my next patchset - thanks for reporting.

diff -puN arch/um/Makefile~uml-add-some-cleaning arch/um/Makefile
--- uml-linux-2.6.7/arch/um/Makefile~uml-add-some-cleaning      2004-08-13 =

21:06:37.604373632 +0200
+++ uml-linux-2.6.7-paolo/arch/um/Makefile      2004-08-13 21:08:47.2416657=
68=20
+0200
@@ -145,6 +145,7 @@ archmrproper:
        @:

 archclean:
+       $(Q)$(MAKE) $(clean)=3Darch/um/util
        @find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
                -o -name '*.gcov' \) -type f -print | xargs rm -f


By the way, there is a lot of mess here - arch/um/include/skas_ptregs.h doe=
s=20
not get updated how much it should. However I wrote some patches for this, =

too.
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
