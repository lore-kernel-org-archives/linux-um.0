Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad> <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <CAHk-=wh4SuNvThq1nBiqk0N-fW6NsY5w=VawC=rJs7ekmjAhjA@mail.gmail.com>
 <20200910181319.GO87483@ziepe.ca>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <0c9bcb54-914b-e582-dd6d-3861267b6c94@nvidia.com>
Date: Thu, 10 Sep 2020 14:22:37 -0700
MIME-Version: 1.0
In-Reply-To: <20200910181319.GO87483@ziepe.ca>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jason Gunthorpe <jgg@ziepe.ca>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, Mike Rapoport <rppt@kernel.org>

On 9/10/20 11:13 AM, Jason Gunthorpe wrote:
> On Thu, Sep 10, 2020 at 10:35:38AM -0700, Linus Torvalds wrote:
>> On Thu, Sep 10, 2020 at 2:40 AM Alexander Gordeev
>> <agordeev@linux.ibm.com> wrote:
>>>
>>> It is only gup_fast case that exposes the issue. It hits because
>>> pointers to stack copies are passed to gup_pXd_range iterators, not
>>> pointers to real page tables itself.
>>
>> Can we possibly change fast-gup to not do the stack copies?
>>
>> I'd actually rather do something like that, than the "addr_end" thing.
> 
>> As you say, none of the other page table walking code does what the
>> GUP code does, and I don't think it's required.
> 
> As I understand it, the requirement is because fast-gup walks without
> the page table spinlock, or mmap_sem held so it must READ_ONCE the
> *pXX.
> 
> It then checks that it is a valid page table pointer, then calls
> pXX_offset().
> 
> The arch implementation of pXX_offset() derefs again the passed pXX
> pointer. So it defeats the READ_ONCE and the 2nd load could observe
> something that is no longer a page table pointer and crash.

Just to be clear, though, that makes it sound a little wilder and
reckless than it really is, right?

Because actually, the page tables cannot be freed while gup_fast is
walking them, due to either IPI blocking during the walk, or the moral
equivalent (MMU_GATHER_RCU_TABLE_FREE) for non-IPI architectures. So the
pages tables can *change* underneath gup_fast, and for example pages can
be unmapped. But they remain valid page tables, it's just that their
contents are unstable. Even if pXd_none()==true.

Or am I way off here, and it really is possible (aside from the current
s390 situation) to observe something that "is no longer a page table"?


thanks,
-- 
John Hubbard
NVIDIA

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

