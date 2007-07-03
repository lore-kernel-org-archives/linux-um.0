Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5kJC-000435-8u for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:28:58 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1I5kJ8-0006ok-Cw
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jul 2007 08:28:54 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 3 Jul 2007 17:28:30 +0200
References: <20070614202655.GA9647@c2.user-mode-linux.org>
	<20070627233701.8e53f3cb.akpm@linux-foundation.org>
In-Reply-To: <20070627233701.8e53f3cb.akpm@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <200707031728.36472.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 4/5] UML - Simplify helper stack handling
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0984312972=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

--===============0984312972==
Content-Type: multipart/signed; boundary="nextPart1472843.a5S91qz8GL";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1472843.a5S91qz8GL
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On gioved=EC 28 giugno 2007, Andrew Morton wrote:
> So I'm running the generic version of this on i386 with 8k stacks (below),
> with a quick LTP run.
>
> Holy cow, either we use a _lot_ of stack or these numbers are off:
>
> vmm:/home/akpm> dmesg -s 1000000|grep 'bytes left'
> khelper used greatest stack depth: 7176 bytes left
> khelper used greatest stack depth: 7064 bytes left
> khelper used greatest stack depth: 6840 bytes left
> khelper used greatest stack depth: 6812 bytes left
> hostname used greatest stack depth: 6636 bytes left
> uname used greatest stack depth: 6592 bytes left
> uname used greatest stack depth: 6284 bytes left
> hotplug used greatest stack depth: 5568 bytes left
> rpc.nfsd used greatest stack depth: 5136 bytes left
> chown02 used greatest stack depth: 4956 bytes left
> fchown01 used greatest stack depth: 4892 bytes left

> That's the sum of process stack and interrupt stack, but I doubt if this
> little box is using much interrupt stack space.
>
> No wonder people are still getting stack overflows with 4k stacks...

=46irst, those numbers pretend to be _unused_ stack space.

Well, UML tends to use more stack space than the rest of kernel. Apart it h=
as=20
a bit more layering (even if less than in the past), we must use libc's=20
function too, and they're not written to be executed on an 8k stack.

We've reimplemented libc's printf() in terms of kernel sprintf() because it=
=20
used 32K of stack.
=2D-=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--nextPart1472843.a5S91qz8GL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGimskqH9OHC+5NscRAoa3AJ0aoVZAsSCUack5plKhHUgAuIP1cgCfVkUo
AYs4QvjRsHgXU75C5JT9SDI=
=YpvS
-----END PGP SIGNATURE-----

--nextPart1472843.a5S91qz8GL--


--===============0984312972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0984312972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0984312972==--

