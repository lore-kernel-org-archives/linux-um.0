Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1a7Hej-0004uf-FF
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Dec 2015 06:58:17 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a7Hei-0000Sf-28
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Dec 2015 06:58:17 +0000
Message-ID: <566A73FF.6080306@kot-begemot.co.uk>
Date: Fri, 11 Dec 2015 06:58:07 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <564F0C6D.8000806@kot-begemot.co.uk>
	<CAFLxGvywFjhSwUAsAGtV3FQLvFCS+UaP4rJCDzbvZ3p+4nvjTQ@mail.gmail.com>
In-Reply-To: <CAFLxGvywFjhSwUAsAGtV3FQLvFCS+UaP4rJCDzbvZ3p+4nvjTQ@mail.gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] IRQ handler reentrancy
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 10/12/15 22:40, Richard Weinberger wrote:
> On Fri, Nov 20, 2015 at 1:05 PM, Anton Ivanov
> <anton.ivanov@kot-begemot.co.uk> wrote:
>> I have gotten to the bottom of this.
>>
>> 1. The IRQ handler re-entrancy issue predates the timer patch. Adding a
>> simple guard with a WARN_ON_ONCE around the device loop in the
>> sig_io_handler catches it in plain 4.3
>>
>> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
>> index 23cb935..ac0bbce 100644
>> --- a/arch/um/kernel/irq.c
>> +++ b/arch/um/kernel/irq.c
>> @@ -30,12 +30,17 @@ static struct irq_fd **last_irq_ptr = &active_fds;
>>
>>   extern void free_irqs(void);
>>
>> +static int in_poll_handler = 0;
>> +
>>   void sigio_handler(int sig, struct siginfo *unused_si, struct
>> uml_pt_regs *regs)
>>   {
>>          struct irq_fd *irq_fd;
>>          int n;
>>
>> +    WARN_ON_ONCE(in_poll_handler == 1);
>> +
>>          while (1) {
>> +        in_poll_handler = 1;
>>                  n = os_waiting_for_events(active_fds);
>>                  if (n <= 0) {
>>                          if (n == -EINTR)
>> @@ -51,6 +56,7 @@ void sigio_handler(int sig, struct siginfo *unused_si,
>> struct uml_pt_regs *regs)
>>                          }
>>                  }
>>          }
>> +    in_poll_handler = 0;
>>
>>          free_irqs();
>>   }
>>
>> This is dangerously broken - you can under heavy IO exhaust the stack,
>> you can get packets out of order, etc. Most IO is reasonably atomic so
>> corruption is not likely, but not impossible (especially if one or more
>> drivers are optimized to use multi-read/multi-write).
>>
>> 2. I cannot catch what is wrong with the current code in signal.c. When
>> I read it, it should not produce re-entrancy. But it does.
> Sorry for the delay. Until now I did not find the time to dig into that.
> Did you find the offending code in signal.c?

Yes.

Unblock signals is logically incorrect - it will re-trigger an
interrupts even if there is an interrupt in flight whose processing has
not been finished.

I tried several approaches both with the original poll() controller and
with my epoll() based version, some show promise.

I had to put it aside until next Friday as I have some stuff due at work
so I cannot spare time to work on it until then. Once I get that out of
the way I should be able to spare it a day or two which should be enough
to finish it.

Ditto for the UBD improvements.

A.

> I'm also winding my head how to fix this properly (and to verify
> whether your patches are correct).
> This UML code is very very old and a dark corner.
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

