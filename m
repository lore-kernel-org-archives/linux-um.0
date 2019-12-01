Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibVgG-0007Pb-AI
 for linux-um@lists.infradead.org; Sun, 01 Dec 2019 20:18:57 +0000
Date: Sun, 1 Dec 2019 21:18:54 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1468911323.103246.1575231534725.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v5.5-rc1
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

The following changes since commit e472c64aa4fa6150c6076fd36d101d667d71c30a:

  Merge tag 'dmaengine-fix-5.4-rc6' of git://git.infradead.org/users/vkoul/slave-dma (2019-10-31 07:34:09 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.5-rc1

for you to fetch changes up to 9807019a62dc670c73ce8e59e09b41ae458c34b3:

  um: Loadable BPF "Firmware" for vector drivers (2019-11-25 22:43:31 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Fixes for our new virtio code
- Fix for the irqflags tracer
- Kconfig coding style fixes
- Allow BPF firmware loading in our vector driver

----------------------------------------------------------------
Anton Ivanov (1):
      um: Loadable BPF "Firmware" for vector drivers

Johannes Berg (4):
      um: Don't trace irqflags during shutdown
      um: virtio: Remove device on disconnect
      um: virtio: Keep reading on -EAGAIN
      um: virtio_uml: Disallow modular build

Krzysztof Kozlowski (1):
      um: Fix Kconfig indentation

 arch/um/Kconfig               |   2 +-
 arch/um/drivers/Kconfig       |   2 +-
 arch/um/drivers/vector_kern.c | 113 ++++++++++++++++++++++++++++++++++++++----
 arch/um/drivers/vector_kern.h |   8 ++-
 arch/um/drivers/vector_user.c |  94 ++++++++++++++++++++++++++++-------
 arch/um/drivers/vector_user.h |   8 ++-
 arch/um/drivers/virtio_uml.c  |  76 ++++++++++++++++++----------
 arch/um/os-Linux/main.c       |   2 +-
 8 files changed, 247 insertions(+), 58 deletions(-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

