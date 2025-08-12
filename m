Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAE4CA0EC4
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 06:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ni03bz74C9TDQf0xtR9HdEFVHcT90zf3s/r1yADBwxo=; b=iuSwOnDtjLY2rF+NzygO8jIA0w
	DC81XyXL0+6VgBpxME+9Bgsd6DH9/KfprPikyTqly9LukINi1Ox0J7TlXKcYBA55ruAiNyZbzuT3h
	JEiRQ8TaHMGcZ/IT2RzJcAMS1pHYxFFEa8WoNyLRWj/3ogtam4rb9S8ZY7uGpo1d+WQVQCI2Asr4I
	p0DQv/vL+zS2eMhRGhzqPN2uJGhg4nfpS6LGFJA+JX2TXQTjzqhUaVL3K25CE95NG/AVq3f8uk6RL
	mjPf1d12oYL7NLclP0ibMEPYz4Ac+U6Ts98czBZhvxLZfBjKYJlLjei9pNrfp7a+p38mJkEum5b3U
	zCIosrgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulilj-0000000A3M1-1iyO;
	Tue, 12 Aug 2025 06:45:59 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoW-00000009uyv-0qiY;
	Tue, 12 Aug 2025 05:44:50 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ni03bz74C9TDQf0xtR9HdEFVHcT90zf3s/r1yADBwxo=;
	b=SPOdyyK6sCUtkj6kxjiocTJJSEG7dMI/35DqLKjSrblI5G1I3CyLRTOU0LfTHDu2JQsxDj
	Dn/jh2j77Of16cGzaV4eefriQ+ADhNYDrnKqgGv5HP6LP8Jj0Yq6B+GTYhlGWdGV/jeCNn
	mChLIch4f7Gt0mUAyBg7i3cMLVb5B3npJ47FGQpkuXq4wraN8yU4e5d5OiTfiARGEt3ujO
	rpuqTNdsRVE9m+8DyoboNXYkzVlSxQ7GC9XLTUGVj7Vki1TG78RIYaiJMK8Y+oI+lds+EP
	JvwYSVkZ8fPvF1iauUDwZWuIMZtURfosroN8t78/t6nMmnrxJZEhAzgaCvJYpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ni03bz74C9TDQf0xtR9HdEFVHcT90zf3s/r1yADBwxo=;
	b=G8Q+ixFA4w8D6kq4xigxFt3Cczt1Y9MbywRc7XOy0tz4miHQTBoNTUawPiaFBeSqGu+zKC
	/2FQ+7R2EdhFKXBA==
Date: Tue, 12 Aug 2025 07:44:28 +0200
Subject: [PATCH v4 15/24] powerpc/elf: Add 32-bit REL16 relocation
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-absolute-reloc-v4-15-61a8b615e5ec@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977469; l=1849;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cTNg9TGsRxWfNuFVqiM2JjMT3BPMQJuifoiqKo4ezxg=;
 b=fTu+sca8EPLbAnEFtmDEkVGkzUGCf6ruToGNTg0scH5R7xB2jsm5rnvfxHsx+1Bkd74GG38mD
 NfkpwBlsVukCHjftZxM7DWULKfpV77bu2ffXVoITzAdYLtHpJEl0ViT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_224448_873846_52A037D9 
X-CRM114-Status: GOOD (  11.06  )
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

These are used by userspace and are necessary for the vdsocheck tool.
They share the numbers with their 64-bit variants.

Also update the copy in tools/ so they can be used by vdsocheck.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/uapi/linux/elf-r.h       | 7 ++++++-
 tools/include/uapi/linux/elf-r.h | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/elf-r.h b/include/uapi/linux/elf-r.h
index 78085d26f4ab27a003fde65c8e981f575f411758..e750989e44e8f517d7dacf9d3a338af7a136e40f 100644
--- a/include/uapi/linux/elf-r.h
+++ b/include/uapi/linux/elf-r.h
@@ -182,8 +182,13 @@
 #define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
 #define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
 
+#define R_PPC_REL16		249
+#define R_PPC_REL16_LO		250
+#define R_PPC_REL16_HI		251
+#define R_PPC_REL16_HA		252
+
 /* keep this the last entry. */
-#define R_PPC_NUM		95
+#define R_PPC_NUM		253
 
 /* PowerPC64 relocations defined by the ABIs */
 #define R_PPC64_NONE    R_PPC_NONE
diff --git a/tools/include/uapi/linux/elf-r.h b/tools/include/uapi/linux/elf-r.h
index 78085d26f4ab27a003fde65c8e981f575f411758..e750989e44e8f517d7dacf9d3a338af7a136e40f 100644
--- a/tools/include/uapi/linux/elf-r.h
+++ b/tools/include/uapi/linux/elf-r.h
@@ -182,8 +182,13 @@
 #define R_PPC_GOT_DTPREL16_HI	93 /* half16*	(sym+add)@got@dtprel@h */
 #define R_PPC_GOT_DTPREL16_HA	94 /* half16*	(sym+add)@got@dtprel@ha */
 
+#define R_PPC_REL16		249
+#define R_PPC_REL16_LO		250
+#define R_PPC_REL16_HI		251
+#define R_PPC_REL16_HA		252
+
 /* keep this the last entry. */
-#define R_PPC_NUM		95
+#define R_PPC_NUM		253
 
 /* PowerPC64 relocations defined by the ABIs */
 #define R_PPC64_NONE    R_PPC_NONE

-- 
2.50.1


