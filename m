Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Fri, 23 Aug 2013 13:37:49 +0200
Message-Id: <1377257869-23373-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: prctl: Do not include linux/ptrace.h
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, david.oberhollenzer@tele2.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On recent toolchains we hit:
In file included from arch/x86/um/os-Linux/prctl.c:7:0:
/usr/include/linux/ptrace.h:58:8: error: redefinition of =E2=80=98struc=
t
ptrace_peeksiginfo_args=E2=80=99 struct ptrace_peeksiginfo_args {
        ^
In file included from arch/x86/um/os-Linux/prctl.c:6:0:
/usr/include/sys/ptrace.h:191:8: note: originally defined here
 struct ptrace_peeksiginfo_args
        ^
make[2]: *** [arch/x86/um/os-Linux/prctl.o] Error 1
make[1]: *** [arch/x86/um/os-Linux] Error 2
make: *** [arch/x86/um] Error 2

The solution is not to include linux/ptrace.h and obtain
the arch specific ptrace command from asm/ptrace.h.

Reported-by: David Oberhollenzer <david.oberhollenzer@tele2.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/os-Linux/prctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/os-Linux/prctl.c b/arch/x86/um/os-Linux/prctl.=
c
index 9d34edd..96eb2bd 100644
--- a/arch/x86/um/os-Linux/prctl.c
+++ b/arch/x86/um/os-Linux/prctl.c
@@ -4,7 +4,7 @@
  */
=20
 #include <sys/ptrace.h>
-#include <linux/ptrace.h>
+#include <asm/ptrace.h>
=20
 int os_arch_prctl(int pid, int code, unsigned long *addr)
 {
--=20
1.8.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

