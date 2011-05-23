Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1306182652-25493-1-git-send-email-richard@nod.at>
References: <1306182652-25493-1-git-send-email-richard@nod.at>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 May 2011 13:46:30 -0700
Message-ID: <BANLkTikh0R7EBaG1q4GQz1Te5jmWtA42GQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: use RWSEM_GENERIC_SPINLOCK on x86
To: Richard Weinberger <richard@nod.at>
Cc: akpm@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "# .39.x" <stable@kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, May 23, 2011 at 1:30 PM, Richard Weinberger <richard@nod.at> wr=
ote:
>
> =A0config RWSEM_XCHGADD_ALGORITHM
> - =A0 =A0 =A0 def_bool X86_XADD
> + =A0 =A0 =A0 def_bool X86_XADD && 64BIT
>
> =A0config RWSEM_GENERIC_SPINLOCK
> - =A0 =A0 =A0 def_bool !X86_XADD
> + =A0 =A0 =A0 def_bool !X86_XADD || !64BIT

May I suggest just changing that second one to

  config RWSEM_GENERIC_SPINLOCK
      def_bool !RWSEM_XCHGADD_ALGORITHM

because I had to look twice just to make sure that they are inverses
of each other.

So why not make that inverse relationship more obvious?

                         Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

