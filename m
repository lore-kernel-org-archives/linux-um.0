Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCF6C35FFA
	for <linux-um@archiver.kernel.org>; Wed, 19 Mar 2025 12:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=58t17/FryLoihx7IbQO2JGVhfBBJ0/DHODS/xHkbCMs=; b=OfOkjEQ1pJGHJSNPm7kI6IXvMV
	tcKwLE53cLhmb/5U774KjOZ/51haR0DhXZV3zfGinDXcR43ulZD20E8JM1fW97Ai9OWBSWGXm/NX2
	RVnocWqtdLO/LZIrBLLNjVpe0omJPB8bDy2KUCOSa4Yv4dIa30lDgNJ0/Z/nwrqVLkfpbWgTVh+Qr
	vkbYnIF40mQdXc1ztTgpLsgZ96HhTs85C94LGc2QYjwrohLr0B/s25zjkO1TvbBzDU4qejM5rRTxj
	SBE9C0531pYk5tqWqS6ZG3uordr3ocjkyMo90zWOR/zvNRLoVbfFimvschYG+3TYOTYtSEbuJ6qYE
	HgTSNKxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tusCk-00000008vOZ-0nR1;
	Wed, 19 Mar 2025 12:07:26 +0000
Received: from out0-206.mail.aliyun.com ([140.205.0.206])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tusCg-00000008vNJ-3dEJ
	for linux-um@lists.infradead.org;
	Wed, 19 Mar 2025 12:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742386039; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=58t17/FryLoihx7IbQO2JGVhfBBJ0/DHODS/xHkbCMs=;
	b=WpwanDNGe0BV0puZNR6Al+4a9K+gDHWMf6OdqoCtlOf1HWjMUVckouNwRHLntdN7bYo+fMPNtGsO3ueX0OcBuMj1KY7+xD1qN/wIifjNB5KL7C7Al/i+VuPswtDupFzONF20sVGePrQ4n/JWNpuWBgUpUdyg+aOzi1tw8uVuGYg=
Received: from 30.230.84.1(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bxzuehh_1742386030 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 20:07:17 +0800
Message-ID: <3df3cd48-e409-4cd6-8dae-d8062c84bf3d@antgroup.com>
Date: Wed, 19 Mar 2025 20:07:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] um: Add pthread-based helper support
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
References: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
 <20250306150747.2926434-2-tiwei.btw@antgroup.com>
 <91bdd4a1200950bf26d3cbe1a42cf1beb913a153.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <91bdd4a1200950bf26d3cbe1a42cf1beb913a153.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_050723_402136_13790459 
X-CRM114-Status: UNSURE (   7.78  )
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

On 2025/3/19 17:11, Johannes Berg wrote:
> On Thu, 2025-03-06 at 23:07 +0800, Tiwei Bie wrote:
>> +void os_kill_helper_thread(struct os_helper_thread *td)
>> +{
>> +	pthread_kill(td->handle, SIGKILL);
> 
> This ends up killing everything.
> 
[...]
> 
> Anyway, the issue is I cannot shut down, I get:
> 
> reboot: Power down
> Killed
> 
> and the terminal isn't cleaned up, i.e. shutdown code isn't run.

Whoops, I completely missed that.. :(

Thanks a lot for the test and analysis!

It seems that SIGKILL will always take the process down [1]. We cannot
use SIGKILL to kill helper threads anymore after switching to pthread.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/signal.c?h=v6.14-rc7#n1005

Regards,
Tiwei

