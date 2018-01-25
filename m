Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH] um: fix user mode linux build
Date: Thu, 25 Jan 2018 11:36:31 -0800
Message-Id: <20180125193631.58835-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Not sure when it got broken, but without this patch the command
make ARCH=um defconfig
make ARCH=um

fails due to struct ucontext being undefined.
arch/um/os-Linux/signal.c: In function ‘hard_handler’:
arch/um/os-Linux/signal.c:163:22: error: dereferencing pointer to incomplete type ‘struct ucontext’
  mcontext_t *mc = &uc->uc_mcontext;
<there are two errors like the above>

The fix seems fairly simple, that the code just needs to use
ucontext_t define instead.

I didn't verify that user-mode-linux is working after this change,
just that it builds successfully.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 arch/um/os-Linux/signal.c | 2 +-
 arch/x86/um/stub_segv.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index a86d7cc2c2d8..a5c0c909c48b 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -159,7 +159,7 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 
 static void hard_handler(int sig, siginfo_t *si, void *p)
 {
-	struct ucontext *uc = p;
+	ucontext_t *uc = p;
 	mcontext_t *mc = &uc->uc_mcontext;
 	unsigned long pending = 1UL << sig;
 
diff --git a/arch/x86/um/stub_segv.c b/arch/x86/um/stub_segv.c
index 1518d2805ae8..fd6825537b97 100644
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -10,7 +10,7 @@
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
 {
-	struct ucontext *uc = p;
+	ucontext_t *uc = p;
 
 	GET_FAULTINFO_FROM_MC(*((struct faultinfo *) STUB_DATA),
 			      &uc->uc_mcontext);
-- 
2.14.3


