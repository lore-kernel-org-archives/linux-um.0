Return-Path: <shorne@gmail.com>
MIME-Version: 1.0
References: <20220720131934.373932-4-shorne@gmail.com> <20220720224238.GA1666095@bhelgaas>
In-Reply-To: <20220720224238.GA1666095@bhelgaas>
From: Stafford Horne <shorne@gmail.com>
Date: Thu, 21 Jul 2022 08:34:10 +0900
Message-ID: <CAAfxs76EGfzUnKp9XYAKxF9n3Y17+vsb3s2bJ4Cqi9hYFkawMg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] asm-generic: Add new pci.h and use it
Content-Type: multipart/alternative; boundary="000000000000de852405e4450af1"
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Pierre Morel <pmorel@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

--000000000000de852405e4450af1
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 21, 2022, 7:42 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Jul 20, 2022 at 10:19:34PM +0900, Stafford Horne wrote:
> > The asm/pci.h used for many newer architectures share similar
> > definitions.  Move the common parts to asm-generic/pci.h to allow for
> > sharing code.
> >
> > One thing to note:
> >
> >  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
> >    undefine it after including asm-generic/pci.h.  Why doesn't csky
> >    define it?
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Link:
> https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> > Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
>
> > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> > index 0aebc3488c32..016eb6b46dc0 100644
> > --- a/arch/arm64/include/asm/pci.h
> > +++ b/arch/arm64/include/asm/pci.h
>
> > -extern int isa_dma_bridge_buggy;
>
> Shouldn't this go in the previous patch?  The only definition of a
> isa_dma_bridge_buggy variable is in drivers/pci/pci.c, and it's under
> #ifdef CONFIG_X86_32.
>
> Same for csky, riscv, um?
>

Yes, you are right. I re ordered the patches and this didn't get into the
right patch.  Thanks for catching this. I'll fix.

- Stafford

>

--000000000000de852405e4450af1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Jul 21, 2022, 7:42 AM Bjorn Helgaas &lt;<a hre=
f=3D"mailto:helgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Wed, Jul 20, 2022 at 10:19:34PM +0900, St=
afford Horne wrote:<br>
&gt; The asm/pci.h used for many newer architectures share similar<br>
&gt; definitions.=C2=A0 Move the common parts to asm-generic/pci.h to allow=
 for<br>
&gt; sharing code.<br>
&gt; <br>
&gt; One thing to note:<br>
&gt; <br>
&gt;=C2=A0 - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so w=
e<br>
&gt;=C2=A0 =C2=A0 undefine it after including asm-generic/pci.h.=C2=A0 Why =
doesn&#39;t csky<br>
&gt;=C2=A0 =C2=A0 define it?<br>
&gt; <br>
&gt; Suggested-by: Arnd Bergmann &lt;<a href=3D"mailto:arnd@arndb.de" targe=
t=3D"_blank" rel=3D"noreferrer">arnd@arndb.de</a>&gt;<br>
&gt; Link: <a href=3D"https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=
=3DJbvf=3DnkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/" rel=3D"noreferrer norefer=
rer" target=3D"_blank">https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=
=3DJbvf=3DnkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/</a><br>
&gt; Acked-by: Pierre Morel &lt;<a href=3D"mailto:pmorel@linux.ibm.com" tar=
get=3D"_blank" rel=3D"noreferrer">pmorel@linux.ibm.com</a>&gt;<br>
&gt; Acked-by: Geert Uytterhoeven &lt;<a href=3D"mailto:geert@linux-m68k.or=
g" target=3D"_blank" rel=3D"noreferrer">geert@linux-m68k.org</a>&gt;<br>
&gt; Signed-off-by: Stafford Horne &lt;<a href=3D"mailto:shorne@gmail.com" =
target=3D"_blank" rel=3D"noreferrer">shorne@gmail.com</a>&gt;<br>
<br>
&gt; diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci=
.h<br>
&gt; index 0aebc3488c32..016eb6b46dc0 100644<br>
&gt; --- a/arch/arm64/include/asm/pci.h<br>
&gt; +++ b/arch/arm64/include/asm/pci.h<br>
<br>
&gt; -extern int isa_dma_bridge_buggy;<br>
<br>
Shouldn&#39;t this go in the previous patch?=C2=A0 The only definition of a=
<br>
isa_dma_bridge_buggy variable is in drivers/pci/pci.c, and it&#39;s under<b=
r>
#ifdef CONFIG_X86_32.<br>
<br>
Same for csky, riscv, um?<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Yes, you are right. I re ordered the patches and t=
his didn&#39;t get into the right patch.=C2=A0 Thanks for catching this. I&=
#39;ll fix.</div><div dir=3D"auto"><br></div><div dir=3D"auto">- Stafford=
=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
</blockquote></div></div></div>

--000000000000de852405e4450af1--

