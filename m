Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1962D66BA3
	for <linux-um@archiver.kernel.org>; Wed, 27 Nov 2024 01:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0TfF3rzjr5nMRnN6EA7tjgJRuyHykCQNl60R37VCL8Y=; b=aZjj4cYnE7ZF9l4RkqV1zOb+at
	hNE34bG7P+aXqZsS8VGKAHcmKuE+QGlJIQ1+dQ6uQs5GH8R4/tB140JV/VeyP3yoinkA1Bn9o/FKH
	9FnaOsrN5tjJQtFyJJiP59HiAbZOwg3Rj6KIQ8XxIxS1p7XexzonWxO7hguLtRqwE9ooPtm5941Tn
	/OSVawIwghZsv8EYvsnc+uvb6HHdnCo9wCmSGnsLmAF7NtxdUQySxGnptE5+M+5Fg8BAeR6dsT+VT
	oZUJf/goy/w57mvr8A1j+XPWvrwzKYnqIKaLc/mKElXibfSX3SsVBpGdan26ea+IW0pgmodlSCvsQ
	5kpJcM7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tG6pY-0000000C0g1-1tcZ;
	Wed, 27 Nov 2024 01:27:00 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tG6pW-0000000C0eQ-0HBZ
	for linux-um@lists.infradead.org;
	Wed, 27 Nov 2024 01:26:59 +0000
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XyhYF11t4zPptQ;
	Wed, 27 Nov 2024 09:24:01 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 966C71800F2;
	Wed, 27 Nov 2024 09:26:47 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 09:26:47 +0800
Message-ID: <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
Date: Wed, 27 Nov 2024 09:26:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML mount failure with Linux 6.11
To: Johannes Berg <johannes@sipsolutions.net>, Karel Zak <kzak@redhat.com>
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>,
	<rrs@debian.org>
References: <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_172658_254909_EF2AE43B 
X-CRM114-Status: GOOD (  18.05  )
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



On 2024/11/26 21:50, Johannes Berg wrote:
> On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
>>
>> The long-term solution would be to clean up hostfs and use named
>> variables, such as "mount -t hostfs none -o 'path="/home/hostfs"'.
> 
> That's what Hongbo's commit *did*, afaict, but it is a regression.
> 
> Now most of the regression is that with fsconfig() call it was no longer
> possible to specify a bare folder, and then we got discussing what
> happens if the folder name actually contains a comma...
> 
> But this is still a regression, so we need to figure out what to do
> short term?
> 
So for short term, even long term, can we consider handling the hostfs 
situation specially within libmount? Such as treat the whole option as 
one key(also may be with comma, even with equal), in this case, libmount 
will use it as FSCONFIG_SET_FLAG. We can do that because for hostfs, it 
only has one mount option, and no need for extension.

Thanks,
Hongbo

> Ignoring the "path with comma" issue, because we can't even fix that in
> the kernel given what you describe changed in userspace, we can probably
> only
> 
>   1) revert the hostfs conversion to the new API, or
>   2) somehow not require the hostfs= key?
> 
> I don't know if either of those are even possible
> 
> 
> Fixing the regression fully (including for paths containing commas)
> probably also requires userspace changes. If you don't want to make
> those we can only point to your workarounds instead, since we can't do
> anything on the kernel side.
> 
> I don't know the fsconfig() API, is it possible to have key-less or
> value-less calls? What does happen
> 
> johannes
> 

