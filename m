Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <005a0edf-6d5e-e9c0-6f93-3d08a41cb24a@oracle.com>
References: <20170312093820.12044-1-vegard.nossum@oracle.com>
 <bc946709-df33-5c5b-5af6-d889f25087ce@nod.at> <005a0edf-6d5e-e9c0-6f93-3d08a41cb24a@oracle.com>
From: Vegard Nossum <vegard.nossum@gmail.com>
Date: Tue, 11 Apr 2017 11:36:16 +0200
Message-ID: <CAOMGZ=Fwjcfm=ceD7K2CFZu68U9TUGSii5mrJcX9bjrZgMyJjw@mail.gmail.com>
Subject: Re: [PATCH] um: use KERN_CONT in stack dump
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 12 March 2017 at 10:47, Vegard Nossum <vegard.nossum@oracle.com> wrote:
> On 12/03/2017 10:45, Richard Weinberger wrote:
>> diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
>> index aa1b56f5ac68..18eddf677ec6 100644
>> --- a/arch/um/kernel/sysrq.c
>> +++ b/arch/um/kernel/sysrq.c
>> @@ -17,10 +17,8 @@
>>
>>  static void _print_addr(void *data, unsigned long address, int reliable)
>>  {
>> -       pr_info(" [<%08lx>]", address);
>> -       pr_cont(" %s", reliable ? "" : "? ");
>> -       print_symbol("%s", address);
>> -       pr_cont("\n");
>> +       pr_info(" [<%08lx>] %s%pB\n", address, reliable ? "" : "? ",
>> +               (void *)address);
>>  }
>
> Tested-by: Vegard Nossum <vegard.nossum@oracle.com>

Just a heads up, this still appears unfixed in Linus's repo.


Vegard

