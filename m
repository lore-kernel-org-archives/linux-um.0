Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED097606A326
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=o0cLppt6;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026102901 header.b=CZ4dsDIj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AMHZHhzuTrdOCzsJR0G5h0s+H2Tf/Af2ZIw878OYuL8=; b=o0cLppt6yGdPyv
	vBxT9BU8cSv/4xmC/9eldLatreKySPCJd6pDs3Uz+G0Dv0T+D4shXEKxMsC0VU39KD+gMvKGydnrD
	K2I9bSo39+ZOZ6t7+puJbjG3yMd+shQq9Jmja6ED9e1gJxmoFEbXU1x0uO24gUjMcMa7FweAt2SSD
	2puBGKlI26zhw5BDC0/q2rnTW6M6JFNVlY4KVn2K8Iyed9xPV8BfRrcHgJaLxqoQUcpB5eO4pTfVm
	g1YnoFlxR4AH3BAMLc2pBsFmJBbVO0enq1zhUTZFTEiE1lkjI5yPbnNUvhLSB1Qu9+wt3CdUmPBmT
	mxhejHP60EA3lK4hO/yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3uN-0000000AXlp-3ble;
	Thu, 05 Nov 2026 20:18:03 +0000
Received: from terminus.zytor.com ([2607:7c80:54:3::136] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP3uK-0000000AXkt-2BtK
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 20:18:01 +0000
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6A5KHO2x3333264
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 5 Nov 2026 12:17:24 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6A5KHO2x3333264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026102901; t=1793909846;
	bh=AMHZHhzuTrdOCzsJR0G5h0s+H2Tf/Af2ZIw878OYuL8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CZ4dsDIjSvNcfIZhbQny/XQsE6A5ymlAfOsmou/O/6R47WaoiGHL8XGN+RE+gqCGV
	 8vvvVrRb4kGRStpvS8dbW3XxwqkCQGAur3anO4RIcpeQkSoeFXIei3onSuxU4ckITS
	 MnFOjLMxxzYbzmGo+wL0cTz6n2FHCFOzxXF+FyePm77nSz7Uk8HHPSBWDBvshKSDl2
	 LQjol5z1F6Qtztjxt/bERmCkdMDTEKRVg9DoPYlfU8mRxqDgfTdjffTe6FuSZ9tI7A
	 /Md3HgaiKjQCiSz7EXtpxmZU7t4JrHSKR8HafSW3juZbRSJ/OfP4/BrdzLzjOiPCBI
	 kBYc0vhRDvqMg==
Date: Thu, 05 Nov 2026 12:17:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>
CC: Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 7/7] x86: simplify 32-bit instruction set selection
User-Agent: K-9 Mail for Android
In-Reply-To: <20261105163440.2381661-8-arnd@kernel.org>
References: <20261105163440.2381661-1-arnd@kernel.org> <20261105163440.2381661-8-arnd@kernel.org>
Message-ID: <4207CA81-6023-4DFC-8FBF-2C5C8C036CCC@zytor.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_121800_571120_6F1ACAF5 
X-CRM114-Status: GOOD (  21.23  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On November 5, 2026 8:34:38 AM PST, Arnd Bergmann <arnd@kernel=2Eorg> wrote=
:
>From: Arnd Bergmann <arnd@arndb=2Ede>
>
>The -march=3D compiler flags select both instruction set and tuning for
>a particular CPU, which works well when building a kernel that can only
>run on this one type, but has some counterintuitive effects because it
>is not always clear which models are compatible=2E
>
>E=2Eg=2E building for Geode LX results in a kernel that can work on all o=
n
>all 686-class CPUs but crashes on CPUs without the CMOV instructions=2E
>Building a kernel for 686 could work on Geode LX and Crusoe but fails
>because of the CPU generation check that detects these as 585-class=2E
>Similarly, building for Intel Atom produces a 32-bit kernel that uses
>the MOVBE instructions and does not work on any other 32-bit CPU or
>even 64-bit CPUs before Haswell/Excavator=2E
>
>Change the CPU selection to build everything with either -march=3Di586
>or -march=3Di686 and make the specific options only change the -mtune=3D
>parameter where this was previously handled by -march=3D=2E Note that
>the only -mtune=3D options that gcc or clang understand for x86-32
>are i486, pentium, pentiumpro, pentium4, atom, geode, k6 and athlon,
>the other ten are just aliases for one of them=2E
>
>Selecting any 586-class configuration option now produces a kernel that
>works on every supported CPU, while selecting a 686-class configuration
>works on all 686-class CPUs but no 586-class ones=2E
>
>Consequently, the vermagic=2Eh logic can be simplified to just these
>two cases=2E
>
>Signed-off-by: Arnd Bergmann <arnd@arndb=2Ede>
>---
> arch/x86/Kconfig=2Ecpu            | 13 +++++-------
> arch/x86/Makefile_32=2Ecpu        | 16 +++++++--------
> arch/x86/include/asm/vermagic=2Eh | 36 ++-------------------------------
> 3 files changed, 15 insertions(+), 50 deletions(-)
>
>diff --git a/arch/x86/Kconfig=2Ecpu b/arch/x86/Kconfig=2Ecpu
>index 21026e0cb569=2E=2E121881c4d076 100644
>--- a/arch/x86/Kconfig=2Ecpu
>+++ b/arch/x86/Kconfig=2Ecpu
>@@ -6,9 +6,9 @@ choice
> 	default M686
> 	help
> 	  This is the processor type of your CPU=2E This information is
>-	  used for optimizing purposes=2E In order to compile a kernel
>-	  that can run on all supported x86 CPU types (albeit not
>-	  optimally fast), you can specify "586" here=2E
>+	  used to pick between i586-class and i686-class processors,
>+	  as well as to optimize for a particular microarchitecture
>+	  within the two classes=2E
>=20
> 	  Note that the 386 and 486 is no longer supported, this includes
> 	  AMD/Cyrix/Intel 386DX/DXL/SL/SLC/SX, Cyrix/TI 486DLC/DLC2,
>@@ -164,16 +164,13 @@ config MCYRIXIII
> 	  treat this chip as a generic 586=2E Whilst the CPU is 686 class,
> 	  it lacks the cmov extension which gcc assumes is present when
> 	  generating 686 code=2E
>-	  Note that Nehemiah (Model 9) and above will not boot with this
>-	  kernel due to them lacking the 3DNow! instructions used in earlier
>-	  incarnations of the CPU=2E
>=20
> config MVIAC3_2
> 	bool "VIA C3-2 (Nehemiah)"
> 	depends on X86_32
> 	help
>-	  Select this for a VIA C3 "Nehemiah"=2E Selecting this enables usage
>-	  of SSE and tells gcc to treat the CPU as a 686=2E
>+	  Select this for a VIA C3 "Nehemiah"=2E Selecting tells gcc to treat
>+	  the CPU as a 686=2E
> 	  Note, this kernel will not boot on older (pre model 9) C3s=2E
>=20
> config MVIAC7
>diff --git a/arch/x86/Makefile_32=2Ecpu b/arch/x86/Makefile_32=2Ecpu
>index c5aa169b596d=2E=2E1735a5f95d33 100644
>--- a/arch/x86/Makefile_32=2Ecpu
>+++ b/arch/x86/Makefile_32=2Ecpu
>@@ -11,26 +11,26 @@ align		:=3D -falign-functions=3D0 -falign-jumps=3D0 -=
falign-loops=3D0
> endif
>=20
> cflags-$(CONFIG_M586TSC)	+=3D -march=3Di586
>-cflags-$(CONFIG_M586MMX)	+=3D -march=3Dpentium-mmx
>+cflags-$(CONFIG_M586MMX)	+=3D -march=3Di586
> cflags-$(CONFIG_M686)		+=3D -march=3Di686
> cflags-$(CONFIG_MPENTIUMII)	+=3D -march=3Di686 $(call tune,pentium2)
> cflags-$(CONFIG_MPENTIUMIII)	+=3D -march=3Di686 $(call tune,pentium3)
> cflags-$(CONFIG_MPENTIUMM)	+=3D -march=3Di686 $(call tune,pentium3)
> cflags-$(CONFIG_MPENTIUM4)	+=3D -march=3Di686 $(call tune,pentium4)
>-cflags-$(CONFIG_MK6)		+=3D -march=3Dk6
>+cflags-$(CONFIG_MK6)		+=3D -march=3Di586 $(call tune,k6)
> # Please note, that patches that add -march=3Dathlon-xp and friends are =
pointless=2E
> # They make zero difference whatsosever to performance at this time=2E
>-cflags-$(CONFIG_MK7)		+=3D -march=3Dathlon
>+cflags-$(CONFIG_MK7)		+=3D -march=3Di686 $(call tune,athlon)
> cflags-$(CONFIG_MCRUSOE)	+=3D -march=3Di686 $(align)
> cflags-$(CONFIG_MEFFICEON)	+=3D -march=3Di686 $(call tune,pentium3) $(al=
ign)
>-cflags-$(CONFIG_MCYRIXIII)	+=3D $(call cc-option,-march=3Dc3,-march=3Di4=
86) $(align)
>-cflags-$(CONFIG_MVIAC3_2)	+=3D $(call cc-option,-march=3Dc3-2,-march=3Di=
686)
>+cflags-$(CONFIG_MCYRIXIII)	+=3D -march=3Di586 $(call tune,i486) $(align)
>+cflags-$(CONFIG_MVIAC3_2)	+=3D -march=3Di686
> cflags-$(CONFIG_MVIAC7)		+=3D -march=3Di686
>-cflags-$(CONFIG_MATOM)		+=3D -march=3Datom
>+cflags-$(CONFIG_MATOM)		+=3D -march=3Di686 $(call tune,atom)
>=20
> # Geode GX1 support
>-cflags-$(CONFIG_MGEODEGX1)	+=3D -march=3Dpentium-mmx
>-cflags-$(CONFIG_MGEODE_LX)	+=3D $(call cc-option,-march=3Dgeode,-march=
=3Dpentium-mmx)
>+cflags-$(CONFIG_MGEODEGX1)	+=3D -march=3Di586 $(call tune,geode)
>+cflags-$(CONFIG_MGEODE_LX)	+=3D -march=3Di586 $(call tune,geode)
> # add at the end to overwrite eventual tuning options from earlier
> # cpu entries
> cflags-$(CONFIG_X86_GENERIC) 	+=3D $(call tune,generic,$(call tune,i686)=
)
>diff --git a/arch/x86/include/asm/vermagic=2Eh b/arch/x86/include/asm/ver=
magic=2Eh
>index e26061df0c9b=2E=2E5323ed585bc9 100644
>--- a/arch/x86/include/asm/vermagic=2Eh
>+++ b/arch/x86/include/asm/vermagic=2Eh
>@@ -5,42 +5,10 @@
>=20
> #ifdef CONFIG_X86_64
> /* X86_64 does not define MODULE_PROC_FAMILY */
>-#elif defined CONFIG_M586TSC
>-#define MODULE_PROC_FAMILY "586TSC "
>-#elif defined CONFIG_M586MMX
>-#define MODULE_PROC_FAMILY "586MMX "
>-#elif defined CONFIG_MATOM
>-#define MODULE_PROC_FAMILY "ATOM "
>-#elif defined CONFIG_M686
>+#elif CONFIG_X86_MINIMUM_CPU_FAMILY =3D=3D 6
> #define MODULE_PROC_FAMILY "686 "
>-#elif defined CONFIG_MPENTIUMII
>-#define MODULE_PROC_FAMILY "PENTIUMII "
>-#elif defined CONFIG_MPENTIUMIII
>-#define MODULE_PROC_FAMILY "PENTIUMIII "
>-#elif defined CONFIG_MPENTIUMM
>-#define MODULE_PROC_FAMILY "PENTIUMM "
>-#elif defined CONFIG_MPENTIUM4
>-#define MODULE_PROC_FAMILY "PENTIUM4 "
>-#elif defined CONFIG_MK6
>-#define MODULE_PROC_FAMILY "K6 "
>-#elif defined CONFIG_MK7
>-#define MODULE_PROC_FAMILY "K7 "
>-#elif defined CONFIG_MCRUSOE
>-#define MODULE_PROC_FAMILY "CRUSOE "
>-#elif defined CONFIG_MEFFICEON
>-#define MODULE_PROC_FAMILY "EFFICEON "
>-#elif defined CONFIG_MCYRIXIII
>-#define MODULE_PROC_FAMILY "CYRIXIII "
>-#elif defined CONFIG_MVIAC3_2
>-#define MODULE_PROC_FAMILY "VIAC3-2 "
>-#elif defined CONFIG_MVIAC7
>-#define MODULE_PROC_FAMILY "VIAC7 "
>-#elif defined CONFIG_MGEODEGX1
>-#define MODULE_PROC_FAMILY "GEODEGX1 "
>-#elif defined CONFIG_MGEODE_LX
>-#define MODULE_PROC_FAMILY "GEODE "
> #else
>-#error unknown processor family
>+#define MODULE_PROC_FAMILY "586 "
> #endif
>=20
> #ifdef CONFIG_X86_32

Crusoe (TM3xxx/TM5xxx) do have a handful of compiler/user space visible it=
ems that are missing from i686, as I recall notably the long nop instructio=
ns and *possibly* fcomi (I *think* we caught that one, but I'm not 100% sur=
e=2E)

As a result, it reports correctly as family 5=2E


