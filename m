Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZwSu-0001yV-GV for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:12 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GZwSs-0002FL-UB
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 14:27:12 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Tue, 17 Oct 2006 23:27:05 +0200
Message-Id: <20061017212705.26445.11192.stgit@americanbeauty.home.lan>
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Subject: [uml-devel] [PATCH 01/10] uml: remove some leftover PPC code
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I happened to notice that this code is a leftover and it should be removed -
since there are sporadical efforts to revive the PPC port doing such cleanups
is not useless.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-um/archparam-ppc.h |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/include/asm-um/archparam-ppc.h b/include/asm-um/archparam-ppc.h
index 172cd6f..4269d8a 100644
--- a/include/asm-um/archparam-ppc.h
+++ b/include/asm-um/archparam-ppc.h
@@ -1,15 +1,6 @@
 #ifndef __UM_ARCHPARAM_PPC_H
 #define __UM_ARCHPARAM_PPC_H
 
-/********* Bits for asm-um/hw_irq.h **********/
-
-struct hw_interrupt_type;
-
-/********* Bits for asm-um/hardirq.h **********/
-
-#define irq_enter(cpu, irq) hardirq_enter(cpu)
-#define irq_exit(cpu, irq) hardirq_exit(cpu)
-
 /********* Bits for asm-um/string.h **********/
 
 #define __HAVE_ARCH_STRRCHR
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
