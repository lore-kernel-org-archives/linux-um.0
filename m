Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EjzVu-0005ud-1k for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Dec 2005 05:39:18 -0800
Received: from courier.cs.helsinki.fi ([128.214.9.1] helo=mail.cs.helsinki.fi)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EjzVt-0002X0-Br
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Dec 2005 05:39:18 -0800
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: Re: [uml-devel] [PATCH] um: fix compile error for tt
In-Reply-To: <200512071038.04958.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.58.0512071538230.22525@sbz-30.cs.Helsinki.FI>
References: <1133900650.3279.9.camel@localhost>
	<200512071038.04958.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 7 Dec 2005 15:39:02 +0200 (EET)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, linux-kernel@vger.kernel.org, jdike@karaya.com

Hi,

On Wed, 7 Dec 2005, Blaisorblade wrote:
> Ok, fine, just a note - the header inclusion should be added to 
> 
> arch/um/include/um_uaccess.h
> 
> where it is effectively used (the offending macros, using FIXADDR_USER_*, are 
> __access_ok_vsyscall.
> 
> For the rest it's ok.

Here's an updated patch.

[PATCH] um: fix compile error for tt

Without the included patch, I get the following compile error for um:

arch/um/kernel/tt/uaccess.c: In function `copy_from_user_tt':
arch/um/kernel/tt/uaccess.c:11: error: `FIXADDR_USER_START' undeclared (first use in this function)
arch/um/kernel/tt/uaccess.c:11: error: (Each undeclared identifier is reported only once
arch/um/kernel/tt/uaccess.c:11: error: for each function it appears in.)

I get the compile error when I disable CONFIG_MODE_SKAS.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 include/um_uaccess.h               |    2 ++
 kernel/skas/include/uaccess-skas.h |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: 2.6/arch/um/include/um_uaccess.h
===================================================================
--- 2.6.orig/arch/um/include/um_uaccess.h
+++ 2.6/arch/um/include/um_uaccess.h
@@ -17,6 +17,8 @@
 #include "uaccess-skas.h"
 #endif
 
+#include "asm/fixmap.h"
+
 #define __under_task_size(addr, size) \
 	(((unsigned long) (addr) < TASK_SIZE) && \
          (((unsigned long) (addr) + (size)) < TASK_SIZE))
Index: 2.6/arch/um/kernel/skas/include/uaccess-skas.h
===================================================================
--- 2.6.orig/arch/um/kernel/skas/include/uaccess-skas.h
+++ 2.6/arch/um/kernel/skas/include/uaccess-skas.h
@@ -7,7 +7,6 @@
 #define __SKAS_UACCESS_H
 
 #include "asm/errno.h"
-#include "asm/fixmap.h"
 
 /* No SKAS-specific checking. */
 #define access_ok_skas(type, addr, size) 0


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
