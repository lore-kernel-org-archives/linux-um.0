Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxIEE-00048Q-6L
 for linux-um@lists.infradead.org; Mon, 12 Aug 2019 21:51:47 +0000
Received: by mail-pf1-x449.google.com with SMTP id e25so67127104pfn.5
 for <linux-um@lists.infradead.org>; Mon, 12 Aug 2019 14:51:44 -0700 (PDT)
Date: Mon, 12 Aug 2019 14:50:37 -0700
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
Message-Id: <20190812215052.71840-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
Subject: [PATCH 04/16] um: prefer __section from compiler_attributes.h
From: Nick Desaulniers <ndesaulniers@google.com>
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: akpm@linux-foundation.org
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, miguel.ojeda.sandonis@gmail.com, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Nick Desaulniers <ndesaulniers@google.com>, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, clang-built-linux@googlegroups.com, netdev@vger.kernel.org, jpoimboe@redhat.com, sedat.dilek@gmail.com, yhs@fb.com, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/um/kernel/um_arch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a818ccef30ca..18e0287dd97e 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -52,9 +52,9 @@ struct cpuinfo_um boot_cpu_data = {
 	.ipi_pipe		= { -1, -1 }
 };
 
-union thread_union cpu0_irqstack
-	__attribute__((__section__(".data..init_irqstack"))) =
-		{ .thread_info = INIT_THREAD_INFO(init_task) };
+union thread_union cpu0_irqstack __section(.data..init_irqstack) = {
+	.thread_info = INIT_THREAD_INFO(init_task)
+};
 
 /* Changed in setup_arch, which is called in early boot */
 static char host_info[(__NEW_UTS_LEN + 1) * 5];
-- 
2.23.0.rc1.153.gdeed80330f-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

