Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DECCC282EC
	for <linux-um@archiver.kernel.org>; Tue, 18 Mar 2025 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wp5VFf1KtgG2aAQ8LxgiSdVf9ERCDO64Wnz+wgaB/+w=; b=vazuyIIkTqati8xRn1nHp+kEGu
	0nWHVSHj+Z9AdaNeShoCY8viPiQVMUlT4ODpH4AvQkn1DloAqK4R8C7eiXDNDwXohV0hcksf++I5h
	NsALLiQZOYgJ3+im8qCHP0LceO7fkduYxb6RG0eJBYyG5+8UaTut8qz542xqED4EsZDI7DIhpEH0J
	2csVMpdSorgFlT8bEbevYCgCaj9My9K+jwgdJywvrm1Qhp3Q3rxWmFzB4lWBDSV0SR/pNhyhPdbIq
	yZqZnZN7lZ+AsoYOhgArP+PPHmpo6kXr4k4SjucXtqP6UAOGG+GBUVbl9qorkyjT8rsSiN2xSUCkK
	lHZBYbXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuYMw-00000006GD8-2yOr;
	Tue, 18 Mar 2025 14:56:38 +0000
Received: from out0-203.mail.aliyun.com ([140.205.0.203])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuYMD-00000006G5u-1OmK
	for linux-um@lists.infradead.org;
	Tue, 18 Mar 2025 14:55:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742309747; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wp5VFf1KtgG2aAQ8LxgiSdVf9ERCDO64Wnz+wgaB/+w=;
	b=IZZBI9hh1lDRH9AqG3AgeIxBaOKZ4GjAWHOoHgNts27sb9a3y4L2Bb+lHDMCfZtp4sVUuEBwtWdpTjpPUoFQDxBRow+NyrzFkryHuosLCMXME38tSGIjNDpX3o/Xcf4ndwa77P78qTHJGe1nr2PJPDkcwC2WdU3LsKu4BjEPQdw=
Received: from 30.174.89.112(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bxNmPLN_1742309728 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 18 Mar 2025 22:55:44 +0800
Message-ID: <870c3af1-10e3-4629-93de-cb92a83de00d@antgroup.com>
Date: Tue, 18 Mar 2025 22:55:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] um: Add pthread-based helper support
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
References: <20250306150747.2926434-1-tiwei.btw@antgroup.com>
 <20250306150747.2926434-2-tiwei.btw@antgroup.com>
 <306312a14326a482cba476733a4adde1799b7ccf.camel@sipsolutions.net>
 <bacc4abaaec8c254e33974d63482575e8e9448aa.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <bacc4abaaec8c254e33974d63482575e8e9448aa.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_075553_888573_5612E0A8 
X-CRM114-Status: UNSURE (   7.96  )
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

On 2025/3/18 21:16, Johannes Berg wrote:
> On Tue, 2025-03-18 at 14:06 +0100, Johannes Berg wrote:
>> On Thu, 2025-03-06 at 23:07 +0800, Tiwei Bie wrote:
>>> Introduce a new set of utility functions that can be used to create
>>> pthread-based helpers. Helper threads created in this way will ensure
>>> thread safety for errno while sharing the same memory space.
>>
>> Using pthreads seemed odd, but Benjamin argues that it's the only way to
>> get libc to really sort it all out, unless we never use libc syscall
>> functions, which is probably kind of unreasonable? Or maybe we could?
> 
> It's a long list of symbols that are needed:
> https://p.sipsolutions.net/2f0c8e0de1e69147.txt

Thanks for the list! That's indeed a long one.

Regards,
Tiwei

