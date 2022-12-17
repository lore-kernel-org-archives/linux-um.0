Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F715C4167B
	for <linux-um@archiver.kernel.org>; Sat, 17 Dec 2022 04:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yClNy2V/Ks5ivevEBntTzIWnwhfLk3/pbsm0T2ZHOkM=; b=2M0RUbKFs2atVtNpizzCivNd3I
	3pc5jyO9XMILbXcUW2F1zvp7WbxXsgvfJgZVom0sD+WzJkUiN9YUG86yhBas60wOp1t0XC+5G54kj
	Fv5BsBMKXRR8lllcxwWKEqKe3m+YX6YisZfnbhtgVZXRXzpMBye7uNxf8MwSTbQjKgjQJd/+myLjo
	b1WUyGHCj8Bcl5isa4OAI8BHIX2ECAW1ADdwaUh5F/XXrh8RglCry3g4m1BEQJXMcGkJ2mJ8xygso
	se0yLEHpNIqXoNRyNq/SMP/JAOFbeW79V5mm3sK7I6ex+WOAzYBpNtJ8lLBoGc0Yz/CwO1XkCtmaV
	P2fhpvHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6P48-005SiH-IG; Sat, 17 Dec 2022 04:44:52 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6P46-005SgF-0y
	for linux-um@lists.infradead.org; Sat, 17 Dec 2022 04:44:51 +0000
Received: by mail-pg1-x549.google.com with SMTP id r126-20020a632b84000000b004393806c06eso2595959pgr.4
        for <linux-um@lists.infradead.org>; Fri, 16 Dec 2022 20:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCkOLeUT8z9uWy5v5k8t9XGXY+OZQL+wMiMJpjklfMk=;
        b=NkQAhros/6X1C1DqT6opfUL3F1fT6++iMSU6wymnZhCK5ti0wioHiihwyt8oVKB0Nu
         MgUxlCztzY3GF0CsapECuOVpjQzsA/HfxIxj+HUz4spuCfAnTFk1I3TqTawO2XpqG6UU
         56J6gfM57ah6xKmO6caUJfUfZx3tNLKF2KhkvRLvfNvFqMBBsEhHyB3A7TvYLarcLN6P
         fKVvVrpvUkOfhUDpOOzx2dUl5F1s46Ffosa6phFHdnfhYsFDpD/qgpTwV2UOy/FRNJvl
         OQIDtS8w7AaUhUhw5rDfSJQ6xtVHReyzqm5xpHermfANmJjYUhaP8hnhRxrFGiuGYe1a
         ancQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCkOLeUT8z9uWy5v5k8t9XGXY+OZQL+wMiMJpjklfMk=;
        b=q9i3Ja/bp/f3sgJCFjCU9g/u+AyTH5dhLflmVe4Dff8ZEgnUTQMdp8PQ3CaO+jQAx1
         6SRsu/ajm+h9cpz37S3S0hFt4Xm8nKhWpBT7eC507vsJRFhqsvDYNLleac188Y4e16mw
         6wBjs+eIdh9ZkeuenTr8HyOjiSzIX3TijiHKIppFk/+eC8A7Qoan16JNU8gcqnqDNM/i
         Fj9E2OruDs99hzhS/YowC1wEiOe+uX8F5Ul2RDqVv31bl67LqAISdhc/r6G8hWlr3UwR
         jQOqX67tt4ChpB4Z8bMUhgIGMXwMCzD7zLbMmwCkFC5x4bGjeMB2Uq0sVLr3Z3BpTHqD
         8byA==
X-Gm-Message-State: ANoB5pmfylRRa/iDd3LHSlKxrcfLoUwkMB2abx9US8DDAgf19ZqRbTcd
	0/aFodUCmUE+t/8e5bE+K8ar7FH/xyKEOw==
X-Google-Smtp-Source: AA0mqf5WvCHE4FnTVtZCQe/4IUCPwpqYVRfZ0jHUmlZpfPT/x7sGQmkzk8ex0J4cnMv1HrvC8Eo90rNa2kROmQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a62:8342:0:b0:577:8eba:c019 with SMTP id
 h63-20020a628342000000b005778ebac019mr7776687pfe.35.1671252288299; Fri, 16
 Dec 2022 20:44:48 -0800 (PST)
Date: Sat, 17 Dec 2022 12:44:34 +0800
In-Reply-To: <20221217044436.4138642-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221217044436.4138642-2-davidgow@google.com>
Subject: [PATCH 1/3] rust: arch/um: Use 'pie' relocation mode under UML
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Cc: David Gow <davidgow@google.com>, rust-for-linux@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org, 
	kunit-dev@googlegroups.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, 
	Jonathan Corbet <corbet@lwn.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221216_204450_086648_258E293E 
X-CRM114-Status: UNSURE (   7.69  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

UML expects a position independent executable for some reason, so tell
rustc to generate pie objects. Otherwise we get a bunch of relocations
we can't deal with in libcore.

Signed-off-by: David Gow <davidgow@google.com>
---
 arch/um/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index f1d4d67157be..ae321282dc6f 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -68,6 +68,8 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 	-Din6addr_loopback=kernel_in6addr_loopback \
 	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
 
+KBUILD_RUSTFLAGS += -Crelocation-model=pie
+
 KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
-- 
2.39.0.314.g84b9a713c41-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
