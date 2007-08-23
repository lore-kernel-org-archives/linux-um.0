Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IOE1R-000797-Gf for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 07:51:04 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IOE1N-0003pO-TK
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Aug 2007 07:50:56 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 23 Aug 2007 16:50:37 +0200
References: <20070816162428.GA8128@c2.user-mode-linux.org>
	<200708211905.59128.blaisorblade@yahoo.it>
	<20070822163729.GB11022@c2.user-mode-linux.org>
In-Reply-To: <20070822163729.GB11022@c2.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200708231650.44468.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML - Add a .note.SuSE section
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2045025351=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>

--===============2045025351==
Content-Type: multipart/signed; boundary="nextPart1265005.ROOJuV1bcG";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1265005.ROOJuV1bcG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On mercoled=EC 22 agosto 2007, Jeff Dike wrote:
> On Tue, Aug 21, 2007 at 07:05:53PM +0200, Blaisorblade wrote:
> > It's not the first time we hit effects of such bugs, is it?
>
> I don't remember seeing this before.
>
> > The .note.ABI-tag fix, time ago, may be about the same problem.
>
> Are you referring to
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdi
>ff;h=3Dc35e584c087381aaa5f1ed40a28b978535c18fb2;hp=3Da5bd1786fb30abe663b90=
4f6d79
>bba413e9ba883?

Yes.

>If so, I never understood that - it just came in saying "this=20
> fixes static building", so I sent it along.

In this case, I'm referring to the patch which had a typo, which is yours:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3D7632fc8f809a97f9d82ce125e8e3e579390ce2e5
Description follows:
"During a static link, ld has started putting a .note section in the
=2Euml.setup.init section.  This has the result that the UML setups begin
with 32 bytes of garbage and UML crashes immediately on boot.

This patch creates a specific .note section for ld to drop this stuff
into."

My patch only made your change work for real - IIRC you had fixed that exac=
t=20
typo too, but you forgot to run quilt refresh before sending the patch (btw=
,=20
quilt pop -a will force you to refresh all patches to succeed - I do it=20
frequently).

> BTW, that commit was singled=20
> out by git-bisect as "causing" this particular problem.
>
> > Can you
> > double-check all UML linker scripts for more instances of this bug?
>
> I did, I have a patch, and it's been verified to fix the problem.

In this case, we _may_ want to remove the .note section altogether - even i=
f=20
it is likely to shake out more problems.

Good bye!
=2D-=20
"Doh!" (cit.), I've made another another mistake!
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--nextPart1265005.ROOJuV1bcG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGzZ7EqH9OHC+5NscRAiMCAJ4pMb6fCpv5EtsGQ06YNewWYyD1/QCgildc
wzUSddXHnjiZfhiqr28ycK4=
=V6aQ
-----END PGP SIGNATURE-----

--nextPart1265005.ROOJuV1bcG--


--===============2045025351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============2045025351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2045025351==--

