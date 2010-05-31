Return-Path: <jdike@addtoit.com>
Date: Mon, 31 May 2010 11:56:19 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] x86, hweight: Fix UML boot crash
Message-ID: <20100531155619.GA29244@c-98-229-117-200.hsd1.ma.comcast.net>
References: <201005271944.09541.toralf.foerster@gmx.de> <AANLkTimKwxYxM_PExplIDK1WPTQ9e_-CHn5SnIvfjfUg@mail.gmail.com> <20100530150214.GA1565@liondog.tnic> <201005301728.25976.toralf.foerster@gmx.de> <20100530170346.GC1565@liondog.tnic> <4C02B020.2040103@zytor.com> <20100530193956.GA2498@liondog.tnic> <20100531023212.GA22673@c-98-229-117-200.hsd1.ma.comcast.net> <20100531135132.GA4915@aftab>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100531135132.GA4915@aftab>
To: Borislav Petkov <borislav.petkov@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, May 31, 2010 at 03:51:32PM +0200, Borislav Petkov wrote:
> <arch/x86/include/asm/bitops.h> includes <asm/arch_hweight.h> which are
> the optimized variants.

But how does UML get to arch/x86/include/asm/bitops.h in the first place?

It must go through an arch/um/include/asm/something.h (where something
might be bitops) first, right?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

