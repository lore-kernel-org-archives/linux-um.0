Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YXTOq-0006Me-O0
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 11:41:36 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXTOp-0006DJ-Uf for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Mar 2015 11:41:36 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 16 Mar 2015 12:41:09 +0100
Message-Id: <1426506079-26183-6-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 05/15] hostfs: Make hostfs_readpage more readable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: richard@nod.at, linux-kernel@vger.kernel.org

...to make life easier for future readers of that code.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 8163aac..67e556c 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -439,25 +439,27 @@ static int hostfs_readpage(struct file *file, struct page *page)
 {
 	char *buffer;
 	long long start;
-	int err = 0;
+	int bytes_read, ret;
 
 	start = (long long) page->index << PAGE_CACHE_SHIFT;
 	buffer = kmap(page);
-	err = read_file(FILE_HOSTFS_I(file)->fd, &start, buffer,
+	bytes_read = read_file(FILE_HOSTFS_I(file)->fd, &start, buffer,
 			PAGE_CACHE_SIZE);
-	if (err < 0)
+	if (bytes_read < 0) {
+		ret = bytes_read;
 		goto out;
+	}
 
-	memset(&buffer[err], 0, PAGE_CACHE_SIZE - err);
+	memset(buffer + bytes_read, 0, PAGE_CACHE_SIZE - bytes_read);
 
 	flush_dcache_page(page);
 	SetPageUptodate(page);
 	if (PageError(page)) ClearPageError(page);
-	err = 0;
+	ret = 0;
  out:
 	kunmap(page);
 	unlock_page(page);
-	return err;
+	return ret;
 }
 
 static int hostfs_write_begin(struct file *file, struct address_space *mapping,
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

