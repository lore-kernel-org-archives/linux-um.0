Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0C2C636CC
	for <linux-um@archiver.kernel.org>; Tue, 31 Jan 2023 07:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ukoJ8r0kA10E0+NsOkIHRHSJJ93+rmuFjLl1HGuMu7w=; b=LpOgVAPbbV1Syo
	1H/JhJDNni7frNWL3efOe0LveUoqyBEyE/xnH5BEZecGwTMGmNH0x4GKv0imMfrh1bvQbnDxSL1GA
	/j3ny4e1WQ71/wdF8JIPb06/EoSWOHC/VJKPR8BDO2peALpP5WFcXESU4tbeSMYofwLQN11baE/CJ
	wSTdq113bcEC7SEQfHVr+/SRFlQ8pYz/0nB3B7h7jWzlZv+FhA93LdyuoJADPrWL+rDUneYXhrKVC
	9UY+NcXWy+uyhECl+fTp3WQNU8CLuhXNvjy+6cREnpzeTXIlJfgkNfrIO3Zb2oBU7R8OYkBeJf4rg
	h9una8MWJa7FhWbO7L+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMl8B-006aKd-JL; Tue, 31 Jan 2023 07:32:39 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMl88-006aJh-Jy
	for linux-um@lists.infradead.org; Tue, 31 Jan 2023 07:32:38 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1pMkQY-006tUH-Iy; Tue, 31 Jan 2023 06:47:35 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1pMkQV-00B1Re-Ka; Tue, 31 Jan 2023 06:47:33 +0000
Message-ID: <aa957c80-1aeb-8fde-440e-6e4408c59559@kot-begemot.co.uk>
Date: Tue, 31 Jan 2023 06:47:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Using ftrace
Content-Language: en-US
To: development@efficientek.com, linux-um <linux-um@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>
References: <20230130221748.5c472da5@crass-HP-ZBook-15-G2>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <20230130221748.5c472da5@crass-HP-ZBook-15-G2>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_233236_678699_D396FAB4 
X-CRM114-Status: GOOD (  11.36  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 31/01/2023 04:17, Glenn Washburn wrote:
> I'm trying to use the ftrace facility within UML. It appears as though
> it exists in the menuconfig, but I can't seem to get the kernel to
> recognize the tracefs filesystem. I'm wondering if someone can confirm
> that either ftrace does or does not work in UML.

I have not used it. We have not had any requests related to it either

I will look into it.

Brgds,

> 
> Thanks,
> Glenn
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 


-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
