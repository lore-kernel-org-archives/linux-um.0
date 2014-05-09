Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joe@perches.com>) id 1WiuRm-0007qO-Bq
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2014 23:43:22 +0000
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]
	helo=smtprelay.hostedemail.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WiuRl-0007f0-EC for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2014 23:43:22 +0000
From: Joe Perches <joe@perches.com>
Date: Fri,  9 May 2014 16:43:09 -0700
Message-Id: <cover.1399678795.git.joe@perches.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 0/4] UserModeLinux: Message logging neatening
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Joe Perches (4):
  UserModeLinux: Convert UM_KERN_<LEVEL> to KERN_<LEVEL>
  UserModeLinux: Remove unused #defines of UM_KERN_<LEVEL>
  UserModeLinux: Use a more current logging style
  UserModeLinux: Convert printks to pr_<level>

 arch/um/drivers/chan_kern.c              |  27 +++----
 arch/um/drivers/chan_user.c              |  47 ++++++------
 arch/um/drivers/daemon_kern.c            |   8 +-
 arch/um/drivers/daemon_user.c            |  28 +++----
 arch/um/drivers/fd.c                     |   9 +--
 arch/um/drivers/harddog_kern.c           |   4 +-
 arch/um/drivers/harddog_user.c           |  14 ++--
 arch/um/drivers/hostaudio_kern.c         |  13 ++--
 arch/um/drivers/line.c                   |  24 +++---
 arch/um/drivers/mconsole_kern.c          |  29 +++----
 arch/um/drivers/mconsole_user.c          |   7 +-
 arch/um/drivers/mmapper_kern.c           |   7 +-
 arch/um/drivers/net_kern.c               |  53 +++++--------
 arch/um/drivers/net_user.c               |  20 ++---
 arch/um/drivers/pcap_kern.c              |   9 +--
 arch/um/drivers/pcap_user.c              |  19 +++--
 arch/um/drivers/port_kern.c              |  23 +++---
 arch/um/drivers/port_user.c              |   6 +-
 arch/um/drivers/pty.c                    |   4 +-
 arch/um/drivers/random.c                 |   3 +-
 arch/um/drivers/slip_kern.c              |   2 +-
 arch/um/drivers/slip_user.c              |  29 +++----
 arch/um/drivers/slirp_kern.c             |   9 +--
 arch/um/drivers/slirp_user.c             |   9 +--
 arch/um/drivers/ssl.c                    |  10 +--
 arch/um/drivers/stdio_console.c          |   9 +--
 arch/um/drivers/tty.c                    |   3 +-
 arch/um/drivers/ubd_kern.c               | 117 +++++++++++++----------------
 arch/um/drivers/ubd_user.c               |   6 +-
 arch/um/drivers/umcast_kern.c            |  38 +++++-----
 arch/um/drivers/umcast_user.c            |  35 ++++-----
 arch/um/drivers/vde_kern.c               |  23 +++---
 arch/um/drivers/vde_user.c               |  17 ++---
 arch/um/drivers/xterm.c                  |  26 +++----
 arch/um/drivers/xterm_kern.c             |   6 +-
 arch/um/include/asm/pgtable-2level.h     |  12 +--
 arch/um/include/asm/pgtable-3level.h     |  18 ++---
 arch/um/include/shared/user.h            |  12 +--
 arch/um/kernel/exec.c                    |   4 +-
 arch/um/kernel/exitcode.c                |   3 +-
 arch/um/kernel/initrd.c                  |  10 +--
 arch/um/kernel/irq.c                     |  14 ++--
 arch/um/kernel/physmem.c                 |  16 ++--
 arch/um/kernel/process.c                 |   2 +-
 arch/um/kernel/sigio.c                   |   4 +-
 arch/um/kernel/skas/mmu.c                |   9 +--
 arch/um/kernel/smp.c                     |  18 ++---
 arch/um/kernel/sysrq.c                   |  21 +++---
 arch/um/kernel/time.c                    |   6 +-
 arch/um/kernel/tlb.c                     |   8 +-
 arch/um/kernel/trap.c                    |   9 +--
 arch/um/os-Linux/aio.c                   |  45 +++++------
 arch/um/os-Linux/drivers/ethertap_kern.c |   8 +-
 arch/um/os-Linux/drivers/ethertap_user.c |  32 ++++----
 arch/um/os-Linux/drivers/tuntap_kern.c   |   6 +-
 arch/um/os-Linux/drivers/tuntap_user.c   |  24 +++---
 arch/um/os-Linux/file.c                  |  37 ++++-----
 arch/um/os-Linux/helper.c                |  33 ++++----
 arch/um/os-Linux/irq.c                   |   8 +-
 arch/um/os-Linux/process.c               |  31 ++++----
 arch/um/os-Linux/sigio.c                 |  83 +++++++++-----------
 arch/um/os-Linux/skas/mem.c              |  23 +++---
 arch/um/os-Linux/skas/process.c          | 125 ++++++++++++++-----------------
 arch/um/os-Linux/time.c                  |   3 +-
 arch/um/os-Linux/tty.c                   |  10 +--
 arch/um/os-Linux/umid.c                  |  48 ++++++------
 arch/x86/um/bugs_32.c                    |  14 ++--
 arch/x86/um/os-Linux/registers.c         |   2 +-
 68 files changed, 605 insertions(+), 786 deletions(-)

-- 
1.8.1.2.459.gbcd45b4.dirty


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

