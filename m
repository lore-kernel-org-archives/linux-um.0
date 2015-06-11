Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z2yoK-0007kM-Mt
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 09:30:08 +0000
Received: from mail-wi0-f172.google.com ([209.85.212.172])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z2yoI-0003B1-Rz
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 09:30:08 +0000
Received: by wiga1 with SMTP id a1so70212912wig.0
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Jun 2015 02:30:00 -0700 (PDT)
From: Hans-Werner Hilse <hwhilse@gmail.com>
Date: Thu, 11 Jun 2015 11:29:18 +0200
Message-Id: <1434014960-14774-2-git-send-email-hwhilse@gmail.com>
In-Reply-To: <1434014960-14774-1-git-send-email-hwhilse@gmail.com>
References: <1434014960-14774-1-git-send-email-hwhilse@gmail.com>
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
Subject: [uml-devel] [PATCH v2 1/3] um: Do not use __ptr_t type for
	stack_t's .ss pointer
To: User-mode-linux-devel@lists.sourceforge.net

__ptr_t type is a glibc-specific type, while the generally
documented type is a void*. That's what other C libraries use,
too.

Signed-off-by: Hans-Werner Hilse <hwhilse@gmail.com>
---
 arch/um/os-Linux/signal.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 7b605e4..036d0db 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -112,9 +112,11 @@ void timer_init(void)
 
 void set_sigstack(void *sig_stack, int size)
 {
-	stack_t stack = ((stack_t) { .ss_flags	= 0,
-				     .ss_sp	= (__ptr_t) sig_stack,
-				     .ss_size 	= size - sizeof(void *) });
+	stack_t stack = {
+		.ss_flags = 0,
+		.ss_sp = sig_stack,
+		.ss_size = size - sizeof(void *)
+	};
 
 	if (sigaltstack(&stack, NULL) != 0)
 		panic("enabling signal stack failed, errno = %d\n", errno);
-- 
2.4.2


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

