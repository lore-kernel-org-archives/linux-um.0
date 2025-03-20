Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C81BC28B30
	for <linux-um@archiver.kernel.org>; Thu, 20 Mar 2025 14:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Nq5J3rEjJGpu3g9dH55QLH8Cw8fRiXcX7uIwi+ELtM=; b=nrWbG3qTgCE5wYOWXCwukliYKB
	eYn1j6W5B6LhOu3log0Rv6CZvuzBvKjVhwDBAtmKkT/dlGWutQOO4jfnsWC7jMl2Qm9ia23Iv2DdE
	j9ZOlntxLhEn6ctzM0x2e57zj+oewMjeYBURzddd+VVk38wxfpqCAPR7cuEYexWbRA2OXE1FiP8dm
	CDqR4ATCYNUe9jIQ7r6pijRWsVelaWNh7/QcKdW/cI3DBT3fWFQhIqfjpSbHc/xi5q+9UkONji1jR
	3vZZIeVV7sbGo9C3TIH6FY7CeUuvvcm9daP89IYnVvBylU/zg8sp+LkIIZ7ErBV3lHW/+VZMtisnB
	uGrM1avA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHCg-0000000CROc-1IZV;
	Thu, 20 Mar 2025 14:49:02 +0000
Received: from out0-221.mail.aliyun.com ([140.205.0.221])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvH6H-0000000CQ2J-2Evd
	for linux-um@lists.infradead.org;
	Thu, 20 Mar 2025 14:42:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742481739; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5Nq5J3rEjJGpu3g9dH55QLH8Cw8fRiXcX7uIwi+ELtM=;
	b=KTjkmaAkjaHDpV+0+0135fvXoMPMaX3o3AisL5n0p/wcyc2akdvRfUJBTagRiW7BlwlX6o7tr/mwxlwLIRKDScAYpIuR1/n+Guo9qedWU8V3fQiVzJKwb5/UKXc0QP9lJOIoOdGFXsd2clg/7s300Amqs3CUkNxrGaLhuuHgbz4=
Received: from 30.174.89.39(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bzYUHFK_1742481731 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 20 Mar 2025 22:42:17 +0800
Message-ID: <ae6c6184-aad4-40d2-9b2f-ac505a5d33c9@antgroup.com>
Date: Thu, 20 Mar 2025 22:42:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] um: Prohibit the VM_CLONE flag in
 run_helper_thread()
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org
References: <20250319135523.97050-1-tiwei.btw@antgroup.com>
 <20250319135523.97050-5-tiwei.btw@antgroup.com>
 <495e4b66edcc65ba9630cf1bbbb119b971af2df6.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <495e4b66edcc65ba9630cf1bbbb119b971af2df6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_074226_108330_22EF0163 
X-CRM114-Status: UNSURE (   6.87  )
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

On 2025/3/20 16:32, Johannes Berg wrote:
> On Wed, 2025-03-19 at 21:55 +0800, Tiwei Bie wrote:
>> Directly creating helper threads with VM_CLONE using clone can
>> compromise the thread safety of errno. Since all these helper
>> threads have been converted to use os_run_helper_thread(), let's
>> prevent using this flag in run_helper_thread().
>>
> 
> I notice that now there's only one user left, the SIGWINCH handler,
> maybe we could change that too? Anyway not related to this patch, of
> course.

Yeah, it would be great. Once the SIGWINCH handler has been changed,
the legacy run_helper_thread() helper could be removed. :)

Regards,
Tiwei


