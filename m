Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F8FCCD184
	for <linux-um@archiver.kernel.org>; Sat, 11 Oct 2025 08:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bj+xcsleBH2mEpd+DDmMDg6DzDmHkh8m8PwoIwde6eE=; b=GyuPvRMkdQ+Xtz4u6pbuA+s7r2
	ul6zNT0iuOarZOdpAD8tx/ZMCUIsvP2MNulWKFJfV2VRbF5XThKAUODYPJk4IfGrRftEGnddl8FKc
	yAObQailcOtGZp75NacdTjGzlYe0qoBad2hI29vDAJJUDui47gJVUsnBw0P1BGOxyIsrA6SAI1na/
	swazvlDVUqvONW0dD1NwtR4uwqYqlcfXo78yOGV7BLMju5FY4x3s2sHIt5o8Tc+oxHLBZ1DWxYvEZ
	emH3UXdkgL+oGRzIXYW6A9UVIsa8RIstiksvlYE4/b8p9Oqv4VGxxkCARSVLajUFCv7cQRyanq3Y2
	VQ4HPC2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7UdF-00000009wJZ-1v3T;
	Sat, 11 Oct 2025 08:07:13 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7UdC-00000009wIP-0hlH
	for linux-um@lists.infradead.org;
	Sat, 11 Oct 2025 08:07:12 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bj+xcsleBH2mEpd+DDmMDg6DzDmHkh8m8PwoIwde6eE=;
	b=jNL3mPw+6YRO7RQ9q0CMwiXptoolguULvX0x/K4Y/eRzHdczhNtewJ3e5urvBknUWMLyn91XU
	uGf4+5818gpLFEeDvrTEfYg0jLOiVAjvfOb3ToVQF16lszpiyUHHAmTZ4qGrXDze6B56c96xgUa
	z5HUGPDSp1hvDseAoyFoMlU=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4ckGQz27YbzRhR7
	for <linux-um@lists.infradead.org>; Sat, 11 Oct 2025 16:06:35 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CC9D180B66
	for <linux-um@lists.infradead.org>; Sat, 11 Oct 2025 16:06:53 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 11 Oct 2025 16:06:52 +0800
Message-ID: <08a853d0-aa74-48c8-9df9-7d21186a3dbc@huawei.com>
Date: Sat, 11 Oct 2025 16:06:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] um/hostfs: define HOSTFS_ATTR_* via asm-offsets
Content-Language: en-US
To: <linux-um@lists.infradead.org>
References: <20251007071452.367989-3-johannes@sipsolutions.net>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20251007071452.367989-3-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251011_010710_866588_2B12E6F8 
X-CRM114-Status: GOOD (  21.75  )
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



On 2025/10/7 15:14, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The HOSTFS_ATTR_* values were meant to be standalone for
> communication between hostfs's kernel and user code parts.
> However, it's easy to forget that HOSTFS_ATTR_* should be
> used even on the kernel side, and that wasn't consistently
> done. As a result, the values need to match ATTR_* values,
> which is not useful to maintain by hand. Instead, generate
> them via asm-offsets like other constants that UML needs
> in user-side code that aren't otherwise available in any
> header files that can be included there.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   arch/um/include/shared/common-offsets.h    | 10 +++++++
>   arch/x86/um/shared/sysdep/kernel-offsets.h |  1 +
>   fs/hostfs/hostfs.h                         | 34 +---------------------
>   3 files changed, 12 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
> index 8ca66a1918c3..fcec75a93e0c 100644
> --- a/arch/um/include/shared/common-offsets.h
> +++ b/arch/um/include/shared/common-offsets.h
> @@ -18,3 +18,13 @@ DEFINE(UM_NSEC_PER_USEC, NSEC_PER_USEC);
>   DEFINE(UM_KERN_GDT_ENTRY_TLS_ENTRIES, GDT_ENTRY_TLS_ENTRIES);
>   
>   DEFINE(UM_SECCOMP_ARCH_NATIVE, SECCOMP_ARCH_NATIVE);
> +
> +DEFINE(HOSTFS_ATTR_MODE, ATTR_MODE);
> +DEFINE(HOSTFS_ATTR_UID, ATTR_UID);
> +DEFINE(HOSTFS_ATTR_GID, ATTR_GID);
> +DEFINE(HOSTFS_ATTR_SIZE, ATTR_SIZE);
> +DEFINE(HOSTFS_ATTR_ATIME, ATTR_ATIME);
> +DEFINE(HOSTFS_ATTR_MTIME, ATTR_MTIME);
> +DEFINE(HOSTFS_ATTR_CTIME, ATTR_CTIME);
> +DEFINE(HOSTFS_ATTR_ATIME_SET, ATTR_ATIME_SET);
> +DEFINE(HOSTFS_ATTR_MTIME_SET, ATTR_MTIME_SET);
> diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/shared/sysdep/kernel-offsets.h
> index 6fd1ed400399..ee6b44ef2217 100644
> --- a/arch/x86/um/shared/sysdep/kernel-offsets.h
> +++ b/arch/x86/um/shared/sysdep/kernel-offsets.h
> @@ -5,6 +5,7 @@
>   #include <linux/crypto.h>
>   #include <linux/kbuild.h>
>   #include <linux/audit.h>
> +#include <linux/fs.h>
>   #include <asm/mman.h>
>   #include <asm/seccomp.h>
>   
> diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
> index 15b2f094d36e..aa02599b770f 100644
> --- a/fs/hostfs/hostfs.h
> +++ b/fs/hostfs/hostfs.h
> @@ -3,40 +3,8 @@
>   #define __UM_FS_HOSTFS
>   
>   #include <os.h>
> +#include <generated/asm-offsets.h>
>   
> -/*
> - * These are exactly the same definitions as in fs.h, but the names are
> - * changed so that this file can be included in both kernel and user files.
> - */
> -
> -#define HOSTFS_ATTR_MODE	1
> -#define HOSTFS_ATTR_UID 	2
> -#define HOSTFS_ATTR_GID 	4
> -#define HOSTFS_ATTR_SIZE	8
> -#define HOSTFS_ATTR_ATIME	16
> -#define HOSTFS_ATTR_MTIME	32
> -#define HOSTFS_ATTR_CTIME	64
> -#define HOSTFS_ATTR_ATIME_SET	128
> -#define HOSTFS_ATTR_MTIME_SET	256
> -
> -/* This one is unused by hostfs. */
> -#define HOSTFS_ATTR_FORCE	512	/* Not a change, but a change it */
> -#define HOSTFS_ATTR_ATTR_FLAG	1024
> -
> -/*
> - * If you are very careful, you'll notice that these two are missing:
> - *
> - * #define ATTR_KILL_SUID	2048
> - * #define ATTR_KILL_SGID	4096
> - *
> - * and this is because they were added in 2.5 development.
> - * Actually, they are not needed by most ->setattr() methods - they are set by
> - * callers of notify_change() to notify that the setuid/setgid bits must be
> - * dropped.
> - * notify_change() will delete those flags, make sure attr->ia_valid & ATTR_MODE
> - * is on, and remove the appropriate bits from attr->ia_mode (attr is a
> - * "struct iattr *"). -BlaisorBlade
> - */
>   struct hostfs_timespec {
>   	long long tv_sec;
>   	long long tv_nsec;

