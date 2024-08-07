Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4170CC52D6F
	for <linux-um@archiver.kernel.org>; Wed,  7 Aug 2024 07:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mqvL9kVCgzj7U7irHa2ORnVHw0WuVj0xvWQ+gN18bsg=; b=R+ntx0sS5FWgTW/sajJ6UMwyFv
	hZF0tPfx46fw9rALHdDpjAs2LaC4ohUisibzYRxYMyFYYpEk/m10xQYgkf+7dTKq/9iXhoRf5IMCe
	huDxqzdUNcs4ctotRpMG+jhVVp97PllzrrCMq2OXmce4kerpUb/iU/KNt2EINbH2RQ9HL3Aq9m5fq
	eSYxnhLKdBd1llPLSKhgWEQMclZJh+/V+LBilDTW4ldUHTJvPJhWqawXMMDSV9vobIe3QYxJsCpbP
	pNtpIlmhiwxBIna0JQ+CzpmtU90R41XkFDDDAsdZiW+Sk+qH6qi0QC4BwrTeq/4ZLNISC3Tt3OFHS
	7RJhbFuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbbFt-00000004FaD-2B1M;
	Wed, 07 Aug 2024 07:38:45 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbbFe-00000004FWx-2W0r;
	Wed, 07 Aug 2024 07:38:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FBB2FEC;
	Wed,  7 Aug 2024 00:38:55 -0700 (PDT)
Received: from [10.57.81.112] (unknown [10.57.81.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 687A53F5A1;
	Wed,  7 Aug 2024 00:38:25 -0700 (PDT)
Message-ID: <e693ed7a-97bf-486b-84fb-f57e44a399b4@arm.com>
Date: Wed, 7 Aug 2024 08:38:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [fs] cdc4ad36a8:
 kernel_BUG_at_include/linux/page-flags.h
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>,
 kernel test robot <oliver.sang@intel.com>,
 Christian Brauner <brauner@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-bcachefs@vger.kernel.org,
 ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net,
 devel@lists.orangefs.org, reiserfs-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <202408062249.2194d51b-lkp@intel.com>
 <ZrLuBz1eBdgFzIyC@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZrLuBz1eBdgFzIyC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240807_003830_719549_1B783D2B 
X-CRM114-Status: GOOD (  12.57  )
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

On 07/08/2024 04:46, Matthew Wilcox wrote:
> On Tue, Aug 06, 2024 at 10:26:17PM +0800, kernel test robot wrote:
>> kernel test robot noticed "kernel_BUG_at_include/linux/page-flags.h" on:
>>
>> commit: cdc4ad36a871b7ac43fcc6b2891058d332ce60ce ("fs: Convert aops->write_begin to take a folio")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>> [test failed on linux-next/master 1e391b34f6aa043c7afa40a2103163a0ef06d179]
>>
>> in testcase: boot
> 
> This patch should fix it.
> 
> Christian, can you squash the fix in?
> 
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7d28304aea0f..66ff87417090 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2904,7 +2904,8 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
>  	if (ret)
>  		return ret;
>  
> -	if (folio_test_has_hwpoisoned(folio)) {
> +	if (folio_test_hwpoison(folio) ||
> +	    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio))) {

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Ryan Roberts <ryan.roberts@arm.com>


>  		folio_unlock(folio);
>  		folio_put(folio);
>  		return -EIO;


