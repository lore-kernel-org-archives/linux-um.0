Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BoWJr-0001GS-Sx for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jul 2004 16:52:47 -0700
Received: from heretic.physik.fu-berlin.de ([160.45.32.227])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BoWJr-00008b-AT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jul 2004 16:52:47 -0700
From: Axel Thimm <Axel.Thimm@ATrpms.net>
Message-ID: <20040724235215.GA4751@neu.nirvana>
References: <Pine.LNX.4.44.0407221901400.1382-100000@hfuhruhurr.iostream.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407221901400.1382-100000@hfuhruhurr.iostream.com>
Subject: [uml-devel] Re: I ported skas3 to fc2 kernel
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
Date: Sun, 25 Jul 2004 01:52:15 +0200
To: Jinnah Dylan Hosein <jdh66@jdh.org>
Cc: user-mode-linux-devel@lists.sourceforge.net



--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jinnah,

On Thu, Jul 22, 2004 at 07:13:33PM -0400, Jinnah Dylan Hosein wrote:
> I ported the host-skas3-2.6.7-v1.patch to the Fedora Core 2 kernel.
>=20
> I used the latest fc2 2.6.6-1.435.2.3 kernel rpm.

Alexander Dalloz has done similar against a later kernel from
post-FC2. Perhaps we should consolidate forces :)

The kernel rpm is available in the testing section of ATrpms:

http://ATrpms.net/name/kernel-testing/fc2/

(the 1.494 based kernel).

BTW my personal wishlist would be a combined uml&skas3 patch for
~2.6.8rc1 (like blaisorblade did for 2.6.6). :)

uml-utilities have also been uploaded as rpms to ATrpms.
--=20
Axel.Thimm at ATrpms.net

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAvYvQBVS1GOamfERArUcAJ0ezsa8J3V6lM58jBYQweURwdB1PgCfa7Q3
I5xElZ1JzxB/ffFEfYV7z4A=
=i171
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
