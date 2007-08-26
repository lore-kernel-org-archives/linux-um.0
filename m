Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPLux-0001yX-Tm for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 10:28:55 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IPLut-00043m-UH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 10:28:55 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 26 Aug 2007 19:28:28 +0200
References: <20070817194341.GA8754@c2.user-mode-linux.org>
In-Reply-To: <20070817194341.GA8754@c2.user-mode-linux.org>
MIME-Version: 1.0
Message-Id: <200708261928.33082.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 3/6] UML - Userspace files should call libc
	directly
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0788544651=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

--===============0788544651==
Content-Type: multipart/signed; boundary="nextPart1308845.BBC9Uh8dEh";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1308845.BBC9Uh8dEh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On venerd=EC 17 agosto 2007, Jeff Dike wrote:
> A number of files that were changed in the recent removal of tt mode
> are userspace files which call the os_* wrappers instead of calling
> libc directly.  A few other files were affected by this, through

> os_print_error has no remaining callers, so it is deleted.

Actually, os_print_error() (or some other interface to perror()) should be=
=20
reintroduced and used more for error messages (and also strsignal() should=
=20
be, for "Kernel mode signal N"). Problem debugging is hard, but there is no=
=20
reason make it harder (or rather, not to simplify it for users).

Btw, the inlined abs() call is not very nice; on the other hand, it's a sim=
ple=20
solution to make it robust, and we do not to be extra-optimal on these debu=
g=20
code paths.

Bye
=2D-=20
"Doh!" (cit.), I've made another mistake!
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--nextPart1308845.BBC9Uh8dEh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG0bhBqH9OHC+5NscRApv2AJ977THK+aBgVvnWB0zcitovTju7jgCglalY
3u+udiiweE+VZlpqtOYoOz4=
=9Msy
-----END PGP SIGNATURE-----

--nextPart1308845.BBC9Uh8dEh--


--===============0788544651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0788544651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0788544651==--

