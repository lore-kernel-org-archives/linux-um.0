Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54883710.7030305@nod.at>
Date: Wed, 10 Dec 2014 13:05:36 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <20141210104624.GB32280@tucsk.suse.de> <54882533.6080901@nod.at> <2739506.ACK9B2Kt4q@wuerfel>
In-Reply-To: <2739506.ACK9B2Kt4q@wuerfel>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [BUG] uml panics with "Segfault with no mm" in v3.19-rc
To: Arnd Bergmann <arnd@arndb.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ley Foon Tan <lftan@altera.com>, linux-kernel@vger.kernel.org, Daniel Walter <sahne@0x90.at>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 10.12.2014 um 12:03 schrieb Arnd Bergmann:
> On Wednesday 10 December 2014 11:49:23 Richard Weinberger wrote:
>> Hi!
>>
>> Am 10.12.2014 um 11:46 schrieb Miklos Szeredi:
>>> The guilty commit is:
>>>
>>>   00f634bc522d "asm-generic: add generic futex for !CONFIG_SMP"
>>
>> Thanks a lot Miklos!
>> Your bisecting faster than I do.
>>
>> Let's dig into the issue!
>>
> 
> Did this happen on linux-next as well?
> 
> Does this happen only on non-SMP UML running on an SMP host, or also
> in other combinations?

Had some time to look into the issue.
UML dies because of futex_detect_cmpxchg().

        /*
         * This will fail and we want it. Some arch implementations do
         * runtime detection of the futex_atomic_cmpxchg_inatomic()
         * functionality. We want to know that before we call in any
         * of the complex code paths. Also we want to prevent
         * registration of robust lists in that case. NULL is
         * guaranteed to fault and we get -EFAULT on functional
         * implementation, the non-functional ones will return
         * -ENOSYS.
         */
        if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
                futex_cmpxchg_enabled = 1;

The said commit adds an futex_atomic_cmpxchg_inatomic() implementation for the non-SMP case.
As UML is non-SMP it will from now on use that code.

This line of code makes UML die because the kernel tries to access address 0.

 if (unlikely(get_user(val, uaddr) != 0)
	return -EFAULT;

On UML you can access user space memory only from process context.
Theoretically init calls are process context but not in terms of UML.
As no user space process called into the kernel UML has no process
to fetch the data using ptrace(), it will fall back to the "kernel did a boo boo"
case and panic().

Maybe we can find an easy way to detect this case in arch/um/kernel/trap.c
but the real question is, does UML need futex_cmpxchg?
Is there a big benefit?
I fear it will open a can of worms.

Thanks,
//richard
