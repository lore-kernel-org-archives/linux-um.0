Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i1t5q-0001WM-CA
 for linux-um@lists.infradead.org; Sun, 25 Aug 2019 14:02:07 +0000
Date: Sun, 25 Aug 2019 16:01:55 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1911490926.73826.1566741715800.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fixes for 5.3-rc6
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

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.3-rc6

for you to fetch changes up to e0917f879536cbf57367429d084775d8224c986c:

  um: fix time travel mode (2019-08-23 00:39:53 +0200)

----------------------------------------------------------------
This pull request contains a single bug fix for UML:

- Fix time travel mode

----------------------------------------------------------------
Johannes Berg (1):
      um: fix time travel mode

 arch/um/include/shared/timer-internal.h | 14 ++++++++++----
 arch/um/kernel/process.c                |  2 +-
 arch/um/kernel/time.c                   | 16 +++++++++-------
 3 files changed, 20 insertions(+), 12 deletions(-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

