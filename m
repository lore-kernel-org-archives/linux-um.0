Return-Path: <kuba@kernel.org>
Date: Mon, 24 Jan 2022 09:04:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: Build regressions/improvements in v5.17-rc1
Message-ID: <20220124090433.1951e2ea@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
References: <20220123125737.2658758-1-geert@linux-m68k.org>
	<alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, kvm@vger.kernel.org, linux-mips@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>, alsa-devel@alsa-project.org, amd-gfx@lists.freedesktop.org, netdev@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Mon, 24 Jan 2022 08:55:40 +0100 (CET) Geert Uytterhoeven wrote:
> >  + /kisskb/src/drivers/net/ethernet/freescale/fec_mpc52xx.c: error: passing argument 2 of 'mpc52xx_fec_set_paddr' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]:  => 659:29  
> 
> powerpc-gcc5/ppc32_allmodconfig
> 
> >  + /kisskb/src/drivers/pinctrl/pinctrl-thunderbay.c: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]:  => 815:8, 815:29  
> 
> arm64-gcc5.4/arm64-allmodconfig
> arm64-gcc8/arm64-allmodconfig

Let me take care of these in net.

