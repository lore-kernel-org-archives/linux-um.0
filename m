Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C07C83F2E
	for <linux-um@archiver.kernel.org>; Thu, 29 Aug 2024 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=48pDeNkBWlaIORB8ItlbBUnxodjBvmJErDFHF+GmEmU=; b=SlKKUhuDDBEfcHIimhwsRIdc1n
	DmZ/uGsT3+fQqU8RGpzIvXU/heoJx+HFPmS8b3ksLkY4aPQL0P6adyWn9qZPscR0UQSz/4TUCzCqy
	5QlP+hKeNPKTPawJCLnNgsi3sur6aRElhzRsat2Ynthtw6hH+0iI3waRmQ0pclJ6IS8G8baPic9al
	w4RhkgluTPZFQL4pI3X2DyFlrHjELpzb7WwrdYVJ9h5mlNT0cFiFcTESr8va0/EpCnni4uA82msX2
	t4zxXeNU2VGz6TtPMYLbcIeBc7Tc8eiz34AHYX3ejVxeASTmdTYfn/LprbCxvqKfy/SD9hiaczy04
	ZTduaUhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjgdV-00000002WGG-34kK;
	Thu, 29 Aug 2024 15:00:33 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjgcU-00000002Vup-34j5;
	Thu, 29 Aug 2024 14:59:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724943571; x=1756479571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LuHSMRJORq3jqFFNMteS+Q2synOJkKn5xhtJHp7x/CE=;
  b=evFNAoDXZBT5ipeseMKeJQ0mPLoUkSuPpXdgK+ktQkLTiqFurivkWM96
   EO+kmiYWCQbrWUVyjC2XE8cPwNP3cyyirkge0nEjzeK9WMKG0zS51aKkl
   UBIp/Gx3++YbgKBwj/ASyZpT6gnbEsewrJMKwHF9/4/yRH6EGfrjie6gH
   iDEYfgA2xOMcJ9fRVu7uvST0e0Q9o/3yEyLevgT9jINYW5u8460nWxiaX
   zha/Y9tFK4F1IVhiLQgvPFaTxAiuF/9onjDgv/P0b6ywPQIAq00Rucn5W
   FLxioeTpDX9V+X1/LA/TDkW9Q+XBOGLVdIp84OF/AX72nndxgpqGUs6XG
   Q==;
X-CSE-ConnectionGUID: 3WmFcq+4SkOHu4ktzeJYnw==
X-CSE-MsgGUID: yZbVd1HDQG6MvUsrGEGeRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="13282284"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="13282284"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 07:59:29 -0700
X-CSE-ConnectionGUID: 8/mRw1n+QH6bo8TAogLHzw==
X-CSE-MsgGUID: LVpn394rTTyiayzAEy+ASw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63229167"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 29 Aug 2024 07:59:26 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjgcN-0000Ny-1N;
	Thu, 29 Aug 2024 14:59:23 +0000
Date: Thu, 29 Aug 2024 22:58:47 +0800
From: kernel test robot <lkp@intel.com>
To: Vegard Nossum <vegard.nossum@oracle.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, linux-um@lists.infradead.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH] kbuild: use objcopy to generate asm-offsets
Message-ID: <202408292215.pEJKHLfT-lkp@intel.com>
References: <20240828083605.3093701-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828083605.3093701-1-vegard.nossum@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_075930_968513_DAEA5BB3 
X-CRM114-Status: GOOD (  11.82  )
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

Hi Vegard,

kernel test robot noticed the following build errors:

[auto build test ERROR on masahiroy-kbuild/for-next]
[also build test ERROR on masahiroy-kbuild/fixes soc/for-next kvmarm/next kvm/queue uml/next krzk-mem-ctrl/for-next bpf-next/master bpf/master linus/master v6.11-rc5 next-20240829]
[cannot apply to tmlind-omap/for-next kvm/linux-next uml/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vegard-Nossum/kbuild-use-objcopy-to-generate-asm-offsets/20240828-163854
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
patch link:    https://lore.kernel.org/r/20240828083605.3093701-1-vegard.nossum%40oracle.com
patch subject: [PATCH] kbuild: use objcopy to generate asm-offsets
config: sh-randconfig-r072-20240829 (https://download.01.org/0day-ci/archive/20240829/202408292215.pEJKHLfT-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408292215.pEJKHLfT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408292215.pEJKHLfT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from scripts/mod/file2alias.c:13:
   scripts/mod/file2alias.c: In function 'do_usb_entry':
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:66:55: note: in definition of macro 'TO_NATIVE'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                       ^
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:57:31: note: in definition of macro 'bswap'
      57 |         _Static_assert(sizeof(x) == 1 || sizeof(x) == 2 || \
         |                               ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:57:49: note: in definition of macro 'bswap'
      57 |         _Static_assert(sizeof(x) == 1 || sizeof(x) == 2 || \
         |                                                 ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:58:31: note: in definition of macro 'bswap'
      58 |                        sizeof(x) == 4 || sizeof(x) == 8, "bug"); \
         |                               ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:58:49: note: in definition of macro 'bswap'
      58 |                        sizeof(x) == 4 || sizeof(x) == 8, "bug"); \
         |                                                 ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:59:17: note: in definition of macro 'bswap'
      59 |         (typeof(x))(sizeof(x) == 2 ? bswap_16(x) : \
         |                 ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:59:28: note: in definition of macro 'bswap'
      59 |         (typeof(x))(sizeof(x) == 2 ? bswap_16(x) : \
         |                            ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
   In file included from scripts/mod/modpost.h:2:
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:66:59: note: in expansion of macro 'bswap'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                           ^~~~~
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:60:28: note: in definition of macro 'bswap'
      60 |                     sizeof(x) == 4 ? bswap_32(x) : \
         |                            ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:66:59: note: in expansion of macro 'bswap'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                           ^~~~~
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:61:28: note: in definition of macro 'bswap'
      61 |                     sizeof(x) == 8 ? bswap_64(x) : \
         |                            ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:66:59: note: in expansion of macro 'bswap'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                           ^~~~~
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:62:21: note: in definition of macro 'bswap'
      62 |                     x); \
         |                     ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:175:9: note: in expansion of macro 'DEF_FIELD'
     175 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:11:36: error: stray '#' in program
      11 | #define OFF_usb_device_id_idVendor #2 /* offsetof(struct usb_device_id, idVendor) */
         |                                    ^
   scripts/mod/modpost.h:66:55: note: in definition of macro 'TO_NATIVE'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                       ^
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_idVendor'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:176:9: note: in expansion of macro 'DEF_FIELD'
     176 |         DEF_FIELD(symval, usb_device_id, idVendor);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:11:36: error: stray '#' in program
      11 | #define OFF_usb_device_id_idVendor #2 /* offsetof(struct usb_device_id, idVendor) */
         |                                    ^
   scripts/mod/modpost.h:57:31: note: in definition of macro 'bswap'
      57 |         _Static_assert(sizeof(x) == 1 || sizeof(x) == 2 || \
         |                               ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_idVendor'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:176:9: note: in expansion of macro 'DEF_FIELD'
     176 |         DEF_FIELD(symval, usb_device_id, idVendor);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:11:36: error: stray '#' in program
      11 | #define OFF_usb_device_id_idVendor #2 /* offsetof(struct usb_device_id, idVendor) */
         |                                    ^
   scripts/mod/modpost.h:57:49: note: in definition of macro 'bswap'
      57 |         _Static_assert(sizeof(x) == 1 || sizeof(x) == 2 || \
         |                                                 ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_idVendor'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:176:9: note: in expansion of macro 'DEF_FIELD'
     176 |         DEF_FIELD(symval, usb_device_id, idVendor);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:11:36: error: stray '#' in program
      11 | #define OFF_usb_device_id_idVendor #2 /* offsetof(struct usb_device_id, idVendor) */
         |                                    ^
   scripts/mod/modpost.h:58:31: note: in definition of macro 'bswap'
      58 |                        sizeof(x) == 4 || sizeof(x) == 8, "bug"); \
         |                               ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_idVendor'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:176:9: note: in expansion of macro 'DEF_FIELD'
     176 |         DEF_FIELD(symval, usb_device_id, idVendor);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:11:36: error: stray '#' in program
      11 | #define OFF_usb_device_id_idVendor #2 /* offsetof(struct usb_device_id, idVendor) */
         |                                    ^
   scripts/mod/modpost.h:58:49: note: in definition of macro 'bswap'
      58 |                        sizeof(x) == 4 || sizeof(x) == 8, "bug"); \
         |                                                 ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_idVendor'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:176:9: note: in expansion of macro 'DEF_FIELD'
     176 |         DEF_FIELD(symval, usb_device_id, idVendor);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:11:36: error: stray '#' in program
      11 | #define OFF_usb_device_id_idVendor #2 /* offsetof(struct usb_device_id, idVendor) */
         |                                    ^
   scripts/mod/modpost.h:59:17: note: in definition of macro 'bswap'
      59 |         (typeof(x))(sizeof(x) == 2 ? bswap_16(x) : \
         |                 ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_idVendor'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:176:9: note: in expansion of macro 'DEF_FIELD'
     176 |         DEF_FIELD(symval, usb_device_id, idVendor);
--
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_bInterfaceNumber'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:185:9: note: in expansion of macro 'DEF_FIELD'
     185 |         DEF_FIELD(symval, usb_device_id, bInterfaceNumber);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:21:44: error: stray '#' in program
      21 | #define OFF_usb_device_id_bInterfaceNumber #16 /* offsetof(struct usb_device_id, bInterfaceNumber) */
         |                                            ^
   scripts/mod/modpost.h:66:59: note: in expansion of macro 'bswap'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                           ^~~~~
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_bInterfaceNumber'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:185:9: note: in expansion of macro 'DEF_FIELD'
     185 |         DEF_FIELD(symval, usb_device_id, bInterfaceNumber);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:21:44: error: stray '#' in program
      21 | #define OFF_usb_device_id_bInterfaceNumber #16 /* offsetof(struct usb_device_id, bInterfaceNumber) */
         |                                            ^
   scripts/mod/modpost.h:60:28: note: in definition of macro 'bswap'
      60 |                     sizeof(x) == 4 ? bswap_32(x) : \
         |                            ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_bInterfaceNumber'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:185:9: note: in expansion of macro 'DEF_FIELD'
     185 |         DEF_FIELD(symval, usb_device_id, bInterfaceNumber);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:21:44: error: stray '#' in program
      21 | #define OFF_usb_device_id_bInterfaceNumber #16 /* offsetof(struct usb_device_id, bInterfaceNumber) */
         |                                            ^
   scripts/mod/modpost.h:66:59: note: in expansion of macro 'bswap'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                           ^~~~~
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_bInterfaceNumber'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:185:9: note: in expansion of macro 'DEF_FIELD'
     185 |         DEF_FIELD(symval, usb_device_id, bInterfaceNumber);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:21:44: error: stray '#' in program
      21 | #define OFF_usb_device_id_bInterfaceNumber #16 /* offsetof(struct usb_device_id, bInterfaceNumber) */
         |                                            ^
   scripts/mod/modpost.h:61:28: note: in definition of macro 'bswap'
      61 |                     sizeof(x) == 8 ? bswap_64(x) : \
         |                            ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_bInterfaceNumber'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:185:9: note: in expansion of macro 'DEF_FIELD'
     185 |         DEF_FIELD(symval, usb_device_id, bInterfaceNumber);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:21:44: error: stray '#' in program
      21 | #define OFF_usb_device_id_bInterfaceNumber #16 /* offsetof(struct usb_device_id, bInterfaceNumber) */
         |                                            ^
   scripts/mod/modpost.h:66:59: note: in expansion of macro 'bswap'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                           ^~~~~
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_bInterfaceNumber'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:185:9: note: in expansion of macro 'DEF_FIELD'
     185 |         DEF_FIELD(symval, usb_device_id, bInterfaceNumber);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:21:44: error: stray '#' in program
      21 | #define OFF_usb_device_id_bInterfaceNumber #16 /* offsetof(struct usb_device_id, bInterfaceNumber) */
         |                                            ^
   scripts/mod/modpost.h:62:21: note: in definition of macro 'bswap'
      62 |                     x); \
         |                     ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_bInterfaceNumber'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:185:9: note: in expansion of macro 'DEF_FIELD'
     185 |         DEF_FIELD(symval, usb_device_id, bInterfaceNumber);
         |         ^~~~~~~~~
   scripts/mod/file2alias.c: In function 'do_usb_entry_multi':
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:66:55: note: in definition of macro 'TO_NATIVE'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                       ^
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:57:31: note: in definition of macro 'bswap'
      57 |         _Static_assert(sizeof(x) == 1 || sizeof(x) == 2 || \
         |                               ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:57:49: note: in definition of macro 'bswap'
      57 |         _Static_assert(sizeof(x) == 1 || sizeof(x) == 2 || \
         |                                                 ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:58:31: note: in definition of macro 'bswap'
      58 |                        sizeof(x) == 4 || sizeof(x) == 8, "bug"); \
         |                               ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:58:49: note: in definition of macro 'bswap'
      58 |                        sizeof(x) == 4 || sizeof(x) == 8, "bug"); \
         |                                                 ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:59:17: note: in definition of macro 'bswap'
      59 |         (typeof(x))(sizeof(x) == 2 ? bswap_16(x) : \
         |                 ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
>> ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:59:28: note: in definition of macro 'bswap'
      59 |         (typeof(x))(sizeof(x) == 2 ? bswap_16(x) : \
         |                            ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:66:59: note: in expansion of macro 'bswap'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                           ^~~~~
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:60:28: note: in definition of macro 'bswap'
      60 |                     sizeof(x) == 4 ? bswap_32(x) : \
         |                            ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:66:59: note: in expansion of macro 'bswap'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                           ^~~~~
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:61:28: note: in definition of macro 'bswap'
      61 |                     sizeof(x) == 8 ? bswap_64(x) : \
         |                            ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:66:59: note: in expansion of macro 'bswap'
      66 |         (target_is_big_endian == host_is_big_endian ? x : bswap(x))
         |                                                           ^~~~~
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                                                           ^~~~
   scripts/mod/file2alias.c:282:9: note: in expansion of macro 'DEF_FIELD'
     282 |         DEF_FIELD(symval, usb_device_id, match_flags);
         |         ^~~~~~~~~
   ./scripts/mod/devicetable-offsets.h:10:39: error: stray '#' in program
      10 | #define OFF_usb_device_id_match_flags #0 /* offsetof(struct usb_device_id, match_flags) */
         |                                       ^
   scripts/mod/modpost.h:62:21: note: in definition of macro 'bswap'
      62 |                     x); \
         |                     ^
   scripts/mod/file2alias.c:73:44: note: in expansion of macro 'TO_NATIVE'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
         |                                            ^~~~~~~~~
   scripts/mod/file2alias.c:73:75: note: in expansion of macro 'OFF_usb_device_id_match_flags'
      73 |         typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

