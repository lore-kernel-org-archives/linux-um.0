Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B8DCFD30C
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WofKWQfIubfeHKDL8Z7mLX9FYWEFQjb7A3Rqqw9UA/8=; b=a4ekDtha60lhK44E5EJgRJNq2W
	MR5LlSxkjZrQCV1bsnYxcN+l7cZR+gtGgvx/bkwhJvig1l5MdMUngrPItg4dTtAYXJsydEkHFRwu+
	gDNnBVchIziD5WjtvU0RE62VnqMb+G0XQ/ZxjDjP1Q17oOJLNojGCgLc7KZ3THwj2eRYRdMazhnkw
	hDfR1J/VEqmHxaHHZdm1NzRZghXwdk0jIqCHqVExMwdsBZkKxo8HsNLCHdyvNY4cIjYefY0hztxtc
	p2lZfs+pxv8nES9fQeIMWqNrsVzoAdJ+4Lzp3x7ulT5ewTuweqUHHj4OAkcpIrzNYeH+Jbm6rBYZ+
	KRiWnWbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szBoA-0000000FoAo-11aY;
	Fri, 11 Oct 2024 09:19:38 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szBnU-0000000Fnut-1NrF
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 09:19:01 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728638332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WofKWQfIubfeHKDL8Z7mLX9FYWEFQjb7A3Rqqw9UA/8=;
	b=pMItqUBA1FGTHUAJGwjQLn8u28ELmvCCdkFJp61+T44IQEHQy66+ju6NrDUBJuj5paWP44
	DDlqLPIjTe3ZR/YONfALP5fDqWR30q+BWI6oPxvifwN/K1EnqauT7SJ/Wzwos6LCdH3J93
	dUJSpqzQpBYWDbgyLMQwbxhV80N8NqA63cnwzTeMOjoZPC/8RHBbxmbnnp+2nl0GVN0A7W
	AmSHIhIaVy/+MwcvHjJwVq6/C/iefgkWzROQhiVwLTjotScE4f7CEE2XGLkCDX+5gBaGOl
	Ewb6fz46k4VD8RM0BZYlR9Oseo89C2IEEr6+1c9GvtL/3mYDBDjK1dopCiz9MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728638332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WofKWQfIubfeHKDL8Z7mLX9FYWEFQjb7A3Rqqw9UA/8=;
	b=HoF1+6rtA7cY8FPUyY2ENIq3BU8v1ZjnYJVrIo3MatrHGR4E19nKDGVeWzMY0exIp1C2fT
	UCYWjl88JJqu3jAg==
Date: Fri, 11 Oct 2024 11:18:25 +0200
Subject: [PATCH 1/3] x86: vdso: Always reject undefined references in
 during linking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-vdso-checkundef-v1-1-1a46e0352d20@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728638330; l=2103;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8graJ88b/1tuzP7zyilPImJgtI4+2y3oe5+fECRuaC4=;
 b=QbuErtNhAAXbGdrRJr2jxflgPuO9hwjLb0cgTtUeTw+X0nZP2svxJLWcPCHmCWk1cJA1jKJ/P
 /VPOOwcIsHfAUDmveF3GaogL7lYf0UB7b3T4G7lZ5MxpZ4eetTYT+JB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_021856_572668_69096835 
X-CRM114-Status: UNSURE (   7.67  )
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
 arch/x86/entry/vdso/Makefile      |  7 +++----
 arch/x86/entry/vdso/checkundef.sh | 10 ----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac4fb1eb8c1e5bc5e33b41e9e40c7924cbf..99de18d88bc39f8f83f35e554028efd0a76fccec 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -32,7 +32,7 @@ targets += $(foreach x, 64 x32 32, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg
 
 CPPFLAGS_vdso.lds += -P -C
 
-VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
+VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 \
 			-z max-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
@@ -151,10 +151,9 @@ $(obj)/vdso32.so.dbg: $(obj)/vdso32/vdso32.lds $(vobjs32) FORCE
 quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(LD) -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
-		 sh $(src)/checkundef.sh '$(NM)' '$@'
+		       -T $(filter %.lds,$^) $(filter %.o,$^)
 
-VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 \
+VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 --no-undefined \
 	$(call ld-option, --eh-frame-hdr) -Bsymbolic -z noexecstack
 
 quiet_cmd_vdso_and_check = VDSO    $@
diff --git a/arch/x86/entry/vdso/checkundef.sh b/arch/x86/entry/vdso/checkundef.sh
deleted file mode 100755
index 7ee90a9b549da32c9c12d694215b89d08645574c..0000000000000000000000000000000000000000
--- a/arch/x86/entry/vdso/checkundef.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-nm="$1"
-file="$2"
-$nm "$file" | grep '^ *U' > /dev/null 2>&1
-if [ $? -eq 1 ]; then
-    exit 0
-else
-    echo "$file: undefined symbols found" >&2
-    exit 1
-fi

-- 
2.47.0


