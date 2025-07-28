Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4279C87FC9
	for <linux-um@archiver.kernel.org>; Mon, 28 Jul 2025 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MUAxr81O75BjtzwkUftLSmn9zrZcUMS8SkgxDTq6MVw=; b=3dZATBkKxNkVmOLIpmdI+022vR
	wOkpUQNee+GmHDz9R5Yvr6x1HZPQ9YNwBoQKG/NDcpIeNk066zDv2GDpfwhr2NsArr9JIBMJ2haXx
	puKKBNLLrPLwMH3Ct1qW0dYP1orlScXidPhkkPnkvSHy5eGZIS5Z8GOkc4OlD4EQrUW4GsCFigcaU
	n3IncOB3GxLaT95K2vq3gVKdx0TDVw3eVya5/uoeiLnDtaZ1xj/R9g8F6Xzv5+oCy1mRjKagA1OrB
	SRRLp4z9x5dJYpk/yLITGNZSHbldu/luGtv9apBMajopCM/jKhqR45qWNHyoczMeujatRdCMPElxZ
	xG6YbTVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugPrH-0000000EpW0-0rF9;
	Mon, 28 Jul 2025 15:33:47 +0000
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugPmU-0000000EobJ-41zE;
	Mon, 28 Jul 2025 15:28:51 +0000
Message-ID: <dcc88c8f-9330-4e1c-9ee4-4e0dfe7bda71@infradead.org>
Date: Mon, 28 Jul 2025 08:28:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] um: Add initial SMP support
To: Johannes Berg <johannes@sipsolutions.net>, Tiwei Bie
 <tiwei.bie@linux.dev>, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, tiwei.btw@antgroup.com,
 linux-arch@vger.kernel.org
References: <20250727062937.1369050-1-tiwei.bie@linux.dev>
 <20250727062937.1369050-10-tiwei.bie@linux.dev>
 <233c916a5c598ca246b3138d13aaad44fdde68b2.camel@sipsolutions.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <233c916a5c598ca246b3138d13aaad44fdde68b2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 7/28/25 3:47 AM, Johannes Berg wrote:
>> +int smp_sigio_handler(struct uml_pt_regs *regs)
>> +{
>> +	int cpu = raw_smp_processor_id();
>> +
>> +	IPI_handler(cpu, regs);
>> +	if (cpu != 0)
>> +		return 1;
>> +	return 0;
> nit: "return cpu != 0;" perhaps

	return !!cpu;

-- 
~Randy


