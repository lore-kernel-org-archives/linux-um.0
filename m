Return-Path: <tsbogend@alpha.franken.de>
Date: Tue, 25 Jan 2022 15:20:02 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: Build regressions/improvements in v5.17-rc1
Message-ID: <20220125142002.GA26778@alpha.franken.de>
References: <20220123125737.2658758-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, kvm@vger.kernel.org, linux-mips@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>, alsa-devel@alsa-project.org, amd-gfx@lists.freedesktop.org, netdev@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Mon, Jan 24, 2022 at 08:55:40AM +0100, Geert Uytterhoeven wrote:
> >  + /kisskb/src/lib/test_printf.c: error: "PTR" redefined [-Werror]:  => 247:0, 247
> >  + /kisskb/src/sound/pci/ca0106/ca0106.h: error: "PTR" redefined [-Werror]:  => 62, 62:0
> 
> mips-gcc8/mips-allmodconfig
> mipsel/mips-allmodconfig

fixing patch sent.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

