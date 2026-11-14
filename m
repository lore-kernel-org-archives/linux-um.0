Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AA606A32E
	for <linux-um@archiver.kernel.org>; Sat, 14 Nov 2026 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kOSqhS40;
	dkim=pass (1024-bit key) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=sr0v5n3s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=eXrt6zjXDYGtbkAl2DYVnczzLf0GaCjURpDTDmTj8GU=; b=kOSqhS40dbXAD/
	KtsOvRVzNPVZeT58PPoIFwPCYiyxyClkPvpX20zU/ZbaGV34Dc7j2/wjJyjv2AmXRC5kTgQSGapPQ
	5BsKgYPwXbm8cV7tbOJ3V3josuHw/QfA/u9hXOgkLxtGsVP1XTAdJFvd2UQCnQ+vi5Z8aKtHPbE5V
	J7KPs5z3Q8sQeQxcEozHT4RhJrpi5mgrxLrOJM9ULbhMtRqm/GOMVNcbcgMz0PCBAh2fkYP6GyXDk
	KaohOrTbWDdnDMGW+W3CwlORM7R06qXo72Z72WN84DeMgNd8Zmt/6A5YiPFJafwVtBX04es9tHufJ
	XmezTdFuvsoRbX04DOYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSImw-0000000Gd4W-2mHH;
	Sat, 14 Nov 2026 18:47:46 +0000
Received: from mail.virtlab.unibo.it ([2001:760:2e00:f0a1::32])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSImt-0000000Gd3J-04po
	for linux-um@lists.infradead.org;
	Sat, 14 Nov 2026 18:47:44 +0000
Received: from eipi10.cs.unibo.it (host0.studiodavoli.it [109.234.61.1])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id F0BC91C025B;
	Sat, 14 Nov 2026 19:47:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1794682051;
	bh=rb+3MKxX5aVEtvNPL35DviAvmrKKFIkGgi9tYTrkJVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sr0v5n3sFV1hSxJsnNyaJjh9ORnCa2EuxQxIo6EYpQNdWQ9Qdp8NehDSsaYHUChFI
	 avvhnS/DXptVVDuBIjIj62/RTds4VX8/oZy/mFF8YzIUKeKafi2KnqVbePJqo7OvdS
	 3w6F4suIu5/B1ADHz2yBJmYpIv7VdqBsBMlcJmDE=
From: Renzo Davoli <renzo@cs.unibo.it>
To: linux-kernel@vger.kernel.org
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	strace-devel@lists.strace.io,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Brian Cain <bcain@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-alpha@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-um@lists.infradead.org
Subject: [PATCH v4 1/3] asm/ptrace.h: add instruction_pointer_set
Date: Sat, 14 Nov 2026 19:47:16 +0100
Message-ID: <20261114184720.373178-2-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114184720.373178-1-renzo@cs.unibo.it>
References: <20261114184720.373178-1-renzo@cs.unibo.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_104743_232963_1599A3F0 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an instruction_pointer_set function for architectures that do
not currently provide one.

Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
 arch/alpha/include/asm/ptrace.h      | 6 ++++++
 arch/hexagon/include/asm/ptrace.h    | 6 ++++++
 arch/m68k/include/asm/ptrace.h       | 6 ++++++
 arch/microblaze/include/asm/ptrace.h | 6 ++++++
 arch/nios2/include/asm/ptrace.h      | 6 ++++++
 arch/um/include/asm/ptrace-generic.h | 6 ++++++
 arch/xtensa/include/asm/ptrace.h     | 6 ++++++
 7 files changed, 42 insertions(+)

diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
index 45d1229344b6..1a6f073e892e 100644
--- a/arch/alpha/include/asm/ptrace.h
+++ b/arch/alpha/include/asm/ptrace.h
@@ -33,6 +33,12 @@ static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
 	return arch_irqs_disabled_flags(regs->ps);
 }
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	instruction_pointer(regs) = val;
+}
+
 /* Syscall emulation defines */
 #define PTRACE_SYSEMU			0x1d
 #define PTRACE_SYSEMU_SINGLESTEP	0x1e
diff --git a/arch/hexagon/include/asm/ptrace.h b/arch/hexagon/include/asm/ptrace.h
index ed35da1ee685..0a121f6e3bfc 100644
--- a/arch/hexagon/include/asm/ptrace.h
+++ b/arch/hexagon/include/asm/ptrace.h
@@ -18,6 +18,12 @@ extern const char *regs_query_register_name(unsigned int offset);
 	((struct pt_regs *) \
 	 ((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	instruction_pointer(regs) = val;
+}
+
 #if CONFIG_HEXAGON_ARCH_VERSION >= 4
 #define arch_has_single_step()	(1)
 #endif
diff --git a/arch/m68k/include/asm/ptrace.h b/arch/m68k/include/asm/ptrace.h
index bc86ce012025..6e8a8f0daee8 100644
--- a/arch/m68k/include/asm/ptrace.h
+++ b/arch/m68k/include/asm/ptrace.h
@@ -18,6 +18,12 @@
 	(struct pt_regs *)((char *)current_thread_info() + THREAD_SIZE) - 1
 #define current_user_stack_pointer() rdusp()
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	instruction_pointer(regs) = val;
+}
+
 #define arch_has_single_step()	(1)
 
 #ifdef CONFIG_MMU
diff --git a/arch/microblaze/include/asm/ptrace.h b/arch/microblaze/include/asm/ptrace.h
index 17982292a64f..69e10658d7a9 100644
--- a/arch/microblaze/include/asm/ptrace.h
+++ b/arch/microblaze/include/asm/ptrace.h
@@ -20,5 +20,11 @@ static inline long regs_return_value(struct pt_regs *regs)
 	return regs->r3;
 }
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	instruction_pointer(regs) = val;
+}
+
 #endif /* __ASSEMBLER__ */
 #endif /* _ASM_MICROBLAZE_PTRACE_H */
diff --git a/arch/nios2/include/asm/ptrace.h b/arch/nios2/include/asm/ptrace.h
index 96cbcd40c7ce..d120d8ecb187 100644
--- a/arch/nios2/include/asm/ptrace.h
+++ b/arch/nios2/include/asm/ptrace.h
@@ -70,6 +70,12 @@ struct switch_stack {
 #define user_stack_pointer(regs)	((regs)->sp)
 extern void show_regs(struct pt_regs *);
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	instruction_pointer(regs) = val;
+}
+
 #define current_pt_regs() \
 	((struct pt_regs *)((unsigned long)current_thread_info() + THREAD_SIZE)\
 		- 1)
diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 62e9916078ec..632d4ce3334d 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -29,6 +29,12 @@ struct pt_regs {
 
 #define PTRACE_OLDSETOPTIONS 21
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	instruction_pointer(regs) = val;
+}
+
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 #define PTRACE_GETFDPIC		31
 #define PTRACE_GETFDPIC_EXEC	0
diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
index d0568ff6d349..97b14418955e 100644
--- a/arch/xtensa/include/asm/ptrace.h
+++ b/arch/xtensa/include/asm/ptrace.h
@@ -103,6 +103,12 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->areg[2];
 }
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	instruction_pointer(regs) = val;
+}
+
 int do_syscall_trace_enter(struct pt_regs *regs);
 void do_syscall_trace_leave(struct pt_regs *regs);
 
-- 
2.47.3


