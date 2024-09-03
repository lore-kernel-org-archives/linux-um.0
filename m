Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A921CD342E
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o41DO12jTXu7WDSj6qYHXgj2n+M3lXK425LAovfo9x8=; b=M2xaRBQr/3K84p6XX9uMzEjpqE
	4FhRAfPk/uYyJK9ZZ9nc6V2dR+Cz58vSzBmxiZ543iWq8qygN66fQ4SXKT6p14arYndZJ/5b927VN
	tCRfsJ9i9ZSKFNT+sfEz6U2QmnV0Jm03nY0SOhPRuDZEiOw9wbSQd8aeb79m5RZMBkC3cTJy4zQfe
	ydaaWCGBLrqvPOh2ztYS+621YKNC7H02XFnHrdKtecUxk0515cevQcNDf4sme4kcECEHUXAUNPBoe
	CY+54+MLrkpvXRD073zztdZZvwmyWkig2pjQzOv7K0pVpS4puOM1TeaHwVA6XIibahdphU9ZXBKtX
	VR9jBFcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTGW-00000000IkF-3nZA;
	Tue, 03 Sep 2024 13:08:12 +0000
Received: from smtpbg156.qq.com ([15.184.82.18])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTGT-00000000IgH-40dh
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 13:08:11 +0000
X-QQ-mid: bizesmtp88t1725368790tz166xl2
X-QQ-Originating-IP: 5Ox9MZOpB4HGff4JCHX+EhqYhjuTtoZvUONrgWtGZ5o=
Received: from localhost.localdomain ( [203.119.160.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Sep 2024 21:06:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5789562387442949554
From: Zigit Zo <zig@iorw.io>
To: ojeda@kernel.org,
	bjorn3_gh@protonmail.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@linutronix.de,
	mingo@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	gary@garyguo.net
Cc: zig@iorw.io,
	rust-for-linux@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rust: arch/um: use 'static' relocation model for uml modules
Date: Tue,  3 Sep 2024 21:06:05 +0800
Message-ID: <FD7D773099A0C7EC+20240903130606.292935-2-zig@iorw.io>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903130606.292935-1-zig@iorw.io>
References: <20240903130606.292935-1-zig@iorw.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:iorw.io:qybglogicsvrgz:qybglogicsvrgz8a-1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_060810_741124_F3B229CF 
X-CRM114-Status: UNSURE (   9.12  )
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

In the x86_64 UML, kernel modules compiled with Rust will currently
generate some R_X86_64_GOTPCREL relocations, which will then be rejected
by the kernel.

And because of the kernel modules of UML are only got handled by the UML
itself, relocation model 'static' can work as expected other than 'pie'.
---
 arch/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 00b63bac5eff..b04b1d4d6dfe 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -63,7 +63,7 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 	-Din6addr_loopback=kernel_in6addr_loopback \
 	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
 
-KBUILD_RUSTFLAGS += -Crelocation-model=pie
+KBUILD_RUSTFLAGS_KERNEL += -Crelocation-model=pie
 
 KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
-- 
2.46.0


