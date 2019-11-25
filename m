Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZMRn-00089J-5a
 for linux-um@lists.infradead.org; Mon, 25 Nov 2019 22:03:08 +0000
Received: by mail-wm1-x343.google.com with SMTP id g206so1006507wme.1
 for <linux-um@lists.infradead.org>; Mon, 25 Nov 2019 14:03:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com>
 <d2d52cac3eff859b8cef0bc755cb6ae4590f27a6.1573179553.git.thehajime@gmail.com>
In-Reply-To: <d2d52cac3eff859b8cef0bc755cb6ae4590f27a6.1573179553.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 25 Nov 2019 23:02:54 +0100
Message-ID: <CAFLxGvyQhi+uKoAv34RE8LSgQMLGwDEWgCT4un1K_-mMvz29vA@mail.gmail.com>
Subject: Re: [RFC v2 02/37] arch: add __SYSCALL_DEFINE_ARCH
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: Octavian Purdila <tavi.purdila@gmail.com>, linux-kernel-library@freelists.org, Akira Moroo <retrage01@gmail.com>, linux-um@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> This allows the architecture code to process the system call
> definitions. It is used by LKL to create strong typed function
> definitions for system calls.
>
> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
> ---
>  include/linux/syscalls.h | 6 ++++++

Same here, core developers need to agree on this.

>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 88145da7d140..77e52fe19923 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -203,9 +203,14 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>  }
>  #endif
>
> +#ifndef __SYSCALL_DEFINE_ARCH
> +#define __SYSCALL_DEFINE_ARCH(x, sname, ...)
> +#endif
> +
>  #ifndef SYSCALL_DEFINE0
>  #define SYSCALL_DEFINE0(sname)                                 \
>         SYSCALL_METADATA(_##sname, 0);                          \
> +       __SYSCALL_DEFINE_ARCH(0, _##sname);                     \
>         asmlinkage long sys_##sname(void);                      \
>         ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);              \
>         asmlinkage long sys_##sname(void)
> @@ -222,6 +227,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>
>  #define SYSCALL_DEFINEx(x, sname, ...)                         \
>         SYSCALL_METADATA(sname, x, __VA_ARGS__)                 \
> +       __SYSCALL_DEFINE_ARCH(x, sname, __VA_ARGS__)            \
>         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>
>  #define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
> --
> 2.20.1 (Apple Git-117)
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um



-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

