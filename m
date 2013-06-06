MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20130605164804.8071867d28c1f20cad8d7d2a@linux-foundation.org>
References: <20130531161807.GA9536@www.outflux.net>
	<20130605164804.8071867d28c1f20cad8d7d2a@linux-foundation.org>
Date: Thu, 6 Jun 2013 09:08:49 +0200
Message-ID: <CAMuHMdWH=3XMTn6Qbt+af9oEOG=EhBVTaDTWqmqg3=zn70q0JQ@mail.gmail.com>
Subject: Re: [PATCH] clean up scary strncpy(dst, src, strlen(src)) uses
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, driverdevel <devel@driverdev.osuosl.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Jun 6, 2013 at 1:48 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
>> -                     strncpy(containerpath, optarg, strlen(optarg) + 1);
>> +                     strlcpy(containerpath, optarg, sizeof(containerpath));
>>                       break;
>>               case 'w':
>>                       logfile = strdup(optarg);
>
> Documentation/accounting/getdelays.c:26:24: fatal error: bsd/string.h: No such file or directory

sudo apt-get install libbsd-dev

strlcpy() is available almost everywhere, except in glibc, cfr.
http://en.wikibooks.org/wiki/C_Programming/C_Reference/nonstandard/strlcpy#Criticism

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

