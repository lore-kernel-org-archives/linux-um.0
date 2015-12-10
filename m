Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1a79sn-00079c-6X
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Dec 2015 22:40:17 +0000
Received: from mail-oi0-f46.google.com ([209.85.218.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a79sm-0006Cg-1P
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Dec 2015 22:40:17 +0000
Received: by oixx65 with SMTP id x65so54876621oix.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 10 Dec 2015 14:40:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <564F0C6D.8000806@kot-begemot.co.uk>
References: <564F0C6D.8000806@kot-begemot.co.uk>
Date: Thu, 10 Dec 2015 23:40:10 +0100
Message-ID: <CAFLxGvywFjhSwUAsAGtV3FQLvFCS+UaP4rJCDzbvZ3p+4nvjTQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Nov 20, 2015 at 1:05 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> I have gotten to the bottom of this.
>
> 1. The IRQ handler re-entrancy issue predates the timer patch. Adding a
> simple guard with a WARN_ON_ONCE around the device loop in the
> sig_io_handler catches it in plain 4.3
>
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index 23cb935..ac0bbce 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -30,12 +30,17 @@ static struct irq_fd **last_irq_ptr = &active_fds;
>
>   extern void free_irqs(void);
>
> +static int in_poll_handler = 0;
> +
>   void sigio_handler(int sig, struct siginfo *unused_si, struct
> uml_pt_regs *regs)
>   {
>          struct irq_fd *irq_fd;
>          int n;
>
> +    WARN_ON_ONCE(in_poll_handler == 1);
> +
>          while (1) {
> +        in_poll_handler = 1;
>                  n = os_waiting_for_events(active_fds);
>                  if (n <= 0) {
>                          if (n == -EINTR)
> @@ -51,6 +56,7 @@ void sigio_handler(int sig, struct siginfo *unused_si,
> struct uml_pt_regs *regs)
>                          }
>                  }
>          }
> +    in_poll_handler = 0;
>
>          free_irqs();
>   }
>
> This is dangerously broken - you can under heavy IO exhaust the stack,
> you can get packets out of order, etc. Most IO is reasonably atomic so
> corruption is not likely, but not impossible (especially if one or more
> drivers are optimized to use multi-read/multi-write).
>
> 2. I cannot catch what is wrong with the current code in signal.c. When
> I read it, it should not produce re-entrancy. But it does.

Sorry for the delay. Until now I did not find the time to dig into that.
Did you find the offending code in signal.c?
I'm also winding my head how to fix this properly (and to verify
whether your patches are correct).
This UML code is very very old and a dark corner.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

