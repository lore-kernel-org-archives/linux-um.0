Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5672BD10BF7
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QX0PbyaMBP4Jnj+1OSpBsDXXO5/csjDDNDRc9dkr6/8=; b=HfSf4O9TglZS/2EuHtoGKUAEwT
	G4L9jWeh8axa2i7OEPY8l5MvgucDyMkYt1CFqgGwEoUGNmVAiHy/587Ne8PSdqBfhfO2uVbX4acdI
	mRkwXbhp4QfqKHdzZtPIV4DWVWbdbY9jbCSg+A6Y+XdeI72BgLd/QFnmV5kHrUn7bRVCdzzITjogC
	/hFM0/dnQg1QKoCU7+9M0Q/AfkhAkw9ng4q+Jat84rdkWkO+roNxEOmzWJNliRm7BkEVeKx+bsE6w
	iJZUN2hwptyvsZ2EOmPEjEBGzVPumMpnmhQWWQ+5dloUJzQmqRjdhaK430t7sCAJ7GgJiKBz5GZS5
	rnkpeRwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4h3V-00000006hc6-084e;
	Sat, 26 Oct 2024 13:42:13 +0000
Received: from out0-198.mail.aliyun.com ([140.205.0.198])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4h3R-00000006hbY-1lZ6
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 13:42:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729950122; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QX0PbyaMBP4Jnj+1OSpBsDXXO5/csjDDNDRc9dkr6/8=;
	b=AuIhOEWQWTFG3Sw4BCt7F+c859iltSAiPLZs8sjn/uuvQpm5CMA938pRfIs/nxJERs6009HcZ5bZL5IiirldaAK7ofT4v3TBolkNCXjJOlDqzolKyUMKkA9Llc7iC9161wiidltA3zTcbYSAt5dyWfmsx1gWHlDg2GjulOHRkrs=
Received: from 30.32.106.210(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZtJ6TkF_1729950111 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 26 Oct 2024 21:42:00 +0800
Message-ID: <c721c0b3-a3f5-41ec-bbdf-c14ac55704a1@antgroup.com>
Date: Sat, 26 Oct 2024 21:41:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/9] um: Implement kernel side of SECCOMP based
 process handling
To: Johannes Berg <johannes@sipsolutions.net>,
 Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
References: <20240925203232.565086-1-benjamin@sipsolutions.net>
 <20240925203232.565086-9-benjamin@sipsolutions.net>
 <590b1ea94cd8166dde2230e8aa8c80045f30cfe4.camel@sipsolutions.net>
 <1aeadd38be5b073cb1f2fd1e1caa55f3997be14e.camel@sipsolutions.net>
 <6182ae812f461ae75d11ba1fc78905cf27114d12.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <6182ae812f461ae75d11ba1fc78905cf27114d12.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241026_064209_978554_001D1511 
X-CRM114-Status: UNSURE (   8.90  )
X-CRM114-Notice: Please train this message.
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

On 2024/10/26 20:56, Johannes Berg wrote:
> On Sat, 2024-10-26 at 13:04 +0200, Benjamin Berg wrote:
>>>>  
>>>> +#include <linux/kconfig.h>
>>>
>>> Hmm. If this works, why do we have UML_CONFIG_64BIT? For ASM stuff?
>>
>> So, I just had a quick look. It seems that before commit a95b37e20db9
>> ("kbuild: get <linux/compiler_types.h> out of <linux/kconfig.h>") doing
>> this would have caused compilation errors.
> 
> And that commit was pretty much done for the exact same reason!
> 
>> With that change, there shouldn't be a reason for the various
>> UML_CONFIG_* macros anymore. It should be safe to include
>> linux/kconfig.h (and if we are not allowed to do that, we could still
>> use generated/autoconf.h).
>>
>> Maybe we should see this as a cleanup opportunity?
> 
> Sounds good to me! That also gives us IS_ENABLED() which can be a nice
> cleanup opportunity too :-)

+1, I also like this idea! :)

Regards,
Tiwei

