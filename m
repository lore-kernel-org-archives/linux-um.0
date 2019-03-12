Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3j6U-0006ji-VK
 for linux-um@lists.infradead.org; Tue, 12 Mar 2019 15:14:08 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] UML updates for 5.1-rc1
Date: Tue, 12 Mar 2019 16:14:04 +0100
Message-ID: <31705653.NnsrL61LRB@blindfold>
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

The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:

  Linux 5.0 (2019-03-03 15:21:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-5.1-rc1

for you to fetch changes up to aea05eb56e47046de1e5b508d40931dca969f1e5:

  um: Fix for a possible OOPS in ubd initialization (2019-03-06 22:39:18 +0100)

----------------------------------------------------------------
This pull request contains updates for UML:

- Bugfix for the UML block device driver

----------------------------------------------------------------
Anton Ivanov (1):
      um: Fix for a possible OOPS in ubd initialization

YueHaibing (1):
      um: Remove duplicated include from vector_user.c

 arch/um/drivers/ubd_kern.c    | 6 +++---
 arch/um/drivers/vector_user.c | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

