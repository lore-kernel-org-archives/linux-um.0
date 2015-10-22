Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <CAHVbs9NZ1qornYCozFCxiUraxrnS1guXh9xbvkP-B0Ov0+Ku1Q@mail.gmail.com>
References: <CAHVbs9NZ1qornYCozFCxiUraxrnS1guXh9xbvkP-B0Ov0+Ku1Q@mail.gmail.com>
Date: Thu, 22 Oct 2015 15:17:46 +0200
Message-ID: <CAFLxGvygpC8ChoCFvUhwEz=YVy55rkBsV2dei7f=im-QrtO3Aw@mail.gmail.com>
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
Subject: Re: [uml-devel] [uml-user] IRQ support?
To: Ricardo Nunes <ricardomiguel.sn@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>

Hi!

CC'ing -devel list.

On Thu, Oct 22, 2015 at 1:29 PM, Ricardo Nunes
<ricardomiguel.sn@gmail.com> wrote:
> I'm trying to use a real hardware driver inside UML and I,ve come to the IRQ
> suppor part.

How do you map the hardware into UML?

> Right now it's failing on request_irq call, so my question is if there is
> any manual on how to support this method calls in UML or if it's supposed to
> work as it is.
>
> I need to register IRQs and raise them. After a few searches I saw SIGIO
> module and everything, but it didn't help enough.

UML is using SIGIO for interrupts.

> What's the best way to support this?

Well, it depends how you map the hardware.
Maybe you can use vfio.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

