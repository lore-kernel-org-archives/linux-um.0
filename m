Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACBBCDE011
	for <linux-um@archiver.kernel.org>; Fri, 14 Nov 2025 06:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yMJTVN/vlpAVXeQX+4HrHc6YyUF9oMQu5Z5m14rtHdA=; b=xDDSGhC3NeSjefsvYAF1zEF5PV
	MVK3hdUGporTtxK4MWtk752pJIL0zYHRx9g+xLlXBCm965gN9reeJXOGlLD/sO/zhu3LS9bqjYcc6
	VDwFmKxGa9biGTOt6CVBlWJyVnaCn1GRLge8zOuQyPjMraRqbQWjZSE5FHE5za24mAcZSoy7LmEgD
	coA0ChTn/bXKqjvkYdnwX/h2JGyaawzsJ5CUiUnH5p7PUWpLKs89B2MKPX9r2d3MFJH0X2QgO56L+
	9BjxSMF4RL1y1FrToYDCVLXpDCQ2T9bTFW7T9KWCA2F4iTP7aL1hi+g5gcZ8KmwXfNRHKxRMjVlrd
	LQXQ00YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJnaw-0000000Bgfy-0d0b;
	Fri, 14 Nov 2025 06:47:42 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJnat-0000000BgfG-3tfO
	for linux-um@lists.infradead.org;
	Fri, 14 Nov 2025 06:47:40 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-34182b1c64bso1113616a91.3
        for <linux-um@lists.infradead.org>; Thu, 13 Nov 2025 22:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763102859; x=1763707659; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMJTVN/vlpAVXeQX+4HrHc6YyUF9oMQu5Z5m14rtHdA=;
        b=cJXPcR2DEf6rVa2ke5Z4szJaIcxkltZKorIC+hIDqHw79u9O2BPnZ5jw6W5pHTN6Ru
         bnzUaW9qNLyANhUR1lkPv6fJggK7a4Aw7o96Qn7xPq86M+nh9IiJa7zTgUCH4tVungo3
         XTa7gVK0CHd1ynRUOY/cmfAjzIloJmQTGAlwh2uefcU3ATR/7kORmNZks+5vS0e2v5wi
         ktmm6U/mZY2uynU11MN6qSrpi/RTUSXOr8S4UUgLp+Q7n2Hr+BYjCSU6q0v+k/2LZrGl
         yAO7UJEhDzZX7PAnaL0/DCR2ZMRWONqH/775vaWvTccr0tAIuiRZ3dzgR8sDwN5tMd0U
         8/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763102859; x=1763707659;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMJTVN/vlpAVXeQX+4HrHc6YyUF9oMQu5Z5m14rtHdA=;
        b=VeBjy0j8anjbqI1MCIgkRX+sBfF/LzgL32ObomXP6zts2/d+ZuJ+DqyIbbh+oBs0Yt
         kVz3/Bn8LTQyJn4IO04brbyhALe52SAqhnqhj8Gnb25KbCglpGIIixoT6u3h9VUL/f1w
         nf25l54AgOOdyw2WMMVonBoxiNW7qcF8Lygl7YNieKIJDlKOsiHDNyqcRx6H7v+355i2
         PBjphx1grjYpYkcTHWK/6dJnJ3+W7r4wSk9b98iI6kNAo4U8mb2r9ENg8TVJ1PaWMibg
         MlnFc8XAB2bUyvLeJ7ieYifvF5Wxs3t3S+H3oNn5vuz55j7mk1SHOIB7tXQ4RaVFwf/i
         grzg==
X-Forwarded-Encrypted: i=1; AJvYcCWjexx6d/GLlYl0qIilj7s07uO9gU5TljCz1LJi66fo++54NEikvJcwpXJXjYhwfRsGSEJpWx6Q9A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyHy6YV3ZPQGMHimHGcc1/pzl37HpagtjJamOMJhAr9jbK7TEQI
	zDalHhhLMVfq+HU/1QRord+ZHUZj/UpsXDAdJXJVxO4SyCyPB0Vkei8E
X-Gm-Gg: ASbGnct4rw/83dbAOuWxhH+Qm2d9UHC8yg0bVLNopWSPDXf2S8+nnDYHLqOJjJkAyG3
	m/vk/Mxnil9UjUr/aBU+48/6OLXP9pzxQHHPGCyNAkURwcZDnTGJYTSnv979c98UhTgVQ4LIgfS
	yfHWdFNcJyAwfZe0JiRL+ZyUrVJp0dk7TEz3lOhryC1jVa9dFs29G1fW2NtC5mcuNG1u2UWnxOf
	hDKbRDBqzS3E/BoTld2qmXs5I01qDIiuLn70ExOKnhpz9+fPXmTOX6GTnVTYd+ZVnb7WIunwSEl
	ikPFrow/HDKadX6Vg8p5LqW8s/3FtgedYo0aA1uTgBk01RlLbhq3fak7Gv52kXjvzPoHYVo/9Jv
	1hjaMP0ZOI5mpEBn2C5Wb5O4gdmkVTZNeDBYbFTffPMFl6CPt36dgPiZfRffHCsgyO0m2yWu3Fm
	1U92ho2xgEnJTr+5EUG6bv0LZeUzTSs/gk+cIpIbmyLm91s60B89mm5iPh7IYobvGNDfO5JWY2C
	DTULvaJ2iFEn9X6WxVzUA==
X-Google-Smtp-Source: AGHT+IGHpz1tKvWFNZesGxw6JVkl+FA0ukZVvkWMJG28B6VXmNdnR8Ek3Iv90x1oeyryt8GFUkrcjQ==
X-Received: by 2002:a17:90b:4e8b:b0:33e:2d0f:4793 with SMTP id 98e67ed59e1d1-343f9eb1cb4mr2546923a91.11.1763102858789;
        Thu, 13 Nov 2025 22:47:38 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343eacbd09fsm2425861a91.4.2025.11.13.22.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 22:47:37 -0800 (PST)
Date: Fri, 14 Nov 2025 15:47:34 +0900
Message-ID: <m2a50pxg8p.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: tiwei.bie@linux.dev
Cc: Liam.Howlett@oracle.com,
	hch@infradead.org,
	johannes@sipsolutions.net,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	ricarkol@google.com
Subject: Re: [PATCH v13 00/13] nommu UML
In-Reply-To: <20251112163651.3689244-1-tiwei.bie@linux.dev>
References: <m2bjl7y6mv.wl-thehajime@gmail.com>
	<20251112163651.3689244-1-tiwei.bie@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_224739_965125_385FF0D4 
X-CRM114-Status: UNSURE (   9.11  )
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


On Thu, 13 Nov 2025 01:36:51 +0900,
Tiwei Bie wrote:

> > we haven't seen any functional regressions
> > since this RFC version (which was 6.12 kernel).
> 
> I took a quick look at the code. It appears that patch 02/13 will
> break the mmu build when UML_TIME_TRAVEL_SUPPORT is enabled.

thanks, it is my bad on the move the chunk.
will fix it and added to my local test.

-- Hajime

