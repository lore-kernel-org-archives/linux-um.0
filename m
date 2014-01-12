Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Date: Sun, 12 Jan 2014 20:01:36 +0100
Message-ID: <16765842.Y8dV5ShgA9@sandpuppy>
In-Reply-To: <CAMuHMdX4ERkYYEEM4=TDeXYbN7bjfvgQCaD+aFSyy2jov+SEyw@mail.gmail.com>
References: <20140112120305.GA13076@gmail.com> <3356484.sS3LQGJdk9@sandpuppy> <CAMuHMdX4ERkYYEEM4=TDeXYbN7bjfvgQCaD+aFSyy2jov+SEyw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [uml-devel] [PATCH] um, x86: Fix vDSO build
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-tip-commits@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Fengguang Wu <fengguang.wu@intel.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Sonntag, 12. Januar 2014, 19:58:06 schrieb Geert Uytterhoeven:
> On Sun, Jan 12, 2014 at 6:17 PM, Richard Weinberger <richard@nod.at> wrote:
> > Fengguang, please make sure that you build both UML/i386 and UML/x86_64.
> > i.e. make defconfig ARCH=um SUBARCH=i386 && make linux ARCH=um
> > and make defconfig ARCH=um SUBARCH=x86 && make linux ARCH=um
> 
> x86 or x86_64?

Both x86 and x86_64 will create a CONFIG_64BIT=y .config.

Thanks,
//richard

