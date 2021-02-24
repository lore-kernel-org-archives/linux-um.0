MIME-Version: 1.0
Date: Wed, 24 Feb 2021 10:47:21 +0100
References: <20210223152707.408995-1-johannes@sipsolutions.net>
	<d2c3b464d782809298670b1ecbc199f56d776600.camel@sipsolutions.net>
In-Reply-To: <d2c3b464d782809298670b1ecbc199f56d776600.camel@sipsolutions.net>
Message-ID: <CAMuHMdWymKxYQHPC4Rqc1A7WSdQZDm6noaedHgXqfXPttmGV6w@mail.gmail.com>
Subject: Re: [PATCH 0/7] PCI support for UML
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um <linux-um@lists.infradead.org>, Arnd Bergmann <arnd@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

Hi Johannes,

On Tue, Feb 23, 2021 at 10:24 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Tue, 2021-02-23 at 16:27 +0100, Johannes Berg wrote:
> > In order to simulate some devices and write tests completely
> > independent of real PCI devices, we continued the development
> > of time-travel and related bits, and are adding PCI support
> > here now.
> >
> > The way it works is that it communicates with the outside (of
> > UML) with virtio, which we previously added using vhost-user,
> > and then offers a PCI bus to the inside system, where normal
> > PCI probing etc. happens, but all config space & IO accesses
> > are forwarded over virtio.
>
> I hadn't sent it out until now, but the userspace bits for all the time-
> travel and PCI-over-vhost-user are here:
>
> https://github.com/linux-test-project/usfstl/
>
> If anyone has any suggestions on a good example PCI device that already
> has a driver upstream I'd be interested - I looked for something simple
> like LED or GPIO but no such thing I could find (that wasn't platform
> dependent in some way). So far I've only implemented a virtual Intel
> WiFi NIC, but that depends on a large body of code I can't publish. As
> an example, it would be nice to write (and publish there) a simple PCI
> device implementation. :)

 bt8xxgpio?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

