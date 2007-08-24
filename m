Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IObkF-0004Az-Vq for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Aug 2007 09:10:48 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IObkD-00060f-8V
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Aug 2007 09:10:47 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Fri, 24 Aug 2007 18:10:24 +0200
References: <20070817194342.GA8759@c2.user-mode-linux.org>
	<200708231655.00034.blaisorblade@yahoo.it>
	<20070824152127.GA7190@c2.user-mode-linux.org>
In-Reply-To: <20070824152127.GA7190@c2.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200708241810.37052.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 6/6] UML - Fix hostfs style
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0585681685=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Joe Perches <joe@perches.com>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Satyam Sharma <satyam@infradead.org>

--===============0585681685==
Content-Type: multipart/signed; boundary="nextPart2219293.37kV9msOPo";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2219293.37kV9msOPo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On venerd=EC 24 agosto 2007, Jeff Dike wrote:
> On Thu, Aug 23, 2007 at 04:54:59PM +0200, Blaisorblade wrote:
> > > actually. Personally I'd prefer:
> > >
> > > 	else
> > > 		type =3D OS_TYPE_DIR;
> >
> > I strongly agree with this style; beyond style itself, one strong reason
> > is that joining statements hinder singlestepping through function code
> > (it's easy to run gdb on UML, and anyway kgdb exists).
>
> How does that help?  gdb should stop as easily on a "else foo;" line as on
> 	else
> 		foo;
> right?
Sorry, a better example is on:

	if (bar)
		foo;
where the test and foo are two distinct parts. One step is "I execute the i=
f",=20
another (possible) step is "I perform foo" - which is not easy to tell if i=
t=20
is not on a different line.
=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--nextPart2219293.37kV9msOPo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGzwL8qH9OHC+5NscRAuywAKCCinDnooJBuqasZi9nMMUUROSgiQCfflJ2
ZVRZ1urkm6xg9zdKkG+ioJ8=
=EDN/
-----END PGP SIGNATURE-----

--nextPart2219293.37kV9msOPo--


--===============0585681685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0585681685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0585681685==--

