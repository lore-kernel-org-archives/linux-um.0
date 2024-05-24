Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA634C25B79
	for <linux-um@archiver.kernel.org>; Fri, 24 May 2024 21:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ZPmVD8hRlsUfNUltjrpVc+YttxM3i3TuDGLxLKmd88=; b=QiCv7+wU4MKx6JGf5CCOkM+1Wq
	DwFRfCWhP6LWD3u1y6ArbQdrKMZzIXK3WiOSKU/RYCXJfjzwIWz+J71zKgFgb35ngtuGzGnxlwASC
	ipn/JP8nhuJBRRzCbJV6Xhz/kt6GS0cCqys2s/XVPwl3kAM4qOk2sWx5rDSbfORIrQH0xE6IAqtBY
	wxXEQwcHS561lOtr3o0qBSHF/pNapfX0s9gPF+T/O76eZavyTXV/e6EYGUQssxURw3xp1OqXxF7Yp
	E5L+JKnq6f6pJK02O/EGq6IgkRebS3TeuKwr5b/qI2FIzg9PF4vA1rFmpoYLFUkHSesStDFcwedqh
	bcfYOKAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcf5-00000009wdQ-1UhF;
	Fri, 24 May 2024 21:41:15 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcf2-00000009wad-1mIV
	for linux-um@lists.infradead.org;
	Fri, 24 May 2024 21:41:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8ZPmVD8hRlsUfNUltjrpVc+YttxM3i3TuDGLxLKmd88=;
	t=1716586872; x=1717796472; b=nfdwTAXLi23hNht68l/xEeBLdkyZ3yCqy4m2kQuWrhPneKR
	zU8sx1oPzOUQuHh2O+t9vaN39Mf5HZhSAeMWj0QHRqtPO97JPaUcLURgl87ni9sLfeONywtpa06B/
	T2hoRWf0m61713HXsQbOzp7InL52rfXMg/gcP0iZRrRWZnuB6AUW0GUZcH2EpF1EXbJlSHN43cfaN
	H/KBiFnjMyqaOODj00y1dSrjZTxd4Z/hIlpIpQqXdNLsWa+jAT9XX4d02yQQFgG9RDxvMeylQbTb+
	bPOLrjvvLdRZCmZ2GYYWOzvfZYWzrP8sd7Y1ypvXnJjCSLxAYy8+0ywR4mOp/ubw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sAcez-00000008ke7-46fm;
	Fri, 24 May 2024 23:41:10 +0200
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 05/12] um: compress memory related stub syscalls while adding them
Date: Fri, 24 May 2024 23:37:11 +0200
Message-ID: <20240524213718.1757703-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524213718.1757703-1-benjamin@sipsolutions.net>
References: <20240524213718.1757703-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_144112_494087_404FF691 
X-CRM114-Status: GOOD (  12.43  )
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
2.45.1


