MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <3356484.sS3LQGJdk9@sandpuppy>
References: <20140112120305.GA13076@gmail.com>
	<1389538341-31383-1-git-send-email-richard@nod.at>
	<52D2CA8E.7090707@zytor.com>
	<3356484.sS3LQGJdk9@sandpuppy>
Date: Sun, 12 Jan 2014 19:58:06 +0100
Message-ID: <CAMuHMdX4ERkYYEEM4=TDeXYbN7bjfvgQCaD+aFSyy2jov+SEyw@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um, x86: Fix vDSO build
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
To: Richard Weinberger <richard@nod.at>
Cc: "H. Peter Anvin" <hpa@zytor.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-tip-commits@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Fengguang Wu <fengguang.wu@intel.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Jan 12, 2014 at 6:17 PM, Richard Weinberger <richard@nod.at> wrote:
> Fengguang, please make sure that you build both UML/i386 and UML/x86_64.
> i.e. make defconfig ARCH=um SUBARCH=i386 && make linux ARCH=um
> and make defconfig ARCH=um SUBARCH=x86 && make linux ARCH=um

x86 or x86_64?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

