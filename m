Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780C6C4345F
	for <linux-um@archiver.kernel.org>; Thu, 18 Apr 2024 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xrN/lXuIrPQinOwq/9LJj22UyygN7itQLwkMND+1p+o=; b=DgDkg9tgQaNNymh1aXmYNW1Hgy
	JHxFzNMoaOFPptyjsq18fmf6JpWvtjNq6uarLwtYoUWYczH2HFwKZEnpvRORqXs0GcEkrPWnl75rL
	Q0N4gxEo+MTX62+B1gW55akD4J8q/9ytzSove7a8nDiUEFuYlw4HNTJIdLWeMX0zzw606+Fmhi7xF
	wHsBFTvS7tQOMgt3Akt5cIg00G1XO9iidVguUwl1z6Fdp0N+o7XmXvzXo0U+jFi05kfjgdv8p3zH1
	OcVgjAhtsBFkAEr/thVghTPlvp2YjnEt58VbBkXhMZ1rRkyIZnOqhMPsvjnsITlD/5HZ317ELg187
	ZUq4a20g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0t-00000001bNG-2zLk;
	Thu, 18 Apr 2024 09:25:03 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxO0m-00000001bFI-33Ry
	for linux-um@lists.infradead.org;
	Thu, 18 Apr 2024 09:24:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xrN/lXuIrPQinOwq/9LJj22UyygN7itQLwkMND+1p+o=;
	t=1713432296; x=1714641896; b=WUGLKXq15gllAY3yzJgAQS/TdrVFrabARonbjP77x+fWE3F
	d5S2sFeGmbWe3ue8A7qAHJGHsA2LeCPy/W4/rTLQwJVKlopsATTMdmlVHwxRRBrK3mLAO9xbuX9k5
	SUoqXgZUqqfgMVHeg/hFjgavBIRjFfkGQhfHkOCZ/N1gzINhQsarFf6G156sitDu1dm1Ls9Yk94R1
	9jE1b+GYl8N2XMfxhFzkWtu0Lyt/3x2UxnVCkFkLkIUEPZIU7BbDt+9z92hBZ8t/8iSeWiG3B2eIm
	rpD7nXPREWj7xmgXIAJJrWptBwNVPtCIMQDNo66MkPsp4FqQdMA7JVN6tOnvXClw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rxO0i-0000000CKXH-44Gd;
	Thu, 18 Apr 2024 11:24:54 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 05/12] um: compress memory related stub syscalls while adding them
Date: Thu, 18 Apr 2024 11:23:20 +0200
Message-ID: <20240418092327.860135-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418092327.860135-1-benjamin@sipsolutions.net>
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_022456_821557_740D6A74 
X-CRM114-Status: GOOD (  12.58  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

To keep the number of syscalls that the stub has to do lower, compress
two consecutive syscalls of the same type if the second is just a
continuation of the first.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/os-Linux/skas/mem.c | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 03c8cde0b89b..e3128e080365 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -152,12 +152,37 @@ struct stub_syscall *syscall_stub_alloc(struct mm_id *mm_idp)
 	return sc;
 }
 
+static struct stub_syscall *syscall_stub_get_previous(struct mm_id *mm_idp,
+						      int syscall_type,
+						      unsigned long virt)
+{
+	if (mm_idp->syscall_data_len > 0) {
+		struct stub_data *proc_data = (void *) mm_idp->stack;
+		struct stub_syscall *sc;
+
+		sc = &proc_data->syscall_data[mm_idp->syscall_data_len - 1];
+
+		if (sc->syscall == syscall_type &&
+		    sc->mem.addr + sc->mem.length == virt)
+			return sc;
+	}
+
+	return NULL;
+}
 
 void map(struct mm_id *mm_idp, unsigned long virt, unsigned long len, int prot,
 	int phys_fd, unsigned long long offset)
 {
 	struct stub_syscall *sc;
 
+	/* Compress with previous syscall if that is possible */
+	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MMAP, virt);
+	if (sc && sc->mem.prot == prot && sc->mem.fd == phys_fd &&
+	    sc->mem.offset == MMAP_OFFSET(offset - sc->mem.length)) {
+		sc->mem.length += len;
+		return;
+	}
+
 	sc = syscall_stub_alloc(mm_idp);
 	sc->syscall = STUB_SYSCALL_MMAP;
 	sc->mem.addr = virt;
@@ -171,6 +196,13 @@ void unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
 {
 	struct stub_syscall *sc;
 
+	/* Compress with previous syscall if that is possible */
+	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MUNMAP, addr);
+	if (sc) {
+		sc->mem.length += len;
+		return;
+	}
+
 	sc = syscall_stub_alloc(mm_idp);
 	sc->syscall = STUB_SYSCALL_MUNMAP;
 	sc->mem.addr = addr;
@@ -182,6 +214,13 @@ void protect(struct mm_id *mm_idp, unsigned long addr, unsigned long len,
 {
 	struct stub_syscall *sc;
 
+	/* Compress with previous syscall if that is possible */
+	sc = syscall_stub_get_previous(mm_idp, STUB_SYSCALL_MPROTECT, addr);
+	if (sc && sc->mem.prot == prot) {
+		sc->mem.length += len;
+		return;
+	}
+
 	sc = syscall_stub_alloc(mm_idp);
 	sc->syscall = STUB_SYSCALL_MPROTECT;
 	sc->mem.addr = addr;
-- 
2.44.0


