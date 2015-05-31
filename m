Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YzAwK-0008Vx-GU
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:38:40 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YzAwJ-0006Ra-Oi for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:38:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 31 May 2015 23:38:23 +0200
Message-Id: <1433108305-9255-3-git-send-email-richard@nod.at>
In-Reply-To: <1433108305-9255-1-git-send-email-richard@nod.at>
References: <1433108305-9255-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 3/5] um: Remove copy&paste code from init.h
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net

As we got rid of the __KERNEL__ abuse, we can directly
include linux/compiler.h now.
This also allows gcc 5 to build UML.

Reported-by: Hans-Werner Hilse <hwhilse@gmail.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/shared/init.h | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
index 031ad1d..233e259 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -40,28 +40,8 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-#ifdef __UM_HOST__
-#ifndef __section
-# define __section(S) __attribute__ ((__section__(#S)))
-#endif
-
-#if __GNUC__ == 3
-
-#if __GNUC_MINOR__ >= 3
-# define __used			__attribute__((__used__))
-#else
-# define __used			__attribute__((__unused__))
-#endif
-
-#else
-#if __GNUC__ == 4
-# define __used			__attribute__((__used__))
-#endif
-#endif
-
-#else
 #include <linux/compiler.h>
-#endif
+
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
 #define __init		__section(.init.text)
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

