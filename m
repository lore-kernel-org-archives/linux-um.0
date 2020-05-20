Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbUiq-0003Ee-0N
 for linux-um@lists.infradead.org; Wed, 20 May 2020 19:49:49 +0000
Date: Wed, 20 May 2020 21:49:36 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1547930539.249342.1590004176796.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fixes for 5.7 final
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

The following changes since commit 1d2cc5ac6f6668cc15216d51051103c61467d7e8:

  Merge tag 'riscv-for-linus-5.7-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2020-04-29 09:25:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.7-rc6

for you to fetch changes up to 2e27d33d22afa3d12746f854d6a4fad7ad7b86de:

  um: Fix typo in vector driver transport option definition (2020-04-29 21:22:15 +0200)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Two missing includes which cause build issues on recent systems
- Correctly set TRANS_GRE_LEN in our vector network driver

----------------------------------------------------------------
Ignat Korchagin (1):
      um: Fix typo in vector driver transport option definition

Johannes Berg (2):
      um: Fix xor.h include
      um: syscall.c: include <asm/unistd.h>

 arch/um/drivers/vector_user.h | 2 +-
 arch/um/include/asm/xor.h     | 2 +-
 arch/um/kernel/skas/syscall.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

