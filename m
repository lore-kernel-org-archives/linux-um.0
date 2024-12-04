Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B218E77171
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ffpke/jppWMPMYS5jq5e2krncaNB3PESE9dICL+0s9E=; b=ex2SCZgXF5MNSbRQTMHc5YfGiv
	4w+HbUbGQdpre17J+LXOZ66nLxHrwShiMyyOMhTcRtSebYL14bgkqToWtwrETf5DwqAXEkHPcqXcb
	6UMWAss/Luj4TJoSkdD0j4KzxacebpVAF7MpzjwlgtJb09DNBOSYj/A2zyQCQddEcKHYJZAoVBlpX
	oIu97NY5DF98HSc6A9UiL44ch+RKL2WsyYuCha6a6cdLkhprHPCsl7o9QuPoHIhRaZvLUOU+c/dGX
	aQimZ62jlAG9iVnv/+pMz3CFEmM7hQGmRb4h2wO8rsUcGG3gzPhC+ogm46aMHLS6kh/1w4ipMMLqd
	KXF7ZThw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tItPK-0000000DPV3-3nsy;
	Wed, 04 Dec 2024 17:43:26 +0000
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tItPH-0000000DPTF-3Zlw
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 17:43:25 +0000
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-29e1a8afb6cso9514fac.1
        for <linux-um@lists.infradead.org>; Wed, 04 Dec 2024 09:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733334202; x=1733939002; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ffpke/jppWMPMYS5jq5e2krncaNB3PESE9dICL+0s9E=;
        b=fX6Ln1XeKqFKkbsmGoak01oO+RDDQtfdfn/SfNAXVXz7i7zA52t9kFWr5m2oHbsOKI
         jw39yXS2TRw5/xDya1Df5ULgA2ePFK0qrD9dY0Os7I92PxcY+jFIYeO2QdJ1FfS9N6nl
         hXepkaN7xlKceI3cgANltZYM4S/RD0hIoI8Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733334202; x=1733939002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ffpke/jppWMPMYS5jq5e2krncaNB3PESE9dICL+0s9E=;
        b=VmAZ56eCrGwKdZodgRZ730uDn2HV3ShAhb/v1HdcmQprX40kEtv8wtOMFVc4dsyF15
         SGHqf4AQumWfC/L/MEzIkaTF9b4IhAZa6lguL97t058vM6LDrY1RnNk4OPxDH8nLldUB
         Y6kFFwXMP3XP01N685HqyzkIrp9I4RcKKtbtUv4HObhbEut9TkiJirVmwcSlW3BThKa6
         g5EfpEmHKi8XqT/oslr8bAN7gGhLXKEbXu7wgaVIhXLboaD6HJNen7ItFvSA4sVe32zS
         hIWeOSYNLeg3KcZmi5RWYa48/U8Jyba49rCW5AAB9cmmwdjwzB4yAKnUgGUe6DE8z8+G
         E4yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbJZQyM01vwkZkcs3a/ENUvVa268ogTLgHZtfxonlFN1dDvV+ElD49iLUq3rq4BnU5dKYw0q9y0w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3pACsG2jhzV1nc6Zxh/dHSIaJvCElMZ+OFekBqAY9KG/tYL4/
	1h8VumSmpXZTioqDt0YTel25u89Mi0mQBHeH8DtPFD1w8HFZHPZ1tU8H6EM/khP4+9Y1YvbEKg1
	Ns3Isj9szWWxlP6NoEsC/wf+yNAI8XAY06SG+
X-Gm-Gg: ASbGncsaXfJJdjqeLBQsLhhQafvvVrdY9pPyxz6t3JclpWwE9AHnErF45GvYzZFcXRa
	DdU4qO//owa/QISzoF8qKZGtJBsMy7wQxnqVO9E3MihCuuh5zL46LUkZG/MRj
X-Google-Smtp-Source: AGHT+IHn7HIS44KbWKiVM6s5E9Bw+9+7axO4PGKeqDfy0AQUicqEFXD0m4tWLtnwb7Q5Oi1HsxoxGTigCZlv6uhxias=
X-Received: by 2002:a05:6820:1f15:b0:5e3:b1fe:b1a with SMTP id
 006d021491bc7-5f25adf5fe6mr1079849eaf.2.1733334202423; Wed, 04 Dec 2024
 09:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <07ca17dce4638f11587da0ebd42bfc0533978298.camel@sipsolutions.net>
In-Reply-To: <07ca17dce4638f11587da0ebd42bfc0533978298.camel@sipsolutions.net>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 4 Dec 2024 09:43:10 -0800
Message-ID: <CABi2SkUU1ChZ6JJ_5aDCL2fQpNts3L3j69iK70UTt0ZJP3_FWw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com, 
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, enh@google.com, 
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_094323_928630_DAE1D25B 
X-CRM114-Status: GOOD (  55.22  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Wed, Dec 4, 2024 at 6:04=E2=80=AFAM Benjamin Berg <benjamin@sipsolutions=
.net> wrote:
>
> Hi,
>
> On Mon, 2024-11-25 at 20:20 +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Seal vdso, vvar, sigpage, uprobes and vsyscall.
> >
> > Those mappings are readonly or executable only, sealing can protect
> > them from ever changing or unmapped during the life time of the process=
.
> > For complete descriptions of memory sealing, please see mseal.rst [1].
> >
> > System mappings such as vdso, vvar, and sigpage (for arm) are
> > generated by the kernel during program initialization, and are
> > sealed after creation.
> >
> > Unlike the aforementioned mappings, the uprobe mapping is not
> > established during program startup. However, its lifetime is the same
> > as the process's lifetime [2]. It is sealed from creation.
> >
> > The vdso, vvar, sigpage, and uprobe mappings all invoke the
> > _install_special_mapping() function. As no other mappings utilize this
> > function, it is logical to incorporate sealing logic within
> > _install_special_mapping(). This approach avoids the necessity of
> > modifying code across various architecture-specific implementations.
> >
> > The vsyscall mapping, which has its own initialization function, is
> > sealed in the XONLY case, it seems to be the most common and secure
> > case of using vsyscall.
> >
> > It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
> > alter the mapping of vdso, vvar, and sigpage during restore
> > operations. Consequently, this feature cannot be universally enabled
> > across all systems.
>
> I think that enabling this feature would break User Mode Linux (UML).
> It uses a tiny static helper executable to create userspace MMs. This
> executable just maps some "stub" data/code pages[1] for management and
> after that all other memory has to be unmapped as it is managed by the
> UML kernel.
> This unmapping will not work if the vdso/vvar mappings are sealed.
>
> Maybe nobody who enables the feature cares about UML. But wanted to
> raise it as a potential issue in case you are not aware yet.
>
Thank you for bringing this to attention, I will add this information
to documentation/comments.

Do you think we need to add a KCONFIG check similar to
!CHECKPOINT_RESTORE ? or this is something purely  in userspace and
the kernel doesn't have a control.

> Benjamin
>
> [1] Hmm, we should mseal() those stub pages.
>
is this reference [1] correct ?

> >
> > Currently, memory sealing is only functional in a 64-bit kernel
> > configuration.
> >
> > To enable this feature, the architecture needs to be tested to
> > confirm that it doesn't unmap/remap system mappings during the
> > the life time of the process. After the architecture enables
> > ARCH_HAS_SEAL_SYSTEM_MAPPINGS, a distribution can set
> > CONFIG_SEAL_SYSTEM_MAPPING to manage access to the feature.
> > Alternatively, kernel command line (exec.seal_system_mappings)
> > enables this feature also.
> >
> > This feature is tested using ChromeOS and Android on X86_64 and ARM64,
> > therefore ARCH_HAS_SEAL_SYSTEM_MAPPINGS is set for X86_64 and ARM64.
> > Other architectures can enable this after testing. No specific hardware
> > features from the CPU are needed.
> >
> > This feature's security enhancements will benefit ChromeOS, Android,
> > and other secure-by-default systems.
> >
> > [1] Documentation/userspace-api/mseal.rst
> > [2] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkR=
kL-NrCZxYAyg@mail.gmail.com/
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 11 ++++++
> >  Documentation/userspace-api/mseal.rst         |  4 ++
> >  arch/arm64/Kconfig                            |  1 +
> >  arch/x86/Kconfig                              |  1 +
> >  arch/x86/entry/vsyscall/vsyscall_64.c         |  8 +++-
> >  include/linux/mm.h                            | 12 ++++++
> >  init/Kconfig                                  | 25 ++++++++++++
> >  mm/mmap.c                                     | 10 +++++
> >  mm/mseal.c                                    | 39 +++++++++++++++++++
> >  security/Kconfig                              | 24 ++++++++++++
> >  10 files changed, 133 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index e7bfe1bde49e..f63268341739 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1538,6 +1538,17 @@
> >                       Permit 'security.evm' to be updated regardless of
> >                       current integrity status.
> >
> > +     exec.seal_system_mappings =3D [KNL]
> > +                     Format: { no | yes }
> > +                     Seal system mappings: vdso, vvar, sigpage, vsysca=
ll,
> > +                     uprobe.
> > +                     - 'no':  do not seal system mappings.
> > +                     - 'yes': seal system mappings.
> > +                     This overrides CONFIG_SEAL_SYSTEM_MAPPINGS=3D(y/n=
)
> > +                     If not specified or invalid, default is the value=
 set by
> > +                     CONFIG_SEAL_SYSTEM_MAPPINGS.
> > +                     This option has no effect if CONFIG_64BIT=3Dn
> > +
> >       early_page_ext [KNL,EARLY] Enforces page_ext initialization to ea=
rlier
> >                       stages so cover more early boot allocations.
> >                       Please note that as side effect some optimization=
s
> > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/user=
space-api/mseal.rst
> > index 41102f74c5e2..bec122318a59 100644
> > --- a/Documentation/userspace-api/mseal.rst
> > +++ b/Documentation/userspace-api/mseal.rst
> > @@ -130,6 +130,10 @@ Use cases
> >
> >  - Chrome browser: protect some security sensitive data structures.
> >
> > +- seal system mappings:
> > +  kernel config CONFIG_SEAL_SYSTEM_MAPPINGS seals system mappings such
> > +  as vdso, vvar, sigpage, uprobes and vsyscall.
> > +
> >  When not to use mseal
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  Applications can apply sealing to any virtual memory region from users=
pace,
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 63de71544d95..fc5da8f74342 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -44,6 +44,7 @@ config ARM64
> >       select ARCH_HAS_SETUP_DMA_OPS
> >       select ARCH_HAS_SET_DIRECT_MAP
> >       select ARCH_HAS_SET_MEMORY
> > +     select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> >       select ARCH_STACKWALK
> >       select ARCH_HAS_STRICT_KERNEL_RWX
> >       select ARCH_HAS_STRICT_MODULE_RWX
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 1ea18662942c..5f6bac99974c 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -26,6 +26,7 @@ config X86_64
> >       depends on 64BIT
> >       # Options that are inherently 64-bit kernel only:
> >       select ARCH_HAS_GIGANTIC_PAGE
> > +     select ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >       select ARCH_SUPPORTS_PER_VMA_LOCK
> >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsy=
scall/vsyscall_64.c
> > index 2fb7d53cf333..30e0958915ca 100644
> > --- a/arch/x86/entry/vsyscall/vsyscall_64.c
> > +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
> > @@ -366,8 +366,12 @@ void __init map_vsyscall(void)
> >               set_vsyscall_pgtable_user_bits(swapper_pg_dir);
> >       }
> >
> > -     if (vsyscall_mode =3D=3D XONLY)
> > -             vm_flags_init(&gate_vma, VM_EXEC);
> > +     if (vsyscall_mode =3D=3D XONLY) {
> > +             unsigned long vm_flags =3D VM_EXEC;
> > +
> > +             vm_flags |=3D seal_system_mappings();
> > +             vm_flags_init(&gate_vma, vm_flags);
> > +     }
> >
> >       BUILD_BUG_ON((unsigned long)__fix_to_virt(VSYSCALL_PAGE) !=3D
> >                    (unsigned long)VSYSCALL_ADDR);
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index df0a5eac66b7..f787d6c85cbb 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4238,4 +4238,16 @@ int arch_get_shadow_stack_status(struct task_str=
uct *t, unsigned long __user *st
> >  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long =
status);
> >  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long=
 status);
> >
> > +#ifdef CONFIG_64BIT
> > +/*
> > + * return VM_SEALED if seal system mapping is enabled.
> > + */
> > +unsigned long seal_system_mappings(void);
> > +#else
> > +static inline unsigned long seal_system_mappings(void)
> > +{
> > +     return 0;
> > +}
> > +#endif
> > +
> >  #endif /* _LINUX_MM_H */
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 1aa95a5dfff8..614719259aa0 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1860,6 +1860,31 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       bool
> >
> > +config ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > +     bool
> > +     help
> > +       Control SEAL_SYSTEM_MAPPINGS access based on architecture.
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       To enable this feature, the architecture needs to be tested to
> > +       confirm that it doesn't unmap/remap system mappings during the
> > +       the life time of the process. After the architecture enables th=
is,
> > +       a distribution can set CONFIG_SEAL_SYSTEM_MAPPING to manage acc=
ess
> > +       to the feature.
> > +
> > +       The CONFIG_SEAL_SYSTEM_MAPPINGS already checks the CHECKPOINT_R=
ESTORE
> > +       feature, which is known to remap/unmap vdso.  Thus, the presenc=
e of
> > +       CHECKPOINT_RESTORE is not considered a factor in enabling
> > +       ARCH_HAS_SEAL_SYSTEM_MAPPINGS for a architecture.
> > +
> > +       For complete list of system mappings, please see
> > +       CONFIG_SEAL_SYSTEM_MAPPINGS.
> > +
> > +       For complete descriptions of memory sealing, please see
> > +       Documentation/userspace-api/mseal.rst
> > +
> >  config HAVE_PERF_EVENTS
> >       bool
> >       help
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 57fd5ab2abe7..bc694c555805 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2133,6 +2133,16 @@ struct vm_area_struct *_install_special_mapping(
> >       unsigned long addr, unsigned long len,
> >       unsigned long vm_flags, const struct vm_special_mapping *spec)
> >  {
> > +     /*
> > +      * At present, all mappings (vdso, vvar, sigpage, and uprobe) tha=
t
> > +      * invoke the _install_special_mapping function can be sealed.
> > +      * Therefore, it is logical to call the seal_system_mappings_enab=
led()
> > +      * function here. In the future, if this is not the case, i.e. if=
 certain
> > +      * mappings cannot be sealed, then it would be necessary to move =
this
> > +      * check to the calling function.
> > +      */
> > +     vm_flags |=3D seal_system_mappings();
> > +
> >       return __install_special_mapping(mm, addr, len, vm_flags, (void *=
)spec,
> >                                       &special_mapping_vmops);
> >  }
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index ece977bd21e1..80126d6231bb 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -7,6 +7,7 @@
> >   *  Author: Jeff Xu <jeffxu@chromium.org>
> >   */
> >
> > +#include <linux/fs_parser.h>
> >  #include <linux/mempolicy.h>
> >  #include <linux/mman.h>
> >  #include <linux/mm.h>
> > @@ -266,3 +267,41 @@ SYSCALL_DEFINE3(mseal, unsigned long, start, size_=
t, len, unsigned long,
> >  {
> >       return do_mseal(start, len, flags);
> >  }
> > +
> > +/*
> > + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> > + */
> > +enum seal_system_mappings_type {
> > +     SEAL_SYSTEM_MAPPINGS_DISABLED,
> > +     SEAL_SYSTEM_MAPPINGS_ENABLED
> > +};
> > +
> > +static enum seal_system_mappings_type seal_system_mappings_v __ro_afte=
r_init =3D
> > +     IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPINGS_EN=
ABLED :
> > +     SEAL_SYSTEM_MAPPINGS_DISABLED;
> > +
> > +static const struct constant_table value_table_sys_mapping[] __initcon=
st =3D {
> > +     { "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> > +     { "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> > +     { }
> > +};
> > +
> > +static int __init early_seal_system_mappings_override(char *buf)
> > +{
> > +     if (!buf)
> > +             return -EINVAL;
> > +
> > +     seal_system_mappings_v =3D lookup_constant(value_table_sys_mappin=
g,
> > +                     buf, seal_system_mappings_v);
> > +     return 0;
> > +}
> > +
> > +early_param("exec.seal_system_mappings", early_seal_system_mappings_ov=
erride);
> > +
> > +unsigned long seal_system_mappings(void)
> > +{
> > +     if (seal_system_mappings_v =3D=3D SEAL_SYSTEM_MAPPINGS_ENABLED)
> > +             return VM_SEALED;
> > +
> > +     return 0;
> > +}
> > diff --git a/security/Kconfig b/security/Kconfig
> > index 28e685f53bd1..5bbb8d989d79 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -51,6 +51,30 @@ config PROC_MEM_NO_FORCE
> >
> >  endchoice
> >
> > +config SEAL_SYSTEM_MAPPINGS
> > +     bool "seal system mappings"
> > +     default n
> > +     depends on 64BIT
> > +     depends on ARCH_HAS_SEAL_SYSTEM_MAPPINGS
> > +     depends on !CHECKPOINT_RESTORE
> > +     help
> > +       Seal system mappings such as vdso, vvar, sigpage, vsyscall, upr=
obes.
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       Depends on the ARCH_HAS_SEAL_SYSTEM_MAPPINGS.
> > +
> > +       CHECKPOINT_RESTORE might relocate vdso mapping during restore,
> > +       and remap/unmap will fail when the mapping is sealed, therefore
> > +       !CHECKPOINT_RESTORE is added as dependency.
> > +
> > +       Kernel command line exec.seal_system_mappings=3D(no/yes) overri=
des
> > +       this.
> > +
> > +       For complete descriptions of memory sealing, please see
> > +       Documentation/userspace-api/mseal.rst
> > +
> >  config SECURITY
> >       bool "Enable different security models"
> >       depends on SYSFS
>
>

