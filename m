Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC479CE79CC
	for <linux-um@archiver.kernel.org>; Wed, 20 Sep 2023 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:From:To:MIME-Version:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DRX7p50BVtEJJ5tl1wzEAVbZMG35repKZ0i8cl51FxQ=; b=s68fPS1jKa3eUk
	RgZU8UsWA/Ng40lK+FO1YoOiocZVT9FwQX+1he1X9IVdZD1rwWktLt4ZfSxGaOFaGSfP07UH+uJKm
	J7YrbpKlAhzz+u1CXoMRg/E9s+F7NlgYyYcg0Lg5yxu8frj/VQ3dbkY+L5u5duojve0hdz4DEcfvQ
	6o1GnJPU8nKyDALFQLwVHKZXk6WX+fEl8jJ6+GpJs6Gyie4JQLn6xU6Wn+YfZBuaCYXbJgtHLU0FX
	V/p08S01ElXhb/DuHVB01gIhoD4agzBWwtgMMxix3R+TH3/dad8gryLyU/3CD7ic/TpNiccGfKQeh
	9wcOMPjPSND36G7qeB8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qivAD-002qYq-27;
	Wed, 20 Sep 2023 11:14:37 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qivA9-002qWg-35
	for linux-um@lists.infradead.org;
	Wed, 20 Sep 2023 11:14:35 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qivA2-002Vk5-FE
	for linux-um@lists.infradead.org; Wed, 20 Sep 2023 11:14:26 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qiv9z-00HA6r-Rt
	for linux-um@lists.infradead.org; Wed, 20 Sep 2023 12:14:25 +0100
Message-ID: <6eb21cc7-05d5-c9be-6abd-07bdda64dcb6@kot-begemot.co.uk>
Date: Wed, 20 Sep 2023 12:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: User Mode Linux <linux-um@lists.infradead.org>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Boots and seems to work with PREEMPT enabled
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_041433_989893_6CC3A5DD 
X-CRM114-Status: UNSURE (   5.91  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Added support for kernel side fpu store/restore and real kernel_fpu_begin/kernel_fpu_end using gcc intrinsics. Enabled PREEMPT.

It boots and seems to be alive and kicking. I do not notice any significant effect on performance either.

How do I test it from here onwards?

I am happy to throw the patches on the list as an RFC, though I would prefer to test first :)

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
