Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA7ECA0EDA
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 05:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3NxCSEvj2PqT9z+zh43cxWZPZy/pc7lSYDl/HSYdpX0=; b=gGBoVPE1pRdW3YXbRCeDCk9QxM
	3nobcikxOCpM5pwCQF+O3jkoqUFy/1M31KmDe8oAXy7/AD8IfUkyXxAq+VEbc2qrKIsY4wqi3HBls
	JYqu+uJW30MFnnti2h9jqF5LoomlAO5Sjvzi4hmRiJhW5bNmm/7qPFd9jFAWxtmW32OoUt48n9iXM
	C28fFaJJ17/+/q8zOkGnV+Ld0CcrUZQ0aa5Fq1evHzZM3eU+CriBLKgEIRTkCZdlO2gYoZPsEV5oX
	/H1t5Ui+e+VaqmSlWL8tGUGxG62EmJvzPpz+Kgw47lkqopg/YoCGyz1R56HTctUGCObifRhrEB8xd
	h6RtpMPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoc-00000009v6S-1saE;
	Tue, 12 Aug 2025 05:44:54 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoI-00000009ui6-2iqT;
	Tue, 12 Aug 2025 05:44:36 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3NxCSEvj2PqT9z+zh43cxWZPZy/pc7lSYDl/HSYdpX0=;
	b=OzPn4l9bPnlKixJ4UTB4AhAiLkjej71xwPtqSacSd+DsXZttorULyXy0fBr+6XMEYsbpyX
	pktj9XCWQ8ee9sbQ7TYV8xKn9kXKt4m2MmDnVX9oK64iccISEQVpCVAjKsf5kfo2Y4wKUi
	D/gtoJVpdPcUWflVbX6Hs6iChwze2AWD5Nd6p9SmoIAq7Qmyf8+MGJgz+NTXtkznsfMX+o
	j3OCtHeIk3g8dw8i98Qx5qdXUibd3WkJPpTCzYYDMYJG02MGifnkCYLytDJNMiDCMFGFIu
	8/+eeYubofn5+rAsSCT5GEPgNyX67Wj5B38v0AvV+ZRmEt8rhZK2/TA3OnjrCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3NxCSEvj2PqT9z+zh43cxWZPZy/pc7lSYDl/HSYdpX0=;
	b=pafKDyE9bffqSWjpfAcol5Guig2fgcH1bW+oS2Qi1sEvJ6rykUviC/BNs2xCa8jswWQoAY
	SQ7jPA+bZKqPUaBg==
Date: Tue, 12 Aug 2025 07:44:16 +0200
Subject: [PATCH v4 03/24] ARM: elf: Move relocation constants to UAPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-absolute-reloc-v4-3-61a8b615e5ec@linutronix.de>
References: <20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de>
In-Reply-To: <20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-mm@kvack.org, linux-um@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977469; l=3153;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jOcL1seJLYtGvYImS8V7KrNCGiyauUm9m0luaNV+25o=;
 b=2ZpJfDEg6FCwuTFwU3Nv++0bd6D+4hY16G/VIAHUE+ed4/E2i08I8MElZpFB/ZPj/iol+ibfT
 +7b+Uoz0sN9CIxjr9xcNzEwxHV7UcmSg7w4o2Gs4g4sQ4acRe/ztk9b
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_224434_978085_9B05117A 
X-CRM114-Status: GOOD (  12.56  )
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

These constants are useful for cross-platform userspace, for example to
process ELF files during kernel cross-compilation.

Move them from the kernel-private architecture-specific header to the UAPI.

One arm64 header is also changed as it duplicates an arm definition.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/include/asm/elf.h   | 24 ------------------------
 arch/arm64/include/asm/elf.h |  1 -
 include/uapi/linux/elf-r.h   | 25 +++++++++++++++++++++++++
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index 9f21e170320fc57f1dc21a33d637bcfd3d1d3917..ec2d416baa9f7ef4b860c4a18b2e2bf2f05e4a9d 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -47,30 +47,6 @@ typedef struct user_fp elf_fpregset_t;
 #define EF_ARM_HASENTRY		0x00000002	/* All */
 #define EF_ARM_RELEXEC		0x00000001	/* All */
 
-#define R_ARM_NONE		0
-#define R_ARM_PC24		1
-#define R_ARM_ABS32		2
-#define R_ARM_REL32		3
-#define R_ARM_CALL		28
-#define R_ARM_JUMP24		29
-#define R_ARM_TARGET1		38
-#define R_ARM_V4BX		40
-#define R_ARM_PREL31		42
-#define R_ARM_MOVW_ABS_NC	43
-#define R_ARM_MOVT_ABS		44
-#define R_ARM_MOVW_PREL_NC	45
-#define R_ARM_MOVT_PREL		46
-#define R_ARM_ALU_PC_G0_NC	57
-#define R_ARM_ALU_PC_G1_NC	59
-#define R_ARM_LDR_PC_G2		63
-
-#define R_ARM_THM_CALL		10
-#define R_ARM_THM_JUMP24	30
-#define R_ARM_THM_MOVW_ABS_NC	47
-#define R_ARM_THM_MOVT_ABS	48
-#define R_ARM_THM_MOVW_PREL_NC	49
-#define R_ARM_THM_MOVT_PREL	50
-
 /*
  * These are used to set parameters in the core dumps.
  */
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 3f93f4eef9530a7b5bc966bf4a16d83093a016ee..8efcfe7efe0c70c59b9b81f93ac9c1442bc7656a 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -18,7 +18,6 @@
  */
 
 /* Miscellaneous. */
-#define R_ARM_NONE			0
 #define R_AARCH64_NONE			256
 
 /* Data. */
diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 45a160ecf40570f3ac916344be363d7e74908ea6..001884641e7703146f91e2dd96fb5a2bbfc7a324 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -36,4 +36,29 @@
 #define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
 #define R_X86_64_PC64		24	/* Place relative 64-bit signed */
 
+/* arm relocation types */
+#define R_ARM_NONE		0
+#define R_ARM_PC24		1
+#define R_ARM_ABS32		2
+#define R_ARM_REL32		3
+#define R_ARM_CALL		28
+#define R_ARM_JUMP24		29
+#define R_ARM_TARGET1		38
+#define R_ARM_V4BX		40
+#define R_ARM_PREL31		42
+#define R_ARM_MOVW_ABS_NC	43
+#define R_ARM_MOVT_ABS		44
+#define R_ARM_MOVW_PREL_NC	45
+#define R_ARM_MOVT_PREL		46
+#define R_ARM_ALU_PC_G0_NC	57
+#define R_ARM_ALU_PC_G1_NC	59
+#define R_ARM_LDR_PC_G2		63
+
+#define R_ARM_THM_CALL		10
+#define R_ARM_THM_JUMP24	30
+#define R_ARM_THM_MOVW_ABS_NC	47
+#define R_ARM_THM_MOVT_ABS	48
+#define R_ARM_THM_MOVW_PREL_NC	49
+#define R_ARM_THM_MOVT_PREL	50
+
 #endif /* _UAPI_LINUX_ELF_R_H */

-- 
2.50.1


