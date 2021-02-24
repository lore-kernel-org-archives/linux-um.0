Return-Path: <johannes@sipsolutions.net>
Message-ID: <b4f7d1f0367548d58d870694eea6187293f0a386.camel@sipsolutions.net>
Subject: Re: [PATCH 0/7] PCI support for UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 24 Feb 2021 15:35:11 +0100
In-Reply-To: <CAMuHMdWymKxYQHPC4Rqc1A7WSdQZDm6noaedHgXqfXPttmGV6w@mail.gmail.com> (sfid-20210224_104734_536153_8E0CF38E)
References: <20210223152707.408995-1-johannes@sipsolutions.net>
	 <d2c3b464d782809298670b1ecbc199f56d776600.camel@sipsolutions.net>
	 <CAMuHMdWymKxYQHPC4Rqc1A7WSdQZDm6noaedHgXqfXPttmGV6w@mail.gmail.com>
	 (sfid-20210224_104734_536153_8E0CF38E)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-um <linux-um@lists.infradead.org>, Arnd Bergmann <arnd@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

Hi,

> > If anyone has any suggestions on a good example PCI device that already
> > has a driver upstream I'd be interested - I looked for something simple
> > like LED or GPIO but no such thing I could find (that wasn't platform
> > dependent in some way). So far I've only implemented a virtual Intel
> > WiFi NIC, but that depends on a large body of code I can't publish. As
> > an example, it would be nice to write (and publish there) a simple PCI
> > device implementation. :)
> 
>  bt8xxgpio?

Yeah, that looks pretty good, thanks for the pointer!

johannes


