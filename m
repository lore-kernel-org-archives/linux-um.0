Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1d9VPJ-0000o1-RV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 11:40:21 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d9VPH-0008Dw-Gi
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 May 2017 11:40:21 +0000
From: Richard Weinberger <richard@nod.at>
Message-ID: <3542c10c-6c48-7934-f69f-b2700fa8a860@nod.at>
Date: Sat, 13 May 2017 13:40:11 +0200
MIME-Version: 1.0
Subject: [uml-devel] [GIT PULL] UML changes for v4.12-rc1
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Linus,

The following changes since commit a351e9b9fc24e982ec2f0e76379a49826036da12:

  Linux 4.11 (2017-04-30 19:47:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.12-rc1

for you to fetch changes up to ce4586063f1af780b1c6b7e344907e6f9c1ba59a:

  um: Add missing NR_CPUS include (2017-05-04 08:15:10 +0200)
----------------------------------------------------------------
This pull request contains updates for UML:
- No new stuff, just fixes

----------------------------------------------------------------

Masami Hiramatsu (1):
      um: Fix to call read_initrd after init_bootmem

Matthias Kaehlcke (1):
      um: Include kbuild.h instead of duplicating its macros

Nikola Kotur (1):
      um: Set number of CPUs

Richard Weinberger (3):
      um: Fix _print_addr()
      um: Fix PTRACE_POKEUSER on x86_64
      um: Add missing NR_CPUS include

 arch/um/Kconfig.common                     | 5 +++++
 arch/um/kernel/initrd.c                    | 4 +---
 arch/um/kernel/sysrq.c                     | 6 ++----
 arch/um/kernel/um_arch.c                   | 6 ++++++
 arch/um/os-Linux/skas/process.c            | 4 +---
 arch/x86/um/ptrace_64.c                    | 2 +-
 arch/x86/um/shared/sysdep/kernel-offsets.h | 9 +--------
 7 files changed, 17 insertions(+), 19 deletions(-)

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

