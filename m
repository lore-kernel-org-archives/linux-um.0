Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTBUR-0007CT-R0
 for linux-um@lists.infradead.org; Wed, 13 Jun 2018 19:31:36 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] UML updates for 4.18-rc1
Date: Wed, 13 Jun 2018 21:31:03 +0200
Message-ID: <1763075.mOQZ1Y9R1k@blindfold>
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
To: torvalds@linux-foundation.org
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Linus,

The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.18-rc1

for you to fetch changes up to 5ec9121195a4f1cecd0fa592636c5f81eb03dc8c:

  um: Fix raw interface options (2018-06-10 22:54:47 +0200)

----------------------------------------------------------------
This pull request contains minor updates for UML:
- Fixes for our new vector network driver by Anton
- initcall cleanup by Alexander
- We have a new mailinglist, sourceforge.net sucks.

----------------------------------------------------------------

Alexander Pateenok (1):
      um: remove uml initcalls

Anton Ivanov (2):
      um: Fix initialization of vector queues
      um: Fix raw interface options

Richard Weinberger (1):
      um: Update mailing list address

 MAINTAINERS                      |  3 +--
 arch/um/drivers/vector_kern.c    | 20 ++++++++++++++------
 arch/um/include/asm/common.lds.S |  6 ------
 arch/um/include/shared/init.h    |  5 -----
 arch/um/os-Linux/main.c          | 12 ------------
 5 files changed, 15 insertions(+), 31 deletions(-)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

