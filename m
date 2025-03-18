Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F691C28B28
	for <linux-um@archiver.kernel.org>; Tue, 18 Mar 2025 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzNTv9iMWIhEiHRW4xa5KRNKBe+R4eBf6YmXgMd/1kI=; b=W9fzLPbc1rihV5O3/9VWygP/It
	PJLGLRgOVDwo24e4D5YGQmk09SPThyZHQuR/3Nu9NdktJT4UYlWTmQxFXxra3Y67UoOaB4QOnDiNc
	Hiy8RpZ3KclDeUk0nV74XITWGNSa/zEaAJxGYIGhQbuvm9M7W2I+u6dc4qZUPgih+jEYUASMbEC5h
	zy8F5Am40uKrdW7CPdL+4J+0rJnRvibmuci8nQqmOmN9kmn2r9oDl123ik/JIiRaXc0Kl6SicAEzQ
	f4O5zqCd/TPumUXymNX/2QtL8HXSoU83zEvvEcvm72qWbFSZwb8pfwpborf/7tm7cx5I11myYN+2C
	79elxIFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuYRy-00000006Hga-47Ys;
	Tue, 18 Mar 2025 15:01:50 +0000
Received: from out0-202.mail.aliyun.com ([140.205.0.202])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuYQb-00000006HO8-1Coe
	for linux-um@lists.infradead.org;
	Tue, 18 Mar 2025 15:00:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742310022; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OzNTv9iMWIhEiHRW4xa5KRNKBe+R4eBf6YmXgMd/1kI=;
	b=l8npzlNNjZ394ywBpZ3tMsC0zKbKPNtA1Q9QVhoMOatkgFrFl1QhfzVRgN0xebVoNQInfB4njjfwBVGqLs+I6RLwzCJoQCJVFd6u0w+QG5htHIzd1v7vAXllab179x0sbI3vepWJ+I9+ELIIuXS/yWYwGMDxI27ea4UTQ70UsbI=
Received: from 30.174.89.112(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bxNmQFl_1742310019 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 18 Mar 2025 23:00:19 +0800
Message-ID: <9c4ddb35-fb86-4d38-aa27-c6fc79f2f3a0@antgroup.com>
Date: Tue, 18 Mar 2025 23:00:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] um: Add pthread-based helper support
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
References: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
 <20250306150747.2926434-2-tiwei.btw@antgroup.com>
 <306312a14326a482cba476733a4adde1799b7ccf.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <306312a14326a482cba476733a4adde1799b7ccf.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_080025_512940_FA418045 
X-CRM114-Status: UNSURE (   8.78  )
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

On 2025/3/18 21:06, Johannes Berg wrote:
> On Thu, 2025-03-06 at 23:07 +0800, Tiwei Bie wrote:
>> Introduce a new set of utility functions that can be used to create
>> pthread-based helpers. Helper threads created in this way will ensure
>> thread safety for errno while sharing the same memory space.
> 
> Using pthreads seemed odd, but Benjamin argues that it's the only way to
> get libc to really sort it all out, unless we never use libc syscall
> functions, which is probably kind of unreasonable? Or maybe we could?

Thanks, Benjamin! :)

Yeah, it's also the only way I've figured out so far, unless we don't use libc.

> 
> 
> Either way though,
> 
>> +#include <pthread.h>
> 
>> +	err = pthread_create(&td->handle, NULL, routine, arg);
> 
> if we're going to use pthread API, then we need to link against it?

I had the same first thought, but scripts/link-vmlinux.sh already handles it:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/link-vmlinux.sh?h=v6.14-rc7#n85

Regards,
Tiwei

