Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hPRIE-0000VJ-RG
 for linux-um@lists.infradead.org; Sat, 11 May 2019 12:40:00 +0000
Date: Sat, 11 May 2019 08:39:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] x86: Hide the int3_emulate_call/jmp functions from UML
Message-ID: <20190511083954.23a60052@gandalf.local.home>
MIME-Version: 1.0
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jkosina@suse.cz>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Andy Lutomirski <luto@amacapital.net>, Richard Weinberger <richard@nod.at>, Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

User Mode Linux does not have access to the ip or sp fields of the
pt_regs, and accessing them causes UML to fail to build. Hide the
int3_emulate_jmp() and int3_emulate_call() instructions from UML, as it
doesn't need them anyway.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

[ I added this to my queue to test too ]

 arch/x86/include/asm/text-patching.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/text-patching.h
b/arch/x86/include/asm/text-patching.h index 05861cc08787..0bbb07eaed6b
100644 --- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -39,6 +39,7 @@ extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len,
void *handler); extern int after_bootmem;
 
+#ifndef CONFIG_UML_X86
 static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned
long ip) {
 	regs->ip = ip;
@@ -65,6 +66,7 @@ static inline void int3_emulate_call(struct pt_regs
*regs, unsigned long func) int3_emulate_push(regs, regs->ip -
INT3_INSN_SIZE + CALL_INSN_SIZE); int3_emulate_jmp(regs, func);
 }
-#endif
+#endif /* CONFIG_X86_64 */
+#endif /* !CONFIG_UML_X86 */
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

