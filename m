Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iTBX1-0000nT-Df
 for linux-um@lists.infradead.org; Fri, 08 Nov 2019 21:11:01 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/23] y2038: vdso: change time_t to __kernel_old_time_t
Date: Fri,  8 Nov 2019 22:07:25 +0100
Message-Id: <20191108210824.1534248-5-arnd@arndb.de>
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: y2038@lists.linaro.org, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>

Only x86 uses the 'time' syscall in vdso, so change that to
__kernel_old_time_t as a preparation for removing 'time_t' and
'__kernel_time_t' later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/entry/vdso/vclock_gettime.c  | 6 +++---
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 arch/x86/um/vdso/um_vdso.c            | 4 ++--
 lib/vdso/gettimeofday.c               | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index d9ff616bb0f6..7d70935b6758 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -15,7 +15,7 @@
 #include "../../../../lib/vdso/gettimeofday.c"
 
 extern int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
-extern time_t __vdso_time(time_t *t);
+extern __kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
 
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
@@ -25,12 +25,12 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
 
-time_t __vdso_time(time_t *t)
+__kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 {
 	return __cvdso_time(t);
 }
 
-time_t time(time_t *t)	__attribute__((weak, alias("__vdso_time")));
+__kernel_old_time_t time(__kernel_old_time_t *t)	__attribute__((weak, alias("__vdso_time")));
 
 
 #if defined(CONFIG_X86_64) && !defined(BUILD_VDSO32_64)
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 76e62bcb8d87..bba5bfdb2a56 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -194,7 +194,7 @@ bool emulate_vsyscall(unsigned long error_code,
 		break;
 
 	case 1:
-		if (!write_ok_or_segv(regs->di, sizeof(time_t))) {
+		if (!write_ok_or_segv(regs->di, sizeof(__kernel_old_time_t))) {
 			ret = -EFAULT;
 			goto check_fault;
 		}
diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index 371724cf70da..2112b8d14668 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -37,7 +37,7 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
 
-time_t __vdso_time(time_t *t)
+__kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 {
 	long secs;
 
@@ -47,7 +47,7 @@ time_t __vdso_time(time_t *t)
 
 	return secs;
 }
-time_t time(time_t *t) __attribute__((weak, alias("__vdso_time")));
+__kernel_old_time_t time(__kernel_old_time_t *t) __attribute__((weak, alias("__vdso_time")));
 
 long
 __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 45f57fd2db64..9ecfd3b547ba 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -164,10 +164,10 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 }
 
 #ifdef VDSO_HAS_TIME
-static __maybe_unused time_t __cvdso_time(time_t *time)
+static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
-	time_t t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+	__kernel_old_time_t t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
 
 	if (time)
 		*time = t;
-- 
2.20.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

