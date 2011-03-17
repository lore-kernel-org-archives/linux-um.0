Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1300370936.16880.96.camel@gandalf.stny.rr.com>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
	<1300370936.16880.96.camel@gandalf.stny.rr.com>
Date: Thu, 17 Mar 2011 15:17:11 +0100
Message-ID: <AANLkTi=P1OsdZSSQu224dDeLhgnXeh+Z1oK2=5y0hZ8V@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
To: Steven Rostedt <rostedt@goodmis.org>
Cc: laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Mar 17, 2011 at 3:08 PM, Steven Rostedt <rostedt@goodmis.org> w=
rote:
> On Thu, 2011-03-17 at 13:25 +0100, richard -rw- weinberger wrote:
>> Lai,
>>
>> Your commit 2e12978a
>> (futex,plist: Pass the real head of the priority list to plist_del()=
)
>> triggers gazillions warnings on User Mode Linux (x86, Linus' tree as=
 of today):
>>
>> ------------[ cut here ]------------
>> WARNING: at kernel/futex.c:786 __unqueue_futex+0x12/0x16()
>> Modules linked in:
>> 27d4cce8: =A0[<081c13fe>] dump_stack+0x1c/0x20
>> 27d4cd00: =A0[<08071aa0>] warn_slowpath_common+0x49/0x5f
>> 27d4cd18: =A0[<08071acb>] warn_slowpath_null+0x15/0x19
>> 27d4cd28: =A0[<0808fdb8>] __unqueue_futex+0x12/0x16
>> 27d4cd38: =A0[<0808fef3>] futex_wait+0x137/0x1ed
>> 27d4cdd0: =A0[<080910c3>] do_futex+0x78/0x7c4
>> 27d4cedc: =A0[<080918e6>] sys_futex+0xd7/0xed
>> 27d4cf28: =A0[<0805abf6>] handle_syscall+0x7a/0x98
>> 27d4cf78: =A0[<080685d9>] userspace+0x2c9/0x370
>> 27d4cfe0: =A0[<08058be5>] fork_handler+0x53/0x5b
>> 27d4cffc: =A0[<00000000>] 0x0
>>
>> ---[ end trace ed7709f235f82328 ]---
>>
>> !spin_is_locked(q->lock_ptr) in the WARN_ON() at line 786
>> triggers the warnings.
>
> Crap, I bet you are running CONFIG_SMP=3Dn. I'll test this. We may ne=
ed to
> make that a WARN_ON_SMP().

Yes, UML does not support SMP.

> -- Steve
>
>>
>> I'm not sure whether this shows a bug within UML
>> or the WARN_ON() is wrong.
>>
>> What do you think?
>>
>
>
>

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

