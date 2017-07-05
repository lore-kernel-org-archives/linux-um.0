Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <149504121868.2543.16105153409840504430.stgit@devbox>
References: <149504121868.2543.16105153409840504430.stgit@devbox>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 5 Jul 2017 23:25:12 +0200
Message-ID: <CAFLxGvxw9ciBb5EZhftG67++O2+-3m6D8ABqjKepky36tZU5FA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] um: Output messages to stderr and support quiet option
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Masami,

On Wed, May 17, 2017 at 7:13 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> Hello,
>
> Here is version 3 of um-quiet series. In this version
> I just fixed some printf format issues.
>
> V2 is here.
>
>  https://lkml.org/lkml/2017/5/8/35
>
> This series fixes some boot time printf output to stderr
> by adding os_info() and os_warn(). The information-level
> messages via os_info() are suppressed when "quiet" kernel
> option is specified.
> Also the last one allows user to pass "console=" option
> to kernel.
>
> Note that the output of --help and --version are still
> sent to stdout since they are intentionally shown by
> the user.
>
> Changes from v2:
>   - Cast rlim_min/max to unsigned long long explicitly
>     for avoiding printf-format warning.
>   - Fix printf format in physmem.c so that it matches
>     the type of arguments.
>
> Thank you,
>
> ---
>
> Masami Hiramatsu (6):
>       um: Use printk instead of printf in make_uml_dir
>       um: Add os_info() for pre-boot information messages
>       um: Use os_info for the messages on normal path
>       um: Add os_warn() for pre-boot warning/error messages
>       um: Use os_warn to print out pre-boot warning/error messages
>       um: console: Ignore console= option
>
>

Series applied. Thanks!

-- 
Thanks,
//richard

