Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1332251159-3582-1-git-send-email-consul.kautuk@gmail.com>
References: <1332251159-3582-1-git-send-email-consul.kautuk@gmail.com>
Date: Tue, 20 Mar 2012 12:15:28 -0400
Message-ID: <CAFPAmTQBkO8X424-_oqHA7sZqi=H0+U4Bv2=Brxc59Dhi5FhBA@mail.gmail.com>
From: Kautuk Consul <consul.kautuk@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/1] um/kernel/trap.c: Port OOM changes to handle_page_fault
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, Kautuk Consul <consul.kautuk@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

hi,

There is a small defect in this patch.
I am sending a v2to this patch.

On Tue, Mar 20, 2012 at 9:45 AM, Kautuk Consul <consul.kautuk@gmail.com=
> wrote:
> Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
> (mm: retry page fault when blocking on disk transfer) and
> commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
> (x86,mm: make pagefault killable)
>
> The above commits introduced changes into the x86 pagefault handler
> for making the page fault handler retryable as well as killable.
>
> These changes reduce the mmap_sem hold time, which is crucial
> during OOM killer invocation.
>
> Port these changes to um.
>
> Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>
> ---
> =A0arch/um/kernel/trap.c | =A0 24 +++++++++++++++++++-----
> =A01 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> index dafc947..76adb61 100644
> --- a/arch/um/kernel/trap.c
> +++ b/arch/um/kernel/trap.c
> @@ -30,6 +30,8 @@ int handle_page_fault(unsigned long address, unsign=
ed long ip,
> =A0 =A0 =A0 =A0pmd_t *pmd;
> =A0 =A0 =A0 =A0pte_t *pte;
> =A0 =A0 =A0 =A0int err =3D -EFAULT;
> + =A0 =A0 =A0 unsigned int flags =3D FAULT_FLAG_ALLOW_RETRY | FAULT_F=
LAG_KILLABLE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(is_=
write ? FAULT_FLAG_WRITE : 0);
>
> =A0 =A0 =A0 =A0*code_out =3D SEGV_MAPERR;
>
> @@ -40,6 +42,7 @@ int handle_page_fault(unsigned long address, unsign=
ed long ip,
> =A0 =A0 =A0 =A0if (in_atomic())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_nosemaphore;
>
> +retry:
> =A0 =A0 =A0 =A0down_read(&mm->mmap_sem);
> =A0 =A0 =A0 =A0vma =3D find_vma(mm, address);
> =A0 =A0 =A0 =A0if (!vma)
> @@ -65,7 +68,11 @@ good_area:
> =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int fault;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fault =3D handle_mm_fault(mm, vma, addr=
ess, is_write ? FAULT_FLAG_WRITE : 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fault =3D handle_mm_fault(mm, vma, addr=
ess, flags);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((fault & VM_FAULT_RETRY) && fatal_s=
ignal_pending(current))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;

The out: label will do an up_read which is not required here.
So, in v2 of this patch I am now doing a goto out_nosmaphore.

> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (unlikely(fault & VM_FAULT_ERROR)) =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (fault & VM_FAULT_O=
OM) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto o=
ut_of_memory;
> @@ -75,10 +82,17 @@ good_area:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BUG();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fault & VM_FAULT_MAJOR)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current->maj_flt++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current->min_flt++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags & FAULT_FLAG_ALLOW_RETRY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fault & VM_FAULT_MA=
JOR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
->maj_flt++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current=
->min_flt++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fault & VM_FAULT_RE=
TRY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags &=
=3D ~FAULT_FLAG_ALLOW_RETRY;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto re=
try;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pgd =3D pgd_offset(mm, address);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pud =3D pud_offset(pgd, address);
> --
> 1.7.5.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

