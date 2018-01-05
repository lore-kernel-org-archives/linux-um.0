Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] um: vector: fix missing unlock on error in vector_net_open()
Date: Fri, 5 Jan 2018 07:22:52 +0000
Message-ID: <1515136972-58532-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Add the missing unlock before return from function vector_net_open()
in the error handling case.

Fixes: ad1f62ab2bd4 ("High Performance UML Vector Network Driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/um/drivers/vector_kern.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index d1d5301..bb83a2d 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1156,8 +1156,10 @@ static int vector_net_open(struct net_device *dev)
 	struct vector_device *vdevice;
 
 	spin_lock_irqsave(&vp->lock, flags);
-	if (vp->opened)
+	if (vp->opened) {
+		spin_unlock_irqrestore(&vp->lock, flags);
 		return -ENXIO;
+	}
 	vp->opened = true;
 	spin_unlock_irqrestore(&vp->lock, flags);


