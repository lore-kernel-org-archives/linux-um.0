Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fmkK9-0005Ru-7j
 for linux-um@lists.infradead.org; Mon, 06 Aug 2018 18:33:46 +0000
Date: Mon, 6 Aug 2018 20:33:29 +0200
From: Michal Kubecek <mkubecek@suse.cz>
Subject: Re: due to kconfig changes kernel config file is no longer
 sufficient for configuring the kernel
Message-ID: <20180806183329.qditzzemevdafcwb@unicorn.suse.cz>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
 <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
 <20180628111623.3807fe9b@naga.suse.cz>
 <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rich Felker <dalias@libc.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Jeff Mahoney <jeffm@suse.com>, Dominik Brodowski <linux@dominikbrodowski.net>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, Linux-sh list <linux-sh@vger.kernel.org>, Andreas Schwab <schwab@suse.de>, X86 ML <x86@kernel.org>, "Peter Zijlstra, " <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Frederic Weisbecker <frederic@kernel.org>, Kees Cook <keescook@chromium.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Nicholas Piggin <npiggin@gmail.com>, Richard Weinberger <richard@nod.at>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, Michal Marek <michal.lkml@markovi.net>, Ulf Magnusson <ulfalizer@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Jul 30, 2018 at 05:02:42PM +0900, Masahiro Yamada wrote:
> 
> For exmaple 'make ARCH=arm config' will create the config suitable
> only for ARM architecture.
> Then, you need to do 'make ARCH=arm' to build the kernel.
> 
> If it is tedious to give 'ARCH=arm' to every make command,
> you can do 'export ARCH=arm' in your shell.
> 
> Again, this is the behavior we have for a long time.

Actually, this no longer works reliably. For example, when I run

  ARCH=powerpc make oldconfig

with our ppc64le config on x86_64 system, I get different result than
when I run it on an actual ppc64le system (or when using a ppc64le cross
compiler on x86_64).

Since .config started to mix user configuration and build environment
capabilities, maintaining distribution configs became real pain. And
it's getting progressively worse.

Michal Kubecek


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

