Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPFLO-0004bI-7Y
 for linux-um@lists.infradead.org; Mon, 05 Oct 2020 01:31:15 +0000
Received: by mail-ej1-x643.google.com with SMTP id cb21so2810303ejb.13
 for <linux-um@lists.infradead.org>; Sun, 04 Oct 2020 18:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
 <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
 <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
 <CAG48ez2LdreJtHcZBL=t010PghjVECcsat2e2kzgakDvR0ue5w@mail.gmail.com>
 <CANN689H6fQkSXL8U0M-MoSrw8b8cQFMDaTRKr2v8oacZJ_FhKA@mail.gmail.com>
In-Reply-To: <CANN689H6fQkSXL8U0M-MoSrw8b8cQFMDaTRKr2v8oacZJ_FhKA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 5 Oct 2020 03:30:43 +0200
Message-ID: <CAG48ez0LuG9nULaBF_3ofE--u=TBgbxVdACthpb8wtJhADO02w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
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
To: Michel Lespinasse <walken@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Sat, Oct 3, 2020 at 11:30 PM Michel Lespinasse <walken@google.com> wrote:
> Unrelated to the above: copy_from_user and copy_to_user should not be
> called with mmap_lock held; it may be worth adding these assertions
> too (probably in separate patches) ?

We already have that: All (hopefully?) the userspace accessors call
might_fault(), and that does might_lock_read(&current->mm->mmap_lock)
(if we're not running in a lazytlb kernel thread or KERNEL_DS is on or
we're in IRQ context or page faults have explicitly been disabled).


But another place where lockdep asserts should be added is find_vma();
there are currently several architectures that sometimes improperly
call that with no lock held:

SPARC's arch_validate_prot():
https://lore.kernel.org/linux-mm/CAG48ez3YsfTfOFKa-Po58e4PNp7FK54MFbkK3aUPSRt3LWtxQA@mail.gmail.com/

nios2 sys_cacheflush():
https://lore.kernel.org/linux-mm/CAG48ez3hxeXU29UGWRH-gRXX2jb5Lc==npbXFt8UDrWO4eHZdQ@mail.gmail.com/

nds32 sys_cacheflush():
https://lore.kernel.org/linux-mm/CAG48ez1UnQEMok9rqFQC4XHBaMmBe=eaedu8Z_RXdjFHTna_LA@mail.gmail.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

