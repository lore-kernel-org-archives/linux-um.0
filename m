Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmKAx-0000ig-Vv
 for linux-um@lists.infradead.org; Mon, 07 Dec 2020 17:19:53 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH 2/3] um: tty: Fix handling of close in tty lines
Date: Mon,  7 Dec 2020 17:19:39 +0000
Message-Id: <20201207171940.25240-2-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20201207171940.25240-1-anton.ivanov@cambridgegreys.com>
References: <20201207171940.25240-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Fix a logical error in tty reading. We get 0 and errno == EAGAIN
on the first attempt to read from a closed file descriptor.

Compared to that a true EAGAIN is EAGAIN and -1.

If we check errno for EAGAIN first, before checking the return
value we miss the fact that the descriptor is closed.

This bug is as old as the driver. It was not showing up with
the original POLL based IRQ controller, because it was
producing multiple events. Switching to EPOLL unmasked it.

Fixes: ff6a17989c08 ("Epoll based IRQ controller")
Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/chan_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 4d80526a4236..d8845d4aac6a 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -26,10 +26,10 @@ int generic_read(int fd, char *c_out, void *unused)
 	n = read(fd, c_out, sizeof(*c_out));
 	if (n > 0)
 		return n;
-	else if (errno == EAGAIN)
-		return 0;
 	else if (n == 0)
 		return -EIO;
+	else if (errno == EAGAIN)
+		return 0;
 	return -errno;
 }
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

