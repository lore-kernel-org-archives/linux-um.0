Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgtDe-00AgA0-0m
 for linux-um@lists.infradead.org; Wed, 12 May 2021 18:04:27 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 09/23] um: Mark all kernel symbols as local
Date: Wed, 12 May 2021 14:03:53 -0400
Message-Id: <20210512180408.665338-9-sashal@kernel.org>
In-Reply-To: <20210512180408.665338-1-sashal@kernel.org>
References: <20210512180408.665338-1-sashal@kernel.org>
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, Ritesh Raj Sarraf <rrs@debian.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>, Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d5027ca63e0e778b641cf23e3f5c6d6212cf412b ]

Ritesh reported a bug [1] against UML, noting that it crashed on
startup. The backtrace shows the following (heavily redacted):

(gdb) bt
...
 #26 0x0000000060015b5d in sem_init () at ipc/sem.c:268
 #27 0x00007f89906d92f7 in ?? () from /lib/x86_64-linux-gnu/libcom_err.so.2
 #28 0x00007f8990ab8fb2 in call_init (...) at dl-init.c:72
...
 #40 0x00007f89909bf3a6 in nss_load_library (...) at nsswitch.c:359
...
 #44 0x00007f8990895e35 in _nss_compat_getgrnam_r (...) at nss_compat/compat-grp.c:486
 #45 0x00007f8990968b85 in __getgrnam_r [...]
 #46 0x00007f89909d6b77 in grantpt [...]
 #47 0x00007f8990a9394e in __GI_openpty [...]
 #48 0x00000000604a1f65 in openpty_cb (...) at arch/um/os-Linux/sigio.c:407
 #49 0x00000000604a58d0 in start_idle_thread (...) at arch/um/os-Linux/skas/process.c:598
 #50 0x0000000060004a3d in start_uml () at arch/um/kernel/skas/process.c:45
 #51 0x00000000600047b2 in linux_main (...) at arch/um/kernel/um_arch.c:334
 #52 0x000000006000574f in main (...) at arch/um/os-Linux/main.c:144

indicating that the UML function openpty_cb() calls openpty(),
which internally calls __getgrnam_r(), which causes the nsswitch
machinery to get started.

This loads, through lots of indirection that I snipped, the
libcom_err.so.2 library, which (in an unknown function, "??")
calls sem_init().

Now, of course it wants to get libpthread's sem_init(), since
it's linked against libpthread. However, the dynamic linker
looks up that symbol against the binary first, and gets the
kernel's sem_init().

Hajime Tazaki noted that "objcopy -L" can localize a symbol,
so the dynamic linker wouldn't do the lookup this way. I tried,
but for some reason that didn't seem to work.

Doing the same thing in the linker script instead does seem to
work, though I cannot entirely explain - it *also* works if I
just add "VERSION { { global: *; }; }" instead, indicating that
something else is happening that I don't really understand. It
may be that explicitly doing that marks them with some kind of
empty version, and that's different from the default.

Explicitly marking them with a version breaks kallsyms, so that
doesn't seem to be possible.

Marking all the symbols as local seems correct, and does seem
to address the issue, so do that. Also do it for static link,
nsswitch libraries could still be loaded there.

[1] https://bugs.debian.org/983379

Reported-by: Ritesh Raj Sarraf <rrs@debian.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Tested-By: Ritesh Raj Sarraf <rrs@debian.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/dyn.lds.S | 6 ++++++
 arch/um/kernel/uml.lds.S | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index f5001481010c..a82ec0113321 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -6,6 +6,12 @@ OUTPUT_ARCH(ELF_ARCH)
 ENTRY(_start)
 jiffies = jiffies_64;
 
+VERSION {
+  {
+    local: *;
+  };
+}
+
 SECTIONS
 {
   PROVIDE (__executable_start = START);
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 9f21443be2c9..85b404d068f4 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -7,6 +7,12 @@ OUTPUT_ARCH(ELF_ARCH)
 ENTRY(_start)
 jiffies = jiffies_64;
 
+VERSION {
+  {
+    local: *;
+  };
+}
+
 SECTIONS
 {
   /* This must contain the right address - not quite the default ELF one.*/
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

