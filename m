Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IaZ2d-0004to-0g for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 08:43:11 -0700
Received: from hu-out-0506.google.com ([72.14.214.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IaZ2I-0007RQ-As
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 08:42:51 -0700
Received: by hu-out-0506.google.com with SMTP id 28so1049590hub
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 26 Sep 2007 08:42:48 -0700 (PDT)
From: Paolo Giarrusso <p.giarrusso@gmail.com>
Date: Wed, 26 Sep 2007 17:42:32 +0200
References: <20070918233336.GA9746@c2.user-mode-linux.org>
	<200709201757.56298.p.giarrusso@gmail.com>
	<20070924200127.GB25202@c2.user-mode-linux.org>
In-Reply-To: <20070924200127.GB25202@c2.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200709261742.44100.p.giarrusso@gmail.com>
Subject: Re: [uml-devel] [PATCH] UML - Fix irqstack crash
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2003735638=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

--===============2003735638==
Content-Type: multipart/signed; boundary="nextPart1380752.XAKfpcfMdN";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1380752.XAKfpcfMdN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On luned=EC 24 settembre 2007, Jeff Dike wrote:
> On Thu, Sep 20, 2007 at 05:57:49PM +0200, Paolo Giarrusso wrote:
> > Yes, indeed - or sign extension on 64bit machines would set to 1 the
> > whole high-word.
> >
> > But using long for that mask makes no difference; either int or long
> > long (or  better, either u32 or u64) should be used, given that the
> > used signal range  is the same on 32 and 64bit machines, it should
> > be u32 for normal signals or u64 if RT-signals are also allowed.
>
> We don't use RT signals for anything, so we could use u32.
I wasn't sure of that.
> I don't=20
> see it making much difference though.
Agreed - the only difference is for cleanliness and easy verification.
=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade

--nextPart1380752.XAKfpcfMdN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+n30qH9OHC+5NscRAryQAJ9qwNwlriYOppUxyYGtZM+mXSppawCcCtQT
FbuRtB9QDFCUmLsAVMOVOT8=
=EPXm
-----END PGP SIGNATURE-----

--nextPart1380752.XAKfpcfMdN--


--===============2003735638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============2003735638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2003735638==--

