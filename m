Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cl1zj-0002lT-3L for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Jan 2005 01:25:51 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cl1zd-0000gc-GA for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Jan 2005 01:25:50 -0800
From: "Armin M. Warda" <Armin.Warda@gmx.de>
Reply-To: Armin.Warda@gmx.de
Subject: Re: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE
	9.2)
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200412311222.10579.Armin.Warda@gmx.de>
	<0e6601c4f03e$00c69770$0201a8c0@hawk>
In-Reply-To: <0e6601c4f03e$00c69770$0201a8c0@hawk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1716292.3YZbyaWD5s";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501021025.11651.Armin.Warda@gmx.de>
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
Date: Sun, 2 Jan 2005 10:25:05 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Christopher S. Aker" <caker@theshore.net>, Gerd Knorr <kraxel@bytesex.org>

--nextPart1716292.3YZbyaWD5s
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  Hi,

I can positively confirm that the problem with /tmp filling=20
irreversibly and being unable to unmount /tmp is solved under=20
host kernel 2.6.10.

Unfortunately I am experiencing some new problems after the=20
change from host kernel SuSE 2.6.8-24.10 to vanilla 2.6.10:=20
submount-0.9: name of iocharset gets truncated when calling=20
df, slmodem-2.9.10: modules complain about unknown symbols,=20
swsusp: ohci1394 fails to release. But that's a different=20
story, has nothing to do with UML.=20

Hopefully the guys at SuSE pick up the /tmp-fixes from 2.6.10=20
and backport them to their SuSE-Kernel...

  Armin

On Saturday 01 January 2005 21:10, Christopher S. Aker wrote:
> > That's supposed to be a 2.6.10 _Host_-Kernel? (Not 2.6.10
> > UM-Kernel?)
>
> Correct.
>
> >> The tmpfs problem is also
> >> compounded by the fact that UMLs without the fix-kill patch
> >> don't exit properly, but the 2.6.9-bb4 patchset has the fix for
> >> UML.
> >
> > You say UM-Kernel 2.6.9-bb4 has that fix? (Yes, I am running
> > 2.6.9-bb4 UM-Kernels)
>
> Correct.
>
> >> For 2.4-um, you can find the fix-kill patch here:
> >> http://www.theshore.net/~caker/uml/patches/2.4.27-1um/
>
> -Chris
>
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

--nextPart1716292.3YZbyaWD5s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB1733RyBj5Zbydm0RAkYqAJ9he8N7JWQQDA+Yab4CkH167/H0sQCdE99W
e7+07A+83sR717dsw+wbX6E=
=XD4l
-----END PGP SIGNATURE-----

--nextPart1716292.3YZbyaWD5s--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
