Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7vx-000337-BL
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:07:17 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7vw-0000E8-Lj
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:07:17 +0000
Date: Thu, 18 Aug 2011 20:07:09 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7vp-0007nu-Mj@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 49/91] um: trim kern.h
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


most of the functions in there are not used in anything that ends up
including that header...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/kern.h |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/arch/um/include/shared/kern.h b/arch/um/include/shared/kern.h
index 4ce3fc6..6cd0124 100644
--- a/arch/um/include/shared/kern.h
+++ b/arch/um/include/shared/kern.h
@@ -13,28 +13,10 @@
  * includes.
  */
 
-extern int errno;
-
-extern int clone(int (*proc)(void *), void *sp, int flags, void *data);
-extern int sleep(int);
 extern int printf(const char *fmt, ...);
-extern char *strerror(int errnum);
-extern char *ptsname(int __fd);
-extern int munmap(void *, int);
 extern void *sbrk(int increment);
-extern void *malloc(int size);
-extern void perror(char *err);
-extern int kill(int pid, int sig);
-extern int getuid(void);
-extern int getgid(void);
 extern int pause(void);
-extern int write(int, const void *, int);
 extern void exit(int);
-extern int close(int);
-extern int read(unsigned int, char *, int);
-extern int pipe(int *);
-extern int sched_yield(void);
-extern int ptrace(int op, int pid, long addr, long data);
 
 #endif
 
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

