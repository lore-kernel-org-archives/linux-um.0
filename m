Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXnzy-00A6rU-U7
 for linux-um@lists.infradead.org; Sat, 17 Apr 2021 16:40:49 +0000
Received: by mail-io1-xd36.google.com with SMTP id b10so30711727iot.4
 for <linux-um@lists.infradead.org>; Sat, 17 Apr 2021 09:40:46 -0700 (PDT)
From: YiFei Zhu <zhuyifei1999@gmail.com>
Subject: [PATCH] uml/helper: Fix stack alignment
Date: Sat, 17 Apr 2021 11:39:49 -0500
Message-Id: <20210417163949.530921-1-zhuyifei1999@gmail.com>
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
To: linux-um@lists.infradead.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes.berg@intel.com>, YiFei Zhu <zhuyifei1999@gmail.com>

GCC assumes that stack is aligned to 16-byte on function entry [1].
Since GCC 8, GCC began using 16-byte aligned SSE instructions to
implement assignments to structs on stack. This affects
os-Linux/sigio.c, write_sigio_thread:

  struct pollfds *fds, tmp;
  tmp = current_poll;

Note that struct pollfds is exactly 16 bytes in size.
GCC 8+ generates assembly similar to:

  movdqa (%rdi),%xmm0
  movaps %xmm0,-0x50(%rbp)

This is an issue, because movaps will #GP if -0x50(%rbp) is not
aligned to 16 bytes [2], and how rbp gets assigned to is via glibc
clone thread_start, then function prologue, going though execution
trace similar to (showing only relevant instructions):

  sub    $0x10,%rsi
  mov    %rcx,0x8(%rsi)
  mov    %rdi,(%rsi)
  syscall
  pop    %rax
  pop    %rdi
  callq  *%rax
  push   %rbp
  mov    %rsp,%rbp

The stack pointer always points to the topmost element on stack,
rather then the space right above the topmost. On push, the
pointer decrements first before writing to the memory pointed to
by it. Therefore, there is no need to have the stack pointer
pointer always point to valid memory unless the stack is poped;
so the `- sizeof(void *)` in the code is unnecessary.

On the other hand, glibc reserves the 16 bytes it needs on stack
and pops itself, so by the call instruction the stack pointer
is exactly the caller-supplied sp. It then push the 16 bytes of
the return address and the saved stack pointer, so the base
pointer will be 16-byte aligned if and only if the caller
supplied sp is 16-byte aligned. Therefore, the caller must supply
a 16-byte aligned pointer, which `stack + UM_KERN_PAGE_SIZE`
already satisfies.

On a side note, musl is unaffected by this issue because it forces
16 byte alignment via `and $-16,%rsi` in its clone wrapper.
Similarly, glibc i386 is also uneffected because it has
`andl $0xfffffff0, %ecx`.

To reproduce this bug, enable CONFIG_UML_RTC. uml_rtc will call
add_sigio_fd which will then cause write_sigio_thread to go
into segfault loop.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=40838
[2] https://c9x.me/x86/html/file_module_x86_id_180.html

Signed-off-by: YiFei Zhu <zhuyifei1999@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 arch/um/os-Linux/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/helper.c b/arch/um/os-Linux/helper.c
index 9fa6e4187d4f..32e88baf18dd 100644
--- a/arch/um/os-Linux/helper.c
+++ b/arch/um/os-Linux/helper.c
@@ -64,7 +64,7 @@ int run_helper(void (*pre_exec)(void *), void *pre_data, char **argv)
 		goto out_close;
 	}
 
-	sp = stack + UM_KERN_PAGE_SIZE - sizeof(void *);
+	sp = stack + UM_KERN_PAGE_SIZE;
 	data.pre_exec = pre_exec;
 	data.pre_data = pre_data;
 	data.argv = argv;
@@ -120,7 +120,7 @@ int run_helper_thread(int (*proc)(void *), void *arg, unsigned int flags,
 	if (stack == 0)
 		return -ENOMEM;
 
-	sp = stack + UM_KERN_PAGE_SIZE - sizeof(void *);
+	sp = stack + UM_KERN_PAGE_SIZE;
 	pid = clone(proc, (void *) sp, flags, arg);
 	if (pid < 0) {
 		err = -errno;
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

