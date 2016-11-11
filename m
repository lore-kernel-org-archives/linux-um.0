Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: Fix compile failure due to current_text_address()
 definition
References: <20161110015326.GA51351@juliacomputing.com>
 <81f0fb21-e336-ed4c-4346-5f54836f5d8c@nod.at>
 <CABV8kRyfAWTMPoaTid2vDvOUWajegvsiYzwcUTe0_J1H-s9JVQ@mail.gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5718c625-bf94-dbd7-c7f5-14957d6b04d9@nod.at>
Date: Fri, 11 Nov 2016 23:07:42 +0100
MIME-Version: 1.0
In-Reply-To: <CABV8kRyfAWTMPoaTid2vDvOUWajegvsiYzwcUTe0_J1H-s9JVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Keno Fischer <keno@juliacomputing.com>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 11.11.2016 22:03, Keno Fischer wrote:
> Did you have CONFIG_INET set? I'm attaching my full .config. This is
> on vanilla Ubuntu 16.10.

Yes, CONFIG_INET is set. Let my try on Ubuntu. ;-\

> I did see the same error when building with `CONFIG_STATIC_LINK=y`.
> Note that I also, separately, ran into a linker problem, though I
> believe it is unrelated to this patch
> (though perhaps is related to the problem you're seeing?):
> https://sourceware.org/bugzilla/show_bug.cgi?id=20800.

This seems to be an UML<->glibc issue.
memmove() is now an ifunc and for whatever reason it does not work with UML.

> I'd also be happy to provide you with ssh access to the machine that
> I'm seeing this on if that
> would be helpful.

Okay, let me try myself first. I think I'm able to install Ubuntu. :)

Thanks,
//richard

