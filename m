Return-Path: <johannes@sipsolutions.net>
Message-ID: <af37cafc60dd0724f76c4be40fc5f70fbe28da13.camel@sipsolutions.net>
Subject: Re: [PATCH 1/7] um: allow disabling NO_IOMEM
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 23 Feb 2021 16:46:35 +0100
In-Reply-To: <CAMuHMdUU40kv6SncuCYGjattnEWR2k7FG2NS+6ffY6K+D1qsiQ@mail.gmail.com> (sfid-20210223_164419_226979_7AEC4F67)
References: <20210223152707.408995-1-johannes@sipsolutions.net>
	 <20210223161449.5fbbdace8fea.I7b2fad8378e4fde7f26ef06a03980ae2807d81c9@changeid>
	 <CAMuHMdUU40kv6SncuCYGjattnEWR2k7FG2NS+6ffY6K+D1qsiQ@mail.gmail.com>
	 (sfid-20210223_164419_226979_7AEC4F67)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-um <linux-um@lists.infradead.org>, Arnd Bergmann <arnd@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

Hi,

> Can't you just use the asm-generic versions instead?

Hmm, yes, for fb.h and vga.h that should work, since they should never
be used. For vga.h it would be wrong since it assumes the VGA memory is
mapped into the CPU memory, but since it should never run it would still
address the compilation issues I needed this for.

So yeah, I guess we could just use the asm-generic versions of these
two.

johannes


