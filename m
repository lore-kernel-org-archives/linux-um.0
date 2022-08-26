Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <b339d712-8229-469e-e976-6283b6fad842@infradead.org>
Date: Fri, 26 Aug 2022 13:37:01 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] um: Cleanup syscall_handler_t cast in syscalls_32.h
Content-Language: en-US
References: <20220826152927.193d262c@gecko>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220826152927.193d262c@gecko>
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
To: Lukas Straub <lukasstraub2@web.de>, linux-um <linux-um@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, x86@kernel.org, linux-kernel@vger.kernel.org



On 8/26/22 08:29, Lukas Straub wrote:
> Like in f4f03f299a56ce4d73c5431e0327b3b6cb55ebb9
> "um: Cleanup syscall_handler_t definition/cast, fix warning",
> remove the cast to to fix the compiler warning.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/x86/um/shared/sysdep/syscalls_32.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/um/shared/sysdep/syscalls_32.h b/arch/x86/um/shared/sysdep/syscalls_32.h
> index 68fd2cf526fd..f6e9f84397e7 100644
> --- a/arch/x86/um/shared/sysdep/syscalls_32.h
> +++ b/arch/x86/um/shared/sysdep/syscalls_32.h
> @@ -6,10 +6,9 @@
>  #include <asm/unistd.h>
>  #include <sysdep/ptrace.h>
>  
> -typedef long syscall_handler_t(struct pt_regs);
> +typedef long syscall_handler_t(struct syscall_args);
>  
>  extern syscall_handler_t *sys_call_table[];
>  
>  #define EXECUTE_SYSCALL(syscall, regs) \
> -	((long (*)(struct syscall_args)) \
> -	 (*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))
> +	((*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

