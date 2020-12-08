Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmlyo-00056s-QE
 for linux-um@lists.infradead.org; Tue, 08 Dec 2020 23:01:11 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] arch: fix 'unexpected IRQ trap at vector' warnings
In-Reply-To: <877dptt5av.fsf@mpe.ellerman.id.au>
References: <20201207143146.30021-1-info@metux.net>
 <877dptt5av.fsf@mpe.ellerman.id.au>
Date: Wed, 09 Dec 2020 00:01:07 +0100
Message-ID: <87y2i7298s.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
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
To: Michael Ellerman <mpe@ellerman.id.au>, Enrico Weigelt,
Cc: linux-s390@vger.kernel.org, hpa@zytor.com, linux-parisc@vger.kernel.org, benh@kernel.crashing.org, deller@gmx.de, x86@kernel.org, linux-um@lists.infradead.org, James.Bottomley@HansenPartnership.com, mingo@redhat.com, paulus@samba.org, richard@nod.at, bp@alien8.de, linuxppc-dev@lists.ozlabs.org, jdike@addtoit.com, anton.ivanov@cambridgegreys.com

On Tue, Dec 08 2020 at 13:11, Michael Ellerman wrote:
> "Enrico Weigelt, metux IT consult" <info@metux.net> writes:
>> All archs, except Alpha, print out the irq number in hex, but the message
>> looks like it was a decimal number, which is quite confusing. Fixing this
>> by adding "0x" prefix.
>
> Arguably decimal would be better, /proc/interrupts and /proc/irq/ both
> use decimal.
>
> The whole message is very dated IMO, these days the number it prints is
> (possibly) virtualised via IRQ domains, ie. it's not necessarily a
> "vector" if that even makes sense on all arches). Arguably "trap" is the
> wrong term on some arches too.
>
> So it would be better reworded entirely IMO, and also switched to
> decimal to match other sources of information on interrupts.

So much for the theory.

The printk originates from the very early days of i386 Linux where it
was called from the low level entry code when there was no interrupt
assigned to a vector, which is an x86'ism.

That was copied to other architectures without actually thinking about
whether the vector concept made sense on that architecture and at some
point it got completely bonkers because it moved to core code without
thought.

There are a few situations why it is invoked or not:

  1) The original x86 usage is not longer using it because it complains
     rightfully about a vector being raised which has no interrupt
     descriptor associated to it. So the original reason for naming it
     vector is gone long ago. It emits:

     pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
                          __func__, smp_processor_id(), vector);

     Directly from the x86 C entry point without ever invoking that
     function.  Pretty popular error message due to some AMD BIOS
     wreckage. :)

  2) It's invoked when there is an interrupt descriptor installed but
     not configured/requested. In that case some architectures need to
     ack it in order not to block further interrupt delivery. In that
     case 'vector is bogus' and really want's to be 'irqnr' or such
     because there is a Linux virq number associated to it.

  3) It's invoked from __handle_domain_irq() when the 'hwirq' which is
     handed in by the caller does not resolve to a mapped Linux
     interrupt which is pretty much the same as the x86 situation above
     in #1, but it prints useless data.

     It prints 'irq' which is invalid but it does not print the really
     interesting 'hwirq' which was handed in by the caller and did
     not resolve.

     In this case the Linux irq number is uninteresting as it is known
     to be invalid and simply is not mapped and therefore does not
     exist.

     This has to print out 'hwirq' which is kinda the equivalent to the
     original 'vector' message.

  4) It's invoked from the dummy irq chip which is installed for a
     couple of truly virtual interrupts where the invocation of
     dummy_irq_chip::irq_ack() is indicating wreckage.

     In that case the Linux irq number is the thing which is printed.

So no. It's not just inconsistent it's in some places outright
wrong. What we really want is:

ack_bad_irq(int hwirq, int virq)
{
        if (hwirq >= 0)
           print_useful_info(hwirq);
        if (virq > 0)
           print_useful_info(virq);
        arch_try_to_ack(hwirq, virq);
}
    
for this to make sense. Just fixing the existing printk() to be less
wrong is not really an improvement.

Thanks,

        tglx



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

