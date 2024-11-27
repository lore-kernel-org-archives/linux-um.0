Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BB0D6ACD6
	for <linux-um@archiver.kernel.org>; Wed, 27 Nov 2024 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=44gpK+gN3ztwzVXmdL8ePjSjKuI2QLN/UWTwyzjRCgs=; b=HUW3Abhq6ItVp+AiOfy3DI+x66
	UjtVJ+BWyMiagSqaNhoXAFeAJajgEnmnQ0CsJRmn9g4sGoB0Pm/srNA9KQ752rKpUwEiqrdosAm2N
	rynIKLGwFQvTMPyJ3oodb/OJmoyldx26wfinmZ0k5R9pBuHMW4pcUfzqJtDWrN6sFUItmIO8euHVc
	m9sUvn/8MaVzDVTTAs+Tw6Poa9zMhav5P4FlFHCjiZ2koPELBPEZG48h/Jrzk5IBcqoI5/fLVG2E7
	DhN8ZWIPF07uPlfO1Rba7ZwK7s1bKs+R7QiO4ufCFgFprF9vSox4JmgfktLw6T6vsH8/yRrZstWNu
	9C89x9Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGIWB-0000000DJkt-0HhE;
	Wed, 27 Nov 2024 13:55:47 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGIW7-0000000DJj4-2LBL
	for linux-um@lists.infradead.org;
	Wed, 27 Nov 2024 13:55:45 +0000
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xz19G15C8z11LqD;
	Wed, 27 Nov 2024 21:52:50 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 06F9B1800A1;
	Wed, 27 Nov 2024 21:55:38 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 21:55:37 +0800
Message-ID: <992a1e43-67c5-4686-b10c-f82c9942daac@huawei.com>
Date: Wed, 27 Nov 2024 21:55:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML mount failure with Linux 6.11
To: Karel Zak <kzak@redhat.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>,
	<rrs@debian.org>
References: <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
 <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
 <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <uppzc2p5bn6fhrdlzzkbdrkoigurkii5ockigngknm4waewl5z@z2a6c6iivu7s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_055543_780792_F12F6A9E 
X-CRM114-Status: GOOD (  16.31  )
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



On 2024/11/27 20:02, Karel Zak wrote:
> On Wed, Nov 27, 2024 at 09:26:46AM GMT, Hongbo Li wrote:
>>
>>
>> On 2024/11/26 21:50, Johannes Berg wrote:
>>> On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
>>>>
>>>> The long-term solution would be to clean up hostfs and use named
>>>> variables, such as "mount -t hostfs none -o 'path="/home/hostfs"'.
>>>
>>> That's what Hongbo's commit *did*, afaict, but it is a regression.
>>>
>>> Now most of the regression is that with fsconfig() call it was no longer
>>> possible to specify a bare folder, and then we got discussing what
>>> happens if the folder name actually contains a comma...
>>>
>>> But this is still a regression, so we need to figure out what to do
>>> short term?
>>>
>> So for short term, even long term, can we consider handling the hostfs
>> situation specially within libmount?
> 
> Yes (see reply to Johannes ).
> 
>> Such as treat the whole option as one
>> key(also may be with comma, even with equal)
> 
> There could be userspace specific options, VFS flags, etc.
> 
>    -o /home/hostfs,ro,noexec
> 
> Is it one path or path and two options?
> 
Interesting!
Perhaps more documentation is needed. VFS flags is filtered, but for 
hostfs, it is a valid path. The semantics seems not very complete. :)

Thanks,
Hongbo

>> in this case, libmount will
>> use it as FSCONFIG_SET_FLAG. We can do that because for hostfs, it only has
>> one mount option, and no need for extension.
> 
> We can automatically add a key (e.g. hostfs=) and use FSCONFIG_SET_FLAG.
> The goal should be to get the path as a value, because key is limited to
> 256 bytes.
> 
>      Karel
> 

