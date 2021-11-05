Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miuJO-00ApDo-3G
 for linux-um@lists.infradead.org; Fri, 05 Nov 2021 08:10:59 +0000
From: Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH] hostfs: Fix writeback of dirty pages
Date: Fri,  5 Nov 2021 09:10:51 +0100
Message-Id: <20211105081052.2353801-1-sjoerd@collabora.com>
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
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

Hostfs was not setting up the backing device information, which means it
uses the noop bdi. The noop bdi does not have the writeback capability
enabled, which in turns means  dirty pages never got written back to
storage.

In other words programs using mmap to write to files on  hostfs never
actually got their data written out...

Fix this by simply setting up the bdi with default settings as all the
required code for writeback is already in place.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

 fs/hostfs/hostfs_kern.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index d5c9d886cd9f..ef481c3d9019 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -924,6 +924,9 @@ static int hostfs_fill_sb_common(struct super_block *sb, void *d, int silent)
 	sb->s_op = &hostfs_sbops;
 	sb->s_d_op = &simple_dentry_operations;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	err = super_setup_bdi(sb);
+	if (err)
+		goto out;
 
 	/* NULL is printed as '(null)' by printf(): avoid that. */
 	if (req_root == NULL)
-- 
2.33.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

