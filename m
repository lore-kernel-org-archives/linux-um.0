Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7D0C04FFE
	for <linux-um@archiver.kernel.org>; Fri, 17 May 2024 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=8VnQm4Wzd0jj3I6yb4jC8r7D5oR7hIr9rTTosx/fIZs=; b=JxD3VXpQ3YXnE1mAX0+UluSgA1
	Hw8GIl8W2WAtsROXGZd/r2KcvccfU4z2ZNuhuJP8dy4YQtHx5zTPKtyxADI5Is+LS6bxfbPY3NsBi
	5HigFBjMymQo57Hw4FPxgsul7yb36dsv90BATl1hjYFz5PiUL5rudIduZmcLagreAJfEuqikg1mXg
	tn4TtJfygDV2eZgIjEnhcgbVSO+X6OaFiIyMBW2HX/g/hF+gRvAHj9VI6a5raxK9WO9NDgjfsCtrp
	Jq6RiMlfWjUS9mctz3nF1sI60MoGxJU58lKAiv8qckylyrWfF0vfigta+57pnbCf1V7HH/jaxthjq
	zB7S9iKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7vLK-00000007aHh-1Oun;
	Fri, 17 May 2024 11:01:42 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7vLG-00000007aH9-0MZn
	for linux-um@lists.infradead.org;
	Fri, 17 May 2024 11:01:40 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a59b58fe083so363213466b.0
        for <linux-um@lists.infradead.org>; Fri, 17 May 2024 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715943694; x=1716548494; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8VnQm4Wzd0jj3I6yb4jC8r7D5oR7hIr9rTTosx/fIZs=;
        b=DRawm73HcccVEK/QPNv85lwlZ4FU4txzVLw1Ez5ineI2DKn+K2qjsbgASH6RdMZxZp
         184n+pGessAvSJeH8fC7jgoPLr0XxPnbSXcujgIeji5PbOsNv1r7W99fgZhDz0yfrkoO
         yFyH5wUSIwO5VsqWc/ehICHeGGyScAL2Nuy7IjGH5lVt5Xfw/ROdVBDeohp0z7uCoDkf
         4R+CcoNIrMwF7oA6I3T1b+lEUVq/VJ0f4kSV/MPscxiGUA+sAC1CIyuK9+I7M0VTWwVn
         bLSb1nMSn8XP5MFRL6T8fl2PKvf1SBBfNd0Rf3+yT/DQP5s+IuIjp2Ig8HlAPYo7MwhQ
         HHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715943694; x=1716548494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VnQm4Wzd0jj3I6yb4jC8r7D5oR7hIr9rTTosx/fIZs=;
        b=r0/KCof2GDnS72bneqPfjeF92UIOh5M9HMjZ5IBg0Tsx/K9k1A19LHV+82Z5gzwNaI
         WtIPL2C6iKoul1YCoJt00jlffPHkMy+9KDYGwKj/1UYhfbAUmEBFa5a2lQCCV1beyf7A
         XM+A7nXtrt9fXd8QOLdBUnB9D2ywveF/mrOhQd+z6GeXr/RtunRP0/NKr3py6ETxcciM
         y20D/B0lwKrPZychW8abMoRXGFP3mWyk6Ik8DvBK5EcsQdZDPjincoqAbWQncg442v9B
         4rbdVaisoiuvjhsIen/OEir4W1YDUxmlxz50ICixQnHAA2Uf0mcm4fwRXwbmhlZuKcHD
         sTnw==
X-Forwarded-Encrypted: i=1; AJvYcCV0IvCr4NhlT1HB9UIxLcY3AjuqFWNv64PoSZeM9LmknwXpC3U043qagn0V24x7AG/J5oHJcNxNgwWq4z0fGnrEmMukXS/Z6Kq35Z/w
X-Gm-Message-State: AOJu0Yw2QzeaNZiRPPGYX7mlFBFm7BPsIH1YGr/hEoLxb2h0bgnUdMJK
	Y3DOT6alXLX7HLfOSTfXdiL6WWtQB3fdWD3/GBnpXjIo/GsGrymZI1fE5sYkdXM=
X-Google-Smtp-Source: AGHT+IGo0vF44PU8Flj2L8GcXH3uM02w5tyFNQ9qE8+bL2lhGta8EhoiS+njX2Y3R8ShLB5wWk0tPw==
X-Received: by 2002:a17:906:8315:b0:a5a:d6c:a30b with SMTP id a640c23a62f3a-a5a2d65f265mr1511949966b.58.1715943694164;
        Fri, 17 May 2024 04:01:34 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01968sm1108799366b.166.2024.05.17.04.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:01:33 -0700 (PDT)
Date: Fri, 17 May 2024 13:01:31 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Hongbo Li <lihongbo22@huawei.com>,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	lihongbo22@huawei.com
Subject: Re: [PATCH] hostfs: convert hostfs to use the new mount api
Message-ID: <d845ba1a-2b10-4d83-a687-56406ce657c9@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513124141.3788846-1-lihongbo22@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240517_040138_155611_113C9F45 
X-CRM114-Status: UNSURE (   6.96  )
X-CRM114-Notice: Please train this message.
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

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/hostfs-convert-hostfs-to-use-the-new-mount-api/20240513-204233
base:   git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux next
patch link:    https://lore.kernel.org/r/20240513124141.3788846-1-lihongbo22%40huawei.com
patch subject: [PATCH] hostfs: convert hostfs to use the new mount api
config: um-randconfig-r081-20240517 (https://download.01.org/0day-ci/archive/20240517/202405171154.21q42SWy-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d3455f4ddd16811401fa153298fadd2f59f6914e)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202405171154.21q42SWy-lkp@intel.com/

smatch warnings:
fs/hostfs/hostfs_kern.c:960 hostfs_fill_super() error: uninitialized symbol 'host_root'.

vim +/host_root +960 fs/hostfs/hostfs_kern.c

2c2593890079e8 Hongbo Li         2024-05-13  938  static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
^1da177e4c3f41 Linus Torvalds    2005-04-16  939  {
2c2593890079e8 Hongbo Li         2024-05-13  940  	struct hostfs_fs_info *fsi = sb->s_fs_info;
^1da177e4c3f41 Linus Torvalds    2005-04-16  941  	struct inode *root_inode;
2c2593890079e8 Hongbo Li         2024-05-13  942  	char *host_root;
^1da177e4c3f41 Linus Torvalds    2005-04-16  943  	int err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  944  
^1da177e4c3f41 Linus Torvalds    2005-04-16  945  	sb->s_blocksize = 1024;
^1da177e4c3f41 Linus Torvalds    2005-04-16  946  	sb->s_blocksize_bits = 10;
^1da177e4c3f41 Linus Torvalds    2005-04-16  947  	sb->s_magic = HOSTFS_SUPER_MAGIC;
^1da177e4c3f41 Linus Torvalds    2005-04-16  948  	sb->s_op = &hostfs_sbops;
b26d4cd385fc51 Al Viro           2013-10-25  949  	sb->s_d_op = &simple_dentry_operations;
752fa51e4c5182 Wolfgang Illmeyer 2009-06-30  950  	sb->s_maxbytes = MAX_LFS_FILESIZE;
ce72750f04d68a Sjoerd Simons     2021-11-05  951  	err = super_setup_bdi(sb);
ce72750f04d68a Sjoerd Simons     2021-11-05  952  	if (err)
74ce793bcbde5c Mickaël Salaün    2023-06-12  953  		return err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  954  
b58c4e96192ee7 Andy Shevchenko   2020-03-20  955  	/* NULL is printed as '(null)' by printf(): avoid that. */
2c2593890079e8 Hongbo Li         2024-05-13  956  	if (fc->source == NULL)
2c2593890079e8 Hongbo Li         2024-05-13  957  		host_root = "";

Uninitialized on else path

^1da177e4c3f41 Linus Torvalds    2005-04-16  958  
2c2593890079e8 Hongbo Li         2024-05-13  959  	fsi->host_root_path =
2c2593890079e8 Hongbo Li         2024-05-13 @960  		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
                                                                                                         ^^^^^^^^^


2c2593890079e8 Hongbo Li         2024-05-13  961  	if (fsi->host_root_path == NULL)
74ce793bcbde5c Mickaël Salaün    2023-06-12  962  		return -ENOMEM;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


