Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRpP1-0002vo-Pv for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 02:36:19 -0700
Received: from vanish.yandex.ru ([213.180.200.4])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRpP0-0007Vu-Uq for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 May 2004 02:36:19 -0700
From: <alnsn@yandex.ru>
Message-ID: <20040523093605.GA2223@x1000.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
Subject: [uml-devel] Hostfs doesn't work - digging the kernel
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
Date: Sun, 23 May 2004 13:36:05 +0400
To: user-mode-linux-devel@lists.sourceforge.net



--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
I'm trying to mount hostfs from inside my tiny uml. Host linux is RH9
with linux-2.6.6 and linux-2.4.26 vanilla kernels. UML patch is
2.4.26-1.
Mounting with no -o option results in UML kernel panic because
mount_arg argument is NULL in this case:

char *host_root_filename(char *mount_arg)
{  =20
    char *root =3D DEFAULT_ROOT;

    if((mount_arg !=3D NULL) && (*mount_arg !=3D '\0'))
        root =3D mount_arg;

    return(uml_strdup(mount_arg));
}

Returning uml_strdup(NULL) causes this panic to happen.
Correct behavior, I think, is return uml_strdup(root).

Even with -o option I can't mount. Function hostfs_init_file composes a
path beginning with jail_dir (/ in my case), then go mount and file.
    const char *path[] =3D { jail_dir, mount, file, NULL };
In my case path is either // or //tmp. The open64 function can't open both.
If I do these transformations:
"//" -> ""
"//tmp" -> "/tmp"
they are mounted but I can't read files.
I suggest always transform path like this. What do you think?
--=20
Alexander Nasonov

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAsHCFK8n/CZPtRx4RAv8CAKCXlpErHjbtrlt5CZYzoE8uwPykxgCgpdCX
eAB7IqwviQurFGNUteN4QJw=
=qqq9
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
