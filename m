Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1Zzl4b-0003TN-Vk
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:45:53 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zzl4a-0002CH-OW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:45:53 +0000
Message-ID: <564F15F9.2030503@kot-begemot.co.uk>
Date: Fri, 20 Nov 2015 12:45:45 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <564F0C6D.8000806@kot-begemot.co.uk>
	<CAFLxGvwaaWgp1AGh+yRn5QqXvLM-EdPXBD3qSnyPpxDePnZ5zQ@mail.gmail.com>
In-Reply-To: <CAFLxGvwaaWgp1AGh+yRn5QqXvLM-EdPXBD3qSnyPpxDePnZ5zQ@mail.gmail.com>
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
Cc: Al Viro <viro@zeniv.linux.org.uk>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

It works correctly if I insert a guard around the interrupt handlers as 
well as into unblock_signals which prevents re-entrancy.

I can clean that and send it in as well as the various irq/signal 
erratas I have dug out while hunting this one.

A

On 20/11/15 12:16, Richard Weinberger wrote:
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
>>    extern void free_irqs(void);
>>
>> +static int in_poll_handler = 0;
>> +
>>    void sigio_handler(int sig, struct siginfo *unused_si, struct
>> uml_pt_regs *regs)
>>    {
>>           struct irq_fd *irq_fd;
>>           int n;
>>
>> +    WARN_ON_ONCE(in_poll_handler == 1);
>> +
>>           while (1) {
>> +        in_poll_handler = 1;
>>                   n = os_waiting_for_events(active_fds);
>>                   if (n <= 0) {
>>                           if (n == -EINTR)
>> @@ -51,6 +56,7 @@ void sigio_handler(int sig, struct siginfo *unused_si,
>> struct uml_pt_regs *regs)
>>                           }
>>                   }
>>           }
>> +    in_poll_handler = 0;
>>
>>           free_irqs();
>>    }
>>
>> This is dangerously broken - you can under heavy IO exhaust the stack,
>> you can get packets out of order, etc. Most IO is reasonably atomic so
>> corruption is not likely, but not impossible (especially if one or more
>> drivers are optimized to use multi-read/multi-write).
>>
>> 2. I cannot catch what is wrong with the current code in signal.c. When
>> I read it, it should not produce re-entrancy. But it does.
>>
>> 3. I found 2-3 minor issues with signal handling and the timer patch
>> which I will submit a hot-fix for, including a proper fix for the
>> hang-in-sleep issue.
>>
>> 4. While I can propose a brutal patch for signal.c which sets guards
>> against reentrancy which works fine, I suggest we actually get to the
>> bottom of this. Why the code in unblock_signals() does not guard
>> correctly against that?
> Thanks for hunting this issue.
> I fear I'll have to grab my speleologist's hat to figure out why UML
> works this way.
> Cc'ing Al, do you have an idea?
>


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

