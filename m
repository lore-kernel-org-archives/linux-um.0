Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BF3C3DA4A
	for <linux-um@archiver.kernel.org>; Tue, 20 Aug 2024 02:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BrYosO9LHzB6Uuy4rqjbrpf+szANMJmWOohtAaSKlIw=; b=AidVhe9dgok2yAa7zge1and1C3
	9b2GrwEr2SgFmIUsScr63Gv+616FL0RPFYlynxap1y0vXAYpBOGUjN5z3YODpjljvc/J00j58RsYd
	6MX1JqOSKuv19m+6pYlDGRxcQPJkf5JCyAL+KD6cLa40SBLK0tXfQShxvDeO+1DPvG1DoyT//eNZw
	r5claTBa8KNI6rNHzIerLl7D2kGHkKUYX9bD0MRmXpyWAzRIwNH0Y/l7H9j7hgHpBXnkIxq0aw1sT
	6O+EOJAURMAqRbZQwiOGfeKwfr750euKJk+I4N5osjy4ZbMDjO47CIy473PqCK5qwzFz9LRkdBuIR
	9sln486g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgEqo-00000003a6j-0RUz;
	Tue, 20 Aug 2024 02:44:02 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgEqB-00000003ZtT-0JBr
	for linux-um@lists.infradead.org;
	Tue, 20 Aug 2024 02:43:25 +0000
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WntyD1xccz1xvSl;
	Tue, 20 Aug 2024 10:41:24 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 33DCA1402CD;
	Tue, 20 Aug 2024 10:43:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 20 Aug
 2024 10:43:17 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>
CC: <lizetao1@huawei.com>, <linux-um@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] hostfs: Convert hostfs_writepage to use folio
Date: Tue, 20 Aug 2024 10:50:45 +0800
Message-ID: <20240820025045.13339-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500012.china.huawei.com (7.221.188.25)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_194323_424795_82002ACE 
X-CRM114-Status: GOOD (  10.45  )
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

convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1]: https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/hostfs/hostfs_kern.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6d1cf2436ead..e17e70f20fa1 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -411,18 +411,19 @@ static const struct file_operations hostfs_dir_fops = {
 
 static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 {
-	struct address_space *mapping = page->mapping;
-	struct inode *inode = mapping->host;
+	struct folio *folio = page_folio(page);
+	struct address_space *mapping = folio->mapping;
+	struct inode *inode = folio_inode(folio);
 	char *buffer;
-	loff_t base = page_offset(page);
+	loff_t base = folio_pos(folio);
 	int count = PAGE_SIZE;
 	int end_index = inode->i_size >> PAGE_SHIFT;
 	int err;
 
-	if (page->index >= end_index)
+	if (folio->index >= end_index)
 		count = inode->i_size & (PAGE_SIZE-1);
 
-	buffer = kmap_local_page(page);
+	buffer = kmap_local_folio(folio, 0);
 
 	err = write_file(HOSTFS_I(inode)->fd, &base, buffer, count);
 	if (err != count) {
@@ -439,7 +440,7 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 
  out:
 	kunmap_local(buffer);
-	unlock_page(page);
+	folio_unlock(folio);
 
 	return err;
 }
-- 
2.34.1


