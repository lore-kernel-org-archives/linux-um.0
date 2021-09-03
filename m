Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mM4kN-00BIZH-Dx
 for linux-um@lists.infradead.org; Fri, 03 Sep 2021 08:40:28 +0000
Message-ID: <30ab717a9ba1c2bb17e2a6948ff61d26c4430772.camel@sipsolutions.net>
Subject: Re: [PATCH] um: don't use CONFIG_X86_{32,64} symbols on x86
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 03 Sep 2021 10:40:23 +0200
In-Reply-To: <f177f8b287f14c93b04542d7ab4a8dfd@AcuMS.aculab.com>
References: <20210902102750.1ddfef4c1915.Icb5c49998c55b87c8584d46894c01b114ae2e661@changeid>
 <f177f8b287f14c93b04542d7ab4a8dfd@AcuMS.aculab.com>
MIME-Version: 1.0
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
To: David Laight <David.Laight@ACULAB.COM>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2021-09-03 at 08:27 +0000, David Laight wrote:
> From: Johannes Berg
> > Sent: 02 September 2021 09:28
> > 
> > The CONFIG_X86_32 and CONFIG_X86_64 symbols are used by
> > both "real" x86 architecture builds and ARCH=um today.
> > However, clearly most people and places in the code are
> > treating it as the architecture Kconfig (technically
> > that's just CONFIG_X86) and use it to indicate that the
> > architecture is X86 in 32- or 64-bit flavour.
> > 
> > This has caused a fair amount of issues in the past,
> > for example drivers not building because use x86 macros
> > or similar under CONFIG_X86_{32,64} ifdef, and then we
> > find build reports and add "!UML" to their Kconfig etc.
> > 
> > However, this is error-prone and a kind of whack-a-mole
> > game, even with the build bots reporting things.
> 
> I suspect you've just changed the 'mole'.

Yeah, that thought occurred to me too.


> You've now got lots of lines like:
> 
> #if defined(CONFIG_X86_64) || defined(CONFIG_X86_64_UML)
> 
> Missing off the UML define is going to cause the 32bit code
> to get compiled by mistake - which is likely to be more
> confusing that the places where you need to do special 'stuff'
> for UML

I'm not sure I agree though.

Yes, I agree that I have a number of lines. But looking through them, we
have new ones:
 - AFS, and it fundamentally wants to know the arch. If it misses one,
   well, that can also happen with any other arch.
 - XFS/falloc has arch-specific stuff again, and considers other
   architectures too
 - fs/ioctl.c is actually unnecessary since CONFIG_COMPAT doesn't exist
   on UML
 - same for blktrace
 - BPF jit - not really sure about that one
 - crypto Kconfig - but again already considers different architectures
   there
 - sound - ok that's a stupid one :)
 - lzo - again stuff that already considers many architectures

But on the other side removal we have
 - sysctl
 - netfilter
 - security
 - many fixes to driver Kconfig that you don't see here because they're
   *missing* "depends on !UML" now


So my gut feeling is that while we've indeed traded one mole for another
in a sense, the somewhat surprising places (like sound and BPF) are much
fewer, and most of the places that we now need it are places that are
already considering different architectures.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

