Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jrduP-000573-O9
 for linux-um@lists.infradead.org; Sat, 04 Jul 2020 08:52:30 +0000
Received: by mail-wm1-x342.google.com with SMTP id o2so36373860wmh.2
 for <linux-um@lists.infradead.org>; Sat, 04 Jul 2020 01:52:27 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH v2 0/3] um: allow static linking for non-glibc libc
 implementations
Date: Sat,  4 Jul 2020 09:52:10 +0100
Message-Id: <20200704085213.444645-1-ignat@cloudflare.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, brendanhiggins@google.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com, Ignat Korchagin <ignat@cloudflare.com>

This is a continuation of [1]. Since I was able to produce a working UML binary
with UML_NET_VECTOR linked with musl with the changes included in the patches
here. I was compiling on Arch Linux, so hopefully all the latest versions of
the compiler, libraries and binutils.

I also tested allyesconfig with both musl and glibc. The compilation succeeds
with both, however both binaries (glibc one being dynamically linked) segfault
on start. This is probably of some incompatible config option/module being
included and not related to musl/glibc.

[1]: https://patchwork.ozlabs.org/project/linux-um/patch/20200624212319.403689-1-ignat@cloudflare.com/

Ignat Korchagin (3):
  um/kconfig: introduce CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
  um: some fixes to build UML with musl
  um: allow static linking for non-glibc implementations

 arch/um/Kconfig               |  2 +-
 arch/um/drivers/Kconfig       |  3 ---
 arch/um/drivers/daemon_user.c |  1 +
 arch/um/drivers/pcap_user.c   | 12 ++++++------
 arch/um/drivers/slip_user.c   |  2 +-
 arch/um/drivers/vector_user.c |  4 +---
 arch/um/os-Linux/util.c       |  2 +-
 arch/x86/um/user-offsets.c    |  2 +-
 init/Kconfig                  |  6 ++++++
 scripts/cc-can-link.sh        |  5 +++--
 10 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

