Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMZz-0007Up-0D
 for linux-um@lists.infradead.org; Fri, 04 Jan 2019 10:19:52 +0000
Subject: Re: [PATCH] um: Try to avoid kmalloc in signal handling
References: <20190104100517.9809-1-anton.ivanov@cambridgegreys.com>
 <2157515.SUgOQPs8Ts@blindfold>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <108ad3b6-93ee-5d8c-c1bf-b83e22ff3d3f@cambridgegreys.com>
Date: Fri, 4 Jan 2019 10:19:46 +0000
MIME-Version: 1.0
In-Reply-To: <2157515.SUgOQPs8Ts@blindfold>
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
To: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org



On 1/4/19 10:13 AM, Richard Weinberger wrote:
> Am Freitag, 4. Januar 2019, 11:05:17 CET schrieb anton.ivanov@cambridgegreys.com:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Signal handling (which maps to interrupt handling in UML) needs
>> to pass current registers to the relevant handlers and was
>> allocating a structure for that using kmalloc. It is possible
>> to avoid this kmalloc by using a small "signal register stack".
>> A depth of 4 suffices for normal use. If it is exceeded
>> further sets of registers are allocated as before via kmalloc.
>>
>> The end result is >10% performance increase in networking
>> as measured by iperf and >5% across the board.
>>
>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> ---
>>   arch/um/include/shared/os.h |  4 ++++
>>   arch/um/kernel/signal.c     | 31 +++++++++++++++++++++++++++++++
>>   arch/um/os-Linux/signal.c   | 16 ++++------------
>>   3 files changed, 39 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
>> index ebf23012a59b..4ec1bc63213b 100644
>> --- a/arch/um/include/shared/os.h
>> +++ b/arch/um/include/shared/os.h
>> @@ -319,4 +319,8 @@ extern unsigned long os_get_top_address(void);
>>   
>>   long syscall(long number, ...);
>>   
>> +/* signal.c */
>> +extern struct uml_pt_regs *get_save_register_state(void);
>> +extern void release_save_register_state(struct uml_pt_regs *r);
>> +
>>   #endif
>> diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
>> index 57acbd67d85d..558ac7e4df97 100644
>> --- a/arch/um/kernel/signal.c
>> +++ b/arch/um/kernel/signal.c
>> @@ -6,11 +6,18 @@
>>   #include <linux/module.h>
>>   #include <linux/ptrace.h>
>>   #include <linux/sched.h>
>> +#include <linux/slab.h>
>>   #include <asm/siginfo.h>
>>   #include <asm/signal.h>
>>   #include <asm/unistd.h>
>>   #include <frame_kern.h>
>>   #include <kern_util.h>
>> +#include <os.h>
>> +
>> +static atomic_t reg_depth;
>> +
>> +static struct uml_pt_regs reg_file[4];
>> +#define REG_SWITCH_TO_KMALLOC_DEPTH 3
> 
> I fear this is not correct.
> Think of task switching, if you push something to reg_file[],
> it is not guaranteed that the same task will run next and pop the item.
> The order can change.

It should not occur for the signals that map onto IRQ (timer and IO) - 
there it is all kernel.

I cannot trigger that for the other ones, but it may be possible.

IMO we should just bite the bullet and go back to using the stack 
increasing the minimum stack order needed to 1 for 32 bit and to 2 for 
64 bit.

x86 if I read it correctly is still using the stack even for the new 
register sets.


> 
> Thanks,
> //richard
> 
> 
> 
> 
> 

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

