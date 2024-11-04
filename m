Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E54ED132A6
	for <linux-um@archiver.kernel.org>; Mon,  4 Nov 2024 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Date:Subject:To:Message-ID:From:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=; b=QtRz3nC7UNNjjVZY1Gw0kCnzR4
	X6QAJsAt+mGBkf4W2d/HJ1EmvAqfCGCI/SiAdfJ4EMtV7kgzMeR+OE0rXxS1ej/2AIpFfyv3ISLmj
	T5U8mmePINe9FLxOmyX30tascYaHfjd3pDqXbiEJ4CI4ZUf/Ezr6P6n5TmW8o9mb/pAvUp/EOJ3Ft
	Snx+kukfM5mNWV0cXY7JFwO1Rfifojxa0y5V/0PdBjJPPY2I9sQAyZpnX9E4ahzOyrQtU1XL16Ibp
	N6mrpv+D1Vqp3H1zXGYyKAkUWHbIpGclhpco97WrfY6mWc0wjHbjcAdsV9G66EjNkorAmfIhBz5N/
	rkbSwLjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7u6o-0000000DHem-00U9;
	Mon, 04 Nov 2024 10:14:54 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7tyb-0000000DFw3-1zbx
	for linux-um@lists.infradead.org;
	Mon, 04 Nov 2024 10:06:26 +0000
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-20c9978a221so39954175ad.1
        for <linux-um@lists.infradead.org>; Mon, 04 Nov 2024 02:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730714784; x=1731319584; darn=lists.infradead.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
        b=ELerZkyMzV1t5/yc0H65xqndIEEguCws1JJ901m7Y7wTw3v0yNtU4F90R1q/nRLgjW
         hCksm0OkLNXXAly2rOv4HzIHyLdGTAJKIC8T7b/ilJ1JdcWS5PpsbJiXP9+jVQ/eMyns
         nHkCeGI20b1ujoo1kB0XM6ErnfzSwggYqbm/YzSBEVZ4B2M11wksdGScDAwlN5qVOkgQ
         YgNroy9SVGCB1FlA7h23v6m0DldVMDhMkUIsus6Ds9qAgo2R0uNVSKnDmCa60IRdJHFJ
         FS7rwTLA949BS/LJpLJAI09mWX9Z17zYHua8e+PmggTCX84gckbhYjwKNuNDQTrJmetF
         BDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714784; x=1731319584;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX28rAzmD4iiFzVyOHBt728GRE15tu8MjCYp4yUF6Zs=;
        b=XCqf7LQA55eWl6equQmyZ3Ds2V4T5dGSFTCQpVylwLEho3YCNXJd42aVKSCq3unrXW
         kYKUXwsj/MW8iC6c0U7k+5dQnzkuHyhDmLF8Lz7h9njDIvVFqQJe4Cr2N9Oe3sCnOox2
         CHN24iFZni50DUWPLJxYTFzK9MSFwQOaAc4CbupzuG3SazrHVHoIXxlBZbQbpSOWjQ8V
         WIr+9ALe5zLs56QvVfdslhZPyl5Nc/9IEMnX5x0dUa9RIY1UCkspNwgfpcem52K+7859
         VV1Wl9G870doRlkvu6CGZkrQ2VJU11OtS8vUJ3RJ/OXEDaxwdjK2eJGfR9auEzqhYpPi
         g1hA==
X-Gm-Message-State: AOJu0YxEw9w9SLQMvs962CaU4fOL4mc7bvy3Hbpi8oNZYh0BgAuXsH7Z
	e7beK4HarcxPT4JrTakWqTAoKsxIVT6d3ZFbRecD5LKUGWlfFDup1UXz29Uq
X-Google-Smtp-Source: AGHT+IGDj9ha33EoH5w2AlN63ga6u63lTE0qf/CDygBXl5tUfuCnalEaMVsRIR6jYlc5dlT/ftIeaw==
X-Received: by 2002:a17:902:e5d1:b0:20b:ab74:f567 with SMTP id d9443c01a7336-210c6b01b9amr403742435ad.27.1730714783826;
        Mon, 04 Nov 2024 02:06:23 -0800 (PST)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d458bsm57867335ad.266.2024.11.04.02.06.23
        for <linux-um@lists.infradead.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2024 02:06:23 -0800 (PST)
From: Debbie Magoffin <aa2554272@gmail.com>
X-Google-Original-From: Debbie Magoffin <dmagoffin@outlook.com>
Message-ID: <698077e820d18cbc70b898b6ad61b51530083d6c619f11cbce649b1d5913ac5d@mx.google.com>
To: linux-um@lists.infradead.org
Subject: Yamaha Piano !!
Date: Mon, 04 Nov 2024 05:06:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_020625_521185_9B788D64 
X-CRM114-Status: UNSURE (   2.37  )
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
Reply-To: dmagoffin@outlook.com
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hello,

I am offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please do not hesitate to contact me.

Warm regards,
Debbie

