Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28B1C36008
	for <linux-um@archiver.kernel.org>; Wed, 26 Mar 2025 06:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4jZnYO+GrdEPZicfFrRLClsbCDnhGukQpycELyQq5DM=; b=c3SRVtDAc2gcErPj5eaE5v9ZmI
	SR0PDvR8Jt5BCwssmNoBzwEQfbTm74b+A9GVq+2eqDgJ/9VFeoVgb2vflbfpl7VfDWd2l+zH7lFx2
	gamgquftiJOmCtOb4irpfYLAeWFmRlZPfEAGN3OcoXWJUNK5f+B5nBUMrTib/BfhjEuIkLkKCAgJR
	txSGCVHQJ4pSwBUs6NgILbUiOMcTsiqYKvyJXrPMMlkaFR+4yQKbkwWIqlKBxSTVd3e/wz779+lmz
	1NRmD/FmFiK7xB05eZv6TNKVKZhlwMaykeTWKPR13n2ZZy1w06tDpn3HncnH56ntrIqqi1nhE5RE5
	yt00xdeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txKN4-00000007ftp-10Bi;
	Wed, 26 Mar 2025 06:36:14 +0000
Received: from out0-214.mail.aliyun.com ([140.205.0.214])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txKIH-00000007fM8-1Ot4
	for linux-um@lists.infradead.org;
	Wed, 26 Mar 2025 06:31:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742970671; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4jZnYO+GrdEPZicfFrRLClsbCDnhGukQpycELyQq5DM=;
	b=n4jffT66cNtBK7Uy8fs6l8BxGjvhe3S5mkRvxwGqH2lvrPmVH7MLkF2BRKoArjYDUdVRPRdicKk8jmZqWLhRQ4UzkqaFT9byANNqzGhRuHj9MpM6dh+y9YA7sO/k3MegnFQsP20uo/CYJly1qJSQabK4MOAr5rZC3JyCnIgagFA=
Received: from 30.230.81.73(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.c3edHKO_1742970661 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 26 Mar 2025 14:31:07 +0800
Message-ID: <e62f39fc-5c45-4b57-acff-46c4a02d43bf@antgroup.com>
Date: Wed, 26 Mar 2025 14:30:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] um: Add pthread-based helper support
To: Benjamin Berg <benjamin@sipsolutions.net>,
 Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
References: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
 <20250306150747.2926434-2-tiwei.btw@antgroup.com>
 <306312a14326a482cba476733a4adde1799b7ccf.camel@sipsolutions.net>
 <bacc4abaaec8c254e33974d63482575e8e9448aa.camel@sipsolutions.net>
 <870c3af1-10e3-4629-93de-cb92a83de00d@antgroup.com>
 <e09f89242902f4a169196f16836e53665198f616.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <e09f89242902f4a169196f16836e53665198f616.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_233117_918511_8B758E0D 
X-CRM114-Status: GOOD (  12.84  )
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

On 2025/3/26 00:31, Benjamin Berg wrote:
> On Tue, 2025-03-18 at 22:55 +0800, Tiwei Bie wrote:
>> On 2025/3/18 21:16, Johannes Berg wrote:
>>> On Tue, 2025-03-18 at 14:06 +0100, Johannes Berg wrote:
>>>> On Thu, 2025-03-06 at 23:07 +0800, Tiwei Bie wrote:
>>>>> Introduce a new set of utility functions that can be used to create
>>>>> pthread-based helpers. Helper threads created in this way will ensure
>>>>> thread safety for errno while sharing the same memory space.
>>>>
>>>> Using pthreads seemed odd, but Benjamin argues that it's the only way to
>>>> get libc to really sort it all out, unless we never use libc syscall
>>>> functions, which is probably kind of unreasonable? Or maybe we could?
>>>
>>> It's a long list of symbols that are needed:
>>> https://p.sipsolutions.net/2f0c8e0de1e69147.txt
>>
>> Thanks for the list! That's indeed a long one.
> 
> So, if we dropped libc, then I think that would also imply dropping the
> abstraction to support hosts other than Linux. And then the hard split
> between user/kernel code might not be needed anymore as one would
> ideally not rely on system headers at all.
> 
> I can imagine that parts of the code base would really benefit (e.g.
> include handling). While other parts would obviously become more
> complicated (e.g. parsing /proc/cpuinfo, mcontext handling).
> 
> It seems to me that the cleanup potential is likely big enough to make
> it worthwhile.

+1. By dropping libc entirely, we can achieve greater flexibility and
elegance by directly leveraging the Linux ABI. While this approach may
require considerable effort, the potential benefits seem worthwhile.

Regards,
Tiwei

