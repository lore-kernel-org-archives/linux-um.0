Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1INXEU-0001mr-Bp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Aug 2007 10:09:34 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1INXEQ-0005nu-N5
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Aug 2007 10:09:33 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 21 Aug 2007 19:09:17 +0200
References: <1187561903.4200.138.camel@localhost>
In-Reply-To: <1187561903.4200.138.camel@localhost>
MIME-Version: 1.0
Message-Id: <200708211909.23027.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] =?iso-8859-1?q?=5BPATCH_1/5=5D_um/=2E=2E=2E_convert_?=
	=?iso-8859-1?q?=23include_=22linux/=2E=2E=2E=22_to_=23include_=3Cl?=
	=?iso-8859-1?q?inux/=2E=2E=2E=3E?=
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1949278429=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Miklos Szeredi <mszeredi@suse.cz>, Maxim Krasnyansky <maxk@qualcomm.com>, Jeff Dike <jdike@karaya.com>, kernel-janitors@vger.kernel.org, Jason Lunz <lunz@falooley.org>, Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>, vtun@office.satix.net, Jens Axboe <jens.axboe@oracle.com>, Stephen Hemminger <shemminger@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, Davide Brini <davide.brini@unibo.it>, Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Alexey Dobriyan <adobriyan@gmail.com>, Zachary Amsden <zach@vmware.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jeff Dike <jdike@addtoit.com>, Rusty Russell <rusty@rustcorp.com.au>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, Chris Wright <chrisw@sous-sol.org>, user-mode-linux-user@lists.sourceforge.net, Jeff Dike <jdike@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-kernel@vger.kernel.org

--===============1949278429==
Content-Type: multipart/signed; boundary="nextPart3465391.6hmGNNrzUM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3465391.6hmGNNrzUM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On luned=EC 20 agosto 2007, Joe Perches wrote:
> (untested)
>
> There are several files that
> #include "linux/file" not #include <linux/file>
> #include "asm/file" not #include <asm/file>
>
> Here's a little script that converts them:
>
> egrep -i -r -l --include=3D*.[ch] \
> "^[[:space:]]*\#[[:space:]]*include[[:space:]]*\"(linux|asm)/(.*)\"" * \
>
> | xargs sed -i -e
> | 's/^[[:space:]]*#[[:space:]]*include[[:space:]]*"\(linux\|asm\)\/\(.*\)=
"/
> |#include <\1\/\2>/g'
>
> Signed-off-by: Joe Perches <joe@perches.com>

Wait, this patch may or may not be sane (Jeff will tell more I guess). Sinc=
e=20
we use two different sets of headers (the host ones from userspace and the=
=20
guest ones from Linux), this peculiar style has been used till now to make=
=20
clear the difference (#include <file> is used for host headers) - at least=
=20
that's what I think (I've never asked to Jeff, but I silently deduced this=
=20
and followed this practice).
=2D-=20
"Doh!" (cit.), I've made another another mistake!
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--nextPart3465391.6hmGNNrzUM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGyxxCqH9OHC+5NscRAuz6AKCgps1/TLX24DaQmwmgVPtM2urAhwCffaU0
OughA/pR1xKW0+WDdsnzZu8=
=caGC
-----END PGP SIGNATURE-----

--nextPart3465391.6hmGNNrzUM--


--===============1949278429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1949278429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============1949278429==--

