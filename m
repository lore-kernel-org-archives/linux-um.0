Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA201CFD316
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kg9B8PQ0+lOyKlgoz+gQ2Jyp4iAe3qYLBwLYXFt7qs0=; b=AxznXuaGb21z64a2tF48Eo33ih
	he4aYYzwBf3GcVNRj+KChsTlibHjY+uK5hfCvn1mkNsg4TsuMxs1g4NdYt+Nx/NfIliWxb0Ic9ciO
	j9pDNCU5CP4UoTSF0WI/fkEYRvRZJWZ10ePCzSnYYQh8YuDAmb3cieBJPQLqI6nkI32UZoLQmcing
	5al5kCIT0u6Gva9CJ9qiccYKg4ztIlfDuqtoorbyDVXLLX7T1ToMUT8XGJ095FqWaRbKucefY/Fys
	mGb8VT6b2B7+86JfZp3dVbBq5aIavqoBFP/INb5jmf/9/Nb7zZEd6A/kXQUncINNjsfS6+0Y2VFYe
	+XR1Xy3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szBoB-0000000FoBt-2Jkt;
	Fri, 11 Oct 2024 09:19:39 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szBnU-0000000Fnv6-3Xgm
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 09:19:06 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728638334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kg9B8PQ0+lOyKlgoz+gQ2Jyp4iAe3qYLBwLYXFt7qs0=;
	b=Azdsz7gpKjh7+LH3mmcClME+4j4GCUx//ySNzUyPGieMaTYeqheWB33EJDWCkOeeBClFDm
	8mOtiBEbKplTI0DloFBIinFll7YGD9/dT0Q9M5pulKs2dnG78hi0QmLb1fMYubVEtZGRJT
	gGgOD9fbCSAcjGXVCOyHHfbo09Dk5ovcf0hYSa3sVWeuqp4qK5+jhqeyLp8Vt0jnjJ5bwM
	TMfPzOKaxy8w3jZ/aEzgXRqRDblylw6SFQpvBnPfFfI5fDepGyjV6LAIf0x6JXFq1cQe1M
	OPkpTYJKswVzifW6e6QqjabKbojAtbjwJKTo1xb+Z+DQUFypYwwmgPY3Qt2uhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728638334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kg9B8PQ0+lOyKlgoz+gQ2Jyp4iAe3qYLBwLYXFt7qs0=;
	b=YQaX3Xlru3m2t43QFH8dxz9o9eqAXcWc9oghCmk2YfnucKpAh7+poULkH5OfFCtT9vyvzz
	VDKp96rMH+UNZwDg==
Date: Fri, 11 Oct 2024 11:18:27 +0200
Subject: [PATCH 3/3] sparc: vdso: Always reject undefined references in
 during linking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-vdso-checkundef-v1-3-1a46e0352d20@linutronix.de>
References: <20241011-vdso-checkundef-v1-0-1a46e0352d20@linutronix.de>
In-Reply-To: <20241011-vdso-checkundef-v1-0-1a46e0352d20@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728638330; l=1993;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=t1AATzKotfQo47rXCJvuPRI3mhX3sXVhtvZQtdB1CqY=;
 b=Eek2fn25N6T9f+HSgVJC+e6+MNtLYV0HzJLw9/OPZ6RC3lZPRES2yGQNKYH1dSHp0sTu22Efm
 FMeeW9L9LMaAoXuDSKNNdJyDRYrCSWkAh0TVYmUhGvPBbu7ddYKiO8y
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_021857_137947_BE55E46F 
X-CRM114-Status: UNSURE (   8.19  )
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

Instead of using a custom script to detect and fail on undefined
references, use --no-undefined for all VDSO linker invocations.

Drop the now unused checkundef.sh script.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/Makefile      |  7 +++----
 arch/sparc/vdso/checkundef.sh | 10 ----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 243dbfc4609d804fc221c3591eebe891107ffdab..c7697884975ea09ccb9bda1e42d2f9f09f23fc49 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -22,7 +22,7 @@ targets += $(foreach x, 32 64, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg)
 
 CPPFLAGS_vdso.lds += -P -C
 
-VDSO_LDFLAGS_vdso.lds = -m elf64_sparc -soname linux-vdso.so.1 --no-undefined \
+VDSO_LDFLAGS_vdso.lds = -m elf64_sparc -soname linux-vdso.so.1 \
 			-z max-page-size=8192
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
@@ -101,7 +101,6 @@ $(obj)/vdso32.so.dbg: FORCE \
 quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(LD) -nostdlib -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
-		sh $(src)/checkundef.sh '$(OBJDUMP)' '$@'
+		       -T $(filter %.lds,$^) $(filter %.o,$^)
 
-VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic
+VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic --no-undefined
diff --git a/arch/sparc/vdso/checkundef.sh b/arch/sparc/vdso/checkundef.sh
deleted file mode 100644
index 2d85876ffc32519ab8a0702917fedd31293cd9da..0000000000000000000000000000000000000000
--- a/arch/sparc/vdso/checkundef.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-objdump="$1"
-file="$2"
-$objdump -t "$file" | grep '*UUND*' | grep -v '#scratch' > /dev/null 2>&1
-if [ $? -eq 1 ]; then
-    exit 0
-else
-    echo "$file: undefined symbols found" >&2
-    exit 1
-fi

-- 
2.47.0


