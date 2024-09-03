Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA4ECD37AB
	for <linux-um@archiver.kernel.org>; Tue,  3 Sep 2024 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t3nDXJLzevMZ4WniFU7yDbmtsQYuSVyzF0RKOG2Eq3Y=; b=U9CwJgcVvP0j4iBNuz8mrt0fBA
	0/3LIPsHNTqQaoir4Van3RhA0HSj+uaCNEyTOseJn0AWhBLCJiydFqTsV3sffBsADZVveZQC+rrHc
	Mg/4RoXHWlfMu1YZ/ZraDZNpR0xa7euql3czw29eNhZscPYYNL+q6f97DF+/vKC/3KgR78etyIius
	e0xYEkcsql98NdX2DoECCatTsLK4WodmuORxa0uG7xzKYRcNb0n2RjQmcghFP77Cz7c5pP0Fefn52
	JJtu1y5BoCCRw/fu7uNjYbIB60d7MTPuxHLAY8nGYo8IjN/D5UcQDpa0WXjFFluHMcq+lpXijR8wh
	k6BtHAJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slX8X-00000001GL9-2DzS;
	Tue, 03 Sep 2024 17:16:13 +0000
Received: from fhigh4-smtp.messagingengine.com ([103.168.172.155] helo=pfhigh4-smtp.messagingengine.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slX7O-00000001Fwz-2mY1
	for linux-um@lists.infradead.org;
	Tue, 03 Sep 2024 17:15:04 +0000
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 08C6C114037B;
	Tue,  3 Sep 2024 13:15:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Sep 2024 13:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1725383702;
	 x=1725470102; bh=t3nDXJLzevMZ4WniFU7yDbmtsQYuSVyzF0RKOG2Eq3Y=; b=
	YDbD8uF7KodEPa+ofyavsEOzxJCqurTp3SI0bB46dt7aDK1sX5kQBrGwupxnMynh
	iGkmM2nm4qNMOiBMhFGF2ZkADqslUgiXdmdQ6XnE5AJUT0XcVHv5mkXQ4W9OoXaH
	DDabE7QpdTvT8lNpzXoL9C96lBtrQQZKGfmUOmbl3afjhIyzJpg4t9pBNyxgiyd8
	hGOjL+4uN6/ZprxVArrdD6FBodiaHuHWPGYmKjjwFNP90BozeTEeEi8jYkLdQ/WP
	G6VwAcccN5kWe6jQPEBeFbrf0kFm8nV2+O00QeTAPg5Ml7yy2/A1hSg9aSjtLx/X
	4WbKJrHSlByR3y44o9GP6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725383702; x=
	1725470102; bh=t3nDXJLzevMZ4WniFU7yDbmtsQYuSVyzF0RKOG2Eq3Y=; b=k
	IkyhErU6eL1hFHh3bFi8To9J6+sFo5ltkScOzTF/q2TO51XVl8j6EHZmG2fbrSh/
	wmF9j0rGtO+i9Axlyu/xqYzszxuYvKz7bIzS9d7uenNBq+6xRp/80cj0SmOJ32Me
	YMM91QTY8lMsyutWSmBATG/f+kpswrhl4Q7PJwfbwJL9l5Y+UMCpBobo1c7yYevG
	y69PDitFPDonrXoMM1XKKqGmhwvV8XQFZQUYUjITwKnqWtKBBoUy4l1+Of3BC5fP
	riyCDurWZoRDd63h9OyYZnDAlclfZLvpsxvUdKLuPvHTqcVPZ52rkKygHOmriq0p
	yc+njotyHIwmP/umq3G8Q==
X-ME-Sender: <xms:FUTXZmGK6hGyqPlt8xDuMC3-9nZOM7GhDNczcd-hRUHUvexuqgjUxg>
    <xme:FUTXZnUtklDeY0RQlgzBRR1QMhVZYM9sq9bWQwisdBKdUSUjrahjewNx-D-YPx0Q9
    AVv890g8Tk-dKoD7oo>
X-ME-Received: <xmr:FUTXZgLRUPjx1bRQ0FwtjJpKbogidJEZZAT-6AEwK4Q2lANUvJ-5yJFSHiMtryWbMKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
    keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
    rdgtohhmpdhnsggprhgtphhtthhopeegtddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepthhs
    sghoghgvnhgusegrlhhphhgrrdhfrhgrnhhkvghnrdguvgdprhgtphhtthhopehjohhhrg
    hnnhgvshesshhiphhsohhluhhtihhonhhsrdhnvghtpdhrtghpthhtoheplhhlvhhmsehl
    ihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghgrrhihsehgrghrhihguhhord
    hnvghtpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepthhg
    lhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepsghjohhrnhefpghghhesph
    hrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:FUTXZgE27AQ7bgMzvT65AKgrPb-kptbxYCIdL-phmkIs4kkyScFi3A>
    <xmx:FUTXZsWoRzTxodD4nSFsAiM43xSQtSr6GOZotGWIcH7SdoadqGJeFw>
    <xmx:FUTXZjN2ppCIZYzxGfiAdgM_NOMtrX8qY4LofKyZjwaHxXV-lgJ26Q>
    <xmx:FUTXZj23s8ifDZow0j0X63zsNvoDeqBxYCGT3sQ7ITZtxYDeyWxD6Q>
    <xmx:FUTXZpKw5p5hNVoFo6pAKpu1pgVrNKJACKiM4vKITOwg3zVlEZgdhEIu>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 13:14:57 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 03 Sep 2024 18:14:35 +0100
Subject: [PATCH 2/3] MIPS: Rename mips_instruction type to workaround
 bindgen issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-mips-rust-v1-2-0fdf0b2fd58f@flygoat.com>
References: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
In-Reply-To: <20240903-mips-rust-v1-0-0fdf0b2fd58f@flygoat.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
  Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,  Richard Weinberger <richard@nod.at>,
  Anton Ivanov <anton.ivanov@cambridgegreys.com>,
  Johannes Berg <johannes@sipsolutions.net>,
  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,  Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
  =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
  Benno Lossin <benno.lossin@proton.me>,
  Andreas Hindborg <a.hindborg@samsung.com>,
  Alice Ryhl <aliceryhl@google.com>,
  Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
  Steven Rostedt <rostedt@goodmis.org>,
  Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,  Jonathan Corbet <corbet@lwn.net>,
 Alex Shi <alexs@kernel.org>,  Yanteng Si <siyanteng@loongson.cn>,
  Nick Desaulniers <ndesaulniers@google.com>,
  Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-um@lists.infradead.org, rust-for-linux@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, llvm@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6582;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=CIsXpNL4Xqbe4+3LwKSPPuuUUgffBKKKBhZHlqW00Cg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTrLmztR2edEbzKcelDgmzRh5tFU2fd27y66MKPxq7+x
 6yCNrdjO0pZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAib+4y/NMya+8+epvzINv7
 btHfobmnhGV2FJqdzFU/UT1r6pH0rAhGhqUXrnoLvp13pdiOz6fiwZJ3P8O6l0ioVttlbWLKWWx
 zmRUA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_101502_915300_4B2CD75A 
X-CRM114-Status: GOOD (  18.00  )
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

We have a union and a type both named after mips_instruction,
rust bindgen is not happy with this kind of naming alias.

Given that union mips_instruction is a part of UAPI, the only
thing we can do is to rename mips_instruction type.

Rename it as mips_insn, which is not conflicting with anything
and fits the name of header.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/dsemul.h |  2 +-
 arch/mips/include/asm/inst.h   |  6 +++---
 arch/mips/kernel/ftrace.c      |  2 +-
 arch/mips/kernel/kprobes.c     |  2 +-
 arch/mips/math-emu/cp1emu.c    | 18 +++++++++---------
 arch/mips/math-emu/dsemul.c    |  8 ++++----
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/mips/include/asm/dsemul.h b/arch/mips/include/asm/dsemul.h
index 08bfe8fa3b40..870597d6d1ad 100644
--- a/arch/mips/include/asm/dsemul.h
+++ b/arch/mips/include/asm/dsemul.h
@@ -34,7 +34,7 @@ struct task_struct;
  *
  * Return: Zero on success, negative if ir is a NOP, signal number on failure.
  */
-extern int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
+extern int mips_dsemul(struct pt_regs *regs, mips_insn ir,
 		       unsigned long branch_pc, unsigned long cont_pc);
 
 /**
diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
index 2f98ced30263..0616b8eb7401 100644
--- a/arch/mips/include/asm/inst.h
+++ b/arch/mips/include/asm/inst.h
@@ -71,12 +71,12 @@
 #define I_FMA_FFMT_SFT	0
 #define MIPSInst_FMA_FFMT(x) (MIPSInst(x) & 0x00000007)
 
-typedef unsigned int mips_instruction;
+typedef unsigned int mips_insn;
 
 /* microMIPS instruction decode structure. Do NOT export!!! */
 struct mm_decoded_insn {
-	mips_instruction insn;
-	mips_instruction next_insn;
+	mips_insn insn;
+	mips_insn next_insn;
 	int pc_inc;
 	int next_pc_inc;
 	int micro_mips_mode;
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 8c401e42301c..153c9666a77c 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -248,7 +248,7 @@ int ftrace_disable_ftrace_graph_caller(void)
 #define S_R_SP	(0xafb0 << 16)	/* s{d,w} R, offset(sp) */
 #define OFFSET_MASK	0xffff	/* stack offset range: 0 ~ PT_SIZE */
 
-unsigned long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
+static long ftrace_get_parent_ra_addr(unsigned long self_ra, unsigned long
 		old_parent_ra, unsigned long parent_ra_addr, unsigned long fp)
 {
 	unsigned long sp, ip, tmp;
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index dc39f5b3fb83..7a1b1c3674da 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -90,7 +90,7 @@ int arch_prepare_kprobe(struct kprobe *p)
 	}
 
 	if (copy_from_kernel_nofault(&prev_insn, p->addr - 1,
-			sizeof(mips_instruction)) == 0 &&
+			sizeof(kprobe_opcode_t)) == 0 &&
 	    insn_has_delayslot(prev_insn)) {
 		pr_notice("Kprobes for branch delayslot are not supported\n");
 		ret = -EINVAL;
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 265bc57819df..bcd6a6f0034c 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -43,10 +43,10 @@
 /* Function which emulates a floating point instruction. */
 
 static int fpu_emu(struct pt_regs *, struct mips_fpu_struct *,
-	mips_instruction);
+	mips_insn);
 
 static int fpux_emu(struct pt_regs *,
-	struct mips_fpu_struct *, mips_instruction, void __user **);
+	struct mips_fpu_struct *, mips_insn, void __user **);
 
 /* Control registers */
 
@@ -846,7 +846,7 @@ do {									\
  * Emulate a CFC1 instruction.
  */
 static inline void cop1_cfc(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
-			    mips_instruction ir)
+			    mips_insn ir)
 {
 	u32 fcr31 = ctx->fcr31;
 	u32 value = 0;
@@ -903,7 +903,7 @@ static inline void cop1_cfc(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
  * Emulate a CTC1 instruction.
  */
 static inline void cop1_ctc(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
-			    mips_instruction ir)
+			    mips_insn ir)
 {
 	u32 fcr31 = ctx->fcr31;
 	u32 value;
@@ -973,7 +973,7 @@ static int cop1Emulate(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 {
 	unsigned long contpc = xcp->cp0_epc + dec_insn.pc_inc;
 	unsigned int cond, cbit, bit0;
-	mips_instruction ir;
+	mips_insn ir;
 	int likely, pc_inc;
 	union fpureg *fpr;
 	u32 __user *wva;
@@ -1461,7 +1461,7 @@ DEF3OP(nmadd, dp, ieee754dp_mul, ieee754dp_add, ieee754dp_neg);
 DEF3OP(nmsub, dp, ieee754dp_mul, ieee754dp_sub, ieee754dp_neg);
 
 static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
-	mips_instruction ir, void __user **fault_addr)
+	mips_insn ir, void __user **fault_addr)
 {
 	unsigned int rcsr = 0;	/* resulting csr */
 
@@ -1680,7 +1680,7 @@ static int fpux_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
  * Emulate a single COP1 arithmetic instruction.
  */
 static int fpu_emu(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
-	mips_instruction ir)
+	mips_insn ir)
 {
 	int rfmt;		/* resulting format */
 	unsigned int rcsr = 0;	/* resulting csr */
@@ -2899,9 +2899,9 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 			dec_insn.micro_mips_mode = 1;
 		} else {
 			if ((get_user(dec_insn.insn,
-			    (mips_instruction __user *) xcp->cp0_epc)) ||
+			    (mips_insn __user *) xcp->cp0_epc)) ||
 			    (get_user(dec_insn.next_insn,
-			    (mips_instruction __user *)(xcp->cp0_epc+4)))) {
+			    (mips_insn __user *)(xcp->cp0_epc+4)))) {
 				MIPS_FPU_EMU_INC_STATS(errors);
 				return SIGBUS;
 			}
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index e02bd20b60a6..d4ea2cf89006 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -61,8 +61,8 @@
  *   couldn't already.
  */
 struct emuframe {
-	mips_instruction	emul;
-	mips_instruction	badinst;
+	mips_insn	emul;
+	mips_insn	badinst;
 };
 
 static const int emupage_frame_count = PAGE_SIZE / sizeof(struct emuframe);
@@ -206,11 +206,11 @@ void dsemul_mm_cleanup(struct mm_struct *mm)
 	bitmap_free(mm_ctx->bd_emupage_allocmap);
 }
 
-int mips_dsemul(struct pt_regs *regs, mips_instruction ir,
+int mips_dsemul(struct pt_regs *regs, mips_insn ir,
 		unsigned long branch_pc, unsigned long cont_pc)
 {
 	int isa16 = get_isa16_mode(regs->cp0_epc);
-	mips_instruction break_math;
+	mips_insn break_math;
 	unsigned long fr_uaddr;
 	struct emuframe fr;
 	int fr_idx, ret;

-- 
2.46.0


