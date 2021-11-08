Return-Path: <bp@alien8.de>
Date: Mon, 8 Nov 2021 22:18:47 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v0 42/42] notifier: Return an error when callback is
 already registered
Message-ID: <YYmUN69Y7z9xITas@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-43-bp@alien8.de>
 <CAMuHMdWH+txiSP_d7Jc4f_bU8Lf9iWpT4E3o5o7BJr-YdA6-VA@mail.gmail.com>
 <YYkyUEqcsOwQMb1S@zn.tnic>
 <CAMuHMdXiBEQyEXJagSfpH44hxVA2t0sDH7B7YubLGHrb2MJLLA@mail.gmail.com>
 <YYlJQYLiIrhjwOmT@zn.tnic>
 <CAMuHMdXHikGrmUzuq0WG5JRHUUE=5zsaVCTF+e4TiHpM5tc5kA@mail.gmail.com>
 <YYlOmd0AeA8DSluD@zn.tnic>
 <20211108205926.GA1678880@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211108205926.GA1678880@rowland.harvard.edu>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Ayush Sawal <ayush.sawal@chelsio.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rohit Maheshwari <rohitm@chelsio.com>, Steven Rostedt <rostedt@goodmis.org>, Vinay Kumar Yadav <vinay.yadav@chelsio.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, intel-gvt-dev@lists.freedesktop.org, alpha <linux-alpha@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, linux-edac@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-hyperv@vger.kernel.org, linux-iio@vger.kernel.org, linux-leds <linux-leds@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-staging@lists.linux.dev, linux-tegra <linux-tegra@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, USB list <linux-usb@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, netdev <netdev@vger.kernel.org>, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, xen-devel@lists.xenproject.org
List-ID: <linux-um.lists.infradead.org>

On Mon, Nov 08, 2021 at 03:59:26PM -0500, Alan Stern wrote:
> Is there really any reason for returning an error code?  For example, is 
> it anticipated that at some point in the future these registration calls 
> might fail?
> 
> Currently, the only reason for failing...

Right, I believe with not making it return void we're leaving the door
open for some, *hypothetical* future return values if we decide we need
to return them too, at some point.

Yes, I can't think of another fact to state besides that the callback
was already registered or return success but who knows what we wanna do
in the future...

And so if we change them all to void now, I think it'll be a lot more
churn to switch back to returning a non-void value and having the
callers who choose to handle that value, do so again.

So, long story short, keeping the retval - albeit not very useful right
now - is probably easier.

I hope I'm making some sense here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

