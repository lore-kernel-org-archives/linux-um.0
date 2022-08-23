Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQIPg-00H21l-3n
	for linux-um@lists.infradead.org; Tue, 23 Aug 2022 01:09:05 +0000
Received: by mail-pj1-x104a.google.com with SMTP id l3-20020a17090aec0300b001fb0bedf2faso2307592pjy.8
        for <linux-um@lists.infradead.org>; Mon, 22 Aug 2022 18:09:00 -0700 (PDT)
Date: Tue, 23 Aug 2022 09:08:30 +0800
Message-Id: <20220823010830.2675419-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH] arch: um: Mark the stack non-executable to fix a binutils warning
From: David Gow <davidgow@google.com>
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
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Nick Desaulniers <ndesaulniers@google.com>
Cc: David Gow <davidgow@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com, x86@kernel.org

Since binutils 2.39, ld will print a warning if any stack section is
executable, which is the default for stack sections on files without a
.note.GNU-stack section.

This was fixed for x86 in commit ffcf9c5700e4 ("x86: link vdso and boot with -z noexecstack --no-warn-rwx-segments"),
but remained broken for UML, resulting in several warnings:

/usr/bin/ld: warning: arch/x86/um/vdso/vdso.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms1.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
/usr/bin/ld: warning: .tmp_vmlinux.kallsyms2.o: missing .note.GNU-stack section implies executable stack
/usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
/usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions

Link both the VDSO and vmlinux with -z noexecstack, fixing the warnings
about .note.GNU-stack sections. In addition, pass --no-warn-rwx-segments
to dodge the remaining warnings about LOAD segments with RWX permissions
in the kallsyms objects. (Note that this flag is apparently not
available on lld, so hide it behind a test for BFD, which is what the
x86 patch does.)

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffcf9c5700e49c0aee42dcba9a12ba21338e8136
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ba951afb99912da01a6e8434126b8fac7aa75107
Signed-off-by: David Gow <davidgow@google.com>
---
 arch/um/Makefile          | 9 ++++++++-
 arch/x86/um/vdso/Makefile | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index f2fe63bfd819..75d5c704b3a8 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -132,10 +132,17 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
 # The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
+# Avoid binutils 2.39+ warnings by marking the stack non-executable and
+# ignorning warnings for the kallsyms sections.
+LINK_RWXSECTION = -Wl,-z,noexecstack
+ifeq ($(CONFIG_LD_IS_BFD),y)
+LINK_RWXSECTION += -Wl,--no-warn-rwx-segments
+endif
+
 LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS),-Wl,$(opt))
 
 # Used by link-vmlinux.sh which has special support for um link
-export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
+export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LINK_RWXSECTION) $(LD_FLAGS_CMDLINE)
 
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 8c0396fd0e6f..6fbe97c52c99 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -65,7 +65,7 @@ quiet_cmd_vdso = VDSO    $@
 		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
-VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv
+VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack
 GCOV_PROFILE := n
 
 #
-- 
2.37.1.595.g718a3a8f04-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

