Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: "James R. Leu" <jleu@mindspring.com>
Subject: Re: [uml-devel] uml for 2.6.12 kernel
Message-ID: <20050824034403.GA8036@mindspring.com>
Reply-To: jleu@mindspring.com
References: <838f7c500508231455607e9a7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <838f7c500508231455607e9a7d@mail.gmail.com>
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
Date: Tue, 23 Aug 2005 22:44:03 -0500
To: ashwin tanugula <ashwin.tanugula@gmail.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since you didn't specify, I assume your talking about building
a guest kernel.  In which case I just went through the the same ordeal.

I used a 2.6.12-mm2 kernel and applied jdike's patch set.  Here are the
URLs for the parts you need.

http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.1=
2-mm2/2.6.12-mm2.bz2
http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.12-mm2/patches.=
tar

I'd be interested to see what others have gotten working.

On Tue, Aug 23, 2005 at 05:55:27PM -0400, ashwin tanugula wrote:
> Hi,
> I want to build UML from source using a 2.6.12 kernel. Can somebody
> tell me whether to patch it or not as kernels from 2.6.9 have the UML
> included??
>=20
> Thanks,
> Ashwin
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--=20
James R. Leu
jleu@mindspring.com

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQFDC+0DQcSCk6yg8WERAtrsAKCBsQw6uiJNo302+MPqmiuwnT5uAACcDb0B
gAlZ7nEVTA7SjgPF5Z9LuCk=
=6cZF
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
