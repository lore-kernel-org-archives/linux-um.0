Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0sNA-00Cqxt-ER
 for linux-um@lists.infradead.org; Tue, 06 Jul 2021 21:12:53 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] hostfs: support splice_write
Date: Tue,  6 Jul 2021 23:12:42 +0200
Message-Id: <20210706231242.aa02ddf73d5b.Id2928a2670d916fb090812a3e9c980d155ffac20@changeid>
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

There's really no good reason not to, and e.g. trace-cmd
currently requires it for the temporary per-CPU files.
Hook up splice_write just like everyone else does.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/hostfs/hostfs_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 7d0c3dbb2898..d5c9d886cd9f 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -381,6 +381,7 @@ static int hostfs_fsync(struct file *file, loff_t start, loff_t end,
 static const struct file_operations hostfs_file_fops = {
 	.llseek		= generic_file_llseek,
 	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

