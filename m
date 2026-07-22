Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBB3C4452D
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 01:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PaF8RdFHIwXtsE+7ATGEyHLI5j3pxcpoGbP3WDIS7qY=; b=TO91TgQjgnc7oWOlaCgwkKiLPl
	91oRUTRq6li2Kd+zJCZONsrMgnFhlcz3ujDRCzJbhPXNHkfu6LTwuboDHIWQSwIL99rwhMwYOjcLH
	q9h2qooEBggCg/+5yGW0omyABr5QOP77rUVKf8UXZByT9EmFq6JnNiHPMRVgClYL0SMvmiZ+um4Em
	YjzjjwZNlS7Rc2I1bhFvszv4StCvbioJelisZzFMPkXFmRwmkjIRWDuXpL+KZUV9v5K5v48AzBq1X
	n4magzoVPsNiV9CbYUdSduxP6uph6wv/HOoOuEtnkj1jqSfNIH/WKsAgOLPopsk0Dc14Losp7Ufcb
	1CMeWalg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmLmy-0000000AiZX-1KG3;
	Wed, 22 Jul 2026 01:30:24 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmLmv-0000000AiZ4-0QKq
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 01:30:23 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2ccf2360620so80233075ad.3
        for <linux-um@lists.infradead.org>; Tue, 21 Jul 2026 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784683820; x=1785288620; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PaF8RdFHIwXtsE+7ATGEyHLI5j3pxcpoGbP3WDIS7qY=;
        b=D7/4D3NSfnQD9s6H17Eoiivmg+cOb48MaZphCImNpbyBaLRBqHidx6An15ULoqPmXr
         s7BYAfswoptjnfEIEC1tE1oYpXKUoVDLDyr+kdgIMSDGTo8+dTO1B2W90CjTqD/uJ2aC
         NBziqsz1DOvOmRQLIvbS5LSZd3kP785OX5kKd2Wj+NcJMao0Ejn7xg8Re3vSsdEC82T6
         nwz3ROYRU/f3zRcvgHKXMffRqAZmJbLvHxOFBsv4A/VR1YyQHO76OTVj/IGkFggfJjlD
         4lXj5TU9Dj39vA0MdPxb1BRxt5mvbGN+oa9QFIRoXRG/Lhmuk9enXcYhiDgNUTOzTqGd
         Qt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784683820; x=1785288620;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PaF8RdFHIwXtsE+7ATGEyHLI5j3pxcpoGbP3WDIS7qY=;
        b=mGYiMA3agUfJ4jud5q13puPIWiJu9YqxdgSmbdVzqwxZ0XHjHwnleMujM9zZU4rH9o
         mxSC4S2NqWM1BSJ9LgvhEsDUDnUPjz308mXiadOtwsOiuf3h4qCTWVhZs/L6Ie8bPhST
         PkJonZOvMRbzy1qXJdnQlKn+DYIdVdWDaT1WB5NyKFOyoZSWDKMHRCUrODRwHGDOr74H
         SG8/9SiSKQ2dju+yVpSHK16fjdf5hyyfjWbvh+89o6Kag9YMS5CSKHDA0TRqpMVUyFnD
         FshoqEh1HJ3YOztqNPtuJ0KKkw1nUuqohbZbiWXbsokB1vvepUvrOgBpdykho0Z04xIl
         F0Qw==
X-Gm-Message-State: AOJu0YwVDOSbnobtGLVJ6Vkfs27XrxD8l94yk0ktt6vy3X8/Dl3c5F5w
	lXSMOYp8HZ3VVj8euI6Fn7HsQ9cRGpBrkMakXrI2aICYNYNHo52SpbKp
X-Gm-Gg: AR+sD12exeTluEVrEr2vIE/zyLlV5mXFyfZExHURW/TGRpkvszR1iGLutAxx7+bWxsO
	piQfjaeE1nCR9X5daNc4SxYTKv/3vMwviafbu/J9NzIi3HYWzeE3AJrKv+zG+H8xHGtfvVxKz4I
	skAeDtgtiTOGhT33VvhSVSo7dfMLTTENMqhUfOQndoQPf1AUrZ66dCCxo3Px1F02L8NCj7inPD/
	YG5u0Wrl1D4FwFW7Ud2QkqhkDCeRUUy15wXxhgotS3F/zmP+XvIgXGD07tws1rgIEhFxyjQ5x6W
	HCv6ZFymBx3zhSAWeKQu1/R/wIRJHnU+r0lHBL9pecXA0EEoJyIL1d1mi1K3/aLvJyKQN+l1Xaw
	ej1xeDNwUT7pTx1MmCqmGyxzCjuUWpkAK0mNIbiVLCHMkvOq4rT2XZSx/uTzHz11uiWNrv/Qvb3
	UZB6eZyh69I6wEYGJAXqOXasGxOKQriH6pMKt/m9yWHbYXxjLRkKGfIQLzvzKVmC8Sn6uPkqZcq
	+CMdjq8zrAMPoiaaRtm8Dw=
X-Received: by 2002:a17:903:178e:b0:2c9:e9c7:2b59 with SMTP id d9443c01a7336-2cf349cc765mr227950865ad.35.1784683820173;
        Tue, 21 Jul 2026 18:30:20 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa39e9sm5446885ad.10.2026.07.21.18.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 18:30:19 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:30:16 +0900
Message-ID: <m27bmn4xqv.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	johannes.berg@intel.com
Subject: Re: [RFC PATCH 8/9] um: nommu: add userspace runner processes
In-Reply-To: <20260720205103.5a666eac428b.I9f810f3ed177d6dc980cad36c231f8c745dee48f@changeid>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
	<20260720205103.5a666eac428b.I9f810f3ed177d6dc980cad36c231f8c745dee48f@changeid>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_183022_103334_68EF31C8 
X-CRM114-Status: GOOD (  17.10  )
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


On Tue, 21 Jul 2026 03:26:58 +0900,
Johannes Berg wrote:
> 
> From: Johannes Berg <johannes.berg@intel.com>
> 
> For NOMMU there are not separate address spaces for
> each userspace process group, which on the one hand
> means we cannot start them on demand, but on the
> other means we can just have one for each (virtual)
> CPU, and map all of the memory into them.
> 
> Implement such processes, and the remaining bits
> needed to compile the kernel without CONFIG_MMU.

I was wondering where kernel address is located in this mode.

although it doesn't have to be, under nommu, kernel address is located
in the same address space with all userspace processes in my
understanding.

the kernel address is accessible (danger but it's !MMU) from userspace
thus __access_ok() always returns 1.  so just wondering what is the
case with this runner process approach.

a program accessing kernel address may fail (or crash in some case),
but with the runner it won't ?

-- Hajime

