Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YXTOx-0006BG-5y
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 11:41:43 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXTOw-0005fE-6N for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 11:41:43 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 16 Mar 2015 12:41:18 +0100
Message-Id: <1426506079-26183-15-git-send-email-richard@nod.at>
In-Reply-To: <1426506079-26183-1-git-send-email-richard@nod.at>
References: <1426506079-26183-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 14/15] hostfs: Use page_offset()
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, linux-kernel@vger.kernel.org

The kernel offers a helper function for that, use it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index f154747..f82f98a5 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -410,7 +410,7 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
 	char *buffer;
-	unsigned long long base;
+	loff_t base = page_offset(page);
 	int count = PAGE_CACHE_SIZE;
 	int end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 	int err;
@@ -419,7 +419,6 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 		count = inode->i_size & (PAGE_CACHE_SIZE-1);
 
 	buffer = kmap(page);
-	base = ((unsigned long long) page->index) << PAGE_CACHE_SHIFT;
 
 	err = write_file(HOSTFS_I(inode)->fd, &base, buffer, count);
 	if (err != count) {
@@ -444,10 +443,9 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 static int hostfs_readpage(struct file *file, struct page *page)
 {
 	char *buffer;
-	long long start;
+	loff_t start = page_offset(page);
 	int bytes_read, ret = 0;
 
-	start = (long long) page->index << PAGE_CACHE_SHIFT;
 	buffer = kmap(page);
 	bytes_read = read_file(FILE_HOSTFS_I(file)->fd, &start, buffer,
 			PAGE_CACHE_SIZE);
-- 
2.3.2


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

