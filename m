Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8F7C369AB
	for <linux-um@archiver.kernel.org>; Sun, 27 Apr 2025 03:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q0liNNgO8yCmpr/Ek9NDR8pMTH9T2ZF8jZq+MihsfUw=; b=AZoLXw1m4tik6lduhpTtRAnVzw
	Zj5RRXEStjU9AsgBKTR0wENL+33x2854FtrjVUTU6uZP8XyHd/qUD84x4w9sv8ueCtmgwP+RYjY6W
	oZkrDt/ROJgaW0dWtOiY5RFzkHtimanOFYTo272YQCeq01sAkNjMGOHvGUm1lugZsINu8LD+GI+Ya
	/s+UyhB6o7L+12sXh3nuADQy5W30ozA9XakS0GqD4/gg8m4Xsixm03KR0UzwVB+4u8OJBCmhC3GjJ
	iPwI7DAaRlre6DxXrtHXS9ttLugyzjoXQalp96CmBy29dmz/WsVmaQF9Vlrf/0mVdb0yscDYD1FeD
	5wjpOUQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8t1W-00000002qmI-21fJ;
	Sun, 27 Apr 2025 03:49:46 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8t1U-00000002qlv-1bET
	for linux-um@lists.infradead.org;
	Sun, 27 Apr 2025 03:49:45 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-736a7e126c7so3419610b3a.3
        for <linux-um@lists.infradead.org>; Sat, 26 Apr 2025 20:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745725783; x=1746330583; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0liNNgO8yCmpr/Ek9NDR8pMTH9T2ZF8jZq+MihsfUw=;
        b=SfdYFzVycuic6m+P7uS148YlIr+KE5vvZKJSi66syI2VcGKXOLNRB1xTGMUBayrCUz
         YLxMALo9JTlAcaWrn24X6Um1PYwZsPp3IJ7vb8wdWX2YD1l9BA3f19P2P+5UiydB6fDD
         MQQ1N84UmGTANZiyKM1A/6MIUw6rn4OOvzrVBA8STKh6s5Am+x/rbVzko60RXjm9vReN
         9pBtiTaOZprz1x7RKc9SsLOuifH5ERo7HrQqMVN4vncwGiryJPanwullQSmE21ImzO0U
         GaWqB3UoHEDAyiqVy0V9JQS3+kTYX6m1qIIxmS7KXS07aNvgE9plOtADjv8kcU3YF/9N
         w2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745725783; x=1746330583;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0liNNgO8yCmpr/Ek9NDR8pMTH9T2ZF8jZq+MihsfUw=;
        b=QLILcnFUEJp/BTlo9AhQT41SeEEFXqHD+6G/rIBrVVUU8LdRdxknXevBYZg6PFUEVt
         ZrNJrRXtJQCHAsf8aEJEqMYYkkOMouBjCrdu4uACCkCXYjKtWu/iyfdujzIUdPSvk36v
         6sANQyO7aw2Af7Q05e1QEU4/r3XipcoHl+SxADsK3zFU1qAQDex7enaN6wvkqf72NlvR
         UXAvy7gFPX2kFw41we/MwpfwN8B8WO2eTy17WMCw7oZH4KFK20OD6j4NRJKEMlQ++dzg
         FQCJzs7N2HydtkkuuaTL6BmMjJhXLm4zZO99uFvh9rWHrXgVePFalfpsfIi3cRwvzUwA
         iXjQ==
X-Gm-Message-State: AOJu0Yz+xngItsEyeTwZniYYb4Ur4ck96HtVY6Sh1MTB/TB5oDjL9avj
	sdaFE4o5uxT4BUsPe3PvrtBGLi0n8y7IagEFSwsVk2wyH48WuRUQ
X-Gm-Gg: ASbGnctwmcZJ0lgorxBYXyV8UPw5ms8sVsbjYaEmshLW7VXGwJaiq5bZJcspRLdZDXu
	IUpCH7lAuaHjxPf85iWuKTWUQVYVaNBhyUWIJQDKdX4pnjK50uPM/DOF8cPn7KcaXDKG5BCJKEM
	met4gF/MhDjjORbNj4xHs5ff/OKdQl2XhUQq8eImdCAkCwGSMXgrcIcLscivRwsZaS8HeEoNRbz
	htUeSJCUbvzBr6EUzmijQLeMGrUM+9c4aW4NtXfsmfYh0jpicrTMoEkBX0BRwF1fQe97tEZ7Bi/
	3brEkQG+IduPJGXGvtgVLhgQgd8CygWkWLW0lw5P+R7knUMKHI8yOJ5sofcvKElktEPIpGqnAHq
	cdQMm6e2ibmykSGvHhGFirv6c
X-Google-Smtp-Source: AGHT+IGg2OBNxa/r9pyJD2HKQU+dGIALRor5XTPgsOgb5qPcwU2NBzrrOPOxZIuDg63sNGyeTdZ0MQ==
X-Received: by 2002:a05:6a00:21c4:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-73ff736a239mr5801031b3a.15.1745725783149;
        Sat, 26 Apr 2025 20:49:43 -0700 (PDT)
Received: from mars.local.gmail.com (sp1-75-76-170.smd03.spmode.ne.jp. [1.75.76.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aa16cbsm5544777b3a.155.2025.04.26.20.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 20:49:42 -0700 (PDT)
Date: Sun, 27 Apr 2025 12:49:36 +0900
Message-ID: <m21pte6z73.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: lorenzo.stoakes@oracle.com
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/13] nommu UML
In-Reply-To: <f4242067-0113-432e-b8d1-d26ff5e4a355@lucifer.local>
References: <cover.1737348399.git.thehajime@gmail.com>
	<f4242067-0113-432e-b8d1-d26ff5e4a355@lucifer.local>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250426_204944_419354_566633ED 
X-CRM114-Status: GOOD (  15.69  )
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


Hello Lorenzo,

On Fri, 25 Apr 2025 22:49:31 +0900,
Lorenzo Stoakes wrote:

> It seemed this series died, which is a pity, i'd be very useful to have
> this functionality to aid in easily testing nommu in mm code.
> 
> I know that I pushed back a little (or rather - wondering about the status
> of nommu in general) back in v2, however with it confirmed that nommu is
> required, this series becomes really quite important.
> 
> This would need rebasing of course for a v8, but I wonder if there is any
> appetite for it or why this didn't go anywhere?
> 
> In any case, if you are still interested in this Hajime (thanks so much for
> all your hard work on it!), just saying there are definitely users out
> there.

I've been waiting for opinions from the um maintainers to the v7
patchset, and am ready to send v8 series with rebasing the current
uml/next branch.

I believe the v7 series is still in the patchwork queue so, I hope
it'll be reviewed soon.

# thanks for the information that this feature is useful to test mm
  code.

-- Hajime

