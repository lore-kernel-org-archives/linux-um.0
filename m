Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF01CD5BD5
	for <linux-um@archiver.kernel.org>; Thu, 28 May 2026 08:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F/GLgACGwCkRETnNK8RBCZY3F27VlxZG83Q+qr3TImQ=; b=dBxW5LH2A2mOnj6/t23Ixa4Udr
	oOhO0UvHoDSGEEXbcgTgvCxN7W/B09cr7Rhf/IK4NvmwfvhJwiyINnSwS06qHzqQ3BwQfrtvDwxRn
	DRbqOp1E5PwndZidkSTxOsN4aqkrYXDgvbiP1WnqFXjOLCgXVYNkNe50ZxHlrdtAiolY7fOKCVscA
	RXFNpKEQNl8Kzgcuaa43GA4HN50PfvstP6UQZUYb5ye71I+2l10aj96xoov/YYOZiKtQm7Mive4GH
	ii3L4hNGZWiT0UqTfSpMBV16sftVMEk/Nb4jiNBfWlldFS8V1TgHgEquq37IXRx8O6MjkkQpyhDUL
	6ZNX4whQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSVzy-00000005MjC-0czm;
	Thu, 28 May 2026 08:21:50 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSVzv-00000005MiP-0kWP
	for linux-um@lists.infradead.org;
	Thu, 28 May 2026 08:21:48 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wSVzo-000QP6-W7; Thu, 28 May 2026 08:21:41 +0000
Received: from [192.168.21.56]
	by jain.kot-begemot.co.uk with esmtp (Exim 4.98.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1wSUVk-00000001e5R-38z3;
	Thu, 28 May 2026 09:21:40 +0100
Message-ID: <d93d4482-c520-49b1-bd22-19376102752f@cambridgegreys.com>
Date: Thu, 28 May 2026 09:21:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: vector: avoid NULL queue dereference in legacy RX
 mode
To: Johannes Berg <johannes@sipsolutions.net>,
 Henry Barreto <contato@henrybarreto.dev>, Richard Weinberger <richard@nod.at>
Cc: Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org, Henry Barreto <me@henrybarreto.dev>
References: <20260527213524.45903-1-contato@henrybarreto.dev>
 <b72e33e9d651f67ff2236b21fc13c3c78a99cb97.camel@sipsolutions.net>
 <a3be3b6c-3347-4b5b-97fa-2431cfb76623@cambridgegreys.com>
 <21c2c12a804d662d74c3518267d90e045223583e.camel@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <21c2c12a804d662d74c3518267d90e045223583e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_012147_240760_5FB1E4F2 
X-CRM114-Status: GOOD (  13.91  )
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


On 28/05/2026 09:17, Johannes Berg wrote:
> On Thu, 2026-05-28 at 09:00 +0100, Anton Ivanov wrote:
>>> So ... you're effectively saying that the tap transport has been broken
>>> since 6.12, released ~1.5 years ago.
>> The one I use is raw :) It is the most useful.
> Right.
>
>> Tap badly needs someone to expose the socket which the kernel uses to implement it. I started writing a kernel helper at some point, but never finished it. It should be able to produce "stupid speeds" with it.
>>
>> And, yes indeed, this was broken by 612a8c8e0b43ba7e3d0e51f6f76a5fec4912d439 / 2024-07-05 which by the look of it I did not test for tap.
>>
> Yeah, I guess I'm just thinking that clearly nobody uses it, the
> infrastructure isn't there (as you say), and it was broken for a rather
> long time now and nobody complained (that we know of.)

That part of the code also gets hit if you turn off vector RX or TX from the command line, so the patch is needed anyway.

>
> So ... is it worth even keeping it? I'm fine either way, just wondering.
>
> johannes
>
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


