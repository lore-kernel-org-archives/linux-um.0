Return-Path: <thomas@m3y3r.de>
Message-ID: <1428067324.106641.5.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Fri, 03 Apr 2015 15:22:04 +0200
In-Reply-To: <CAMuHMdUXKnoCwoUMNN_zOce=Z4B_YHF73rnkfK1=cdUH5_M8xg@mail.gmail.com>
References: <1428062392.106641.3.camel@m3y3r.de>
	 <CAMuHMdUXKnoCwoUMNN_zOce=Z4B_YHF73rnkfK1=cdUH5_M8xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [uml-devel] [PATCH v2] um: Print minimum physical memory
 requirement
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Freitag, den 03.04.2015, 15:17 +0200 schrieb Geert Uytterhoeven:
> On Fri, Apr 3, 2015 at 1:59 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> > --- a/arch/um/kernel/physmem.c
> > +++ b/arch/um/kernel/physmem.c
> > @@ -61,18 +61,26 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
> >                           unsigned long len, unsigned long long highmem)
> >  {
> >         unsigned long reserve = reserve_end - start;
> > -       int pfn = PFN_UP(__pa(reserve_end));
> > -       int delta = (len - reserve) >> PAGE_SHIFT;
> > -       int err, offset, bootmap_size;
> > +       unsigned long pfn = PFN_UP(__pa(reserve_end));
> > +       unsigned long delta = (len - reserve) >> PAGE_SHIFT;
> > +       unsigned long offset, bootmap_size;
> > +       int err, map_size;
> 
> map_size should be unsigned long.

No, this can actually get negative as the memory size needed by the
executable file (linux) can be bigger then the physical memory assigned
to the kernel via "mem=xxx" command line!

> 
> > +
> > +       offset = uml_reserved - uml_physmem;
> > +       map_size = len - offset;
> 
> 
> 
> 




