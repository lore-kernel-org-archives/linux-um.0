Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from [43.155.65.254] (helo=smtpbg.qq.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEFUB-009yAO-0B
	for linux-um@lists.infradead.org; Wed, 20 Jul 2022 19:36:00 +0000
From: Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] kernel:do not initialise statics to 0.
Date: Thu, 21 Jul 2022 03:33:23 +0800
Message-Id: <20220720193323.7848-1-gaoxin@cdjrlc.com>
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
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/um/drivers/mconsole_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 8ca67a692683..de40e7822fa6 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -283,7 +283,7 @@ struct unplugged_pages {
 };
 
 static DEFINE_MUTEX(plug_mem_mutex);
-static unsigned long long unplugged_pages_count = 0;
+static unsigned long long unplugged_pages_count;
 static LIST_HEAD(unplugged_pages);
 static int unplug_index = UNPLUGGED_PER_PAGE;
 
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

