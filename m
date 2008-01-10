Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCruA-0000dN-Vh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 23:32:47 -0800
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCruA-0002AK-8X
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 23:32:46 -0800
Date: Thu, 10 Jan 2008 08:32:16 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20080110073215.GA11506@elte.hu>
References: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu>
Subject: Re: [uml-devel] uml and -regparm=3
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jdike@addtoit.com, akpm@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> FASTCALL is defined empty in -mm, but UML is not compiled with =

> -mregparm=3D3 and so this breaks things (I noticed problems with =

> rwsem_down_write_failed).
> =

> Tried recompiling UML with -mregparm=3D3, but that resulted in a strange =

> failure immediately after startup:
> =

> |=1B%G=EF=BF=BD=1B%@: Invalid argument
> =

> What's up?

Miklos, could you try the fix below?

In general most FASTCALL/fastcall uses are bogus, except for code where =

a function that takes parameters is implemented in assembly with a =

regparm calling convention. The fix is to introduce the "asmregparm" =

attribute to mark such function prototypes with regparm(3). This is the =

opposite of asmlinkage. [asmlinkage forced regparm(0)]

	Ingo

------------>
Subject: x86: fix UML calling convention
From: Ingo Molnar <mingo@elte.hu>

introduce the "asmregparm" calling convention: for functions
implemented in assembly with a fixed regparm input parameters
calling convention.

mark the semaphore and rwsem slowpath functions with that.

Reported-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/asm-x86/linkage.h      |    5 +++++
 include/asm-x86/rwsem.h        |   12 ++++++++----
 include/asm-x86/semaphore_32.h |    8 ++++----
 3 files changed, 17 insertions(+), 8 deletions(-)

Index: linux-x86.q/include/asm-x86/linkage.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-x86.q.orig/include/asm-x86/linkage.h
+++ linux-x86.q/include/asm-x86/linkage.h
@@ -9,6 +9,11 @@
 #ifdef CONFIG_X86_32
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #define prevent_tail_call(ret) __asm__ ("" : "=3Dr" (ret) : "0" (ret))
+/*
+ * For 32-bit UML - mark functions implemented in assembly that use
+ * regparm input parameters:
+ */
+#define asmregparm __attribute__((regparm(3)))
 #endif
 =

 #ifdef CONFIG_X86_ALIGNMENT_16
Index: linux-x86.q/include/asm-x86/rwsem.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-x86.q.orig/include/asm-x86/rwsem.h
+++ linux-x86.q/include/asm-x86/rwsem.h
@@ -44,10 +44,14 @@
 =

 struct rwsem_waiter;
 =

-extern struct rw_semaphore *FASTCALL(rwsem_down_read_failed(struct rw_sema=
phore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_down_write_failed(struct rw_sem=
aphore *sem));
-extern struct rw_semaphore *FASTCALL(rwsem_wake(struct rw_semaphore *));
-extern struct rw_semaphore *FASTCALL(rwsem_downgrade_wake(struct rw_semaph=
ore *sem));
+extern asmregparm struct rw_semaphore *
+ rwsem_down_read_failed(struct rw_semaphore *sem);
+extern asmregparm struct rw_semaphore *
+ rwsem_down_write_failed(struct rw_semaphore *sem);
+extern asmregparm struct rw_semaphore *
+ rwsem_wake(struct rw_semaphore *);
+extern asmregparm struct rw_semaphore *
+ rwsem_downgrade_wake(struct rw_semaphore *sem);
 =

 /*
  * the semaphore definition
Index: linux-x86.q/include/asm-x86/semaphore_32.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-x86.q.orig/include/asm-x86/semaphore_32.h
+++ linux-x86.q/include/asm-x86/semaphore_32.h
@@ -83,10 +83,10 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 =

-void __down_failed(void /* special register calling convention */);
-int  __down_failed_interruptible(void  /* params in registers */);
-int  __down_failed_trylock(void  /* params in registers */);
-void __up_wakeup(void /* special register calling convention */);
+extern asmregparm void __down_failed(atomic_t *count_ptr);
+extern asmregparm int  __down_failed_interruptible(atomic_t *count_ptr);
+extern asmregparm int  __down_failed_trylock(atomic_t *count_ptr);
+extern asmregparm void __up_wakeup(atomic_t *count_ptr);
 =

 /*
  * This is ugly, but we want the default case to fall through.


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
