Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRqBL-0005Dz-O4 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 03:26:15 -0700
Received: from bingo.yandex.ru ([213.180.200.1])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BRqBL-0007SD-3S for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 03:26:15 -0700
From: <alnsn@yandex.ru>
Subject: Re: [uml-devel] Hostfs doesn't work - digging the kernel
Message-ID: <20040523102602.GA4034@x1000.localdomain>
References: <20040523093605.GA2223@x1000.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20040523093605.GA2223@x1000.localdomain>
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
Date: Sun, 23 May 2004 14:26:02 +0400
To: user-mode-linux-devel@lists.sourceforge.net



--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alexander Nasonov wrote:
> Even with -o option I can't mount. Function hostfs_init_file composes a
> path beginning with jail_dir (/ in my case), then go mount and file.
>     const char *path[] =3D { jail_dir, mount, file, NULL };
> In my case path is either // or //tmp. The open64 function can't open bot=
h.
> If I do these transformations:
> "//" -> ""
> "//tmp" -> "/tmp"
> they are mounted but I can't read files.
> I suggest always transform path like this. What do you think?
Opps, it doesn't work. I wonder how it worked before. I need more digging :)
--=20
Alexander Nasonov

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAsHw6K8n/CZPtRx4RAuXoAKCoChUcmM1tgZ3C3+Hga+K1qT9CZgCfbvY3
0AMCLm94DSD7ozho3+26bpo=
=TVzw
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
