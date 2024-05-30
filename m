Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DCEC25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 20:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9DNYu25PsP7kPSgGts/yb+luWRPbPj48AdRNc25boMg=; b=wllnLLSvaD3Nbo9Fuvt7ctI05n
	6H4OEqzRM0ERuPC04vBLJqZiWelfZ8BxSHDzQtxwf/7UnQnR+gDt3gbKPZXnM3NjAAssgFVAe9a9V
	0qq84oxJFwTXt2pmaTwaD7g1ciJrXBCDPXH5PfjUAa/8cDstWLhuH2dtIGSIIIC+DN8pkIRnqDsXK
	pVZc495lRFN6/5RCoKvaljOLYB6kgLnXnoU4KO59jrVj21NDwfgNTPjrktWJE5PzotCv9CZyephvm
	67ZgndsOcxDsrHedkj/jMwx3BtDmlbE1c7AceEhIwO2eCA2YZ1e3UWrhFDPA19r5ZN6wlrWkBujnC
	2OPxoS2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmH3-00000008LEn-1PTD;
	Thu, 30 May 2024 20:21:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmH1-00000008LE6-3Wax
	for linux-um@bombadil.infradead.org;
	Thu, 30 May 2024 20:21:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9DNYu25PsP7kPSgGts/yb+luWRPbPj48AdRNc25boMg=; b=Hp4lnncAb+Y7qAWyMQC8y9C3cL
	1NE/tUm4Y+Bo0u5NH1N7c/K1DmobVe+Xgy/2Pw+5tNH/vf0JVZy0rJDldTrmytERkfOR1brelldAV
	t47mdAehl7tkopV60hxaOakAJILKD5HLz2LniSl1Oap+ePGfnVll1h/T8FdvPyBDJBPzbj2fS2OOs
	skaFYUvb2LMTzTFheYdUlwRyyLKDA/JBkBxzu6/igLRf5TI41ELdqED1RMhgiXVRrAY3lYj5eRxjQ
	2/wRD+VjLyaGbwKPy5S72ZGpy00eIx7PL5XGrcRMC/kliJlSbk0P7aZpt+oR6+mjrWYh3Ots1Trmr
	44w3qShg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmGz-0000000B8LI-3CbL;
	Thu, 30 May 2024 20:21:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH 07/16] hostfs: Convert hostfs_read_folio() to use a folio
Date: Thu, 30 May 2024 21:20:59 +0100
Message-ID: <20240530202110.2653630-8-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
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

Remove the use of page APIs, including setting/clearing the error flag
which is never checked on hostfs folios.  This does not include support
for large folios as kmap_local_folio() maps only one page at a time.

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hostfs/hostfs_kern.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index a73d27c4dd58..e7c72f2634f6 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -432,31 +432,20 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 
 static int hostfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
 	char *buffer;
-	loff_t start = page_offset(page);
+	loff_t start = folio_pos(folio);
 	int bytes_read, ret = 0;
 
-	buffer = kmap_local_page(page);
+	buffer = kmap_local_folio(folio, 0);
 	bytes_read = read_file(FILE_HOSTFS_I(file)->fd, &start, buffer,
 			PAGE_SIZE);
-	if (bytes_read < 0) {
-		ClearPageUptodate(page);
-		SetPageError(page);
+	if (bytes_read < 0)
 		ret = bytes_read;
-		goto out;
-	}
-
-	memset(buffer + bytes_read, 0, PAGE_SIZE - bytes_read);
-
-	ClearPageError(page);
-	SetPageUptodate(page);
-
- out:
-	flush_dcache_page(page);
+	else
+		buffer = folio_zero_tail(folio, bytes_read, buffer);
 	kunmap_local(buffer);
-	unlock_page(page);
 
+	folio_end_read(folio, ret == 0);
 	return ret;
 }
 
-- 
2.43.0


