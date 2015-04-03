MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1428067324.106641.5.camel@m3y3r.de>
References: <1428062392.106641.3.camel@m3y3r.de>
	<CAMuHMdUXKnoCwoUMNN_zOce=Z4B_YHF73rnkfK1=cdUH5_M8xg@mail.gmail.com>
	<1428067324.106641.5.camel@m3y3r.de>
Date: Fri, 3 Apr 2015 15:25:54 +0200
Message-ID: <CAMuHMdWhre+Qxd00boj4TihorU_Jvu+u-LcVKvUxswqN-Gv3Kg@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH v2] um: Print minimum physical memory requirement
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Apr 3, 2015 at 3:22 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Am Freitag, den 03.04.2015, 15:17 +0200 schrieb Geert Uytterhoeven:
>> On Fri, Apr 3, 2015 at 1:59 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
>> > --- a/arch/um/kernel/physmem.c
>> > +++ b/arch/um/kernel/physmem.c
>> > @@ -61,18 +61,26 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
>> >                           unsigned long len, unsigned long long highmem)
>> >  {
>> >         unsigned long reserve = reserve_end - start;
>> > -       int pfn = PFN_UP(__pa(reserve_end));
>> > -       int delta = (len - reserve) >> PAGE_SHIFT;
>> > -       int err, offset, bootmap_size;
>> > +       unsigned long pfn = PFN_UP(__pa(reserve_end));
>> > +       unsigned long delta = (len - reserve) >> PAGE_SHIFT;
>> > +       unsigned long offset, bootmap_size;
>> > +       int err, map_size;
>>
>> map_size should be unsigned long.
>
> No, this can actually get negative as the memory size needed by the
> executable file (linux) can be bigger then the physical memory assigned
> to the kernel via "mem=xxx" command line!

In that case it should be (signed) long.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

