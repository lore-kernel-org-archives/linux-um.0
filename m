Return-Path: <bp@alien8.de>
Date: Mon, 8 Nov 2021 17:29:55 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v0 00/42] notifiers: Return an error when callback is
 already registered
Message-ID: <YYlQg+OvUpUL630W@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101924.15759-1-bp@alien8.de>
 <20211108141703.GB1666297@rowland.harvard.edu>
 <YYkzJ3+faVga2Tl3@zn.tnic>
 <YYk1xi3eJdMJdjHC@zn.tnic>
 <20211108112313.73d0727e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211108112313.73d0727e@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Geert Uytterhoeven <geert@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ayush Sawal <ayush.sawal@chelsio.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rohit Maheshwari <rohitm@chelsio.com>, Vinay Kumar Yadav <vinay.yadav@chelsio.com>, alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-remoteproc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org, linux-staging@lists.linux.dev, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-usb@vger.kernel.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org
List-ID: <linux-um.lists.infradead.org>

On Mon, Nov 08, 2021 at 11:23:13AM -0500, Steven Rostedt wrote:
> Question, how often does this warning trigger? Is it common to see in
> development?

Yeah, haven't seen it myself yet.

But we hashed it out over IRC. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

