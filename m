Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B02EB64D8
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 19:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=s1wwRFyGXF67bGSVY8Nkd4T7pSDsmDkj0o2pdIQ7ZHg=; b=RTmpj0hqpDt1X0
	ut9AjUu9RPMdWjUOS0UxtvvsiOtmlHJ93C17ZosAr4RlfCZgi36+4GqCRoIPjI6NT07KrNIAgstxr
	j7e8iTLMhuw+wjNjheCWYSWZA2SWFo3NK/MpBGk82nIqy8O0AdNqFgj6Whgq13mYdhIfweTp50GzK
	6RUcB49tkw+r/3OAmzacOAaUeXduJAuvPw8gPsKYR4uTOZzQs4yyXd7CBsPC2ObJVoGBxhZxVBIjh
	sGx3sK6ekxrcSWfF+VR7SSKh3R5OzfB8k9LJov70mGK7+luvLGpeEArr2ryMqVR9nMS8iS6cpVbpx
	3fNeJGqlx1WrVFvh7flw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCPtO-001Y8b-0K;
	Thu, 22 Jun 2023 19:22:54 +0000
Received: from mail-il1-f176.google.com ([209.85.166.176])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCPtL-001Y8B-1V
	for linux-um@lists.infradead.org;
	Thu, 22 Jun 2023 19:22:52 +0000
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3421e3b7dfcso29678635ab.2
        for <linux-um@lists.infradead.org>; Thu, 22 Jun 2023 12:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687461769; x=1690053769;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/y3W6LcJBx2VWUUYMcpQy46Ji5lWxmxcmLugNQrFHs=;
        b=hMzY1ZGDm/4R8lqo8QBjc8atmxq0shcD3jRLwnJK3H5xuEeLgL9FcPosl8GPA4ZWZX
         hfFsIi7HZIuscnggtrmUj6k4X/Zb27jHTcbc6kmgFkodGpZAXjWJX+xjaGVUgnO7aaVX
         kZD//0uOwjhid4VwUdFPCJw35iUxx6r6mc5wHYQ1L6QU4x3U7M5yKbdK+fpyVpJ0G4xE
         gB9oi19j83b+gTZQngjmYaox4HNcgVbxAVHHacAx/47fPyPHLjwLKMfM73V6gXkhqfvN
         l+Y+66xP7SMlwElc54i15dOmGxjeIqt7TBJ7+UNhdQWA0rooT9+jXHcUHy8q7Kod8EbS
         XLXA==
X-Gm-Message-State: AC+VfDwWVoh1puhcUJFZNpO3T9ZqNcshcSd9tZfx8a3Imu4LXMvgKnGJ
	7346hatpQDbiZy8OuQkTC653nZ0tiA==
X-Google-Smtp-Source: ACHHUZ43z2GbMQG0Xqzr9yzfNP6vVrYf4IBGEkLT2MwYgK3GwkVAL8o7ErD6Jcr+FbDmyFFqN1DZ+g==
X-Received: by 2002:a92:c04f:0:b0:340:b4b2:5fc7 with SMTP id o15-20020a92c04f000000b00340b4b25fc7mr19968450ilf.10.1687461769428;
        Thu, 22 Jun 2023 12:22:49 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d13-20020a92d78d000000b0033b27117120sm2232660iln.13.2023.06.22.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:22:48 -0700 (PDT)
Received: (nullmailer pid 2289048 invoked by uid 1000);
	Thu, 22 Jun 2023 19:22:47 -0000
Date: Thu, 22 Jun 2023 13:22:47 -0600
From: Rob Herring <robh@kernel.org>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Subject: UML for arm64
Message-ID: <20230622192247.GA2278576-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_122251_508512_684C37AE 
X-CRM114-Status: UNSURE (   5.23  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi all,

I'm interested in getting UML working on Arm. Is anyone aware of any 
efforts to do this already? I've not found anything searching around. Or 
perhaps a port to any other arch as I'd imagine any 2nd arch will 
require some refactoring.

Thanks,
Rob

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
