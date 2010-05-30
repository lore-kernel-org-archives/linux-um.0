Return-Path: <hpa@zytor.com>
Message-ID: <4C02B020.2040103@zytor.com>
Date: Sun, 30 May 2010 11:36:16 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86, hweight: Fix UML boot crash
References: <201005271944.09541.toralf.foerster@gmx.de> <AANLkTimKwxYxM_PExplIDK1WPTQ9e_-CHn5SnIvfjfUg@mail.gmail.com> <20100530150214.GA1565@liondog.tnic> <201005301728.25976.toralf.foerster@gmx.de> <20100530170346.GC1565@liondog.tnic>
In-Reply-To: <20100530170346.GC1565@liondog.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@alien8.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Borislav Petkov <borislav.petkov@amd.com>, =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 05/30/2010 10:03 AM, Borislav Petkov wrote:
> Obviously UML cannot stomach callee reg-saving trickery
> introduced with d61931d89be506372d01a90d1755f6d0a9fafe2d (x86:
> Add optimized popcnt variants) and oopses during boot:
> http://marc.info/?l=linux-kernel&m=127522065202435&w=2
> 
> Go ahead and fall back to the software hweight* routines on UML.

I actually don't understand why UML can't stomach that... it would work
exactly the same in userspace as in kernel space.  The only thing that I
can think of is if UML overrides the CFLAGS including the per-file
CFLAGS, but that would seem to cause all kinds of other issues.

I would also be a lot happier if this was handled in
<asm/arch_hweight.h> than in <asm/bitops.h>.  Finally, if UML really
can't handle this, then ARCH_HWEIGHT_CFLAGS should be disabled on UML.

This bothers me, because it really feels like something is fundamentally
broken in UML tryingto track the upstream architecture, and this is just
a bandage.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


