MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <AANLkTilqSSfV3vR-fI1LxrsuSMt_M7_zaeT_xQuNVJL4@mail.gmail.com>
References: <alpine.DEB.1.10.1001041421450.4942@dr-wily.mit.edu>
	<AANLkTinji7n8Hd1Ldci_ruH0r8qglGjC00YQkb-MEwoV@mail.gmail.com>
	<AANLkTilcHe8jnIBcTC_FjLPGxIbuZV3snU4u0FtdoeDi@mail.gmail.com>
	<AANLkTim4Tn74BSTqpXMfZeAG9eLDYEKUbcN_wiw2HpBY@mail.gmail.com>
	<AANLkTikU23ID2LWjAOAeGnnhhV5wulXeRghVG20PFPje@mail.gmail.com>
	<AANLkTilqSSfV3vR-fI1LxrsuSMt_M7_zaeT_xQuNVJL4@mail.gmail.com>
Date: Fri, 18 Jun 2010 22:01:27 +0200
Message-ID: <AANLkTilrk4mzoKIGIWTElkdMnoWwEjXgAMOEZpdLvuz0@mail.gmail.com>
Subject: Re: [RESEND][REGRESSION] um: CONFIG_STATIC_LINK=y broken
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: akpm@linux-foundation.org, tabbott@ksplice.com, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, stable@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Jun 18, 2010 at 19:50, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> On Fri, Jun 18, 2010 at 7:17 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Fri, Jun 18, 2010 at 17:22, richard -rw- weinberger
>> <richard.weinberger@gmail.com> wrote:
>>> On Fri, Jun 18, 2010 at 4:27 PM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Fri, Jun 18, 2010 at 15:49, richard -rw- weinberger
>>>> <richard.weinberger@gmail.com> wrote:
>>>>> Andrew, Linus, Jeff, ... anyone?
>>>>> Please apply this patch.
>>>>>
>>>>> CONFIG_STATIC_LINK is still broken. :(
>>>>
>>>> I wanted to verify Tim's patch, but after enabling CONFIG_STATIC_LINK,
>>>> it fails to link
>>>> (with or without your patch):
>>>>
>>>
>>> BTW: Does CONFIG_STATIC_LINK work for you when you revert commit
>>> 5d150a97f9391f5bcd7ba0d59d7a11c3de3cea80 (um: Clean up linker script
>>> using standard macros)?
>>
>> Still the same linking errors ;-(
>>
>
> Are you using a non-x86 environment?
> Maybe CONFIG_STATIC_LINK is more broken than i thought.

I'm using amd64 on Ubuntu 10.04.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

