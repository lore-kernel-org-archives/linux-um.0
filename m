Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1is8PF-0000go-No
 for linux-um@lists.infradead.org; Thu, 16 Jan 2020 16:54:07 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 176/205] um: virtio_uml: Disallow modular build
Date: Thu, 16 Jan 2020 11:42:31 -0500
Message-Id: <20200116164300.6705-176-sashal@kernel.org>
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.co.uk>, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit bf9f80cf0ccab5f346f7d3cdc445da8fcfe6ce34 ]

This driver *can* be a module, but then its parameters (socket path)
are untrusted data from inside the VM, and that isn't allowed. Allow
the code to only be built-in to avoid that.

Fixes: 5d38f324993f ("um: drivers: Add virtio vhost-user driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.co.uk>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/Kconfig      | 2 +-
 arch/um/drivers/virtio_uml.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index fea5a0d522dc..388096fb45a2 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -337,7 +337,7 @@ config UML_NET_SLIRP
 endmenu
 
 config VIRTIO_UML
-	tristate "UML driver for virtio devices"
+	bool "UML driver for virtio devices"
 	select VIRTIO
 	help
 	  This driver provides support for virtio based paravirtual device
diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index c5643a59a8c7..179b41ad63ba 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -4,12 +4,12 @@
  *
  * Copyright(c) 2019 Intel Corporation
  *
- * This module allows virtio devices to be used over a vhost-user socket.
+ * This driver allows virtio devices to be used over a vhost-user socket.
  *
  * Guest devices can be instantiated by kernel module or command line
  * parameters. One device will be created for each parameter. Syntax:
  *
- *		[virtio_uml.]device=<socket>:<virtio_id>[:<platform_id>]
+ *		virtio_uml.device=<socket>:<virtio_id>[:<platform_id>]
  * where:
  *		<socket>	:= vhost-user socket path to connect
  *		<virtio_id>	:= virtio device id (as in virtio_ids.h)
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

