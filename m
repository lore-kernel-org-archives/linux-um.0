Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AF4C3065C
	for <linux-um@archiver.kernel.org>; Thu,  4 Jul 2024 09:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+oVzVmT/1e1Qz3Me9s5crQyuWOUQTb71hXAKCetk+Uo=; b=ynuxycYLUCerBdWdQQS5bynff9
	nRfhqqxeZZ6Ny9GHxIQly9JBxUkQ0C8ycnPBhHbM10phqHCfmF6Mrv/GQOEhaMHBk3+FFJ0AM3tCH
	bi8Q+DTluZhi2BoHMOCIiMXncNsJJ6f3fl7zf03o8OqtAbGxgIi6Zt8R6nPi0t4eOIBJoYWy3gy1c
	shRHPWHk8eEhRgfiErC89HWxzxIBt8TCTPLPxvjGVFbXjeVgpw5TbCZcKSarMlg47DH/EkQG6921Y
	Piby+QKN8zPpnW2yRuGqPUPSqU5rGOicHfwAwasPZKBWi2L9m60ayWFKSjRYZo7BlkJkUh7qHlovq
	TlfxZEVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJ2n-0000000CmZu-2OuF;
	Thu, 04 Jul 2024 09:46:25 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPJ2k-0000000CmZV-3v0N
	for linux-um@lists.infradead.org;
	Thu, 04 Jul 2024 09:46:24 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPJ2d-005cpI-CX; Thu, 04 Jul 2024 09:46:15 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1sPJ2a-007Vqk-0J;
	Thu, 04 Jul 2024 10:46:15 +0100
Message-ID: <fc08c3c9-0861-4dd3-911e-28f3ad01cf0a@kot-begemot.co.uk>
Date: Thu, 4 Jul 2024 10:46:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: register power-off handler
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20240703173839.fcbb538c6686.I3d333f4773cff93c4337c4d128ee0b1b501b3dfa@changeid>
 <456e9b12-fd66-4da2-be6c-ad04222da495@kot-begemot.co.uk>
 <f2fcf3ae00e5bcffc0337f3022128dbb5c63c699.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <f2fcf3ae00e5bcffc0337f3022128dbb5c63c699.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_024623_004178_781A223B 
X-CRM114-Status: UNSURE (   5.56  )
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


On 04/07/2024 10:21, Johannes Berg wrote:
> On Thu, 2024-07-04 at 07:58 +0100, Anton Ivanov wrote:
>>> +__initcall(register_power_off);
>> Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Heh, I thought I saw an Acked-by from you but then patchwork didn't seem
> to pick it up, I guess I'll treat it as one anyway? :)

Yes. Sorry. Too high blood level in the coffee circulatory system.


>
> johannes
>
-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


