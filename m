Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n3mOU-007PKi-3i
 for linux-um@lists.infradead.org; Sat, 01 Jan 2022 21:58:31 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/4] um: irq: Restore O_ASYNC upon exit
Date: Sat,  1 Jan 2022 22:58:10 +0100
Message-Id: <20220101215810.13260-5-richard@nod.at>
In-Reply-To: <20220101215810.13260-1-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
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
Cc: linux-kernel@vger.kernel.org, johannes.berg@intel.com, anton.ivanov@cambridgegreys.com, Richard Weinberger <richard@nod.at>

Just like with O_NONBLOCK, make sure UML clears O_ASYNC
upon exit when it set it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/kernel/irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index a8873d9bc28b..e020bdccfa23 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -342,6 +342,7 @@ static void free_irq_by_irq_and_dev(unsigned int irq, void *dev)
 				continue;
 
 			os_del_epoll_fd(entry->fd);
+			os_clear_fd_async(entry->fd);
 			reg->events = 0;
 			update_or_free_irq_entry(entry);
 			goto out;
@@ -396,8 +397,10 @@ int deactivate_all_fds(void)
 	os_set_ioignore();
 
 	/* we can no longer call kfree() here so just deactivate */
-	list_for_each_entry(entry, &active_fds, list)
+	list_for_each_entry(entry, &active_fds, list) {
 		os_del_epoll_fd(entry->fd);
+		os_clear_fd_async(entry->fd);
+	}
 	os_close_epoll_fd();
 	return 0;
 }
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

