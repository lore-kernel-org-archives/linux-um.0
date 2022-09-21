Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ob2iK-00C0OM-BN
	for linux-um@lists.infradead.org; Wed, 21 Sep 2022 16:36:46 +0000
Date: Wed, 21 Sep 2022 18:36:36 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1498364411.248529.1663778196892.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fixes for 6.0-rc7
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
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

Linus,

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/for-linus-6.0-rc7

for you to fetch changes up to bd71558d585ac61cfd799db7f25e78dca404dd7a:

  arch: um: Mark the stack non-executable to fix a binutils warning (2022-09-21 09:11:42 +0200)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Various fixes for build warnings
- Fix default kernel command line

----------------------------------------------------------------
Christian Lamparter (1):
      um: fix default console kernel parameter

David Gow (1):
      arch: um: Mark the stack non-executable to fix a binutils warning

Lukas Straub (2):
      um: Cleanup syscall_handler_t cast in syscalls_32.h
      um: Cleanup compiler warning in arch/x86/um/tls_32.c

Vincent Whitchurch (1):
      um: Prevent KASAN splats in dump_stack()

 arch/um/Makefile                        | 8 ++++++++
 arch/um/kernel/sysrq.c                  | 3 ++-
 arch/um/kernel/um_arch.c                | 2 +-
 arch/x86/um/shared/sysdep/syscalls_32.h | 5 ++---
 arch/x86/um/tls_32.c                    | 6 ------
 arch/x86/um/vdso/Makefile               | 2 +-
 6 files changed, 14 insertions(+), 12 deletions(-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

