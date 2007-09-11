Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IV6Ne-0001cV-Qs for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 07:06:19 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IV6Nc-0004Hh-Dn
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 07:06:18 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 11 Sep 2007 16:06:08 +0200
References: <20070904214521.GB5417@c2.user-mode-linux.org>
	<296838.33596.qm@web52009.mail.re2.yahoo.com>
	<20070910155943.GA14112@c2.user-mode-linux.org>
In-Reply-To: <20070910155943.GA14112@c2.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200709111606.08509.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [uml-user] Hanging using 'iptables -L' in UML vm
	booted with con0=pts
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1934487481=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Andrews <bbmaj7@yahoo.com.au>, Jeff Dike <jdike@addtoit.com>

--===============1934487481==
Content-Type: multipart/signed; boundary="nextPart1560680.e1Z5J5f28i";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1560680.e1Z5J5f28i
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On luned=EC 10 settembre 2007, Jeff Dike wrote:
> On Wed, Sep 05, 2007 at 09:00:51AM +1000, Richard Andrews wrote:
> > There is an outstanding kernel + mod_utils bug I am tracking via RedHat
> > that exhibits similar behaviour - lockup with 100% CPU in modprobe.
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D212922
>
> This one seems not to have anything to do with UML, while the bug that
> we're talking about here seems to, as modprobe sometimes works and
> sometimes doesn't.

My memory remembers that vmalloc() is used both by iptables and by module=20
support, and that I've learnt this while we debugged some very old vmalloc=
=20
bug (I may be talking of 2.4.20). I've not had the time to look at that=20
report, but does what I say make sense to you?
=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--nextPart1560680.e1Z5J5f28i
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG5qDQqH9OHC+5NscRAnvIAJ47+YcZMtXCdq8lNBW9kOi51hhGRACfY0jJ
KHDSZSRguWmZ26tx2bUyXPg=
=IFfj
-----END PGP SIGNATURE-----

--nextPart1560680.e1Z5J5f28i--


--===============1934487481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1934487481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1934487481==--

