Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CkKsN-0002Ko-Q9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Dec 2004 03:23:23 -0800
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CkKsJ-00060O-6M for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Dec 2004 03:23:23 -0800
From: "Armin M. Warda" <Armin.Warda@gmx.de>
Reply-To: Armin.Warda@gmx.de
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200412301520.48951.Armin.Warda@gmx.de>
	<E54DD071-5A7D-11D9-853A-0003931D03FE@theshore.net>
In-Reply-To: <E54DD071-5A7D-11D9-853A-0003931D03FE@theshore.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17272628.CnRYXJrCcs";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412311222.10579.Armin.Warda@gmx.de>
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
Date: Fri, 31 Dec 2004 12:22:05 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, "Christopher S. Aker" <caker@theshore.net>

--nextPart17272628.CnRYXJrCcs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 30 December 2004 17:14, Christopher S. Aker wrote:
> You need to run 2.6.10,=20

That's supposed to be a 2.6.10 _Host_-Kernel? (Not 2.6.10 UM-Kernel?)

> as it doesn't exhibit the tmpfs filling up=20
> problem like 2.6.9 variants do.=20

Any chance to have a 2.6.10 SuSE Kernel soon?=20

(As I use some non-GPL kernel modules - Atheros, Soft-Modem - that=20
come with the SuSE kernels but are not in kernel.org's, I would=20
prefer to stick with the SuSE-Kernel and not switch to the vanilla=20
2.6.10 kernel. But if this would be the only possibility to solve=20
this problem, I would indeed switch...)

> The tmpfs problem is also =20
> compounded by the fact that UMLs without the fix-kill patch don't
> exit properly, but the 2.6.9-bb4 patchset has the fix for UML.

You say UM-Kernel 2.6.9-bb4 has that fix? (Yes, I am running 2.6.9-bb4=20
UM-Kernels)

> For 2.4-um, you can find the fix-kill patch here:
> http://www.theshore.net/~caker/uml/patches/2.4.27-1um/
>
> -Chris
>
> On Dec 30, 2004, at 9:20 AM, Armin M. Warda wrote:
> >   Hi,
> >
> > just tried again with SuSE host kernel 2.6.8-24.10: same problem.
> >
> > (Is 2.6.8-24.10 a 2.6.8 with back-ported fixes from 2.6.10 ?)
> >
> >   Armin.
> >
> > On Thursday 16 December 2004 20:13, Paolo Giarrusso wrote:
> >> On Thursday 16 December 2004 19:36, Gerd Knorr wrote:
> >>>> Well, this matches some other reports of a different problem
> >>>> (impossible to unmount a fs used by UML) which probably
> >>>> relates to 2.6.9 host bugs.
> >>>>
> >>>> I'd suggest trying to reproduce the bug with a 2.6.8.1 +
> >>>> SKAS3-v7 patch, or checking what's different in the SuSE
> >>>> kernel from vanilla 2.6.8.1 (I'm particularly suspiscious
> >>>> about the TASK_TRACED introduction).
> >>>
> >>> The suse 2.6.8 kernel is actually 2.6.9-rc2, thus more close to
> >>> 2.6.9 than 2.6.8.  Especially it already has the TASK_TRACED
> >>> stuff and I've used the 2.6.9 version of the skas v7 patch
> >>>
> >>> (and also thats why I've
> >>> suggested to check against 2.6.9 not 2.6.8.1 vanilla to see if
> >>> the issue is still there).
> >>
> >> Remember that there was an invisible reference from died UMLs
> >> that kept the tmpfs from being unmounted (multiply reported, I
> >> experienced that too). Well, it the file is kept used, then it
> >> will keep using the tmpfs space. So nothing new....
> >
> > --
> >    --- May the Source be with you! Linux. ---
> >    --- secure eMail: http://www.gnupg.de/ ---
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well,
> almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

=2D-=20
   --- May the Source be with you! Linux. ---
   --- secure eMail: http://www.gnupg.de/ ---

--nextPart17272628.CnRYXJrCcs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB1TZiRyBj5Zbydm0RAgJQAKCF2nNFyrZOyGAkgAi5X6r2GfvosgCgwLu/
SvwvozNvQ+TPlCU6kaBj7fw=
=YJ96
-----END PGP SIGNATURE-----

--nextPart17272628.CnRYXJrCcs--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
