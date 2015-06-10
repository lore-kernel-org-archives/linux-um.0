Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Message-ID: <5578aa4d.4230460a.1098.ffffe35eSMTPIN_ADDED_BROKEN@mx.google.com>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z2nQg-0008Ik-Uu
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:20:58 +0000
Received: from hilses.de ([213.133.103.163])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2nQf-0006tx-M1
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 21:20:58 +0000
Received: from [10.0.0.1] (helo=localhost) by hilses.de with esmtpa (Exim 4.85)
	(envelope-from <hwhilse@gmail.com>) id 1Z2nQH-0006Nq-Dz
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 10 Jun 2015 23:20:33 +0200
MIME-Version: 1.0
Date: Wed, 10 Jun 2015 23:20:33 +0200
From: Hans-Werner Hilse <hwhilse@gmail.com>
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
Subject: [uml-devel] =?utf-8?q?=5BPATCH_1/3=5D_um=3A_Fallback_when_C_libra?=
 =?utf-8?q?ry_does_not_provide_=5F=5Fptr=5Ft?=
To: User-mode-linux-devel@lists.sourceforge.net

Glibc provides __ptr_t for the pointer in the stack_t struct,
but other C libraries - namely musl - do not necessarily do so.
In that case, fall back to a void* pointer.

Signed-off-by: Hans-Werner Hilse <hwhilse@gmail.com>
---
  arch/um/os-Linux/signal.c | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 7b605e4..82d95d9 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -15,6 +15,11 @@
  #include <sysdep/mcontext.h>
  #include "internal.h"

+/* some C libraries do not provide a special pointer typedef */
+#ifndef __ptr_t
+# define __ptr_t void *
+#endif
+
  void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
  	[SIGTRAP]	= relay_signal,
  	[SIGFPE]	= relay_signal,
-- 
2.4.2



------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

