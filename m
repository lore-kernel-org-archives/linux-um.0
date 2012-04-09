Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1SHN6d-0006ZN-Mv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Apr 2012 22:30:39 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SHN6c-0004me-9j
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Apr 2012 22:30:39 +0000
MIME-Version: 1.0
Date: Tue, 10 Apr 2012 00:30:28 +0200
From: Richard Weinberger <richard@nod.at>
Message-ID: <905c4f872802ba8c93fe28bc2f627407@radon2.swed.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [GIT PULL] UML fixes for 3.4-rc3
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Linus,

This are the UML fixes for for 3.4-rc3.

Thanks,
//richard

---
The following changes since commit 
0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-3.4-rc3

Al Viro (3):
      um: fix linker script generation
      um: several x86 hw-dependent crypto modules won't build on uml
      um: switch cow_user.h to htobe{32,64}/betoh{32,64}

Boaz Harrosh (1):
      um: uml_setup_stubs': warning: unused variable 'pages'

Richard Weinberger (2):
      um: Disintegrate asm/system.h
      um: Use asm-generic/switch_to.h

 arch/um/drivers/cow.h           |   35 ----------
 arch/um/drivers/cow_user.c      |   43 ++++++------
 arch/um/drivers/mconsole_kern.c |    1 +
 arch/um/include/asm/Kbuild      |    3 +-
 arch/um/kernel/Makefile         |    7 +-
 arch/um/kernel/process.c        |    6 +--
 arch/um/kernel/skas/mmu.c       |    1 -
 arch/x86/Makefile.um            |    3 +
 arch/x86/um/asm/barrier.h       |   75 +++++++++++++++++++++
 arch/x86/um/asm/system.h        |  135 
---------------------------------------
 crypto/Kconfig                  |    6 +-
 11 files changed, 110 insertions(+), 205 deletions(-)
 create mode 100644 arch/x86/um/asm/barrier.h
 delete mode 100644 arch/x86/um/asm/system.h


------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

