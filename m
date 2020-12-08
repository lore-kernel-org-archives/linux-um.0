Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.17.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmeDI-0001IR-AL
 for linux-um@lists.infradead.org; Tue, 08 Dec 2020 14:43:37 +0000
Subject: Re: [PATCH] arch: fix 'unexpected IRQ trap at vector' warnings
References: <20201207143146.30021-1-info@metux.net>
 <877dptt5av.fsf@mpe.ellerman.id.au>
From: Helge Deller <deller@gmx.de>
Message-ID: <cd9cdd74-688a-dc4b-6590-9aec8b89cbc1@gmx.de>
Date: Tue, 8 Dec 2020 15:42:41 +0100
MIME-Version: 1.0
In-Reply-To: <877dptt5av.fsf@mpe.ellerman.id.au>
Content-Language: en-US
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
To: Michael Ellerman <mpe@ellerman.id.au>, "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, hpa@zytor.com, linux-parisc@vger.kernel.org, benh@kernel.crashing.org, jdike@addtoit.com, x86@kernel.org, linux-um@lists.infradead.org, James.Bottomley@HansenPartnership.com, mingo@redhat.com, paulus@samba.org, richard@nod.at, bp@alien8.de, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, anton.ivanov@cambridgegreys.com

On 12/8/20 3:11 AM, Michael Ellerman wrote:
> "Enrico Weigelt, metux IT consult" <info@metux.net> writes:
>> All archs, except Alpha, print out the irq number in hex, but the message
>> looks like it was a decimal number, which is quite confusing. Fixing this
>> by adding "0x" prefix.
>
> Arguably decimal would be better, /proc/interrupts and /proc/irq/ both
> use decimal.

I agree.

> The whole message is very dated IMO, these days the number it prints is
> (possibly) virtualised via IRQ domains, ie. it's not necessarily a
> "vector" if that even makes sense on all arches). Arguably "trap" is the
> wrong term on some arches too.
>
> So it would be better reworded entirely IMO, and also switched to
> decimal to match other sources of information on interrupts.
>
> Perhaps:
> 	"Unexpected Linux IRQ %d."

Yes.

and while cleaning it up, introducing a default weak implementation of ack_bad_irq()
which adds and increases irq_err_count for all platforms would be a nice cleanup.

Helge

> If anyone else is having deja vu like me, yes this has come up before:
>   https://lore.kernel.org/lkml/20150712220211.7166.42035.stgit@bhelgaas-glaptop2.roam.corp.google.com/
>
> cheers
>
>
>
>> diff --git a/arch/arm/include/asm/hw_irq.h b/arch/arm/include/asm/hw_irq.h
>> index cecc13214ef1..2749f19271d9 100644
>> --- a/arch/arm/include/asm/hw_irq.h
>> +++ b/arch/arm/include/asm/hw_irq.h
>> @@ -9,7 +9,7 @@ static inline void ack_bad_irq(int irq)
>>  {
>>  	extern unsigned long irq_err_count;
>>  	irq_err_count++;
>> -	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
>> +	pr_crit("unexpected IRQ trap at vector 0x%02x\n", irq);
>>  }
>>
>>  #define ARCH_IRQ_INIT_FLAGS	(IRQ_NOREQUEST | IRQ_NOPROBE)
>> diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
>> index 7f7039516e53..c3348af88d3f 100644
>> --- a/arch/parisc/include/asm/hardirq.h
>> +++ b/arch/parisc/include/asm/hardirq.h
>> @@ -35,6 +35,6 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
>>  #define __IRQ_STAT(cpu, member) (irq_stat[cpu].member)
>>  #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
>>  #define __inc_irq_stat(member)	__this_cpu_inc(irq_stat.member)
>> -#define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector %02x\n", irq)
>> +#define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector 0x%02x\n", irq)
>>
>>  #endif /* _PARISC_HARDIRQ_H */
>> diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
>> index f133b5930ae1..ec8cf3cf6e49 100644
>> --- a/arch/powerpc/include/asm/hardirq.h
>> +++ b/arch/powerpc/include/asm/hardirq.h
>> @@ -29,7 +29,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
>>
>>  static inline void ack_bad_irq(unsigned int irq)
>>  {
>> -	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
>> +	printk(KERN_CRIT "unexpected IRQ trap at vector 0x%02x\n", irq);
>>  }
>>
>>  extern u64 arch_irq_stat_cpu(unsigned int cpu);
>> diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
>> index dfbc3c6c0674..aaaec5cdd4fe 100644
>> --- a/arch/s390/include/asm/hardirq.h
>> +++ b/arch/s390/include/asm/hardirq.h
>> @@ -23,7 +23,7 @@
>>
>>  static inline void ack_bad_irq(unsigned int irq)
>>  {
>> -	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
>> +	printk(KERN_CRIT "unexpected IRQ trap at vector 0x%02x\n", irq);
>>  }
>>
>>  #endif /* __ASM_HARDIRQ_H */
>> diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
>> index b426796d26fd..2a2e6eae034b 100644
>> --- a/arch/um/include/asm/hardirq.h
>> +++ b/arch/um/include/asm/hardirq.h
>> @@ -15,7 +15,7 @@ typedef struct {
>>  #ifndef ack_bad_irq
>>  static inline void ack_bad_irq(unsigned int irq)
>>  {
>> -	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
>> +	printk(KERN_CRIT "unexpected IRQ trap at vector 0x%02x\n", irq);
>>  }
>>  #endif
>>
>> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
>> index c5dd50369e2f..957c716f2df7 100644
>> --- a/arch/x86/kernel/irq.c
>> +++ b/arch/x86/kernel/irq.c
>> @@ -37,7 +37,7 @@ atomic_t irq_err_count;
>>  void ack_bad_irq(unsigned int irq)
>>  {
>>  	if (printk_ratelimit())
>> -		pr_err("unexpected IRQ trap at vector %02x\n", irq);
>> +		pr_err("unexpected IRQ trap at vector 0x%02x\n", irq);
>>
>>  	/*
>>  	 * Currently unexpected vectors happen only on SMP and APIC.
>> --
>> 2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

