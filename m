Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A66CA0EDE
	for <linux-um@archiver.kernel.org>; Tue, 12 Aug 2025 05:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tKATP4n6UsYsKAR5HymmCjK/vOsSvbOqbAEjaPPKais=; b=Z2OxB6TdZaCidQo5ojvkydKK85
	JzBK0WUabr5SX3z8Tv08iLFc9bkWgZdTqlWSFxOqVj1cgtsgDQcWsu2vqS6r2cBaepMU9Wr+qDEap
	5fzn7wyq2NwuKka+1Vp2HMxsumdlKkUdREksC+GAOTO9m/v3eNVPSaVHkJqhsdGljrZtz+bjrmqEH
	d5awwGHXsQ62lVUBH+zj0+3DzqnJFn25TjQP5J56aRKLWG69SVegcVUxSJjZ/AhLJq11JhEW4rr/v
	YoN8OphTQXPtuKhNmShL54Sdz6RJz9VpwZuOr9XhponZK8YkIIqI7gFjQfO+x9TC2RXVcwh8Cbk3v
	kpYTSlIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhp4-00000009vhc-0pOe;
	Tue, 12 Aug 2025 05:45:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoc-00000009v71-48qM;
	Tue, 12 Aug 2025 05:44:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=tKATP4n6UsYsKAR5HymmCjK/vOsSvbOqbAEjaPPKais=; b=cZGQ/UTansGIS7cyPXiipqu9yF
	1CGr/Rt6cPJIgcaoGslE/EHlrizg+EwtdZoTpiq+1uXYkzZnSVqry9juwvVpwbbuIfYGlhFJQqF2R
	BCRYHNl3nGo8QBhNzXdSC9MxAibPoiBhFCQ6tIsk5LlEp3MaMx+zWFvHaxkpsbWwMVtd4gcT764pl
	uEZHGXYRQeiuNnFA1N8V6SsemtI7/u1W7tBT8abh6iCXxHCsbSP4cn3YSQ6IJhIQuDAdLal9G4tIM
	U9fuaVR7FfoXjuE3xFjIOY+qQz4UmsQDZnWljgI4L0rDcaIhzVosVL9Nf68/PwetnQIWnuJAbBJ99
	QjPcGuvg==;
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulhoY-0000000FgAO-1Irh;
	Tue, 12 Aug 2025 05:44:52 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tKATP4n6UsYsKAR5HymmCjK/vOsSvbOqbAEjaPPKais=;
	b=bex0uDqIIRryXaAvloStzvTEg31Q/TslhPGGgsXrYUJQEuDPVSuExWDJoQ+QwFi7lf0yAO
	URQMEz948bdEqfzWNykOMmx0N0qCkowwyqQ/XW+cqX/t8XUfB3+thiAImpgwWl735nhTDn
	MbXfvG9BhcCGaVw0dqDJx0TWqkzSw7fSuY/OCQ2k788QYQQXlSx3+N/IAcdMnXX7UbQ5NP
	O71dXBXttz5NHvIyavgFoT4UKupvoxlm2Oj7aHwgXryEeW/GW1V3CPKqxcXs/yk7d2I4ko
	Y2pHKtHhDLJcybmOM+Tx+MB/82qgi/3jBA6CJHxpAXP6N5KKv8bnwkxc3G1m1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tKATP4n6UsYsKAR5HymmCjK/vOsSvbOqbAEjaPPKais=;
	b=sTzojLz1t1ocNTNz0HXeQczJ+INJVdOcOb3Rd0Buek8cjuenSqzq6kFPLpRAnPaQ1RQoA4
	MvLiIPaAJKXQzDAA==
Date: Tue, 12 Aug 2025 07:44:30 +0200
Subject: [PATCH v4 17/24] riscv: vdso: Deduplicate CFLAGS_REMOVE_*
 variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-absolute-reloc-v4-17-61a8b615e5ec@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977469; l=1337;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=n7rZyBbT5pbmt5M5GrSidThNFcSgij4efiSpxxemwhg=;
 b=0JIHJbt9zi6gUHgjcuSIwo+4izQMegBN32Ik6FgPfMJGJcayTSsoHfu7UHm/d6C4nSaS3Btnn
 B/WNe5Tn1umCM3sBScvC+evhAbZ739AK6c1oCCk0CX0mwimaIdz7FBr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_064450_576223_729E24CE 
X-CRM114-Status: UNSURE (   8.56  )
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

All vDSO objects need the same treatment.
To make changes to both the list of objects and the list of removed flags
easier, introduce a helper variable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Jan Stancek <jstancek@redhat.com>
---
 arch/riscv/kernel/vdso/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 9ebb5e590f93a3228c451dca58e6d5cfbbc03ff7..c19c3c76f7c9f6b2f7523a59269de3b683656323 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -49,9 +49,10 @@ CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
 endif
 
 # Disable -pg to prevent insert call site
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
-CFLAGS_REMOVE_getrandom.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
-CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
+CFLAGS_REMOVE_VDSO = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
+CFLAGS_REMOVE_vgettimeofday.o = $(CFLAGS_REMOVE_VDSO)
+CFLAGS_REMOVE_getrandom.o = $(CFLAGS_REMOVE_VDSO)
+CFLAGS_REMOVE_hwprobe.o = $(CFLAGS_REMOVE_VDSO)
 
 # Force dependency
 $(obj)/vdso.o: $(obj)/vdso.so

-- 
2.50.1


