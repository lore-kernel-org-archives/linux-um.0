Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA81CFC51E
	for <linux-um@archiver.kernel.org>; Sat, 22 Nov 2025 08:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tjw8aI/2+6BpvAtWs9pCDpeY2rVZkm/V2EMdU6q1xQI=; b=G4LvKs4WTLcu6/AWhKwz05vf3o
	pXrYvkd6BONbelyKAmFoxf6jLVAmqJGHpVPB8Xl1C3R/yoBPlPJQU1rDToOpf0jYvkrRLFJBd2NDL
	Ha/gfvBOxaQwSuXYMU/acLcrflrmqwVIUXkdM3F8IEY79Mkwx/UqtQ1h12bRK0kP/+vs/tQDZFjh2
	Twhult76pKv1RJB/d3cI0/uHL689pnDkCiubW6TRHBmu6qlc69lzYInoVhWrDor5lP3Os3QVBgUqd
	UJwkYLi1VN7oCT3Uae7lSPV29P6yw3vJ63/OStIh0yz46UCbl8fB8tmbHH2IEjj846/3N7wy7PJv3
	iu7X/mMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMj2a-00000009NiP-35G3;
	Sat, 22 Nov 2025 08:32:20 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMj2Y-00000009Nhu-082F
	for linux-um@lists.infradead.org;
	Sat, 22 Nov 2025 08:32:19 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-34378c914b4so9242547a91.1
        for <linux-um@lists.infradead.org>; Sat, 22 Nov 2025 00:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763800337; x=1764405137; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tjw8aI/2+6BpvAtWs9pCDpeY2rVZkm/V2EMdU6q1xQI=;
        b=EEfsD0yqMtJ3DzUUIF4o2XamfLT2kKVDW3nfTJ0Er268383m5GoMMENLJjYQgCdfcX
         7t4+g1atf1a+RSHE+mls5fMNWeX4YHeLKnmOfsEg+pyTDD90M1UJRovLuAZZH2bSi/NF
         lRtxumwwNSodZkczNgc3imc/Q6jCv1E4V+KBTF6519SZSNfgnVj2fYsnpCnmHiT9fBXB
         FWCRcYitg+UWiBLivCj7S6ng6sbsvUxb5XUOC3KrWEndK6pUfZrZzViJU2H/+7/vrVh+
         j+RclngfJv0LkUfIQ9D++Ff4sDTzW1rsqD+kmCaHbAl+NKfRsudmFv5g2Pd1jg03ifSx
         ZeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763800337; x=1764405137;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjw8aI/2+6BpvAtWs9pCDpeY2rVZkm/V2EMdU6q1xQI=;
        b=gDZtLtxukiY403pf6d/CN8+GZ4/ttGu4KNkTqpvc3FhuhiPlBVQxsqx3js560l47jC
         Gvsi5EjCjkDE3sOzB4bDwHmAbLnvdF3QR7RiFcsbNXBvG+Lg/g2UtfX9266rB+d8GGHf
         I2vMsJenLjvoeoyG/d98xpkkETXwq4wr6k1T4SJZs3ZaeGewMhsQ4RKJC+PXkf9NxEUK
         gH15WvAonWN3ZwuXkXlLAfknVdspkDVc28rPPSB0O41uZTM2OFf1tR8BA2VMO27lkIbP
         6mFbD+BIHk82J2JaiYwHfLlrTC/1u5QcWyk/dI9qC08YTM+wsQY66La9RHLYNIbsdyed
         Np0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCMcRQsxcSdHr7VviGXq0MFbNxaDs24Oi8Lf8YGz0OjjRc+HzVwcyVgzp8TI8TjY25lu4aB/bvtg==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywrvz8RU6o8GkWuXTq5k6J8WlRAb1G7lWbZA7ObTeLbZfjlP+7L
	z7Y1nBJXtVp0sbXiQcoCXvTDtxBDQARu7CDaGvM8gCMCCiHgSJ4O9/3NkHPxpgVM/j77IwZX+hS
	6+hCksrBpTamI8g==
X-Google-Smtp-Source: AGHT+IFpm4WPPdyNkn7T9C5i+DiRgpU+Gw7XnL1ezBCClEJfss/czSHMfxCJTpkY6PfTfg1L3XhRDYgd2jfgZg==
X-Received: from pjbpw1.prod.google.com ([2002:a17:90b:2781:b0:33b:c211:1fa9])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2c86:b0:340:54a1:d6fe with SMTP id 98e67ed59e1d1-34733e60868mr5397018a91.15.1763800336865;
 Sat, 22 Nov 2025 00:32:16 -0800 (PST)
Date: Sat, 22 Nov 2025 16:32:12 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122083213.3996586-1-davidgow@google.com>
Subject: [PATCH] arch: um: Don't rename vmap to kernel_vmap
From: David Gow <davidgow@google.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Miguel Ojeda <ojeda@kernel.org>, 
	"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: David Gow <davidgow@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251122_003218_075056_CA7D3EB0 
X-CRM114-Status: GOOD (  11.07  )
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

In order to work around the existence of a vmap symbol in libpcap, the
UML makefile unconditionally redefines vmap to kernel_vmap. However,
this not only affects the actual vmap symbol, but also anything else
named vmap, including a number of struct members in DRM.

This would not be too much of a problem, since all uses are also
updated, except we now have Rust DRM bindings, which expect the
corresponding Rust structs to have 'vmap' names. Since the redefinition
applies in bindgen, but not to Rust code, we end up with errors such as:

error[E0560]: struct `drm_gem_object_funcs` has no fields named `vmap`
  --> rust/kernel/drm/gem/mod.rs:210:9

Since, as far as I can tell, we no longer actually link to libpcap, it
should be safe to just remove this define unconditionally.

(If it's not, we can possibly either disable DRM Rust bindings under
UML, or move the redefinition of vmap behind some config option.)

We also take this opportunity to update the comment.

Signed-off-by: David Gow <davidgow@google.com>
---
 arch/um/Makefile | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 7be0143b5ba3..721b652ffb65 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -46,19 +46,17 @@ ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS)
 ARCH_INCLUDE	+= -I$(srctree)/$(HOST_DIR)/um/shared
 KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/um
 
-# -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
-# named - it's a common symbol in libpcap, so we get a binary which crashes.
-#
-# Same things for in6addr_loopback and mktime - found in libc. For these two we
-# only get link-time error, luckily.
+# -Dstrrchr=kernel_strrchr (as well as the various in6addr symbols) prevents
+#  anything from referencing
+# libc symbols with the same name, which can cause a linker error.
 #
 # -Dlongjmp=kernel_longjmp prevents anything from referencing the libpthread.a
 # embedded copy of longjmp, same thing for setjmp.
 #
-# These apply to USER_CFLAGS to.
+# These apply to USER_CFLAGS too.
 
 KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
-	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
+	$(ARCH_INCLUDE) $(MODE_INCLUDE)	\
 	-Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
 	-Din6addr_loopback=kernel_in6addr_loopback \
 	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr \
-- 
2.52.0.rc2.455.g230fcf2819-goog


