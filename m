Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF247FF8868
	for <linux-um@archiver.kernel.org>; Mon, 27 Apr 2026 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sOGbn9OoG8rBGqzI2kLVy+02fyWRJuxPwbq3dZ0vyfI=; b=qupMSoKaU0Bjd7i4aHLO6AYyTP
	QTHrFUyi4KngvR3PvoxL90PueiituFMG8NoszyrC9UKl2IqPqUxmMenJOVCSeRkskiB5+Jacx0Vq1
	pAC/wgL2DjdWTe1cD3kpH15aLNRDQqGqr+Mk4YxjjtMdM4so1fvul+6own3bXDEf7iNSSNp9UAbSh
	BMT3LaXhLdgZxaogDr8P+nPyUD5ab1BQqEnWcALCa+vTC9tWDfwYzgfTEQp07EZHye4NNz+VYcg51
	OaL28YUWK4MNrVQ+fAI6l4KfYOdnUH6L88nP/PtXKUYCTpKuINl0giOkEscpZoR+Tz6wRB17FtgFU
	XQLgn50A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHPbC-0000000HR72-2HyC;
	Mon, 27 Apr 2026 17:18:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHPb7-0000000HR41-48rJ;
	Mon, 27 Apr 2026 17:18:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B93C440C2;
	Mon, 27 Apr 2026 17:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C06C2BCF4;
	Mon, 27 Apr 2026 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310297;
	bh=G/2eQ9TI5TAejE5IgsfdvVcfACCawPpecEdM1VXM32k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDwlcHynPBKJgZEQOCWtilxNz5OJTbEC9ImCjJuQT3RnOoZjD4+90hMORF2q1smV0
	 ZZwStmTz2ZWfCFTglmd/E7DTmKQiqUkyq6DoW4QkOcmP8LtfpYhN9V4ZMaLV1xjKUX
	 qf/gxqJdT3gAPMXuYRhHcRDH0KM3YGUgvPXpdKncm5DePPHjb0VOG6buq4s8MreRM+
	 EZo8pRxSQAzQ5kujjD1AkNCv3dgeUm7ZrfC1oOr8cnbPHFYMiYdejiO8B5iigWhrca
	 1OgKQbcauQ7QAB8qeF6Zf8CM71cpuIXWBUm7GSS+m87r+rFbtJTWOdD0Mn8qIs0Vfn
	 3JDYXNLvVgu3g==
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
Subject: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
Date: Mon, 27 Apr 2026 19:13:45 +0200
Message-ID: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777306795.git.chleroy@kernel.org>
References: <cover.1777306795.git.chleroy@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=chleroy@kernel.org; h=from:subject:message-id; bh=G/2eQ9TI5TAejE5IgsfdvVcfACCawPpecEdM1VXM32k=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxmjMKmwhcOl/KmCyQK3t3e2vTXauaOc++38fue5J 1/fnLd3d0cpC4MYF4OsmCLL8f/cu2Z0fUnNn7pLH2YOKxPIEAYuTgGYyD5HRoZnIqUtqi/uzJzx /elrrqTduXsuSM05kFXcMu1CQyFnzPFOhv/RJewtZeu89EsObX+ieXizf2Xo8RNCJwMOumbxCC5 Mr+EBAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_101818_067118_086FD715 
X-CRM114-Status: GOOD (  13.07  )
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

Today there are approximately 3000 calls for copy_to_user() and
3000 calls to copy_from_user().

The majority of callers of copy_{to/from}_user() don't care about the
return value, they only check whether it is 0 or not, and when it is
not 0 they handle it as a -EACCES.

In order to allow better optimisation of copy_{to/from}_user() when
the size of the copy is known at build time, create new fonctions
named copy_{to/from}_user_partial() to be used by the few callers
that are interested in partial copies and need to now how many
bytes remain at the end of the copy.

For the time being it is just the same as copy_{to/from}_user().

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 include/linux/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index bd1201c81d94..2d37173782b3 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -221,6 +221,8 @@ copy_from_user(void *to, const void __user *from, unsigned long n)
 		return _inline_copy_from_user(to, from, n);
 }
 
+#define copy_from_user_partial copy_from_user
+
 static __always_inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
@@ -233,6 +235,8 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
 		return _inline_copy_to_user(to, from, n);
 }
 
+#define copy_to_user_partial copy_to_user
+
 #ifndef copy_mc_to_kernel
 /*
  * Without arch opt-in this generic copy_mc_to_kernel() will not handle
-- 
2.49.0


