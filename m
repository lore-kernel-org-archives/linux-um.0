Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045E5C4345F
	for <linux-um@archiver.kernel.org>; Sat, 20 Apr 2024 02:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9DNYu25PsP7kPSgGts/yb+luWRPbPj48AdRNc25boMg=; b=Fd1vCzFBecsEgMBN8T7BQFYW7/
	fc0+fMVSzbug6HnUuJShBHULr074VH57cv50QqPHN4Vw+KWYweoi6S4To/f5hfICT/gjWGglVfJ9J
	9jl8kWSgVNTFXlsVtsUb98fPHbtIDX5MCgGL1KjUWrWFrelupvfS+drAPwnIXOJO+m8rMLeXutFwa
	99a+M4jV/cJq+1qVm12kAHH3WZx1e/PimY4fmqyZ2XT2cqjCe8QydmR0hHz7JGbSYKI4DCYrKMV51
	Xw/Z8EcmjPsXHAzKQDc45nQ8SWFPYoGVgF+CvYD6F0ymM1YtGGjtyZURC5uXmeOWXXLwa1nY3PSby
	Y5Ran1dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0of-00000007dVH-0oxh;
	Sat, 20 Apr 2024 02:51:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0od-00000007dV2-3IvU
	for linux-um@bombadil.infradead.org;
	Sat, 20 Apr 2024 02:50:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=9DNYu25PsP7kPSgGts/yb+luWRPbPj48AdRNc25boMg=; b=ubi+VSlCphTsd5AtD9cNNkb+HS
	nB/FMrouSxmA1uW+1Vxn+g98ve7pogJOK8MnjiaX3HIupI/wSrLZ3Sk0vyNgLubyrkD9i5YRmAmeX
	NsaMUr0g4f4Qp3IOBnTR1yCAi1HQ16jImzYPH91cMfTfFN2Z3rvEgIxhmYf6Flk95MtWplsxJaB/J
	ZKW/niTOR7NdHbEKV1qUkEtdncbL91pWCOZPe1fhsLW/K4r3wt5dsHyyRpM0yHuFsCUkk0LnhEXW9
	699fPezQifdLcWOPNiyQ87VmwvgFRoL4cwBVcu6yVn533CSmzwg7CQdJG4o/3xBiCynO8D4/Xeibt
	SPmp2suA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oU-000000095f0-2u7G;
	Sat, 20 Apr 2024 02:50:50 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH 12/30] hostfs: Convert hostfs_read_folio() to use a folio
Date: Sat, 20 Apr 2024 03:50:07 +0100
Message-ID: <20240420025029.2166544-13-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
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


