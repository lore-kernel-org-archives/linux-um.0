Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288EDC25B10
	for <linux-um@archiver.kernel.org>; Mon, 13 May 2024 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54y5MmmYVF7M8nj5MjKyYXJ2hwWz7efHfqNxbhPK4/k=; b=Cr0u3bYbrMCbnRa2htGTXJI+yi
	RkXFzRebepFo5yP2Z/39RE2gjT4ms9tPjfT8QYgV+ZVSD5DO2i/W4Ubb9mzKZMfzGHVYtL7FcbGNi
	7is6FBuAVvw3JPHoSzh3/macWiXHFkGtFBChJVrgFifMdp1Y8Fa/I5lkm9W8hNRNCfqt7uK8j7Jj4
	8NZavZ7spjHQTSA+B9AFuTimiiEWDt40FWSw+Vgsf+TeGZZmJLaL0CJn37/zLBWe5cZmL20d4pfSb
	ZMp5PwlQ2IsQo2DkRPWmRWpjL0uo2/96oy4723QWk8E/VxiGOkiPWHnDQkAeifCB3hB92HNChmLap
	/j2Cv9Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6XkN-0000000DNoY-0K4s;
	Mon, 13 May 2024 15:37:51 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6XkJ-0000000DNmT-26sw
	for linux-um@lists.infradead.org;
	Mon, 13 May 2024 15:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715614667; x=1747150667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uyyw+toTPJDowzp241v5LlMsgBGLrNOoFcg8By35fz0=;
  b=G6cPRFKhClR+akJq1e5ruUM2H9fXPNRTNw/Cy0Wa2xwhh3V+oiVZMfyq
   1APPmVmkR+QqfyAncQh7Ww6GCowopCPxUldHtLlaTZ+0493ovxbUVI4x3
   mNYOqAGWjtcESEwQ0p4EVXw7TGhv5bF2iVqzD4ybRwAOfQodT7g/J6us2
   tiKX8Hlbq4zS4zKBtXAUagFegqLViaUjR8o62o56PFrhs6pHVyyv/GNhu
   13ErIKyqUu7BaT6j8iy5a02xrqA3tFa/gRM/CbMaZ9Ht7oh1TT8LhWUlV
   pyEjeXcKw+knO5OwylNNTrSX+nCTcXwlvPO+IaQG8u//ef38IBbLQCGqR
   A==;
X-CSE-ConnectionGUID: 0KcEkdoSRM+hA45yNbdGig==
X-CSE-MsgGUID: pOhvPpzxRz630uaNPtu5iQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11430751"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="11430751"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 08:37:43 -0700
X-CSE-ConnectionGUID: 62UIxe0UTxGVBloKJFgdvQ==
X-CSE-MsgGUID: RPSSrmOaRoqsIbbiYqtiGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="61208577"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 May 2024 08:37:40 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6XkA-000APr-0Q;
	Mon, 13 May 2024 15:37:38 +0000
Date: Mon, 13 May 2024 23:37:03 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	lihongbo22@huawei.com
Subject: Re: [PATCH] hostfs: convert hostfs to use the new mount api
Message-ID: <202405132349.LJ3Qx7on-lkp@intel.com>
References: <20240513124141.3788846-1-lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513124141.3788846-1-lihongbo22@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_083747_649079_A7A5BF77 
X-CRM114-Status: GOOD (  13.74  )
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

Hi Hongbo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on uml/next]
[also build test WARNING on wireless-next/main wireless/main linus/master v6.9 next-20240513]
[cannot apply to uml/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/hostfs-convert-hostfs-to-use-the-new-mount-api/20240513-204233
base:   git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20240513124141.3788846-1-lihongbo22%40huawei.com
patch subject: [PATCH] hostfs: convert hostfs to use the new mount api
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240513/202405132349.LJ3Qx7on-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240513/202405132349.LJ3Qx7on-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405132349.LJ3Qx7on-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/hostfs/hostfs_kern.c:13:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from fs/hostfs/hostfs_kern.c:13:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/hostfs/hostfs_kern.c:13:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> fs/hostfs/hostfs_kern.c:956:6: warning: variable 'host_root' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     956 |         if (fc->source == NULL)
         |             ^~~~~~~~~~~~~~~~~~
   fs/hostfs/hostfs_kern.c:960:44: note: uninitialized use occurs here
     960 |                 kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
         |                                                          ^~~~~~~~~
   fs/hostfs/hostfs_kern.c:956:2: note: remove the 'if' if its condition is always true
     956 |         if (fc->source == NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
     957 |                 host_root = "";
   fs/hostfs/hostfs_kern.c:942:17: note: initialize the variable 'host_root' to silence this warning
     942 |         char *host_root;
         |                        ^
         |                         = NULL
   13 warnings generated.


vim +956 fs/hostfs/hostfs_kern.c

   937	
   938	static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
   939	{
   940		struct hostfs_fs_info *fsi = sb->s_fs_info;
   941		struct inode *root_inode;
   942		char *host_root;
   943		int err;
   944	
   945		sb->s_blocksize = 1024;
   946		sb->s_blocksize_bits = 10;
   947		sb->s_magic = HOSTFS_SUPER_MAGIC;
   948		sb->s_op = &hostfs_sbops;
   949		sb->s_d_op = &simple_dentry_operations;
   950		sb->s_maxbytes = MAX_LFS_FILESIZE;
   951		err = super_setup_bdi(sb);
   952		if (err)
   953			return err;
   954	
   955		/* NULL is printed as '(null)' by printf(): avoid that. */
 > 956		if (fc->source == NULL)
   957			host_root = "";
   958	
   959		fsi->host_root_path =
   960			kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
   961		if (fsi->host_root_path == NULL)
   962			return -ENOMEM;
   963	
   964		root_inode = hostfs_iget(sb, fsi->host_root_path);
   965		if (IS_ERR(root_inode))
   966			return PTR_ERR(root_inode);
   967	
   968		if (S_ISLNK(root_inode->i_mode)) {
   969			char *name;
   970	
   971			iput(root_inode);
   972			name = follow_link(fsi->host_root_path);
   973			if (IS_ERR(name))
   974				return PTR_ERR(name);
   975	
   976			root_inode = hostfs_iget(sb, name);
   977			kfree(name);
   978			if (IS_ERR(root_inode))
   979				return PTR_ERR(root_inode);
   980		}
   981	
   982		sb->s_root = d_make_root(root_inode);
   983		if (sb->s_root == NULL)
   984			return -ENOMEM;
   985	
   986		return 0;
   987	}
   988	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

