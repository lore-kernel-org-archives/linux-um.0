Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ClTFb-0002yK-16 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Jan 2005 06:32:03 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1ClTFS-0007WM-3D for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Jan 2005 06:32:02 -0800
From: "Armin M. Warda" <Armin.Warda@gmx.de>
Reply-To: Armin.Warda@gmx.de
References: <200412140958.58402.Armin.Warda@ePost.De>
	<200501031249.26675.Armin.Warda@gmx.de>
	<20050103133412.GA25262@bytesex>
In-Reply-To: <20050103133412.GA25262@bytesex>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1435149.jpvz4k4KtT";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501031531.19246.Armin.Warda@gmx.de>
Subject: [uml-devel] Re: UML fills /tmp irreversibly (2.6.9-bb4 on SuSE 9.2)
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
Date: Mon, 3 Jan 2005 15:31:14 +0100
To: Gerd Knorr <kraxel@bytesex.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Paolo Giarrusso <blaisorblade_personal@yahoo.it>, "Christopher S. Aker" <caker@theshore.net>

--nextPart1435149.jpvz4k4KtT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  Hi Gerd,

On Monday 03 January 2005 14:34, you wrote:
> host or uml kernel fix?  URL?  Havn't tracked stuff at all over
> xmas holidays ...

Must be a host-Kernel fix, not a uml-kernel fix, because um-kernel=20
2.6.9-bb4 running on host-kernels

 -  SuSE 2.6.8-24-default
 -  SuSE 2.6.8-24.3-default
 -  SuSE 2.6.8-24.5-default
 -  SuSE 2.6.8-24.10-default

(which are actually 2.6.9-rc2, as you stated in earlier mail) makes=20
the problem occur (I tested it), and Christopher S. Aker reports the=20
same problem with host-kernel

 -  2.6.9-ck3
 -  2.6.10-rc2-bk7

The same um-kernel 2.6.9-bb4 on a plain kernel.org host-kernel=20

 +  2.6.10

and on a kernel.org host-kernel

 +  2.6.10 with skas3-v7

does not show the problem (I tested it), and Christopher S. Aker=20
reports no problem with host-kernel

 +  2.6.10-rc3-bk10

Thus the bugfix must have been introduced somewhere between=20
2.6.10-rc2-bk7 and 2.6.10-rc3-bk10.

I scanned the changelog for 2.6.10 but until now failed to identify=20
the patch:

  http://www.de.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.10

Can somebody else on the list help me to identify the patch for=20
this "problem with /tmp filling irreversibly and being unable to
unmount /tmp" bugfix? Thanks!=20

  Armin.

=2D-=20
   --- May the Source be with you! Linux. ---
   --- secure eMail: http://www.gnupg.de/ ---

--nextPart1435149.jpvz4k4KtT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB2Vc3RyBj5Zbydm0RAuuaAKDCcMUih5ssOJDsvggAZwtuIdBL/wCgzzvI
GWtic5AD0apD8f3f7wzGzwE=
=irjc
-----END PGP SIGNATURE-----

--nextPart1435149.jpvz4k4KtT--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
