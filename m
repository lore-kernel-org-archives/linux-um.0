Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37E2E77188
	for <linux-um@archiver.kernel.org>; Fri, 20 Dec 2024 05:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hbyDsBYs078/edYsxxQxZi+pKFEuecjVboPxERHpBOk=; b=vQZGFbBKY9r0g2/b/CKbjSeGHt
	H4QedNlsAuM8tjHRPopJZm6tIarVYyUrMk+BZ95gURhhgD0C9C6pWxMkNBTD4hFUxO+tu0tJwK/Ot
	11h9ejQSVhWF80LpFHmOnIiu27AZns8NBQwGv/cnrGokI6HLAFc0kq4Ukewp57cIm4bnSC8ktdYG5
	MOO11lLkgqaJQCCiJNdxq1Rc6ZxLfp7qIKKugLhF6s+LeEVzUCEn0ksMfe9Giwx7UmK1snVfnzmH5
	ODia+inwnx6CTGSxkPiQRHLFM12eHvZ5iHJOqGqu1iqEKjNPIE9mdL++J1GKGQfpJzhJNyHg+Rrew
	oOFyCL6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOVLt-00000003xmS-1I6f;
	Fri, 20 Dec 2024 05:15:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOVLr-00000003xmD-3hrz
	for linux-um@bombadil.infradead.org;
	Fri, 20 Dec 2024 05:15:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=hbyDsBYs078/edYsxxQxZi+pKFEuecjVboPxERHpBOk=; b=s7VaH9sJHuR6ieR/HltkARbxm6
	Jg9SDtN0yFFZCtUhWL/LPyfqM9ZWn70vZ4lldIjTQxXZubbScbkVzLR26dzjrbbNSkMOg2Yleuqjw
	ErhmfyUBzk6odNkJK3o9RtBu3OrqHAX81sbMw56RlB8WJk6Wm1P8z6D32UJvWUAK9dH/2wj7tEoyQ
	voQZ0B6kK/9saJaGBk0Kkw/tvHQ6JZWs6ryCLKWu+q59tCJNVLQwq7wzyUbFVwi9vxPGQTuGrSwbp
	uMEfIplHVyvl7pcWoBEIY3jCeZ8kT5iZd2/B4TNGEZOqxIBEQL2HcAP4VoRBA6FOhOvz2vrP08ZVA
	LTvRHEbA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOVLq-000000083KQ-0caJ;
	Fri, 20 Dec 2024 05:15:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Richard Weinberger <richard@nod.at>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] hostfs: Convert to writepages
Date: Fri, 20 Dec 2024 05:14:58 +0000
Message-ID: <20241220051500.1919389-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

If we add a migrate_folio operation, we can convert the writepage
operation to writepages.  The large folio support here is illusory;
we would need to kmap each page in turn for proper support.  But we do
remove a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hostfs/hostfs_kern.c | 54 +++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 7e51d2cec64b..844c45253452 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -410,38 +410,33 @@ static const struct file_operations hostfs_dir_fops = {
 	.fsync		= hostfs_fsync,
 };
 
-static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
+static int hostfs_writepages(struct address_space *mapping,
+		struct writeback_control *wbc)
 {
-	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
-	char *buffer;
-	loff_t base = page_offset(page);
-	int count = PAGE_SIZE;
-	int end_index = inode->i_size >> PAGE_SHIFT;
-	int err;
-
-	if (page->index >= end_index)
-		count = inode->i_size & (PAGE_SIZE-1);
-
-	buffer = kmap_local_page(page);
-
-	err = write_file(HOSTFS_I(inode)->fd, &base, buffer, count);
-	if (err != count) {
-		if (err >= 0)
-			err = -EIO;
-		mapping_set_error(mapping, err);
-		goto out;
+	struct folio *folio = NULL;
+	loff_t i_size = i_size_read(inode);
+	int err = 0;
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
+		loff_t pos = folio_pos(folio);
+		size_t count = folio_size(folio);
+		char *buffer;
+		int ret;
+
+		if (count > i_size - pos)
+			count = i_size - pos;
+
+		buffer = kmap_local_folio(folio, 0);
+		ret = write_file(HOSTFS_I(inode)->fd, &pos, buffer, count);
+		kunmap_local(buffer);
+		folio_unlock(folio);
+		if (ret != count) {
+			err = ret < 0 ? ret : -EIO;
+			mapping_set_error(mapping, err);
+		}
 	}
 
-	if (base > inode->i_size)
-		inode->i_size = base;
-
-	err = 0;
-
- out:
-	kunmap_local(buffer);
-	unlock_page(page);
-
 	return err;
 }
 
@@ -506,11 +501,12 @@ static int hostfs_write_end(struct file *file, struct address_space *mapping,
 }
 
 static const struct address_space_operations hostfs_aops = {
-	.writepage 	= hostfs_writepage,
+	.writepages 	= hostfs_writepages,
 	.read_folio	= hostfs_read_folio,
 	.dirty_folio	= filemap_dirty_folio,
 	.write_begin	= hostfs_write_begin,
 	.write_end	= hostfs_write_end,
+	.migrate_folio	= filemap_migrate_folio,
 };
 
 static int hostfs_inode_update(struct inode *ino, const struct hostfs_stat *st)
-- 
2.45.2


