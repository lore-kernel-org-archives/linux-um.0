Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539CCC531DF
	for <linux-um@archiver.kernel.org>; Wed, 14 Aug 2024 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ImVhDDZvGKdMvHRXKWtBY7b1k/mxkNbLUAPdKjzQZA4=; b=XJKJEg1Tjjs9CkVYVrICQOqjBK
	etZBpxwdHJwcJylyA0XPDUGiNZGv4I9DARqBPCVktjowDCLhxmPYhampdiYXUhS2K+m3l+YI2yN43
	7DkSeNUMAwv6mHLIx+tXf3IMReA27y837TMIi26/XhTgygWXqgH9ByDuBX4tthzZ0SPlIZ3yuGaW2
	2qPjrEFK0SZ9ghzfg5zvCCezjHid8AuT62dUwB7isQWxZ7ODIzCMJHmseoxFz6YXudneIZqua2JvC
	jtySXjnoFOFAnkA5kV4t6bMYfbeGenmkoXOx/3ztPui6Eyeg0J2ONz61burzpDsXY2xceMtmELsfd
	y/HKR3Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGBH-00000007WGc-421W;
	Wed, 14 Aug 2024 15:44:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAt-00000007W4C-2ilc
	for linux-um@bombadil.infradead.org;
	Wed, 14 Aug 2024 15:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ImVhDDZvGKdMvHRXKWtBY7b1k/mxkNbLUAPdKjzQZA4=; b=vm4v2bc1RJWujLJZeuHTO2tTsQ
	r9TLvhRGZHshO+cnttcm3iLy974IWx6T811ohmQwtnkXjc3sCZkSRvrTVT/gR9nkri6yeC707ghwJ
	Bh1bmjfmYR0tTcecAL4mF+rr6iy3ahkAozOJf1TqTanDkuXZmQXqfPxMOfu2lC3wBDD1Bl2AxnxTi
	tLvueUBRhx2Yljo6YI2vWB60Ha40L4FgOjsz7Ly3zHPmvRBwfRbjAJgWdFcwILeE/J2+nWDSyaOxr
	WowQrt9wNTEQv7Go8sxdc2Qep7gI0w3W6K+x60EZuFdRON7IxbDs6/aVGC1P2klBWA8+azfqVgUVj
	SOSl8zGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGAs-00000000gHd-25s5;
	Wed, 14 Aug 2024 15:44:34 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH 5/5] mm: Make mk_pte() definition unconditional
Date: Wed, 14 Aug 2024 16:44:25 +0100
Message-ID: <20240814154427.162475-6-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814154427.162475-1-willy@infradead.org>
References: <20240814154427.162475-1-willy@infradead.org>
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

All architectures now use the common mk_pte() definition, so we
can remove the condition.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8204ffd87d74..1d46422b79cc 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -41,12 +41,10 @@
 #define FIRST_USER_ADDRESS	0UL
 #endif
 
-#ifndef mk_pte
 static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
 {
 	return pfn_pte(page_to_pfn(page), pgprot);
 }
-#endif
 
 /*
  * This defines the generic helper for accessing PMD page
-- 
2.43.0


