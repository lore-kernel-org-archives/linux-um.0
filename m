Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Vn5vT-0006Pg-S3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Dec 2013 12:15:03 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vn5vR-0003sf-Qa
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Dec 2013 12:15:03 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 01 Dec 2013 13:14:32 +0100
Message-ID: <3994463.tIZbdZ5tnp@sandpuppy>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5802462151344245798=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [GIT PULL] UML fixes for 3.13-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


--===============5802462151344245798==
Content-Type: multipart/signed; boundary="nextPart6199045.vrAS1g4IA8";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart6199045.vrAS1g4IA8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Linus,

The following changes since commit af91706d5ddecb4a9858cca9e90d463037cfd498:

  ima: store address of template_fmt_copy in a pointer before calling strsep 
(2013-11-30 13:09:53 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus

for you to fetch changes up to fff6540cbcb56a6ae92d4fd4b0864c8d13a8f932:

  um: Build always with -mcmodel=large on 64bit (2013-12-01 13:06:51 +0100)

----------------------------------------------------------------
Fixes two regressions which got introduced while the merge window.

----------------------------------------------------------------
Richard Weinberger (2):
      um: Rename print_stack_trace to do_stack_trace
      um: Build always with -mcmodel=large on 64bit

 arch/um/Makefile       | 9 ++++-----
 arch/um/kernel/sysrq.c | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

--nextPart6199045.vrAS1g4IA8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAABAgAGBQJSmygxAAoJEPmeIjfg4UaaS04P/1gkKzTSlLGbV/Yhr4bdGCj1
2mm+18x3U2VYITk6+hYwqVKtBSD4t734SK3vM6lDkeoHrXExp1IMBvoYl1rRHxYX
Fyaog1z9ssK2uIA1Xt4GhEZRGOxGk8Smedj/YSfToTo9WwthUfsVW1wwmOAtFSn6
M/jecyTJclPid6Nsb53OQP9o1H5+1hx8nfqOme0PscOcgEFqqph64HzhWXnUsoor
NfYMTl0sNOXQypCNpRivcLHdb+oekIzTKBCNO4l94F6Sa9n5wa71YEIJGVgtQF3M
Al/+O2W0bF1G+nHlXD4qR3JAGPWuocfWiCql6yqTvJJQKyjhrOhMBQ0fWdI6zVXq
NXVRHEH5sOfTg16XSxwuMAhqVQ+BBpN2B1jtDsE4bnRBODqm5pXHJ55/BmJ0hY30
IzfhaV27WDbA9LhOtmgxmYJTgQx0fhDbV6xNtD2T807P4sG9sstCzJCQ2ek23W9V
f6AvflfsfVbPr5BJfWTaSYQvjnufYFrgbLevWP6bYGoP4/TzbPvapl3w6BGrVObh
fLhbPSnxtwKFV8IZNNSerFqui9/51XBD0dNGf7hL1WZu5rBVJ43exvn1DnB7BQPE
p4WjJzuRLl9sn1y5HIA0S4v8K++Jab6GqG2D0F/LJCJVNue7kcFWgB0v8QE2X8lw
d3VuromAsTTtPdS+57bj
=rk8T
-----END PGP SIGNATURE-----

--nextPart6199045.vrAS1g4IA8--



--===============5802462151344245798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
--===============5802462151344245798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============5802462151344245798==--



