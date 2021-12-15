Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: remove set_fs for UML
Date: Wed, 15 Dec 2021 17:56:10 +0100
Message-Id: <20211215165612.554426-1-hch@lst.de>
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
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Richard and Anton,

this series removes address space overrides using set_fs for UML.

Diffstat:
 um/Kconfig                   |    1 -
 um/include/asm/thread_info.h |    4 ----
 um/include/asm/uaccess.h     |   21 +++++++++++++++++++--
 um/kernel/skas/uaccess.c     |   25 -------------------------
 x86/include/asm/mtrr.h       |    8 +-------
 x86/kernel/setup.c           |    7 ++++++-
 x86/um/asm/segment.h         |    8 --------
 7 files changed, 26 insertions(+), 48 deletions(-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

