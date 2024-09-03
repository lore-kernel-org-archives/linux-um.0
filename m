Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976D6CD342E
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 13:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6IqllyrUhloeCP1GdDFH00v4luxps/k9E2ikjV5Jdto=; b=w337cYZSuLIoe3MvLmMMYctEFf
	0sNWbBBd0fO9zplsSSUBfKVx65T8ZLzBezm2sKoZEthUNUYNSq/2IQQ1lmKHcHqSXBPlqcjYbLZMG
	xdB5zX/fnWllZhCCB2tk8D4a3vfi7s1LMLRZkYpdx1HQwrvXMZzX/V1bXOotMGSo6UqjeVLMnYT75
	Bezkx1A9ZLc52Ferotzxu+NnGXdkLJXahHKj80rfYsreAPTg2Ma6xbqxydyCR657k9sCwc40+DWy3
	YJbq4ErIQ7Uo69sqCU6MxynnbGkoQsMLnDkeLJtsRADR6t3dNSZ82NyPrc270HTqeXcHdhusbd/Vi
	oyBUR0Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTGT-00000000Iir-1bKV;
	Tue, 03 Sep 2024 13:08:09 +0000
Received: from smtpbgau1.qq.com ([54.206.16.166])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slTGO-00000000Ify-46eR
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 13:08:07 +0000
X-QQ-mid: bizesmtp88t1725368797tvffge9y
X-QQ-Originating-IP: IniwHKqgiTyeNYqQCtQD+YECBJEHxDU1F/TeNYWWD5k=
Received: from localhost.localdomain ( [203.119.160.23])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Sep 2024 21:06:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14936481488341771613
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
Subject: [PATCH 2/2] rust: arch/um: use 'large' code model for uml
Date: Tue,  3 Sep 2024 21:06:06 +0800
Message-ID: <54FC087D02C52990+20240903130606.292935-3-zig@iorw.io>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903130606.292935-1-zig@iorw.io>
References: <20240903130606.292935-1-zig@iorw.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:iorw.io:qybglogicsvrgz:qybglogicsvrgz8a-1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_060805_469449_39B66633 
X-CRM114-Status: UNSURE (   7.10  )
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

The Rust modules compiled against UML should be 'large', without this
the compiler will generate some R_X86_64_32S relocations, but UML is
running at userspace with signed-address larger than zero, therefore
makes '__write_relocate_add' treating the relocation as overflowed.
---
 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index b04b1d4d6dfe..c2a9f2102ba7 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -32,6 +32,7 @@ endif
 
 ifdef CONFIG_64BIT
 	KBUILD_CFLAGS += -mcmodel=large
+	KBUILD_RUSTFLAGS += -Ccode-model=large
 endif
 
 HOST_DIR := arch/$(HEADER_ARCH)
-- 
2.46.0


