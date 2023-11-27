Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28296C0755A
	for <linux-um@archiver.kernel.org>; Mon, 27 Nov 2023 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:To:From:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dTiFG6qdhQcVRSsTcOkt3+TsB38yc9mQoDsS/cU2mTk=; b=MDkOgYTbI9N7aX
	DywXUlz3WuGyLBl4HW/5gLe7eHC1tDf/A1+evkft5tuwFQItuBdJ865C8i0uv8X7hhbLIca95XRho
	R0D708KgQ9ngp5lfXmLa9ZtxxIUXAhY7fNmeQJngcsDqV06Vr/hlfVtwkUhrlpQ/Pujq6jtjItuC7
	A6lPSGvE3TxNtYPAMStN6naOeF5EsntR0t21Rn45iLMdPriLlCy1+vZ+uzr9pNXBFZOU/hnSDgAT1
	F7Cm49BYkhOmfQnE+FYkrYbDd9AGFlmiiL3nRG7BZjxtIT+3Vtp9H4o3vXRuti65t55r2pJaWLRoC
	GmseQRBAwLlNdWDc7ovg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7eqc-0033Mj-14;
	Mon, 27 Nov 2023 16:52:38 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7eqX-0033MJ-2u
	for linux-um@lists.infradead.org;
	Mon, 27 Nov 2023 16:52:35 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32faea0fa1fso2539935f8f.1
        for <linux-um@lists.infradead.org>; Mon, 27 Nov 2023 08:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701103952; x=1701708752; darn=lists.infradead.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tZa3+EBPmr3IlMEtKh+TLvpIfzmfFEGfUJ7ow8nZ+Jo=;
        b=d6lp4ONmjlQ+WYOxLpyAZAeQB4IIqjS6GnnZH5LrBaOpoxjEgwT8ChVk/8Kh/ALPeb
         TjlIjrK+cctOuSQjNNG1GhX4/9vyyfeG4QAffmq4B7QObb3jr7OC7pB8fVljbVwS4EYO
         PiW/Q54hatRt1Cw/dptgKiFrU3gES70HAPzsGz79aOaZfUprUeMfGhyz5F4fMoAYhLQ5
         3lhkeXPBEx+UaLti+owMIUoMhyVlbBwgopQdZZvVyI2r5ldg3wJhK87650rZwc+CCNzI
         IdOc0/PYlKvRohy7fCCd5ua/FcFr50O041PQbJf/dzyJzThpsH4YJ7xjC/uVH/707iWm
         N3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701103952; x=1701708752;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZa3+EBPmr3IlMEtKh+TLvpIfzmfFEGfUJ7ow8nZ+Jo=;
        b=PQ/o+xdtcQPU4q0Gw6XF1m2jRk0PO2nR51tg9koaLCLRIwtp8sLippouMWH0M5UdeV
         BzgxbuKb83Xsbungc1M/J7/UJyCDkiuVVvOn5sjdVNRiqtXdLs+b/0BpifvBU961dHKz
         2NMJsFFKARv63pkuoWMysrpUC+Q8jDF8RAUGoNFJ/RUw7QpV4o+zG1+VMEQ6SLQZ1vhe
         lAO/Ywj4bdJSsjGu7Uafcn0BTIE9JNB4oEO7CBXwIzm+fAJMNb+97o4ZrJVqnhdsL6MM
         f/g9cKzsXAWapymP9D/7HtY3Q0xhw5yVtnFeaFwMELjkr9zdXq9JnMcmqJ7YBpwEmYaK
         ONxQ==
X-Gm-Message-State: AOJu0YxVu6ffZlcRaOKwuRpF6X5ULG1Wn6dBLZ8WA60/Z9yVMRrAGFBY
	XJEWZJJgMLwJPpC9HIPoCPhC7k4bzTk=
X-Google-Smtp-Source: AGHT+IEx3eTZUsOOBaT+XpGUuUWwyb2JkCo+yz3RPHmYjDRQYE3bUC+AMevcaqHZUhHSsvQA27Tf6w==
X-Received: by 2002:a5d:4e8c:0:b0:332:e75c:a3ae with SMTP id e12-20020a5d4e8c000000b00332e75ca3aemr11245882wru.13.1701103951662;
        Mon, 27 Nov 2023 08:52:31 -0800 (PST)
Received: from DESKTOP-6F6Q0LF (static-host119-30-85-97.link.net.pk. [119.30.85.97])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b004094d4292aesm14409550wmo.18.2023.11.27.08.52.30
        for <linux-um@lists.infradead.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 27 Nov 2023 08:52:31 -0800 (PST)
Message-ID: <6564c94f.050a0220.376d3.ea65@mx.google.com>
Date: Mon, 27 Nov 2023 08:52:31 -0800 (PST)
X-Google-Original-Date: 27 Nov 2023 11:52:29 -0500
MIME-Version: 1.0
From: alvaroenoch632@gmail.com
To: linux-um@lists.infradead.org
Subject: Building Estimates
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_085233_960421_C3B2685B 
X-CRM114-Status: UNSURE (   2.24  )
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

We provide estimation & quantities takeoff services. We are providing 98-100 accuracy in our estimates and take-offs. Please tell us if you need any estimating services regarding your projects.

Send over the plans and mention the exact scope of work and shortly we will get back with a proposal on which our charges and turnaround time will be mentioned

You may ask for sample estimates and take-offs. Thanks.

Kind Regards
Alvaro Enoch			
Dreamland Estimation, LLC


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
