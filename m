Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knUur-0005G6-QN
 for linux-um@lists.infradead.org; Thu, 10 Dec 2020 23:00:07 +0000
Subject: Re: [PATCH v2] um: add a UML specific futex implementation
References: <20201112195718.6070-1-anton.ivanov@cambridgegreys.com>
 <CAFLxGvxiQiiS5Di3UqZKPyANd5EQC0DwzBZ-9r8skcbe=YYY7w@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <fb1a9caf-da4a-0d6e-b14c-e3e62d8a8039@cambridgegreys.com>
Date: Thu, 10 Dec 2020 22:59:58 +0000
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxiQiiS5Di3UqZKPyANd5EQC0DwzBZ-9r8skcbe=YYY7w@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, linux-um <linux-um@lists.infradead.org>

On 10/12/2020 22:38, Richard Weinberger wrote:
> On Thu, Nov 12, 2020 at 8:57 PM <anton.ivanov@cambridgegreys.com> wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> The generic asm futex implementation emulates atomic access to
>> memory by doing a get_user followed by put_user. These translate
>> to two mapping operations on UML with paging enabled in the
>> meantime. This, in turn may end up changing interrupts,
>> invoking the signal loop, etc.
>>
>> This replaces the generic implementation by a mapping followed
>> by an operation on the mapped segment. It is for now limited
>> to 64 bit as the 32 bit may also need to take care of highmem,
>> etc.
>>
>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> ---
>>   arch/um/include/asm/futex.h   |  20 ++++++
>>   arch/um/kernel/skas/uaccess.c | 119 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 139 insertions(+)
>>   create mode 100644 arch/um/include/asm/futex.h
>>
>> diff --git a/arch/um/include/asm/futex.h b/arch/um/include/asm/futex.h
>> new file mode 100644
>> index 000000000000..9af35ab66b6e
>> --- /dev/null
>> +++ b/arch/um/include/asm/futex.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_GENERIC_FUTEX_H
>> +#define _ASM_GENERIC_FUTEX_H
>> +
>> +#ifdef CONFIG_64BIT
>> +
>> +#include <linux/futex.h>
>> +#include <linux/uaccess.h>
>> +#include <asm/errno.h>
>> +
>> +
>> +extern int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr);
>> +extern int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>> +                             u32 oldval, u32 newval);
>> +
>> +#else
>> +#include <"asm-generic/futex.h">
>> +#endif /* CONFIG_64BIT */
>> +
>> +#endif
>> diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
>> index 2dec915abe6f..21a8f2b283bb 100644
>> --- a/arch/um/kernel/skas/uaccess.c
>> +++ b/arch/um/kernel/skas/uaccess.c
>> @@ -11,6 +11,7 @@
>>   #include <asm/current.h>
>>   #include <asm/page.h>
>>   #include <kern_util.h>
>> +#include <asm/futex.h>
>>   #include <os.h>
>>
>>   pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr)
>> @@ -248,3 +249,121 @@ long __strnlen_user(const void __user *str, long len)
>>          return 0;
>>   }
>>   EXPORT_SYMBOL(__strnlen_user);
>> +
>> +/**
>> + * arch_futex_atomic_op_inuser() - Atomic arithmetic operation with constant
>> + *                       argument and comparison of the previous
>> + *                       futex value with another constant.
>> + *
>> + * @encoded_op:        encoded operation to execute
>> + * @uaddr:     pointer to user space address
>> + *
>> + * Return:
>> + * 0 - On success
>> + * -EFAULT - User access resulted in a page fault
>> + * -EAGAIN - Atomic operation was unable to complete due to contention
>> + * -ENOSYS - Operation not supported
>> + */
>> +int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
> Does this even build in 32bits mode?
> AFAICT the generic futex implementation has
> arch_futex_atomic_op_inuser() as static inline...
>
I did not try, mea culpa. It was pulling the generic before. So generic 
should work.

I can retest this one and the others in 32 bit mode tomorrow (most of 
them were written to fall back to generic implementation for 32).

A.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

