Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF86CCD1BF
	for <linux-um@archiver.kernel.org>; Tue, 28 Oct 2025 09:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AHYEc+7bFZ9SQ8uNEgo4nVYWQFf8fTUlITvRCThhJdI=; b=qi8VAdabiF7algxrS9xB4WPsHa
	chNbfN8i+0NBTpQiK+dI33SVTrlO8Xcwm7o44UEU2HsnEsf7NQRnvikKC6aA4bJDf6MliBmE2vH+j
	kn8M7ByGbxNCdNI5zugRzFvst7DefvocHngSPtU349GfFn+UugN3LCLFmJ8DX+kLCueXrEDrxF+jk
	WrNRi31+FVvvIkfLO4pwrKsVHkYHp0Et1EzaEurDmN4B4Qm1wQmfLoZW0JxpmyOJz5JMPwsdWyMKk
	IJ4NTKJaDDEUKQU6TlRe7sg7eic+uZZ+TLbzJU/uhQXE8y8ctK+C+NmqBsi/vTHntcLl3tpKDfa+n
	J+aGEBTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpb-0000000Fd7y-30y1;
	Tue, 28 Oct 2025 09:17:31 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfpV-0000000Fd16-2sta
	for linux-um@lists.infradead.org;
	Tue, 28 Oct 2025 09:17:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761643039;
	bh=CxIHi84E4Pt5K6l2BuyDuvOD5HSJpAj9jMAXhBrWhPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KWo7sg0HDLVwuJxbMVa0QVJzurgJIyDK1zw+ebn5phBhr3C7MAG7cMyz7E3fh1y4e
	 avOz7YrsLk6fYH4IO4FdkTI/iNgikB3bVS59fqSLrIm96xlRBup9wuuqLoQcjwrxJc
	 lbH0wPaZH2bjA7cpHu677LiCQ4taEjaAg3HuaoXc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:15:43 +0100
Subject: [PATCH 08/10] um: Remove __access_ok_vsyscall()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-remove-32bit-pseudo-vdso-v1-8-e930063eff5f@weissschuh.net>
References: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
In-Reply-To: <20251028-uml-remove-32bit-pseudo-vdso-v1-0-e930063eff5f@weissschuh.net>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761643036; l=1320;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CxIHi84E4Pt5K6l2BuyDuvOD5HSJpAj9jMAXhBrWhPI=;
 b=indsseQNY5fyzet23byGMfRz3iZPxGotar2HG8qPmnBRDzv8C40nHyUQRT0Da3oxy3nlZoEEs
 qs0pIYidKlJBq6P+Kh9ASIbrA6/scKN4tp4chTLKNoVkGLy5/Xl70ij
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_021725_957677_3FC8E02C 
X-CRM114-Status: UNSURE (   7.48  )
X-CRM114-Notice: Please train this message.
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

FIXADDR_USER_START and FIXADDR_USER_END are now always zero.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/include/asm/uaccess.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 3770bdeee100..0df9ea4abda8 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -15,10 +15,6 @@
 	(((unsigned long) (addr) < TASK_SIZE) && \
 	 (((unsigned long) (addr) + (size)) < TASK_SIZE))
 
-#define __access_ok_vsyscall(addr, size) \
-	  (((unsigned long) (addr) >= FIXADDR_USER_START) && \
-	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END))
-
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
 
@@ -39,9 +35,7 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
 static inline int __access_ok(const void __user *ptr, unsigned long size)
 {
 	unsigned long addr = (unsigned long)ptr;
-	return __addr_range_nowrap(addr, size) &&
-		(__under_task_size(addr, size) ||
-		 __access_ok_vsyscall(addr, size));
+	return __addr_range_nowrap(addr, size) && __under_task_size(addr, size);
 }
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\

-- 
2.51.1.dirty


