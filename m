Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D75ED12D5D
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 01:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LpoiwvHqaXjg7ehCfiqAV8HzuRWj+tKWaDH7XLz28BY=; b=Jz8Usryz0UrAT+XyqN7gFud+uT
	q1V2TDdkvY14OwtD6U8+gN+nerJXfeXxnaTqu5ZuhIv647UMROnrPGMpzC26W8ZR8jWSi/PgLDQH/
	34ZDbMKtu1eI8HM1qvvGRHNwE7fSXKH/oxUQv0aug9roKxccVSmWZ5sgwUdkl/Pcm4KzgVXVdC3wd
	6GjIB8YF8KWfOwFFRjfh3FmnWOSDhbsB4aqlNT8y+gDXOYfWNNDBY+S5HZD1FvTDdkU6NyGaAIvv3
	rMCDKsEhCY8w85aMUG3X6amPp9LAWoK1mj3c8O5O7srYzXCbEYza/1z4y0aKaVUK7J1GLJilhjRla
	FxG615tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAJ50-0000000G0vw-3fv1;
	Mon, 11 Nov 2024 01:18:58 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAJ2d-0000000G0ed-3rwb
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 01:16:34 +0000
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xms5j1Ymwz1hwRL;
	Mon, 11 Nov 2024 09:14:33 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id BACE91402D0;
	Mon, 11 Nov 2024 09:16:20 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 09:16:20 +0800
Message-ID: <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
Date: Mon, 11 Nov 2024 09:16:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML mount failure with Linux 6.11
To: <kzak@redhat.com>
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>,
	Johannes Berg <johannes@sipsolutions.net>, <rrs@debian.org>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_171632_327573_2AC1B1CA 
X-CRM114-Status: GOOD (  17.34  )
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

Hi Karel,

We are discussing about the hostfs mount with new mount API in [1]. And 
may need your help.

After finishing the conversion to the new mount API for hostfs, it 
encountered a situation where the old version supported only one mount 
option, and the whole mount option was used as the root path (it is also 
valid for the path to contain commas). But when switching to the new 
mount API, the option part will be split using commas (if I'm not 
mistaken, this step would be done in libmount), which could potentially 
split a complete path into multiple parts, and the call fsconfig syscall 
to set the mount options for underline filesystems. This is different 
from the original intention of hostfs. And this kind of situation is not 
common in other filesystems.

Is it necessary to handle the hostfs situation specially within libmount.

[1] 
https://lore.kernel.org/all/ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net/T/

Thanks,
Hongbo


On 2024/11/7 22:35, Johannes Berg wrote:
> On Thu, 2024-11-07 at 22:17 +0800, Hongbo Li wrote:
>>> There's only one option anyway, so I'd think we just need to fix this
>>> and not require the hostfs= key. Perhaps if and only if it starts with
>>> hostfs= we can treat it as a key, otherwise treat it all as a dir? But I
>>
>> May be we can do that (just record the unknown option in host_root_path
>> when fs_parse failed). But this lead us to consider the case in which we
>> should handle a long option -o unknown1,hostfs=xxx,unknow2, which one
>> should be treated as the root directory? For new mount api, it will call
>> fsconfig three times to set the root directory. For older one, if one
>> path with that name exactly, may be it can mount successfully.
> 
> Technically, comma _is_ valid in a dir name, as you say ... so perhaps
> the new mount API handling would need to be modified to have an escape
> for this and not split it automatically, if the underlying FS doesn't
> want that? Or we just revert cd140ce9f611 too?
> 
> I feel like perhaps we just found a corner case - clearly the new mount
> API assumes that mount options are always comma-separated, but, well,
> turns out that's simply not true since hostfs has only a single option
> and treats the whole thing as a single string.
> 
> johannes
> 

