Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMjiN-00037i-IM for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 02:40:19 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FMjiN-0002Vx-At
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 02:40:19 -0800
Subject: Re: [uml-devel] Re: TLS support - status - need for re-testing
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <20060324015120.GA8104@ccure.user-mode-linux.org>
References: <200603230317.48384.blaisorblade@yahoo.it>
	<20060323211424.GA6130@ccure.user-mode-linux.org>
	<200603240044.06196.blaisorblade@yahoo.it>
	<20060324015120.GA8104@ccure.user-mode-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Fb2c+g6GGOAomURob7Eo"
Message-Id: <1143196799.2868.1.camel@localhost>
Mime-Version: 1.0
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
Date: Fri, 24 Mar 2006 10:39:59 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net


--=-Fb2c+g6GGOAomURob7Eo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-23 at 20:51 -0500, Jeff Dike wrote:
> On Fri, Mar 24, 2006 at 12:44:05AM +0100, Blaisorblade wrote:
> > Yes, that is true, but meanwhile give a testing to them, especially reg=
ressio
> > test the new patches. I can't merge new patches in until I'm sure they =
don't=20
> > cause regressions.
>=20
> OK, I give it a thumbs-up on a first boot - it's running my FC5
> filesystem without any trouble.  I'll keep playing with it and let you
> know of any trouble.
I haven't been able to run FC4/FC5 x86 filesystems with any of the
patches floating around. (on amd64 host)

> Attached is a tarball of the patches merged after the patches I have
> planned for 2.6.17.  Nothing major, just some fuzz, some Makefile
> rejections, and rejections from some whitespace cleanup in
> kernel/skas/process_kern.c.
I couldn't figure out in which order I need to apply these (no series
file) and I've ran out of time.

Antoine

--=-Fb2c+g6GGOAomURob7Eo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEI8x/rTBrLRG7eDcRAt/OAKCdTg7ETnZqm/sBqFA15tbX71/e5wCfa8Tj
1bir0SJfIWZxiCpLoADrvik=
=GLDL
-----END PGP SIGNATURE-----

--=-Fb2c+g6GGOAomURob7Eo--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
