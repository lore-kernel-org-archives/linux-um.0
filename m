Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D36C63797
	for <linux-um@archiver.kernel.org>; Tue, 17 Jan 2023 13:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:To:From:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7mUojJvf8prE2a31ixbT/zLT7Ais7ACnJ75ZDrKdzw4=; b=A/DVFrbnNF+iSG
	AAKKTpW6FytR7880hAILswqWTc3sI5n6m8IlAJ7B3sRM5GAxRVtUD7MkjXp4dHqlkusuYmbAvQXsn
	01WAjx1XX+/TgixLgRe1Kjft00CXva959i4v2ovDEiVZsjwy4t7mi0B9Xa3AvlkGtz/phwML5w6Ns
	3JmFVZ20O/bAatftX5eZ1wrlnT2QdrTrASgEOQq0q3d9+QE61H+YhWyShZ/8aFY2kbwMz9YXAiOX5
	uQc4o/4NXsygT6lnAQDoboSD/wEA68fKpNWODCjXFGl8U3h49N9CC0RcQpJm6+E8wOnogBYUhHXQi
	WPwm4LEtB3thn0/peCSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHmRe-00EUuM-M7; Tue, 17 Jan 2023 13:56:10 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHmQt-00EUbn-UR
	for linux-um@lists.infradead.org; Tue, 17 Jan 2023 13:55:25 +0000
Received: by mail-wm1-x330.google.com with SMTP id h12-20020a05600c314c00b003da50afcb33so5916787wmo.4
        for <linux-um@lists.infradead.org>; Tue, 17 Jan 2023 05:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/25DhdAmRN9effrRikf/37uSs969leXr6Z842JBsFSE=;
        b=ko/JiuYnEjP/ThIadvIq0m3ftHwY1wxg1NC1oSq8ApptD/DE5ZH/I6tbyTdSCjfE0l
         lkOx8M+8MUx+vEr4cvwEU2cerXzBa6/7k+L/PyclrkftQ6aiCTLaNsx8DXhGlKUmj/su
         PAhXjrJvJo6ow1w8jUXtaKJaHco/Ub/cEjgS2ZavhFt4dCLlPVKZZFKeaCDHLyW4OAzt
         fbvR7m+a1W26w4nExdrXCPNiyxj90/vSRQ9zHb9XoJlUt9UxQ1zai8UeJUTbkDAGATWC
         DCV0mdpYhBS/2+dtWimkLwFnneKBWGatSBe7cnYYPaUEgV5WYc2ooLifu78h1IrF4Gwe
         YKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/25DhdAmRN9effrRikf/37uSs969leXr6Z842JBsFSE=;
        b=IQtYeZloG+FxRbgD8S2MF/cx44pdII6ab62fcqqjoeOOn28vNM+TnQih83nBdLdABV
         wIES8pfi2T2vQGc9f2w4jEfvviiJRKuN43payJtJOQ2uL/RmiKiaHYjfAjgi21mHn1Fb
         EzAJfZAgUiq5geBnbE+7QpDidIS2OosgxtETUX1fNleDCYbQoxKcJ7TI/huzxUpNJCaP
         HAJJeB3NIcNAYhOINBdwB8/X6gT9T4yXVEoF+hrYslXnLBpRuPyWZiZoryxWId6ts/bP
         kL0AjiXAxT7g8PWoaFrsLQKfbf8Lr3J47JZhAAWvH3NDWOey4fSUg78H4Aae8wrPddnu
         JDqQ==
X-Gm-Message-State: AFqh2krvmDBjCBvNb2ut0qAm1Yhk1sJ8IRKxJk456ojoT3ZCCYBMQCgw
	FyU6MUi1ij7qLdumXTj8j6txnO7tMk4=
X-Google-Smtp-Source: AMrXdXvTYvu/bRhZ2fqEQTPaN9RietuIAKcS7dGVoj2wK01nGrbnuWltuFfIZr1sDdmVCsVuGDvhaA==
X-Received: by 2002:a05:600c:5006:b0:3da:f92a:5446 with SMTP id n6-20020a05600c500600b003daf92a5446mr3324184wmr.27.1673963721721;
        Tue, 17 Jan 2023 05:55:21 -0800 (PST)
Received: from DESKTOP-53HLT22 ([39.42.178.198])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm28888639wrb.107.2023.01.17.05.55.20
        for <linux-um@lists.infradead.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 17 Jan 2023 05:55:21 -0800 (PST)
Message-ID: <63c6a8c9.5d0a0220.3f69e.f27c@mx.google.com>
Date: Tue, 17 Jan 2023 05:55:21 -0800 (PST)
X-Google-Original-Date: 17 Jan 2023 08:56:56 -0500
MIME-Version: 1.0
From: glennharland437@gmail.com
To: linux-um@lists.infradead.org
Subject: TakeOff
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_055524_020962_0F06EB88 
X-CRM114-Status: UNSURE (   4.49  )
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


Hi,

Do you have any estimating projects for us

If you are holding a project, please send over the plans in PDF format for getting a firm quote on your project.

Let me know if you have any questions or if you would like to see some samples.

We will be happy to answer any questions you have. Thank you

Regards,
Glenn Harland
Crossland Estimation, INC


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
