Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989B4CF855A
	for <linux-um@archiver.kernel.org>; Thu,  3 Oct 2024 04:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/60/8wx6TbhlqvUyeLWQvUQcyo91KnWb9aUOijCaGI=; b=hEZ+eDKDTpmcyu4sj0vwApeJUz
	GGfEDu4CK5vmf6r7VdN34Yp6gCFjldH3f0ZULpQ//F7JBcppGXBKYguH4TMROCQDJVUc0gnAZfu3c
	LYoOtUYMIRhh8UJRLQlmuF+6BwzOF1oYoOJ+Jclgl73VzTvCTeGVY9IIFmDin5piCW6dx+MT99cR3
	dPiOyk+PeUSyTrabJaqmfNWoq7C+/crvsEDd8G0JB6oDznDcTxdzzdMJBbqcn6c/1M1YH4HVCXdqF
	5SrUUZbzXgCPm3ChFVwIVzBwnbUkClMawhticWLOG1n5IN3Z+dWywXD16+t4W+IyciF5Vq1Ia5Ubp
	H6Fp5Jmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swDOO-000000088gV-2An1;
	Thu, 03 Oct 2024 04:24:44 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swDN7-000000088XF-0DrI;
	Thu, 03 Oct 2024 04:23:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727929405; x=1759465405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EtmmmjmtCv7y2r6N/47etXvFSsaT+TfFyuK+t624T28=;
  b=NnrSRKHv0SBx3Hswneo/rieW7MNgPDLaakZwcuVe20fYKlLV7KE3/7mx
   TmbQXAYoDv2QhOIKuzzQkhazi+/JHd+pUkEaT/R+2wFRQ/x5I6MVcI7+e
   jzeyQF8qHVqcKGrJeN4a2757aBbp+xi8vz0jiDVvWUOv/zVwJDeHFy6hN
   RgiK0mvGg93yjEVU+zn4jZEJJzv+VXiimiBHa9cIBRZnDDu20M+UVsZ9+
   i/s3kUVVUMvkQ2ehL/KucD5utJbFwOJqz/p15DEJPmzjNqGZFiDV1eUWI
   IFt43WdessQo2JQuqKbJmDWSkNqGonxXRCdLGpX3jRAad5pZQHf2xNgiU
   g==;
X-CSE-ConnectionGUID: Ln9hfmoITIqz5SbATUJ10Q==
X-CSE-MsgGUID: BL+GrJ3ARv2Y30INAnjzeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27291016"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27291016"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 21:23:21 -0700
X-CSE-ConnectionGUID: WkoeICGXRPSQ1BhbC3+oiA==
X-CSE-MsgGUID: r5WHHwS8RfqeYPAtPz/yNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="79072842"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 02 Oct 2024 21:23:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swDMt-000024-1U;
	Thu, 03 Oct 2024 04:23:11 +0000
Date: Thu, 3 Oct 2024 12:23:06 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Vetter <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v7 01/10] Consolidate IO memcpy/memset into iomap_copy.c
Message-ID: <202410031104.2bzZJyNF-lkp@intel.com>
References: <20240930132321.2785718-2-jvetter@kalrayinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930132321.2785718-2-jvetter@kalrayinc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_212325_175137_0B202311 
X-CRM114-Status: GOOD (  13.71  )
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

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on deller-parisc/for-next linus/master arm/for-next arm/fixes v6.12-rc1 next-20241002]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Vetter/Consolidate-IO-memcpy-memset-into-iomap_copy-c/20240930-213742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20240930132321.2785718-2-jvetter%40kalrayinc.com
patch subject: [PATCH v7 01/10] Consolidate IO memcpy/memset into iomap_copy.c
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20241003/202410031104.2bzZJyNF-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241003/202410031104.2bzZJyNF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410031104.2bzZJyNF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/io.h:14,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:8,
                    from include/linux/cgroup.h:25,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/powerpc/kernel/asm-offsets.c:21:
>> arch/powerpc/include/asm/io.h:709:23: error: conflicting types for 'memcpy_fromio'; have 'void(void *, const volatile void *, size_t)' {aka 'void(void *, const volatile void *, unsigned int)'}
     709 | #define memcpy_fromio memcpy_fromio
         |                       ^~~~~~~~~~~~~
   include/asm-generic/io.h:105:13: note: in expansion of macro 'memcpy_fromio'
     105 | extern void memcpy_fromio(void *to, const volatile void __iomem *from,
         |             ^~~~~~~~~~~~~
   arch/powerpc/include/asm/io-defs.h:58:18: note: previous definition of 'memcpy_fromio' with type 'void(void *, const volatile void *, long unsigned int)'
      58 | DEF_PCI_AC_NORET(memcpy_fromio, (void *d, const PCI_IO_ADDR s, unsigned long n),
         |                  ^~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:664:20: note: in definition of macro 'DEF_PCI_AC_NORET'
     664 | static inline void name at                                      \
         |                    ^~~~
>> arch/powerpc/include/asm/io.h:710:21: error: conflicting types for 'memcpy_toio'; have 'void(volatile void *, const void *, size_t)' {aka 'void(volatile void *, const void *, unsigned int)'}
     710 | #define memcpy_toio memcpy_toio
         |                     ^~~~~~~~~~~
   include/asm-generic/io.h:107:13: note: in expansion of macro 'memcpy_toio'
     107 | extern void memcpy_toio(volatile void __iomem *to, const void *from,
         |             ^~~~~~~~~~~
   arch/powerpc/include/asm/io-defs.h:60:18: note: previous definition of 'memcpy_toio' with type 'void(volatile void *, const void *, long unsigned int)'
      60 | DEF_PCI_AC_NORET(memcpy_toio, (PCI_IO_ADDR d, const void *s, unsigned long n),
         |                  ^~~~~~~~~~~
   arch/powerpc/include/asm/io.h:664:20: note: in definition of macro 'DEF_PCI_AC_NORET'
     664 | static inline void name at                                      \
         |                    ^~~~
>> arch/powerpc/include/asm/io.h:708:19: error: conflicting types for 'memset_io'; have 'void(volatile void *, int,  size_t)' {aka 'void(volatile void *, int,  unsigned int)'}
     708 | #define memset_io memset_io
         |                   ^~~~~~~~~
   include/asm-generic/io.h:109:13: note: in expansion of macro 'memset_io'
     109 | extern void memset_io(volatile void __iomem *dst, int c, size_t count);
         |             ^~~~~~~~~
   arch/powerpc/include/asm/io-defs.h:56:18: note: previous definition of 'memset_io' with type 'void(volatile void *, int,  long unsigned int)'
      56 | DEF_PCI_AC_NORET(memset_io, (PCI_IO_ADDR a, int c, unsigned long n),
         |                  ^~~~~~~~~
   arch/powerpc/include/asm/io.h:664:20: note: in definition of macro 'DEF_PCI_AC_NORET'
     664 | static inline void name at                                      \
         |                    ^~~~
   make[3]: *** [scripts/Makefile.build:117: arch/powerpc/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1193: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +709 arch/powerpc/include/asm/io.h

4cb3cee03d558f include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  676  
4cb3cee03d558f include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  677  /* Some drivers check for the presence of readq & writeq with
4cb3cee03d558f include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  678   * a #ifdef, so we make them happy here.
4cb3cee03d558f include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  679   */
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  680  #define readb readb
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  681  #define readw readw
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  682  #define readl readl
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  683  #define writeb writeb
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  684  #define writew writew
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  685  #define writel writel
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  686  #define readsb readsb
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  687  #define readsw readsw
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  688  #define readsl readsl
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  689  #define writesb writesb
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  690  #define writesw writesw
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  691  #define writesl writesl
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  692  #define inb inb
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  693  #define inw inw
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  694  #define inl inl
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  695  #define outb outb
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  696  #define outw outw
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  697  #define outl outl
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  698  #define insb insb
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  699  #define insw insw
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  700  #define insl insl
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  701  #define outsb outsb
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  702  #define outsw outsw
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21  703  #define outsl outsl
68a64357d15ae4 include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-13  704  #ifdef __powerpc64__
4cb3cee03d558f include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  705  #define readq	readq
4cb3cee03d558f include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-11  706  #define writeq	writeq
68a64357d15ae4 include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-13  707  #endif
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21 @708  #define memset_io memset_io
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21 @709  #define memcpy_fromio memcpy_fromio
894fa235eb4ca0 arch/powerpc/include/asm/io.h Christophe Leroy       2020-11-21 @710  #define memcpy_toio memcpy_toio
68a64357d15ae4 include/asm-powerpc/io.h      Benjamin Herrenschmidt 2006-11-13  711  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

