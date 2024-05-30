Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C445BC25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 11:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yYL8uItYjLvX4XXmJVewmmoWRUKbv1uKkHOYIVSiw1Y=; b=EFWaG+U38heeS5/UhGv4YtlNAV
	SDmQXcdvfN9WF/dgKR7vfYqawU7XmrjmtlBQrmygcdleJalTtM6bl3gNaBdaaeiyorseVoCvDyhz7
	yZujlFNfdEs3262fjgraRqFtxzXqCYRFJBZh6Y9YhV4OrajEMoykj3Wrd7z5NSlvPfnZucpIs4j3O
	wbe4iIu3LWKa6Adveny8dweMHFFZfA0fqqeqrpnFB6M/hFliI7jCmBR20p+Trjt3izUrYGHCPUIJr
	hDgwaz8Nn+ojwx7f8WZLWi6b7GMPGodSd+wEMnfQcV6c0yqPucfCkFlb0aFD5RpdVhFWDG9j4jgK5
	IIkgO6Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCeGR-0000000796z-3ZWA;
	Thu, 30 May 2024 11:48:11 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCeGN-0000000794Y-1QwK
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 11:48:10 +0000
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VqksY3crKzmWyJ;
	Thu, 30 May 2024 19:43:29 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id AAEA0140382;
	Thu, 30 May 2024 19:47:53 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 30 May 2024 19:47:53 +0800
Message-ID: <49f5cd14-987f-4d72-8606-496fca08a708@huawei.com>
Date: Thu, 30 May 2024 19:47:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostfs: convert hostfs to use the new mount api
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <oe-kbuild@lists.linux.dev>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
	<lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <d845ba1a-2b10-4d83-a687-56406ce657c9@suswa.mountain>
 <74576c52-5eca-4961-ada4-a9ec99fb16cf@huawei.com>
 <df349a89-e638-41de-858b-04341d89774e@moroto.mountain>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <df349a89-e638-41de-858b-04341d89774e@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_044807_624131_D22D1BA2 
X-CRM114-Status: GOOD (  13.02  )
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

Thanks for replying.

I will send the new patch marked with v2 later.

regards,
Hongbo Li

On 2024/5/23 18:43, Dan Carpenter wrote:
> On Fri, May 17, 2024 at 07:21:09PM +0800, Hongbo Li wrote:
>> Thanks for your attention, I have solved the warnings in the following patch
>> (the similar title: hostfs: convert hostfs to use the new mount API):
>>
>> https://lore.kernel.org/all/20240515025536.3667017-1-lihongbo22@huawei.com/
>>
>> or
>>
>> https://patchwork.ozlabs.org/project/linux-um/patch/20240515025536.3667017-1-lihongbo22@huawei.com/
>>
>> It was strange that the kernel test robot did not send the results on the
>> new patch.
> 
> With uninitialized variable warnings, quite often Smatch is not the only
> or first checker to report the bug so I normally search lore to see if
> it has already been fixed.  In this case there were no bug reports from
> Nathan Chancelor and the second version of the patch wasn't marked as a
> v2 and there was no note explaining it like:
> 
> ---
> v2: fixed uninitialized variable warning
> 
> So it wasn't immediately clear that it had been fixed already.
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
> 
> regards,
> dan carpenter
> 

