Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <richard@nod.at>) id 1dtIJ8-0004j8-Js
 for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 16 Sep 2017 18:59:14 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1dtIJ7-0003Kd-2E for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 16 Sep 2017 18:59:14 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sat, 16 Sep 2017 20:59:25 +0200
Message-ID: <2875043.4mJUi0PUJr@blindfold>
MIME-Version: 1.0
Subject: [uml-devel] [GIT PULL] UML updates for 4.14-rc1
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Linus,

The following changes since commit 569dbb88e80deb68974ef6fdd6a13edb9d686261:

  Linux 4.13 (2017-09-03 13:56:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.14-rc1

for you to fetch changes up to 6d20e6b235aad0be463b23588093b079362bb2e4:

  um: return negative in tuntap_open_tramp() (2017-09-13 22:36:50 +0200)

----------------------------------------------------------------
This pull request contains updates for UML:
- Minor improvements
- Fixes for Debian's new gcc defaults (pie enabled by default)
- Fixes for XSTATE/XSAVE to make UML work again on modern systems

----------------------------------------------------------------
Dan Carpenter (2):
      um: remove a stray tab
      um: return negative in tuntap_open_tramp()

James Pack (1):
      Fix minor typos and grammar in UML start_up help

Krzysztof Kozlowski (1):
      um: defconfig: Cleanup from old Kconfig options

Thomas Meyer (4):
      um: Fix FP register size for XSTATE/XSAVE
      um: Fix CONFIG_GCOV for modules.
      um: link vmlinux with -no-pie
      um: Use relative modversions with LD_SCRIPT_DYN

 arch/um/Kconfig.um                     |  1 +
 arch/um/Makefile                       |  2 +-
 arch/um/configs/i386_defconfig         |  1 -
 arch/um/configs/x86_64_defconfig       |  1 -
 arch/um/include/asm/thread_info.h      |  3 +++
 arch/um/include/shared/os.h            |  2 +-
 arch/um/kernel/gmon_syms.c             |  7 +++++++
 arch/um/kernel/process.c               |  4 ++--
 arch/um/os-Linux/drivers/tuntap_user.c |  2 +-
 arch/um/os-Linux/skas/process.c        | 17 ++++++++---------
 arch/um/os-Linux/start_up.c            |  6 +++---
 arch/x86/um/os-Linux/registers.c       | 18 ++++++++++++------
 arch/x86/um/os-Linux/tls.c             |  2 +-
 arch/x86/um/user-offsets.c             |  2 +-
 14 files changed, 41 insertions(+), 27 deletions(-)


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

