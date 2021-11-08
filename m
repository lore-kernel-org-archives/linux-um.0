Return-Path: <bp@alien8.de>
Date: Mon, 8 Nov 2021 15:21:04 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v0 42/42] notifier: Return an error when callback is
 already registered
Message-ID: <YYkyUEqcsOwQMb1S@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-43-bp@alien8.de>
 <CAMuHMdWH+txiSP_d7Jc4f_bU8Lf9iWpT4E3o5o7BJr-YdA6-VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWH+txiSP_d7Jc4f_bU8Lf9iWpT4E3o5o7BJr-YdA6-VA@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Ayush Sawal <ayush.sawal@chelsio.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rohit Maheshwari <rohitm@chelsio.com>, Steven Rostedt <rostedt@goodmis.org>, Vinay Kumar Yadav <vinay.yadav@chelsio.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, intel-gvt-dev@lists.freedesktop.org, alpha <linux-alpha@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-clk <linux-clk@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, linux-edac@vger.kernel.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-hyperv@vger.kernel.org, linux-iio@vger.kernel.org, linux-leds <linux-leds@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" <linux-remoteproc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-staging@lists.linux.dev, linux-tegra <linux-tegra@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, USB list <linux-usb@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, netdev <netdev@vger.kernel.org>, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, xen-devel@lists.xenproject.org
List-ID: <linux-um.lists.infradead.org>

On Mon, Nov 08, 2021 at 03:07:03PM +0100, Geert Uytterhoeven wrote:
> I think the addition of __must_check is overkill, leading to the
> addition of useless error checks and message printing.

See the WARN in notifier_chain_register() - it will already do "message
printing".

> Many callers call this where it cannot fail, and where nothing can
> be done in the very unlikely event that the call would ever start to
> fail.

This is an attempt to remove this WARN() hack in
notifier_chain_register() and have the function return a proper error
value instead of this "Currently always returns zero." which is bad
design.

Some of the registration functions around the tree check that retval and
some don't. So if "it cannot fail" those registration either should not
return a value or callers should check that return value - what we have
now doesn't make a whole lot of sense.

Oh, and then fixing this should avoid stuff like:

+	if (notifier_registered == false) {
+		mce_register_decode_chain(&amdgpu_bad_page_nb);
+		notifier_registered = true;
+	}

from propagating in the code.

The other idea I have is to add another indirection in
notifier_chain_register() which will check the *proper* return value of
a lower level __notifier_chain_register() and then issue that warning.
That would definitely avoid touch so many call sites.

Bottom line is: what we have now needs cleaning up.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

