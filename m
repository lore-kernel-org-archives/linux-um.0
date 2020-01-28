Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwN6S-0000qn-0n
 for linux-um@lists.infradead.org; Tue, 28 Jan 2020 09:24:13 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml updates for 5.6-rc1
Message-ID: <aaf07936-6fd2-be40-15dc-f87e8e84091d@cambridgegreys.com>
Date: Tue, 28 Jan 2020 09:24:07 +0000
MIME-Version: 1.0
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: torvalds@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, johannes@sipsolutions.net, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Linus,

I am sending this on behalf of Richard who is traveling.

Please pull the following uml updates for v5.6-rc1:

The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

   Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.6-rc1

for you to fetch changes up to d65197ad52494bed3b5e64708281b8295f76c391:

   um: Fix time-travel=inf-cpu with xor/raid6 (2020-01-19 22:42:06 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Fix for time travel mode
- Disable CONFIG_CONSTRUCTORS again
- A new command line option to have an non-raw serial line
- Preparations to remove obsolete UML network drivers

----------------------------------------------------------------
Brendan Higgins (1):
       um: Mark non-vector net transports as obsolete

Johannes Berg (3):
       um: Add an option to make serial driver non-raw
       Revert "um: Enable CONFIG_CONSTRUCTORS"
       um: Fix time-travel=inf-cpu with xor/raid6

  arch/um/Kconfig                  |  2 +
  arch/um/drivers/Kconfig          | 81 ++++++++++++++++++++--------------------
  arch/um/drivers/chan_user.h      |  2 +-
  arch/um/drivers/ssl.c            |  8 ++++
  arch/um/include/asm/Kbuild       |  1 -
  arch/um/include/asm/common.lds.S |  2 +-
  arch/um/include/asm/xor.h        |  7 ++++
  arch/um/kernel/dyn.lds.S         |  1 +
  init/Kconfig                     |  1 +
  kernel/gcov/Kconfig              |  2 +-
  10 files changed, 63 insertions(+), 44 deletions(-)
  create mode 100644 arch/um/include/asm/xor.h




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

