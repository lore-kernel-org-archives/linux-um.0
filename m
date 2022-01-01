Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n3mOU-007PKf-10
 for linux-um@lists.infradead.org; Sat, 01 Jan 2022 21:58:31 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/4] um: Assorted console related fixes
Date: Sat,  1 Jan 2022 22:58:06 +0100
Message-Id: <20220101215810.13260-1-richard@nod.at>
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
Cc: linux-kernel@vger.kernel.org, johannes.berg@intel.com, anton.ivanov@cambridgegreys.com, Richard Weinberger <richard@nod.at>

When UML terminates (gracefully or panic) it does not always
cleanup on the host side.
Especially when fd:0,fd:1 is used as console it can leave a misconfigured
stdin/out on the host side.
Also stale processes such as port-helper can left behind.

This series fixes the console exit code to make sure UML
undoes everything it changed on the host side.

Richard Weinberger (4):
  um: Run console exit code also upon kernel panic
  um: os_set_fd_block: Return old blocking mode
  um: chan: Restore blocking mode upon exit
  um: irq: Restore O_ASYNC upon exit

 arch/um/drivers/chan.h               |  1 +
 arch/um/drivers/chan_kern.c          | 11 +++++++----
 arch/um/drivers/chan_user.c          |  2 +-
 arch/um/drivers/mconsole_kern.c      |  2 +-
 arch/um/drivers/stdio_console.c      |  4 ++--
 arch/um/drivers/ubd_user.c           |  2 +-
 arch/um/drivers/xterm.c              |  2 +-
 arch/um/include/shared/uml_console.h | 11 +++++++++++
 arch/um/kernel/irq.c                 |  5 ++++-
 arch/um/kernel/um_arch.c             |  8 +++++---
 arch/um/os-Linux/file.c              |  5 ++++-
 11 files changed, 38 insertions(+), 15 deletions(-)
 create mode 100644 arch/um/include/shared/uml_console.h

-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

