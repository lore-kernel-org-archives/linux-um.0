Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muybT-00D6tO-91
 for linux-um@lists.infradead.org; Wed, 08 Dec 2021 15:11:32 +0000
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 0/2] Devicetree support for UML
Date: Wed, 8 Dec 2021 16:11:21 +0100
Message-ID: <20211208151123.29313-1-vincent.whitchurch@axis.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: kernel@axis.com, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, devicetree@vger.kernel.org, Vincent Whitchurch <vincent.whitchurch@axis.com>

This series add support for passing a devicetree blob to UML.  It can be used
for testing device drivers.

Vincent Whitchurch (2):
  um: Extract load file helper from initrd.c
  um: Add devicetree support

 arch/um/Kconfig            |  1 +
 arch/um/kernel/Makefile    |  2 ++
 arch/um/kernel/dtb.c       | 41 +++++++++++++++++++++++++
 arch/um/kernel/initrd.c    | 48 ++++--------------------------
 arch/um/kernel/load_file.c | 61 ++++++++++++++++++++++++++++++++++++++
 arch/um/kernel/um_arch.c   |  3 ++
 arch/um/kernel/um_arch.h   | 14 +++++++++
 7 files changed, 127 insertions(+), 43 deletions(-)
 create mode 100644 arch/um/kernel/dtb.c
 create mode 100644 arch/um/kernel/load_file.c
 create mode 100644 arch/um/kernel/um_arch.h

-- 
2.33.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

