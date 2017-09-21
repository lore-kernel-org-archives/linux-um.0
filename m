Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170912121016.GF2908@pathway.suse.cz>
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
 <1504729681-3504-3-git-send-email-deller@gmx.de> <20170912121016.GF2908@pathway.suse.cz>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 21 Sep 2017 22:13:27 +0200
Message-ID: <CAFLxGvyA-KY9KMJLGKg6DqmJbYPhTk0thySF9QX3xpyE3EFDMw@mail.gmail.com>
Subject: Re: [PATCH 02/14] um: Use %pS printk format for symbols from direct addresses
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Helge Deller <deller@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Sep 12, 2017 at 2:10 PM, Petr Mladek <pmladek@suse.com> wrote:
> On Wed 2017-09-06 22:27:49, Helge Deller wrote:
>> Use the %pS printk format for printing symbols from direct addresses.
>> In usermode-linux there is actually no difference between %pS and %pF, but for
>> consistency throughout the kernel fix the wrong usage here too.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: user-mode-linux-devel@lists.sourceforge.net
>> ---
>>  arch/um/kernel/sysrq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
>> index 6b995e8..05585ee 100644
>> --- a/arch/um/kernel/sysrq.c
>> +++ b/arch/um/kernel/sysrq.c
>> @@ -20,7 +20,7 @@
>>
>>  static void _print_addr(void *data, unsigned long address, int reliable)
>>  {
>> -     pr_info(" [<%08lx>] %s%pF\n", address, reliable ? "" : "? ",
>> +     pr_info(" [<%08lx>] %s%pS\n", address, reliable ? "" : "? ",
>>               (void *)address);
>
> This seems to be used to print addresses from the stack.
> IMHO, we should use %pB here.

%pWTF? ;)

Agreed, let's use %pB.

-- 
Thanks,
//richard

