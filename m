Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPX3p-00073O-Ct for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 18:09:13 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CPX3o-0002Pi-No for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 18:09:13 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Uml: hostfs sendfile support
References: <20041102150339.GA6904@gandalf.intern.marcant.net>
	<200411032037.56892.blaisorblade_spam@yahoo.it>
	<20041104011116.GB5175@gandalf.intern.marcant.net>
In-Reply-To: <20041104011116.GB5175@gandalf.intern.marcant.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4893120.WOCtJdFSgr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411040309.18181.blaisorblade_spam@yahoo.it>
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
Date: Thu, 4 Nov 2004 03:09:03 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: nils toedtmann <user-mode-linux-user@nils.toedtmann.net>, user-mode-linux-user@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

--nextPart4893120.WOCtJdFSgr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 November 2004 02:11, nils toedtmann wrote:
> I cc this mail to user-mode-linux-devel and LKML, too. But as i do not
> subscribe to those lists it will probably get rejected. So you may
> want to forward it.
No need. LKML is open, and UML-devel follows that.

> > > > I don't remember at the moment.

> > So, if you want to use httpd, either don't use in on hostfs, or use it =
on
> > 2.4,

> That's what i did. It was my sole 2.4-uml ...

> > or recompile apache disabling the usage of sendfile(). This is a new
> > notice I get, however.

> > That said, there is a possibility the patch is just a one-liner. It see=
ms
> > there is generic support for this. Try the attached one. Report what
> > happens, please, so I know what to do with it. If it works, it will be
> > included in next release.

> Whoopy! It works.
Wonderful!
> Many thanks!

Ok, in this case, I'm going to include that in next release. Bye and thanks=
=20
for the report!
=2D-=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--nextPart4893120.WOCtJdFSgr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBiY9OqH9OHC+5NscRAiZWAJ0Sn/j2+vi/uR+s/8N9vKw6GkyoXwCgiaUd
AFxEIV7gHchQN2lruJl7GU8=
=qz1x
-----END PGP SIGNATURE-----

--nextPart4893120.WOCtJdFSgr--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
