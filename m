Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB44D6ED34
	for <linux-um@archiver.kernel.org>; Thu, 21 Nov 2024 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:CC:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xAUdviULB44hGI4dynB01M2Up5TvsxG0k/X2pF0OKqg=; b=HvRPGJY9rpE8PiaQR9HRcXTCUh
	9lJARUqn3jfMbrQkE9UdcXbE1wzF2wx2GQCVt/OCUrvJo0dQf6ho6WPQsA7GxMXhdx+FffjLReR9f
	pQ10EBIVA9lV3jzaslSwDWJ/oL0sAnyz6bQCg6BZKYUNG2C6ofqBb+41vafz3hnWoPCEsaqnI/0Pb
	OeFyd4QlcwftvLyaDRclYCAyfO04WWMz5xmtlunpA7tuFrlPPzV3bV9T3BCDm53dJoCDgxtGX+8VG
	v2l2OyKMYYIx4mem3dq4uK31wX4oqqBLWXBdXKGQZAsnNnei5g9ycmMum3qQkGxqcxxdtskRSnUOS
	ewrszeoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE7cY-000000009Zu-3dCw;
	Thu, 21 Nov 2024 13:53:22 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE7cV-000000009Yh-2YjX
	for linux-um@lists.infradead.org;
	Thu, 21 Nov 2024 13:53:21 +0000
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XvKLl0Yz9z1JCJL;
	Thu, 21 Nov 2024 21:48:15 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FD6E180019;
	Thu, 21 Nov 2024 21:53:07 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 21 Nov 2024 21:53:07 +0800
Message-ID: <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
Date: Thu, 21 Nov 2024 21:53:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML mount failure with Linux 6.11
From: Hongbo Li <lihongbo22@huawei.com>
To: Karel Zak <kzak@redhat.com>
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
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
Content-Language: en-US
In-Reply-To: <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_055320_035087_012E9E3D 
X-CRM114-Status: GOOD (  18.40  )
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



On 2024/11/13 9:23, Hongbo Li wrote:
> 
> 
> On 2024/11/13 4:10, Karel Zak wrote:
>>
>>   Hi,
>>
>> On Mon, Nov 11, 2024 at 09:16:18AM GMT, Hongbo Li wrote:
>>> We are discussing about the hostfs mount with new mount API in [1]. 
>>> And may
>>> need your help.
>>>
>>> After finishing the conversion to the new mount API for hostfs, it
>>> encountered a situation where the old version supported only one mount
>>> option, and the whole mount option was used as the root path (it is also
>>> valid for the path to contain commas). But when switching to the new 
>>> mount
>>> API, the option part will be split using commas (if I'm not mistaken, 
>>> this
>>> step would be done in libmount), which could potentially split a 
>>> complete
>>> path into multiple parts, and the call fsconfig syscall to set the mount
>>> options for underline filesystems. This is different from the original
>>> intention of hostfs. And this kind of situation is not common in other
>>> filesystems.
>>
>> The options has been always parsed by mount(8) and it's very fragile
>> to assume that kernel get as in the original order (etc.).
>>
>> For decades, commas have been supported in mount options. For example,
>> SeLinux uses them frequently in context settings. All you need to do
>> is use quotes, but be careful because the shell will strip them off.
>> Therefore, double quoting is required.
>>
> 
> Thanks for your reply!
> 
> If I'm not mistaken, we should add double quoting explicitly if we need 
> commas in mount options. However, it seems different for hostfs. For 
> example, with hostfs, if we use "mount -t hostfs none -o 
> /home/hostfs,dir /mnt" in the older interface, which can successfully 
> mount the host directory `/home/hostfs,dir`, then we should use "mount 
> -t hostfs none -o '"/home/hostfs,dir"' /mnt" in the new interface. If 
> that is the case, we should change the mount command which is hardcoded 
> in the original project.
Sorry for the disturbance. So am I right?

Thanks,
Hongbo

> 
> Thanks,
> Hongbo
> 
>>     mount -o 'rw,bbb="this,is,value",ccc'
>>
>> It's also supported in fstab, just use name="v,a,l,u,e"
>>
>> You can try it:
>>
>>   # strace -e fsconfig mount -t tmpfs -o 'rw,bbb="this,is,value",ccc' 
>> tmpfs /dontexist
>>
>>   fsconfig(3, FSCONFIG_SET_STRING, "source", "tmpfs", 0) = 0
>>   fsconfig(3, FSCONFIG_SET_FLAG, "rw", NULL, 0) = 0
>>   fsconfig(3, FSCONFIG_SET_STRING, "bbb", "this,is,value", 0) = -1 EINVAL
>>
>> You can see the expected result when using fsconfig().
>>
>>   Karel
>>
>>
> 
> 

