Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <koct9i@gmail.com>) id 1X4Sku-000263-6q
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jul 2014 10:36:12 +0000
Received: from mail-lb0-f177.google.com ([209.85.217.177])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1X4Skt-000444-BH
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Jul 2014 10:36:12 +0000
Received: by mail-lb0-f177.google.com with SMTP id u10so3711969lbd.8
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Jul 2014 03:36:04 -0700 (PDT)
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Tue, 08 Jul 2014 14:35:57 +0400
Message-ID: <20140708103557.4408.87822.stgit@zurg>
In-Reply-To: <CALYGNiOkiBWfT1+SeAkx1qEZKFm2y9G1gXhVEyNC0OrewB2ktA@mail.gmail.com>
References: <CALYGNiOkiBWfT1+SeAkx1qEZKFm2y9G1gXhVEyNC0OrewB2ktA@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] scripts/checkstack.pl: automatically handle
 32-bit and 64-bit mode for ARCH=x86
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org

This patch adds support for ARCH=x86 into checkstack.

commit ffee0de ("x86: Default to ARCH=x86 to avoid overriding CONFIG_64BIT")
had merged ARCH=i386 and ARCH=x86_64 into one ARCH=x86. checkstack.pl searches
patterns of machine instructions which are usually used for allocating stack
frames. checkstalk.pl needs either i386 or x86_64, x86 isn't enough:

$ make checkstack
objdump -d vmlinux $(find . -name '*.ko') | \
perl linux/scripts/checkstack.pl x86
wrong or unknown architecture "x86"

Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
---
 scripts/checkstack.pl |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index c05d586..899b423 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -52,14 +52,12 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
 		#8000008a:       20 1d           sub sp,4
 		#80000ca8:       fa cd 05 b0     sub sp,sp,1456
 		$re = qr/^.*sub.*sp.*,([0-9]{1,8})/o;
-	} elsif ($arch =~ /^i[3456]86$/) {
+	} elsif ($arch =~ /^x86(_64)?$/ || $arch =~ /^i[3456]86$/) {
 		#c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
-		$re = qr/^.*[as][du][db]    \$(0x$x{1,8}),\%esp$/o;
-		$dre = qr/^.*[as][du][db]    (%.*),\%esp$/o;
-	} elsif ($arch eq 'x86_64') {
-		#    2f60:	48 81 ec e8 05 00 00 	sub    $0x5e8,%rsp
-		$re = qr/^.*[as][du][db]    \$(0x$x{1,8}),\%rsp$/o;
-		$dre = qr/^.*[as][du][db]    (\%.*),\%rsp$/o;
+		# or
+		#    2f60:    48 81 ec e8 05 00 00       sub    $0x5e8,%rsp
+		$re = qr/^.*[as][du][db]    \$(0x$x{1,8}),\%(e|r)sp$/o;
+		$dre = qr/^.*[as][du][db]    (%.*),\%(e|r)sp$/o;
 	} elsif ($arch eq 'ia64') {
 		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
 		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

