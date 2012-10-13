MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <50796C57.9070303@nod.at>
References: <14846952.alsA7bkick@vault01>
	<50796C57.9070303@nod.at>
Date: Sat, 13 Oct 2012 15:53:59 +0200
Message-ID: <CAMuHMdVxNfsi9DoQe5wukHgxMExgZMx2snoq8SKFoWzWfDddUQ@mail.gmail.com>
Subject: Re: [uml-devel] linux-3.6.x ARCH=um will not build
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Richard Weinberger <richard@nod.at>
Cc: "Dave Humphreys (Bob)" <dave@bob-the-boat.me.uk>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, Oct 13, 2012 at 3:27 PM, Richard Weinberger <richard@nod.at> wrote:
> Am 13.10.2012 15:13, schrieb Dave Humphreys (Bob):
>> Apologies if this repeats any previous attempts made by me: problems with
>> something called 'gmane'
>>
>> ===
>>  ...
>>   CC      arch/um/os-Linux/signal.o
>> arch/um/os-Linux/signal.c:18:8: error: conflicting types for 'sig_info'
>> /nfs4xp/software/krn/linux-3.6.x/linux-3.6.2-um64/arch/um/include/shared/as-
>> layout.h:64:15: note: previous declaration of 'sig_info' was here
>>
>> I get the above error when trying to build both linux-3.6 and linux-3.6.2 in
>> both x86 (gcc-4.7.2) and x86_64 (gcc-4.6.3) environments.
>>
>> Since both files involved in the conflict are part of the source distribution,
>> I don't think that it can be a fault with my environment; but then I don't
>> understand why it obviously works for others.
>>
>> arch/um/os-Linux/signal.c:18:8
>> arch/um/include/shared/as-layout.h:64:15
>
> Already known and fixed. :)
> http://www.spinics.net/lists/mm-commits/msg91703.html

Missing "Cc: stable@vger.kernel.org"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

