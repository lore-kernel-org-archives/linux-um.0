Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E2AC369D9
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 04:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NjC677D2QKT6l7B4bbwK1QRma2CFb697KBKGL3X43mc=; b=qws8WRJENv49wzlSWWQf7O+Sro
	Vc7HR+sVLEH2KbeStRGMEhIBE57gWuqbjdQQSpfyPzDo1PZRcCg96GHNHHaEITodIPCTly8SdwzC9
	QpBjwJReZsmRHMyc/AoDfFwKE6mAcK9HUdcKFeZKjurS9Tr8qS5tSUkJX2Ptp3rXG2ZpcSrT9aREj
	A706TJWm9vIouWqZPLIvEh7SWv+/UBkJjwGMGS61fwGzZAYetDGe/q6/6UUiS2ZtqXdPiQ+8qUvqz
	RSTV+uW62dTP4hOw1lErf8IMJxvYlsl30K/05/unnxGKdJTSabyKSI9cSD4kt7QpF7YUPUxkFl8I/
	0k5fGpvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB4Ja-00000003Tr5-2rbM;
	Sat, 03 May 2025 04:17:26 +0000
Received: from out0-206.mail.aliyun.com ([140.205.0.206])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB4JX-00000003Tqc-0jGr
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 04:17:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1746245838; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NjC677D2QKT6l7B4bbwK1QRma2CFb697KBKGL3X43mc=;
	b=FXBQ/soPZC72e6Ot8Z781FBtmc2OGwxW+LjkfuqKpmKscynRAbaO32A7BCZJ0+nhJgVP9NCroFCw+8Px8FUYPkNby9H7TAD9fTGzxL6UwV5FSr6JLZnO/ShI3Thl43oZOgU+nAX2uYn6A7SwjbBr2KhO2uWYo8bryfU2RFiuEds=
Received: from 30.174.103.17(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cdokazs_1746245829 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 03 May 2025 12:17:16 +0800
Message-ID: <92df1143-f935-41bb-aa58-430319391a05@antgroup.com>
Date: Sat, 03 May 2025 12:17:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Merge os-Linux/drivers/ into drivers/
To: Johannes Berg <johannes@sipsolutions.net>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Thomas Meyer <thomas@m3y3r.de>, linux-um@lists.infradead.org, richard@nod.at
References: <20250502083152.3791637-1-tiwei.btw@antgroup.com>
 <2E84324B-747A-4216-804B-921A7AA2F29F@m3y3r.de>
 <7f55fde9-9753-42b4-856f-2e22a29a555b@cambridgegreys.com>
 <62bd586a078ff81ca8cdf4db66f548489f3a3535.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <62bd586a078ff81ca8cdf4db66f548489f3a3535.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_211723_719704_46E3BDAB 
X-CRM114-Status: GOOD (  10.49  )
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

On 2025/5/3 00:09, Johannes Berg wrote:
> On Fri, 2025-05-02 at 10:08 +0100, Anton Ivanov wrote:
>>
>> On 02/05/2025 09:35, Thomas Meyer wrote:
>>> Hi,
>>>
>>> Aren't those drivers under exactly this folder because those drivers will work only with when the host OS is Linux? I mean this is all hypothetical but when somebody is going to implement UML under Mac OS, this layout won't work anymore, or do I err?
>>
>> Yes indeed.
>>
>> However, we have plenty of linux specific dependencies throughout nowadays: EPOLL, vhost-net, etc.
>> PTRACE usage is probably OS specific too. SECCOMP. And so on.
>>
>> The original idea to keep Linux dependent stuff under os-Linux is no longer realistic.
>>
> 
> Indeed. Also, there's really no need to have that anyway - there are
> plenty of drivers that only work on some architectures, and these ones
> are anyway going to depend on UM. They could depend on a hypothetical
> UM_LINUX_HOST in the future instead?
> 

Good idea! If necessary, it would be much better to introduce a
UM_LINUX_HOST option in the future instead.

Regards,
Tiwei


