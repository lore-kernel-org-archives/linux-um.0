Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKB5V-0002oY-N1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Aug 2007 03:54:25 -0700
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IKB5R-0003yU-PQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Aug 2007 03:54:25 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 12 Aug 2007 12:54:05 +0200
References: <20070725143227.GO5115@pintsize>
	<20070725160700.GA7607@c2.user-mode-linux.org>
In-Reply-To: <20070725160700.GA7607@c2.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200708121254.10137.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [RFC PATCH] vde network backend
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1673125434=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

--===============1673125434==
Content-Type: multipart/signed; boundary="nextPart1186930963.zWHiZe1SIv";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1186930963.zWHiZe1SIv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On mercoled=EC 25 luglio 2007, Jeff Dike wrote:
> 	style violations :

> 		if( blah ){ should be if(blah) {
Hmm - I know I'm a bit too late, but that should be "if (blah) {", with a=20
space after if (or after for, or after while (blah) { ).

Bye
=2D-=20
"Doh!" (cit.), I've made another another mistake!
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--nextPart1186930963.zWHiZe1SIv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGvubSqH9OHC+5NscRAodgAJ4nyPbct7uS3RIAhtQBhv9yaxr6yQCdFj7Z
VBvuiyqbpjG8qfkmSt23Cms=
=dMA8
-----END PGP SIGNATURE-----

--nextPart1186930963.zWHiZe1SIv--


--===============1673125434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1673125434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1673125434==--

