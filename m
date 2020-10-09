Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v2 04/16] afs: Tell the VFS that readpage was synchronous
Date: Fri,  9 Oct 2020 15:30:52 +0100
Message-Id: <20201009143104.22673-5-willy@infradead.org>
In-Reply-To: <20201009143104.22673-1-willy@infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-fsdevel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org, Richard Weinberger <richard@nod.at>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

The afs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 371d1488cc54..4aa2ad3bea6a 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -367,7 +367,8 @@ int afs_page_filler(void *data, struct page *page)
 			BUG_ON(PageFsCache(page));
 		}
 #endif
-		unlock_page(page);
+		_leave(" = AOP_UPDATED_PAGE");
+		return AOP_UPDATED_PAGE;
 	}
 
 	_leave(" = 0");
-- 
2.28.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

