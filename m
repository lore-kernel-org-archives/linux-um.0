Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C334CE7A96
	for <linux-um@archiver.kernel.org>; Mon, 25 Sep 2023 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQ7FTbfHYVuA/Gp5Qg9zJLu/KgMyh1vzhwTnE38mEYc=; b=rH7VzCiD0enUtR+KKKTnsHc2qu
	mf3jTujheGVB2/dgQxPmlN9hfYckPkRWkJO3nnb7wM0e3rGyEfQqq5nTpkT+aawSzJFa7AjLA2IAc
	IhRzk0voSTpmjRiVZhS2nHhVfY4r4LWmMzGx5ButtkavXjsAjv3d+/fVeQPlkkqjsHytkfKsSI4MO
	+7LZHa3zq7kqUnXMSXBddKjzzy+3eb9044G3tGC5YUj4NiS6CujyhANC3V+ZSzsFqFQ6Jb7CyK+nO
	TMI1Sv/aI3vmvVlTZUuw/MmhC35HNqW3WdSDNGlSG2tyhU8Fv8magMfjquEKc7RcxuPlBcdYQFdbX
	CqaEzyAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qklen-00EL0R-2b;
	Mon, 25 Sep 2023 13:29:49 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qklek-00EKyo-0A
	for linux-um@lists.infradead.org;
	Mon, 25 Sep 2023 13:29:47 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qkled-002ng6-Ow; Mon, 25 Sep 2023 13:29:40 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qkleY-006Ejz-3B;
	Mon, 25 Sep 2023 14:29:39 +0100
Message-ID: <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
Date: Mon, 25 Sep 2023 14:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20230922223737.1206223-4-johannes@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_062946_110503_4B96426F 
X-CRM114-Status: GOOD (  10.02  )
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

I have rebased the preempt patch on top of these series.

PREEMPT works with some performance decrease.

VOLUNTARY deadlocks early in boot around the time it starts loading modules.

non-preemptible deadlocks very early in boot.

I am going to investigate and come back with a revised PREEMPT patch (hopefully, this will also flush out any remaining gremlins).

A.

On 22/09/2023 23:37, Johannes Berg wrote:
> This shouldn't pessimize since we keep copy_context_skas0() and
> the setup there, but still clean up the code there to not rely on
> current, and move the force_flush_all() to a more appropriate
> place, which fixes the issue with that in the fork_handler().
>
> johannes
>
>
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
