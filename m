MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1348949440.3294.2.camel@joe-AO722>
References: <1348938460-20919-1-git-send-email-geert@linux-m68k.org>
	<1348938460-20919-2-git-send-email-geert@linux-m68k.org>
	<1348949440.3294.2.camel@joe-AO722>
Date: Sat, 29 Sep 2012 22:27:44 +0200
Message-ID: <CAMuHMdWiDKV2=kbO8UGqZBETdrYExLRbaRFNnVTVRcWUs16OcA@mail.gmail.com>
Subject: Re: [PATCH 2/4] arch/um/os-Linux: Drop UM_ prefix from printk() level specifiers
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Joe Perches <joe@perches.com>
Cc: Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, x86@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, Sep 29, 2012 at 10:10 PM, Joe Perches <joe@perches.com> wrote:
>> @@ -88,7 +88,7 @@ static int do_aio(aio_context_t ctx, enum aio_type type, int fd, char *buf,
>>               iocbp->aio_nbytes = sizeof(c);
>>               break;
>>       default:
>> -             printk(UM_KERN_ERR "Bogus op in do_aio - %d\n", type);
>> +             printk(KERN_ERR "Bogus op in do_aio - %d\n", type);
>
> Maybe a follow-on patch to convert these to pr_<level>?

That requires adding pr_<level> to arch/um/include/shared/user.h first.
Or to avoid duplication, extracting the pr_<level> definitions from
include/linux/printk.h to a new header file, and preincluding that one for
the user part of UML, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

