Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54347CE7A86
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 22:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=niPMJN8pL9cMrhl20oaYMMnLPXDrwF/KzeM5NakJ7Q8=; b=elO34kG92ImXpu
	+NLQ/eUFqegJnq38NpNV0uPB/fdVysw0h0fSLzSGIZeZ6ne2pVUgYBTxV4pblql3vazgpbD4Gm9D/
	bi/VS5sbmRDHqc9Cgt+opEkxhHSqdYacQSdetE03mUPEQV0l748PIgChbBTCUbbt8SGIZ/SzGaYON
	nIU7Z5RkRvlCR9yBrCG2kjJ755GGVeTBPEu8jxyinpu8r0/vTePomDPAluLfwJ4rPvQoeVey6Wd/r
	yorFhnktuZu09wOCBKebQrJLtJlWWv9qVObeXT5QntlKl66COpu+NK5DVFxmwmNWbXnZ8wNloF5Na
	xL88waAObgqwi85rjSfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjoo6-009vXn-12;
	Fri, 22 Sep 2023 22:39:30 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjoo2-009vWI-2Z
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 22:39:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=d15QR+C/cKPE7lUbgEdFsX9RQUItxjtiuUeFnxwv4OE=;
	t=1695422363; x=1696631963; b=LSisxhSqvhU4ISvsuEQsdN61Rubq4poNbbie43LnuNG1OgQ
	hEzzsEizbWCMtluCG8M88n3fj1gyvTKquPjViSlzKwK2X+j7wAAbjTM+pICRUb0+uDtpG7pUOdNQX
	GVyLz8aUtA4oVLJxB0AIdTFgcXnUdT2XA28P34btUgHPrEM2xUMfCgZh7m7t58zIpTvDlN1g/yJon
	5UdsIV9BwwLtMfl1LnzbF0/DIcKZk4u5WzdW15eknfbsgO1+iLx7cZ34eZj1urz7N3rTDYuM1wMb2
	8KxBP0ui8WfoGyggwAjKet0BrM3tDgXdWEU9UvoDyWz8WHOvnrtj7n+lBZegjKpA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjonw-00FtWi-2h;
	Sat, 23 Sep 2023 00:39:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 1/3] um/x86: remove ldt mutex and use mmap lock instead
Date: Sat, 23 Sep 2023 00:37:39 +0200
Message-ID: <20230923003737.97896a6a5213.Ibb36a758aa737a028eea3a73ed8718bf18109b99@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922223737.1206223-4-johannes@sipsolutions.net>
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_153926_884237_198CA2D6 
X-CRM114-Status: GOOD (  14.76  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

There's really not much value in having this as a
separate lock, and having it makes it harder to
clean up the init_new_context() semantics to not
rely on 'current', even if dup_mm() is really only
called with 'current->mm' as the source today.

Replace the locking accordingly with mmap read and
write lock, and remove it from init_new_ldt()
entirely since it already holds the source lock.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/x86/um/asm/mm_context.h |  1 -
 arch/x86/um/ldt.c            | 14 ++++----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/um/asm/mm_context.h b/arch/x86/um/asm/mm_context.h
index dc32dc023c2f..2b1a76a87e14 100644
--- a/arch/x86/um/asm/mm_context.h
+++ b/arch/x86/um/asm/mm_context.h
@@ -25,7 +25,6 @@ struct ldt_entry {
 
 typedef struct uml_ldt {
 	int entry_count;
-	struct mutex lock;
 	union {
 		struct ldt_entry * pages[LDT_PAGES_MAX];
 		struct ldt_entry entries[LDT_DIRECT_ENTRIES];
diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
index 255a44dd415a..6b8e368f779c 100644
--- a/arch/x86/um/ldt.c
+++ b/arch/x86/um/ldt.c
@@ -65,7 +65,7 @@ static int read_ldt(void __user * ptr, unsigned long bytecount)
 		bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
 	err = bytecount;
 
-	mutex_lock(&ldt->lock);
+	mmap_read_lock(current->mm);
 	if (ldt->entry_count <= LDT_DIRECT_ENTRIES) {
 		size = LDT_ENTRY_SIZE*LDT_DIRECT_ENTRIES;
 		if (size > bytecount)
@@ -89,7 +89,7 @@ static int read_ldt(void __user * ptr, unsigned long bytecount)
 			ptr += size;
 		}
 	}
-	mutex_unlock(&ldt->lock);
+	mmap_read_unlock(current->mm);
 
 	if (bytecount == 0 || err == -EFAULT)
 		goto out;
@@ -146,7 +146,7 @@ static int write_ldt(void __user * ptr, unsigned long bytecount, int func)
 			goto out;
 	}
 
-	mutex_lock(&ldt->lock);
+	mmap_write_lock(current->mm);
 
 	err = write_ldt_entry(mm_idp, func, &ldt_info, &addr, 1);
 	if (err)
@@ -201,7 +201,7 @@ static int write_ldt(void __user * ptr, unsigned long bytecount, int func)
 	err = 0;
 
 out_unlock:
-	mutex_unlock(&ldt->lock);
+	mmap_write_unlock(current->mm);
 out:
 	return err;
 }
@@ -305,9 +305,6 @@ long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
 	long page, err=0;
 	void *addr = NULL;
 
-
-	mutex_init(&new_mm->arch.ldt.lock);
-
 	if (!from_mm) {
 		memset(&desc, 0, sizeof(desc));
 		/*
@@ -334,7 +331,6 @@ long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
 	 * i.e., we have to use the stub for modify_ldt, which
 	 * can't handle the big read buffer of up to 64kB.
 	 */
-	mutex_lock(&from_mm->arch.ldt.lock);
 	if (from_mm->arch.ldt.entry_count <= LDT_DIRECT_ENTRIES)
 		memcpy(new_mm->arch.ldt.u.entries, from_mm->arch.ldt.u.entries,
 		       sizeof(new_mm->arch.ldt.u.entries));
@@ -353,8 +349,6 @@ long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
 		}
 	}
 	new_mm->arch.ldt.entry_count = from_mm->arch.ldt.entry_count;
-	mutex_unlock(&from_mm->arch.ldt.lock);
-
     out:
 	return err;
 }
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
