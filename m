Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klCv6-0006Et-KB
 for linux-um@lists.infradead.org; Fri, 04 Dec 2020 15:22:53 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: line: don't free winch (with IRQ) under spinlock
Date: Fri,  4 Dec 2020 16:22:44 +0100
Message-Id: <20201204162243.779ca2ed9a30.I11ed45127847cd6c160f561a3508ba111be82b2d@changeid>
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
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

Lockdep correctly complains that one shouldn't call um_free_irq()
with free_irq() inside under a spinlock since that will attempt
to acquire a mutex.

Rearrange the code to keep the list manipulations under the lock
while moving the actual freeing outside of it, to avoid this.

In particular, this removes the lockdep complaint at shutdown that
I was seeing with lockdep enabled.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/line.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 2d68f58ac54b..1c70a31e7c5b 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -614,7 +614,6 @@ static void free_winch(struct winch *winch)
 	winch->fd = -1;
 	if (fd != -1)
 		os_close_file(fd);
-	list_del(&winch->list);
 	__free_winch(&winch->work);
 }
 
@@ -715,6 +714,8 @@ static void unregister_winch(struct tty_struct *tty)
 		winch = list_entry(ele, struct winch, list);
 		wtty = tty_port_tty_get(winch->port);
 		if (wtty == tty) {
+			list_del(&winch->list);
+			spin_unlock(&winch_handler_lock);
 			free_winch(winch);
 			break;
 		}
@@ -725,14 +726,17 @@ static void unregister_winch(struct tty_struct *tty)
 
 static void winch_cleanup(void)
 {
-	struct list_head *ele, *next;
 	struct winch *winch;
 
 	spin_lock(&winch_handler_lock);
+	while ((winch = list_first_entry_or_null(&winch_handlers,
+						 struct winch, list))) {
+		list_del(&winch->list);
+		spin_unlock(&winch_handler_lock);
 
-	list_for_each_safe(ele, next, &winch_handlers) {
-		winch = list_entry(ele, struct winch, list);
 		free_winch(winch);
+
+		spin_lock(&winch_handler_lock);
 	}
 
 	spin_unlock(&winch_handler_lock);
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

