Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D15C30653
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 10:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kgvocbsVMniYnA46xCHP0pdhefiuh0xvPZAtTS5ibmw=; b=bODhH4/a+/rS60xacTxJ5NiV5k
	TARMR6Sq+sIuM+W2pZ0wIDBZ26wTz3B5UHGD/eRf9g5i5eRDZsxzPCpgJkfbQXvwso+RtzSiPEDEu
	HXqC51MBd1tfwTz2mJvyDlYkIMGX23p/DSFj3BDlDT99ab+eFmwEjphrS9ILH5/PVJQF++jzcbfRT
	Mh8ARAoPyIPL9loi/jMRJoHXIcIELy8wg1gXJmJtNcsSfi7EuwX65XO9D61VL7r1DaTpVKS6ERuYg
	G2dLFQ6zZ23tvoXM+HhJa7by4LlGH9mXxpg02UK17cQO06050YTsB3+o8fRLm6optkd2V4f5FIMX+
	elUC+J3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPK6Z-0000000Cw3T-0Gsa;
	Thu, 04 Jul 2024 10:54:23 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPK6V-0000000Cw2L-42pZ
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 10:54:21 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sPK6T-005d1W-Ra; Thu, 04 Jul 2024 10:54:18 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sPK6R-007ev2-0G;
	Thu, 04 Jul 2024 11:54:17 +0100
Message-ID: <4fbae305-6249-4d63-ac85-679da1342ae4@cambridgegreys.com>
Date: Thu, 4 Jul 2024 11:54:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: Replace locks guarding queue depth with
 atomics
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20240704072154.1716301-1-anton.ivanov@cambridgegreys.com>
 <43f01cf5b1e55730ee06a42136a8814a61a84951.camel@sipsolutions.net>
 <8b581760-1ac3-4aa0-9257-aac2799e02c0@cambridgegreys.com>
 <d9367dcf-5383-4dc4-ac84-fae5e104eccc@cambridgegreys.com>
 <78132ecdf0eecd3b78c16499989c1a36ef7c8603.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <78132ecdf0eecd3b78c16499989c1a36ef7c8603.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_035420_035119_D08C576A 
X-CRM114-Status: UNSURE (   8.00  )
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



On 04/07/2024 10:55, Johannes Berg wrote:
> On Thu, 2024-07-04 at 10:52 +0100, Anton Ivanov wrote:
>>>
>>> There is an extra issue there - stats. I need to double-check the locking when
>>> they are being fetched.
>>
>> Same story - these need atomics. Otherwise we can potentially get the same ABBA
>> lock issue when they are being fetched.
>>
> 
> Email overlap ...
> 
> I don't think so? If no other path now uses _both_ locks, the stats path
> can, it'll just be "AB" never "BA".

Good point.

> 
> johannes
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

