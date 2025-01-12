Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A9BC02182
	for <linux-um@archiver.kernel.org>; Tue, 21 Jan 2025 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tdTlc/XFe97BaoasIyxjUjqvcp7zfHXxj6AYwEKsX38=; b=SZF2FNWcDBFOhfAomva2WJPwnj
	DjaNKgdAYpdwor/hT+38aIk2ZYiq8dBeXUyalLxBh4IPhxE/eJ6Q+z6CzbzPAvSzW3tIOKoGEKCUJ
	C2ZCVr6r0vZA+X/iCHpPRk0ZKWbvEEcCq3+1s0HWjvzUBpd1CRVMg7otJcLN4zthkUeQqr1pmsU2M
	PL2v4/qec3DKb7Flf+wJwjjp4cQj1H/xe/sD8y7LbaRJfZFI9nvaPKzloNds3690VtRPseDVhGqWL
	y7s1IdDa9A/zvWUykwNVYZ8eCE+ydLJgFRPVSMqn5McPaIkQDfCSpqX0Izy73hxZKJ0n2jU3vfGOe
	BUtxmYww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taGn5-00000008Jo5-1sET;
	Tue, 21 Jan 2025 16:07:47 +0000
Received: from [198.175.65.12] (helo=mgamail.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tX2ul-00000003GvY-2XPj;
	Sun, 12 Jan 2025 18:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736707344; x=1768243344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yIaBS7LkmzUat2OFaATD2kGBTQNP/h49/H3lTPBbro8=;
  b=lHW+9QQWYKyPIOUybZasOa3J1OQFOuOMtjrwe0ueLIte6P+JPA6r8FCO
   d3tiOtwHwdEfikamTWzBJdMQ7R5mVqcGw5FdiTmHyK8FT4iJ6tXiqKEJj
   TwUv05RYnQ6733g8s37xC+/nAD9nDARvdvhYWyEYQhhHpHpLvK9+RS8Zd
   Mt8wiecN89gQH1W4TtaTmSk9Y13zx8VOXA7wJFnDVhmn83moK56pI1JOR
   j2MFgjmrUvkeUZ9ixGN38hnhmPiz0+frtb6lXTlmIENVV3JjTqgPuQ89b
   pvGhgtm7RPx+nfEz9Ej+sGPgBVSsIQzRTV6I3FPT2JSSZFX0zpQ4ivsMU
   A==;
X-CSE-ConnectionGUID: AS+JXUvsSc2jOD0l4SrVAw==
X-CSE-MsgGUID: NkWtkabvT3KgBrRTa9gsLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="48304990"
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="48304990"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 10:42:21 -0800
X-CSE-ConnectionGUID: ATBPUUgvRE6sx2qYcVZXpw==
X-CSE-MsgGUID: s4iONW0iTDay0Hxof3O8IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="104396986"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 12 Jan 2025 10:42:06 -0800
Received: by stinkbox (sSMTP sendmail emulation); Sun, 12 Jan 2025 20:42:05 +0200
Date: Sun, 12 Jan 2025 20:42:05 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.or
Subject: [REGRESSION] Re: [PATCH v7 8/8] x86/module: enable ROX caches for
 module text on 64 bit
Message-ID: <Z4QM_RFfhNX_li_C@intel.com>
References: <20241023162711.2579610-1-rppt@kernel.org>
 <20241023162711.2579610-9-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241023162711.2579610-9-rppt@kernel.org>
X-Patchwork-Hint: comment
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_104223_752153_4F36DF25 
X-CRM114-Status: GOOD (  25.13  )
X-Mailman-Approved-At: Tue, 21 Jan 2025 08:07:46 -0800
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

On Wed, Oct 23, 2024 at 07:27:11PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>=20
> Enable execmem's cache of PMD_SIZE'ed pages mapped as ROX for module
> text allocations on 64 bit.

Hi,

This breaks resume from hibernation on my Alderlake laptop.

Fortunately this still reverts cleanly.

pstore managed to catch the following oops (seems to blow up on
bringing up the second ht of the second pcore for whatever reason):

<6>[   33.993727] PM: hibernation: hibernation entry
<6>[   34.154410] Filesystems sync: 0.006 seconds
<6>[   34.154418] Freezing user space processes
<6>[   34.156019] Freezing user space processes completed (elapsed 0.001 se=
conds)
<6>[   34.156026] OOM killer disabled.
<6>[   34.160470] PM: hibernation: Preallocating image memory
<6>[   34.330327] PM: hibernation: Allocated 387861 pages for snapshot
<6>[   34.330328] PM: hibernation: Allocated 1551444 kbytes in 0.16 seconds=
 (9696.52 MB/s)
<6>[   34.330330] Freezing remaining freezable tasks
<6>[   34.331499] Freezing remaining freezable tasks completed (elapsed 0.0=
01 seconds)
<6>[   34.351602] printk: Suspending console(s) (use no_console_suspend to =
debug)
<6>[   34.836184] ACPI: EC: interrupt blocked
<6>[   34.858903] ACPI: PM: Preparing to enter system sleep state S4
<6>[   34.868434] ACPI: EC: event blocked
<6>[   34.868434] ACPI: EC: EC stopped
<6>[   34.868435] ACPI: PM: Saving platform NVS memory
<6>[   34.872538] Disabling non-boot CPUs ...
<6>[   34.874012] smpboot: CPU 15 is now offline
<6>[   34.875511] smpboot: CPU 14 is now offline
<6>[   34.877209] smpboot: CPU 13 is now offline
<6>[   34.879173] smpboot: CPU 12 is now offline
<6>[   34.881117] smpboot: CPU 11 is now offline
<6>[   34.882952] smpboot: CPU 10 is now offline
<6>[   34.885175] smpboot: CPU 9 is now offline
<6>[   34.886844] smpboot: CPU 8 is now offline
<6>[   34.889056] smpboot: CPU 7 is now offline
<6>[   34.891866] smpboot: CPU 6 is now offline
<6>[   34.893685] smpboot: CPU 5 is now offline
<6>[   34.896856] smpboot: CPU 4 is now offline
<6>[   34.900015] smpboot: CPU 3 is now offline
<6>[   34.902355] smpboot: CPU 2 is now offline
<6>[   34.906162] smpboot: CPU 1 is now offline
<6>[   34.914835] PM: hibernation: Creating image:
<6>[   35.074645] PM: hibernation: Need to copy 348072 pages
<6>[   34.915076] ACPI: PM: Restoring platform NVS memory
<6>[   34.916499] ACPI: EC: EC started
<6>[   34.918228] Enabling non-boot CPUs ...
<6>[   34.918248] smpboot: Booting Node 0 Processor 1 APIC 0x1
<6>[   34.920121] CPU1 is up
<6>[   34.920132] smpboot: Booting Node 0 Processor 2 APIC 0x8
<6>[   34.923737] CPU2 is up
<6>[   34.923746] smpboot: Booting Node 0 Processor 3 APIC 0x9
<1>[   34.927019] BUG: kernel NULL pointer dereference, address: 0000000000=
000008
<1>[   34.927023] #PF: supervisor write access in kernel mode
<1>[   34.927024] #PF: error_code(0x0002) - not-present page
<6>[   34.927026] PGD 0 P4D 0=20
<4>[   34.927028] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
<4>[   34.927030] CPU: 3 UID: 0 PID: 93 Comm: cpuhp/3 Not tainted 6.13.0-rc=
5+ #406
<4>[   34.927033] Hardware name: LENOVO 21AJS29M0Q/21AJS29M0Q, BIOS N3MET18=
W (1.17 ) 10/24/2023
<4>[   34.927033] RIP: 0010:__rmqueue_pcplist+0x1c9/0x6f0
<4>[   34.927039] Code: 00 00 48 39 f0 0f 84 7c 01 00 00 49 89 c6 49 83 ee =
08 0f 84 6f 01 00 00 48 8b 78 08 41 b8 01 00 00 00 89 ce 4c 8b 08 41 d3 e0 =
<49> 89 79 08 4c 89 0f 48 bf 00 01 00 00 00 00 ad de 48 89 38 48 83
<4>[   34.927041] RSP: 0000:ffffc90000457840 EFLAGS: 00010082
<4>[   34.927042] RAX: ffffea000427af48 RBX: ffff88844e2f0720 RCX: 00000000=
00000000
<4>[   34.927043] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff=
827f0f00
<4>[   34.927043] RBP: 0000000000000000 R08: 0000000000000001 R09: 00000000=
00000000
<4>[   34.927044] R10: ffff88844e2f0700 R11: 0000000000000001 R12: 00000000=
00000000
<4>[   34.927044] R13: ffffffff827f0e40 R14: ffffea000427af40 R15: ffffffff=
ffffffff
<4>[   34.927045] FS:  0000000000000000(0000) GS:ffff88844e2c0000(0000) knl=
GS:0000000000000000
<4>[   34.927046] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[   34.927046] CR2: 0000000000000008 CR3: 000000000402e001 CR4: 00000000=
00372ef0
<4>[   34.927047] Call Trace:
<4>[   34.927048]  <TASK>
<4>[   34.927049]  ? __die+0x1a/0x60
<4>[   34.927053]  ? page_fault_oops+0x157/0x440
<4>[   34.927055]  ? exc_page_fault+0x444/0x710
<4>[   34.927058]  ? asm_exc_page_fault+0x22/0x30
<4>[   34.927060]  ? __rmqueue_pcplist+0x1c9/0x6f0
<4>[   34.927061]  get_page_from_freelist+0x20f/0xf00
<4>[   34.927063]  __alloc_pages_noprof+0x111/0x240
<4>[   34.927065]  allocate_slab+0x24f/0x3c0
<4>[   34.927066]  ? get_page_from_freelist+0x21a/0xf00
<4>[   34.927067]  ___slab_alloc+0x42a/0xb80
<4>[   34.927069]  ? __kernfs_new_node.isra.0+0x59/0x1e0
<4>[   34.927071]  ? get_nohz_timer_target+0x29/0x140
<4>[   34.927073]  ? timerqueue_add+0x62/0xb0
<4>[   34.927074]  kmem_cache_alloc_noprof+0x17a/0x220
<4>[   34.927076]  __kernfs_new_node.isra.0+0x59/0x1e0
<4>[   34.927077]  ? dl_server_stop+0x26/0x30
<4>[   34.927079]  ? dequeue_entities+0x33b/0x5f0
<4>[   34.927080]  kernfs_new_node+0x3b/0x60
<4>[   34.927081]  kernfs_create_dir_ns+0x22/0x80
<4>[   34.927083]  sysfs_create_dir_ns+0x6b/0xd0
<4>[   34.927085]  kobject_add_internal+0x9e/0x270
<4>[   34.927087]  kobject_add+0x79/0xe0
<4>[   34.927088]  ? __kmalloc_cache_noprof+0x105/0x240
<4>[   34.927090]  device_add+0xb7/0x7d0
<4>[   34.927092]  ? complete_all+0x1b/0x80
<4>[   34.927095]  cpu_device_create+0xea/0x100
<4>[   34.927097]  ? __pfx_smpboot_thread_fn+0x10/0x10
<4>[   34.927099]  ? __set_cpus_allowed_ptr+0x47/0x90
<4>[   34.927100]  ? detect_cache_attributes+0xd2/0x330
<4>[   34.927102]  ? __pfx_cacheinfo_cpu_online+0x10/0x10
<4>[   34.927104]  cacheinfo_cpu_online+0x94/0x270
<4>[   34.927105]  ? __pfx_cacheinfo_cpu_online+0x10/0x10
<4>[   34.927107]  ? __pfx_smpboot_thread_fn+0x10/0x10
<4>[   34.927108]  cpuhp_invoke_callback+0x10e/0x4b0
<4>[   34.927110]  ? __pfx_smpboot_thread_fn+0x10/0x10
<4>[   34.927111]  cpuhp_thread_fun+0xcf/0x150
<4>[   34.927112]  smpboot_thread_fn+0xd1/0x1c0
<4>[   34.927113]  kthread+0xc6/0x100
<4>[   34.927115]  ? __pfx_kthread+0x10/0x10
<4>[   34.927115]  ret_from_fork+0x28/0x40
<4>[   34.927117]  ? __pfx_kthread+0x10/0x10
<4>[   34.927118]  ret_from_fork_asm+0x1a/0x30
<4>[   34.927120]  </TASK>
<4>[   34.927120] Modules linked in: fuse ctr ccm sch_fq_codel cmac xt_mult=
iport xt_tcpudp xt_state iptable_filter xt_MASQUERADE iptable_nat nf_nat nf=
_conntrack nf_defrag_ipv4 ip_tables x_tables bnep btusb uvcvideo btrtl btin=
tel videobuf2_vmalloc btbcm videobuf2_memops btmtk uvc videobuf2_v4l2 bluet=
ooth videodev videobuf2_common ecdh_generic mc ecc binfmt_misc snd_hda_code=
c_hdmi mousedev snd_hda_codec_realtek snd_hda_codec_generic snd_hda_scodec_=
component snd_ctl_led iwlmvm mac80211 libarc4 i915 snd_hda_intel snd_intel_=
dspcfg i2c_algo_bit snd_hda_codec drm_buddy xhci_pci intel_tcc_cooling mei_=
hdcp snd_hwdep ttm mei_pxp mei_wdt processor_thermal_device_pci snd_hda_cor=
e x86_pkg_temp_thermal processor_thermal_device xhci_hcd thinkpad_acpi inte=
l_powerclamp 8250_pci processor_thermal_wt_hint drm_display_helper snd_pcm =
processor_thermal_rfim i2c_hid_acpi coretemp 8250 processor_thermal_rapl nv=
ram i2c_hid iwlwifi kvm_intel drm_kms_helper usbcore intel_rapl_msr 8250_ba=
se iTCO_wdt intel_rapl_common platform_profile hid snd_timer
<4>[   34.927180]  intel_gtt mei_me serial_mctrl_gpio led_class processor_t=
hermal_wt_req cfg80211 kvm thunderbolt e1000e snd efi_pstore intel_lpss_pci=
 serial_base usb_common agpgart processor_thermal_power_floor spi_intel_pci=
 i2c_i801 intel_lpss mei soundcore processor_thermal_mbox drm rfkill pstore=
 spi_intel mfd_core tpm_tis i2c_smbus psmouse tpm_tis_core zlib_deflate pcs=
pkr evdev tpm think_lmi video intel_pmc_core firmware_attributes_class inte=
l_hid sparse_keymap int3403_thermal intel_vsec pinctrl_tigerlake int3400_th=
ermal wmi int340x_thermal_zone pmt_telemetry i2c_core backlight pinctrl_int=
el pmt_class acpi_thermal_rel efivarfs
<4>[   34.927209] CR2: 0000000000000008
<4>[   34.927210] ---[ end trace 0000000000000000 ]---

>=20
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Tested-by: kdevops <kdevops@lists.linux.dev>
> ---
>  arch/x86/Kconfig   |  1 +
>  arch/x86/mm/init.c | 37 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2852fcd82cbd..ff71d18253ba 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -83,6 +83,7 @@ config X86
>  	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
>  	select ARCH_HAS_EARLY_DEBUG		if KGDB
>  	select ARCH_HAS_ELF_RANDOMIZE
> +	select ARCH_HAS_EXECMEM_ROX		if X86_64
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index eb503f53c319..c2e4f389f47f 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -1053,18 +1053,53 @@ unsigned long arch_max_swapfile_size(void)
>  #ifdef CONFIG_EXECMEM
>  static struct execmem_info execmem_info __ro_after_init;
> =20
> +#ifdef CONFIG_ARCH_HAS_EXECMEM_ROX
> +void execmem_fill_trapping_insns(void *ptr, size_t size, bool writeable)
> +{
> +	/* fill memory with INT3 instructions */
> +	if (writeable)
> +		memset(ptr, INT3_INSN_OPCODE, size);
> +	else
> +		text_poke_set(ptr, INT3_INSN_OPCODE, size);
> +}
> +#endif
> +
>  struct execmem_info __init *execmem_arch_setup(void)
>  {
>  	unsigned long start, offset =3D 0;
> +	enum execmem_range_flags flags;
> +	pgprot_t pgprot;
> =20
>  	if (kaslr_enabled())
>  		offset =3D get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
> =20
>  	start =3D MODULES_VADDR + offset;
> =20
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_EXECMEM_ROX)) {
> +		pgprot =3D PAGE_KERNEL_ROX;
> +		flags =3D EXECMEM_KASAN_SHADOW | EXECMEM_ROX_CACHE;
> +	} else {
> +		pgprot =3D PAGE_KERNEL;
> +		flags =3D EXECMEM_KASAN_SHADOW;
> +	}
> +
>  	execmem_info =3D (struct execmem_info){
>  		.ranges =3D {
> -			[EXECMEM_DEFAULT] =3D {
> +			[EXECMEM_MODULE_TEXT] =3D {
> +				.flags	=3D flags,
> +				.start	=3D start,
> +				.end	=3D MODULES_END,
> +				.pgprot	=3D pgprot,
> +				.alignment =3D MODULE_ALIGN,
> +			},
> +			[EXECMEM_KPROBES ... EXECMEM_BPF] =3D {
> +				.flags	=3D EXECMEM_KASAN_SHADOW,
> +				.start	=3D start,
> +				.end	=3D MODULES_END,
> +				.pgprot	=3D PAGE_KERNEL,
> +				.alignment =3D MODULE_ALIGN,
> +			},
> +			[EXECMEM_MODULE_DATA] =3D {
>  				.flags	=3D EXECMEM_KASAN_SHADOW,
>  				.start	=3D start,
>  				.end	=3D MODULES_END,
> --=20
> 2.43.0
>=20

--=20
Ville Syrj=E4l=E4
Intel

