Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CEFD43362
	for <linux-um@archiver.kernel.org>; Thu,  7 Nov 2024 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XXYmVm9csNKJbuzj7koFZwnopqDZ0zmrzPImY/rSFig=; b=RqmId4bE53ZankLum9YPwWEdrA
	UsHWnFiIKnavga715GI8f2E5GwE2E5ymx0eOJQKlwS0E3OVTDnFYEWpg79nQG3KmxZ3kMqkw3urJ/
	3g0ImgHsi96PxN1uyN2xDuPTiYxAHL9akReTta8txg4HUQvBaaTQhxIBWvvM6m3elH6Jo593ilhu/
	2ZeIuyckwT4jWbJpFEhAv0Z3jVURyOPPbQIhOLfZCbAH/g7DhEianFaYmcqD4d+EWI6WsGLkocPdF
	bTpfYAyqORCP0lQdOKXCP446ppHkvGMMEjGVjOVyexw29d9ddD91CvG9vnjDPB4x6+ofFijnbz9Ky
	5010qpSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t93K5-00000007G8O-1cGY;
	Thu, 07 Nov 2024 14:17:21 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t93K2-00000007G6d-1LG2
	for linux-um@lists.infradead.org;
	Thu, 07 Nov 2024 14:17:19 +0000
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XkkbX2HZdz923c;
	Thu,  7 Nov 2024 22:14:32 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id B58121402CB;
	Thu,  7 Nov 2024 22:17:09 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 22:17:09 +0800
Message-ID: <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
Date: Thu, 7 Nov 2024 22:17:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML mount failure with Linux 6.11
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <rrs@debian.org>
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_061718_546754_FC22F2EF 
X-CRM114-Status: GOOD (  23.22  )
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



On 2024/11/7 21:09, Johannes Berg wrote:
> Hi,
> 
> So took me a while to grok the context, and to understand why it was
> working for me, and broken on another machine...
> 
> 
>> I have read the context in [1]. It seems your tool has already used new
>> mount api to mount the hostfs.
> 
> Yes, however, that's a default that's entirely transparent to the user.
> This is why I wasn't seeing the errors, depending on the machine I'm
> running this on, because the 'mount' tool either uses the old or new
> style and the user can never know.
> 
>> It now rejects unknown mount options as
>> many other filesystems do regardless of its earlier behavior (which
>> treats any option as the root directory in hostfs).
> 
> And that's clearly the root cause of this regression.
> 
> You can't even argue it's not a regression, because before cd140ce9f611
> ("hostfs: convert hostfs to use the new mount API") it still worked with
> the new fsconfig() API, but with the old mount options...
> 
>> I'm not sure it is reasonable in this way. If we accept unknown option
>> in the hostfs, it will be treated as root directory. But which one
>> should be used (like mount -t hostfs -o unknown,/root/directory none
>> /mnt). So in the conversion, we introduce the `hostfs` key to mark the
>> root directory. May be we need more discussion about use case.
> 
> There's only one option anyway, so I'd think we just need to fix this
> and not require the hostfs= key. Perhaps if and only if it starts with
> hostfs= we can treat it as a key, otherwise treat it all as a dir? But I

May be we can do that (just record the unknown option in host_root_path 
when fs_parse failed). But this lead us to consider the case in which we 
should handle a long option -o unknown1,hostfs=xxx,unknow2, which one 
should be treated as the root directory? For new mount api, it will call 
fsconfig three times to set the root directory. For older one, if one 
path with that name exactly, may be it can mount successfully.


Thanks,
Hongbo

> guess the API wouldn't make that easy.
> 
> Anyway, I dunno, but it seems like a regression to me and we should try
> to find a way to fix it.
> 
> johannes
> 

