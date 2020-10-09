Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 03/16] 9p: Tell the VFS that readpage was synchronous
Date: Fri,  9 Oct 2020 15:30:51 +0100
Message-Id: <20201009143104.22673-4-willy@infradead.org>
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
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
To: linux-fsdevel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, Dominique Martinet <asmadeus@codewreck.org>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org

The 9p readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Dominique Martinet <asmadeus@codewreck.org>
---
 fs/9p/vfs_addr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index cce9ace651a2..506ca0ba2ec7 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -65,7 +65,7 @@ static int v9fs_fid_readpage(void *data, struct page *page)
 	SetPageUptodate(page);
 
 	v9fs_readpage_to_fscache(inode, page);
-	retval = 0;
+	return AOP_UPDATED_PAGE;
 
 done:
 	unlock_page(page);
@@ -280,6 +280,10 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
 		goto out;
 
 	retval = v9fs_fid_readpage(v9inode->writeback_fid, page);
+	if (retval == AOP_UPDATED_PAGE) {
+		retval = 0;
+		goto out;
+	}
 	put_page(page);
 	if (!retval)
 		goto start;
-- 
2.28.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

