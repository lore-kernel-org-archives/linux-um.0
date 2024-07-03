Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB73C3DA40
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 15:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=frONFhB+5TrylNa1+J9QPPMf9J+LSyLNMObbXG2XPdU=; b=VtQPbLj29R5F03OYqwscOQp/B7
	w20QPJ4YKcx0upyH8aGzTcrqgVXOu8VMmeaGzdZNaO2cTzxMZgFtNi3mdGZ0szyFM4cI0afZ5JONe
	hhCDoqXR9rWYwD7gjhOoAxZOMyS3G3vEhBSO/jQpu6iCwArXm9B/eGXVDu0g7PSldoMSc8gFvaxbF
	g0HMcv+qe5MQvTXROQ+KDiPAh4Ea9gr+q79Ink4o6rTxfNiO6hW9M/b1PhP1y0xWZfZjHR6WqkaUA
	Ix0PjB5bqOdMd6eM5Vs+MiuiBN4Wwkv9jnTyJ/ErqgqnQFnqgpCxuKtlWwAnDRBMq0we+S/Sy0tRz
	AAq6v1lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1TV-0000000AacT-2bzI;
	Wed, 03 Jul 2024 15:00:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JU-0000000ALIj-16SS
	for linux-um@bombadil.infradead.org;
	Wed, 03 Jul 2024 13:46:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=frONFhB+5TrylNa1+J9QPPMf9J+LSyLNMObbXG2XPdU=; b=H0t+t/tT8vgUFEQKfKM/Jyo4Kx
	SBo9qxdnvTaRZQeBp2kulEC+1cbOCLm1ZrcqqOpDud3HteRkM5DgR2X01H6q14SLEdzzAEH3hpATB
	nvmv9PJz+sxReZ1zAfzENjwkwu2NVddQJntetrNY01FfxOAgMaho/QLZr/AI2GqJLFK8q2h9kYbQU
	WPL1daU26t6rvXPwdicxluhyxKubFk6P1r+Qlwlw05KIllnaEUnvnz6KPqKmIEPZS1yHs9KFbYa/f
	Opr4hWmohpCAoChttuf0EslcSWvDzAWLaHr88AeoCE+m6F/CHA+IVsyjdjmQ0isLSzEs3Qk+eoWpN
	oqt731KA==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0JQ-0000000A1HY-3Z3L
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 13:46:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=frONFhB+5TrylNa1+J9QPPMf9J+LSyLNMObbXG2XPdU=;
	t=1720014380; x=1721223980; b=jxALtmlvKZ7YgjudC0XmxjJ/STax+3D/ucBlZO/sc2IUGV4
	GdyUEiP+MSXFB9xlvK2x/Uw/pYxLz2EqReWgG8kmaU5to5FjP+V5Db3pnL1XzI2m4Zyx0W+7PxPeM
	yMKPlooDqvxhwKHKfEyTBIMnkady/+3XTSwyiCN1Rvl3HSFRk63bvjaK2LDPMeX0lPDaqrmpulKE1
	s530ZwXOEhau5hDX5Bsc0DPB6PXuxQPNZaLCSEj4+rvCKVycauyw5Fr1wkq1pBeq0Wzh3Wht1qk8t
	X9CYi+C7BvgBJK1IdQzBi+utEqD3qKSWqC5dfeaqTjIhNgTsbWobmludqIciR4FQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sP0JN-000000094nb-2odJ;
	Wed, 03 Jul 2024 15:46:18 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v4 05/12] um: compress memory related stub syscalls while adding them
Date: Wed,  3 Jul 2024 15:45:29 +0200
Message-ID: <20240703134536.1161108-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703134536.1161108-1-benjamin@sipsolutions.net>
References: <20240703134536.1161108-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_144621_196899_BBA145E7 
X-CRM114-Status: GOOD (  12.71  )
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
index 40be9085f65b..32c61189110c 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -151,12 +151,37 @@ struct stub_syscall *syscall_stub_alloc(struct mm_id *mm_idp)
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
@@ -170,6 +195,13 @@ void unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long len)
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
@@ -181,6 +213,13 @@ void protect(struct mm_id *mm_idp, unsigned long addr, unsigned long len,
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
2.45.2


