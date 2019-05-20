Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] x86: Hide the int3_emulate_call/jmp functions from UML
References: <20190511083954.23a60052@gandalf.local.home>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <41bc0b7b-9f51-6a10-6182-811163aa0890@cambridgegreys.com>
Date: Mon, 20 May 2019 09:08:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190511083954.23a60052@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <jpoimboe@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>



On 11/05/2019 13:39, Steven Rostedt wrote:
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> User Mode Linux does not have access to the ip or sp fields of the
> pt_regs, and accessing them causes UML to fail to build. Hide the
> int3_emulate_jmp() and int3_emulate_call() instructions from UML, as it
> doesn't need them anyway.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> 
> [ I added this to my queue to test too ]
> 
>   arch/x86/include/asm/text-patching.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/text-patching.h
> b/arch/x86/include/asm/text-patching.h index 05861cc08787..0bbb07eaed6b
> 100644 --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -39,6 +39,7 @@ extern int poke_int3_handler(struct pt_regs *regs);
>   extern void *text_poke_bp(void *addr, const void *opcode, size_t len,
> void *handler); extern int after_bootmem;
>   
> +#ifndef CONFIG_UML_X86
>   static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned
> long ip) {
>   	regs->ip = ip;
> @@ -65,6 +66,7 @@ static inline void int3_emulate_call(struct pt_regs
> *regs, unsigned long func) int3_emulate_push(regs, regs->ip -
> INT3_INSN_SIZE + CALL_INSN_SIZE); int3_emulate_jmp(regs, func);
>   }
> -#endif
> +#endif /* CONFIG_X86_64 */
> +#endif /* !CONFIG_UML_X86 */
>   
>   #endif /* _ASM_X86_TEXT_PATCHING_H */
> 
The patch has been garbled by an auto-wrap. Can you resend it please.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

