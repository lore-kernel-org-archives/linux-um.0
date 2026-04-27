Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1652FF886D
	for <linux-um@archiver.kernel.org>; Mon, 27 Apr 2026 17:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aMiFQ9YDeWWeAvKmml+uHoGAC+wRXXMneJLs8f7ea2c=; b=LYPwDITyBpEw/CrdghSqKbPSI0
	eyy1WLWLs3vB55HdrJD0Rico0Gfs5Mod2OuB3fHcjswb23Z8OGZC0XSamkWk+5eAUrNhq2U8yxE28
	PtGq3MxsR8ouOAl+uSdFupvsIkZKQqxM/jKQO6YgNwEcAbfqc1S83HlbFPPtOTXSTUzspxiPsYeka
	d1gI9bbYirGmAkTZxRBhFcTkSYTJ3dGwpLMRFi75+ngs09QKPPAo+lp4+BzBJzaak8kmk28CH3NUv
	gsYKXgGTYldw8uSmNBbDd00Y0NhIzSHykvbwsFlyiIED+19N+JhYp4aYw41/FZeWa6YDVxNXU1m/J
	TqjyS4SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHPap-0000000HQsG-0jni;
	Mon, 27 Apr 2026 17:17:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHPam-0000000HQpR-3m2B;
	Mon, 27 Apr 2026 17:17:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D6C426024D;
	Mon, 27 Apr 2026 17:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B91DC2BCB9;
	Mon, 27 Apr 2026 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310275;
	bh=W5kkD2qOaf9p6y+JEmiY6YQ2keZoelr0Bif5djAA9uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWIdgH61f3FZjJK5/4M8qA2Z3PdTv2PxzuZWcauBhk9DdVxbBkauIdrH8T66hguCp
	 RKByLYUodinjcBlbYhttuH2LGK1CACi5Chox46drqrLCValqYMs6iS6hvWfa8xjP86
	 SRX8mzMn7HjzzZ5PMWVnIWvrJFLR/iyEIDn4Oi2BFSrDeboqSnIrX7WfhL6Ub+tY2g
	 I0hH+wNzy6c//f0TkDzcuax+fX8WXY8rTh4FJ51XM25PFd/tzjClOdpIOdXk4NjGqA
	 oBIlgUIOAdKFgg5RvdKRR4Lqk1Q+lbng1I1sXXDqtORIX/zFE6g7Yv8vrz97KbzGDV
	 XrdmpG3tF9W3Q==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Yury Norov <ynorov@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fsi@lists.ozlabs.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-x25@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-sound@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [RFC PATCH v1 3/9] x86/umip: Be stricter in fixup_umip_exception()
Date: Mon, 27 Apr 2026 19:13:44 +0200
Message-ID: <9e8e43d4f81d8f8b6f68311f1c6f859d718d36e4.1777306795.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777306795.git.chleroy@kernel.org>
References: <cover.1777306795.git.chleroy@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=chleroy@kernel.org; h=from:subject:message-id; bh=W5kkD2qOaf9p6y+JEmiY6YQ2keZoelr0Bif5djAA9uo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxnda1Jdur5TX+RgO1P4hHufdruHR358Lz3BYPORx G8pRRuZOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBE9kkxMjTtX+zW2RH44ELN UZ/TjtH3Kj+Uzdh01e2y7qEZTgrchx8y/E9kjcpJ3dj/tNZwXUT0XHGmyS9k3dX75mj427u7JaY VMwMA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
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

fixup_umip_exception() calls copy_to_user() and checks whether
the returned value is strictly positive.

A subsequent patch will change the return of copy_to_user() to
return -EFAULT in case of error.

Change the test to checking that the result is not 0.

At the time being copy_to_user() return an unsigned value so
'strictly positive' is the same as 'not 0'.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/x86/kernel/umip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 3ce99cbcf187..dfff28ea1dea 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -409,7 +409,7 @@ bool fixup_umip_exception(struct pt_regs *regs)
 			return false;
 
 		nr_copied = copy_to_user(uaddr, dummy_data, dummy_data_size);
-		if (nr_copied  > 0) {
+		if (nr_copied) {
 			/*
 			 * If copy fails, send a signal and tell caller that
 			 * fault was fixed up.
-- 
2.49.0


