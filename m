Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Wed, 9 Sep 2020 18:12:11 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH v2 0/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200909181211.1cad8d28@thinkpad>
In-Reply-To: <20200908193650.1c1511d0@thinkpad>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907201256.GC1976319@kernel.org>
 <9bde9857-fdfd-e384-ea27-a14e5a06f1e6@csgroup.eu>
 <20200908193650.1c1511d0@thinkpad>
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
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Heiko Carstens <hca@linux.ibm.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, Mike Rapoport <rppt@kernel.org>

On Tue, 8 Sep 2020 19:36:50 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

[..]
> 
> It seems now that the generalization is very well accepted so far,
> apart from some apparent issues on arm. Also, merging 2 + 3 and
> putting them first seems to be acceptable, so we could do that for
> v3, if there are no objections.
> 
> Of course, we first need to address the few remaining issues for
> arm(32?), which do look quite confusing to me so far. BTW, sorry for
> the compile error with patch 3, I guess we did the cross-compile only
> for 1 + 2 applied, to see the bloat-o-meter changes. But I guess
> patch 3 already proved its usefulness by that :-)

Umm, replace "arm" with "power", sorry. No issues on arm so far, but
also no ack I think.

Thanks to Christophe for the power change, and to Mike for volunteering
for some cross compilation and cross-arch testing. Will send v3 with
merged and re-ordered patches after some more testing.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

