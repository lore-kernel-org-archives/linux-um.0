Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGVsM-0002nY-TE
 for linux-um@lists.infradead.org; Thu, 10 Sep 2020 23:21:12 +0000
Received: by mail-qv1-xf42.google.com with SMTP id db4so4256574qvb.4
 for <linux-um@lists.infradead.org>; Thu, 10 Sep 2020 16:21:10 -0700 (PDT)
Date: Thu, 10 Sep 2020 20:21:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910232106.GR87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <20200910130233.GK87483@ziepe.ca>
 <20200910195749.795232d1@thinkpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910195749.795232d1@thinkpad>
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
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>

On Thu, Sep 10, 2020 at 07:57:49PM +0200, Gerald Schaefer wrote:
> On Thu, 10 Sep 2020 10:02:33 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Thu, Sep 10, 2020 at 11:39:25AM +0200, Alexander Gordeev wrote:
> > 
> > > As Gerald mentioned, it is very difficult to explain in a clear way.
> > > Hopefully, one could make sense ot of it.
> > 
> > I would say the page table API requires this invariant:
> > 
> >         pud = pud_offset(p4d, addr);
> >         do {
> > 		WARN_ON(pud != pud_offset(p4d, addr);
> >                 next = pud_addr_end(addr, end);
> >         } while (pud++, addr = next, addr != end);
> > 
> > ie pud++ is supposed to be a shortcut for 
> >   pud_offset(p4d, next)
> > 
> 
> Hmm, IIUC, all architectures with static folding will simply return
> the passed-in p4d pointer for pud_offset(p4d, addr), for 3-level
> pagetables.

It is probably moot now, but since other arch's don't crash they also
return pud_addr_end() == end so the loop only does one iteration.

ie pud == pud_offset(p4d, addr) for all iterations as the pud++ never
happens.

Which is what this addr_end patch does for s390..

Jason

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

