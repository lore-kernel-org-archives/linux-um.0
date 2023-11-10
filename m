Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1F3C4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 20:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8SBfW9G1xyKZ9UgEhn8qAwVtXXUQ7dVOB7tizkxNzrs=; b=U0aBJptmVC1T9H
	xfnYK42T2Raio5h1u3/5foQWyEzdR733xsvWM3R9MN/EqseKmeaI9mCx0Txlgp3Q2rmufV7sGQLTB
	cOs1ArG94Fvi/+PAe0Y1l3RGzoDsGZsUa2jRbd34FcZxHW20eKbmVgccL0inTkfcPZLUoIfUWDbJ4
	XMk/Nms7HWhIRvXua4uMJCNAnKlP87IHKM3NTAMY5UGHKDHz933wcikZUSt5oVlx44H2SKUtX2FsN
	8KbiLtIqoepTSq1cbhjvlEyhjlAeUbOPp2TpCKTQG/222aduUrhMtgMFGt3+IhizRI9psKZQSpmx9
	wUWDoZTpNZPIdA7n+uIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1YIx-009P0w-2j;
	Fri, 10 Nov 2023 20:40:39 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1YIu-009Oz3-1K
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 20:40:38 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1r1YIl-005g72-1Z; Fri, 10 Nov 2023 20:40:27 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1r1YIi-00C9jm-0Y;
	Fri, 10 Nov 2023 20:40:26 +0000
Message-ID: <11a25e62-be07-9a37-71f3-0607b0591623@kot-begemot.co.uk>
Date: Fri, 10 Nov 2023 20:40:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] um: add mmap/mremap/munmap OS calls
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20231110185255.32006-5-johannes@sipsolutions.net>
 <20231110195255.711150d60a27.Ic2da1d3a983fe57340c1b693badfa9c5bd2d8c61@changeid>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20231110195255.711150d60a27.Ic2da1d3a983fe57340c1b693badfa9c5bd2d8c61@changeid>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_124036_443648_8482C093 
X-CRM114-Status: GOOD (  14.90  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 10/11/2023 18:52, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> For the upcoming shared-memory time-travel external
> optimisations, we need to be able to mmap/mremap
> (and on error munmap). Add the necessary OS calls.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/include/shared/os.h |  3 +++
>   arch/um/os-Linux/file.c     | 28 ++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
> index 4fbe574eff4c..1a82c6548dd5 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -180,6 +180,9 @@ extern int os_eventfd(unsigned int initval, int flags);
>   extern int os_sendmsg_fds(int fd, const void *buf, unsigned int len,
>   			  const int *fds, unsigned int fds_num);
>   int os_poll(unsigned int n, const int *fds);
> +void *os_mmap_rw_shared(int fd, size_t size);
> +void *os_mremap_rw_shared(void *old_addr, size_t old_size, size_t new_size);
> +void os_munmap(void *addr, size_t size);
>   
>   /* start_up.c */
>   extern void os_early_checks(void);
> diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
> index c972dfeab9a3..c482850f27d8 100644
> --- a/arch/um/os-Linux/file.c
> +++ b/arch/um/os-Linux/file.c
> @@ -17,6 +17,7 @@
>   #include <sys/stat.h>
>   #include <sys/sysmacros.h>
>   #include <sys/un.h>
> +#include <sys/mman.h>
>   #include <sys/types.h>
>   #include <sys/eventfd.h>
>   #include <poll.h>
> @@ -708,3 +709,30 @@ int os_poll(unsigned int n, const int *fds)
>   
>   	return -EIO;
>   }
> +
> +void *os_mmap_rw_shared(int fd, size_t size)
> +{
> +	void *res = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +
> +	if (res == MAP_FAILED)
> +		return NULL;
> +
> +	return res;
> +}
> +
> +void *os_mremap_rw_shared(void *old_addr, size_t old_size, size_t new_size)
> +{
> +	void *res;
> +
> +	res = mremap(old_addr, old_size, new_size, MREMAP_MAYMOVE, NULL);
> +
> +	if (res == MAP_FAILED)
> +		return NULL;
> +
> +	return res;
> +}
> +
> +void os_munmap(void *addr, size_t size)
> +{
> +	munmap(addr, size);
> +}


os_munmap already exists as os_munmap_memory

The other two are OK.
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
