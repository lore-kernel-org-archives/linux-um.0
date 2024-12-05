Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7313E7716C
	for <linux-um@archiver.kernel.org>; Thu,  5 Dec 2024 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9qk/6gaKcK8bXcAudnFz4qes7wu5yd8vlxKwAF83BsY=; b=OtHjwlybC4mjB3Xw60p+RfuQK1
	FEwlY+Qiaz3pkbLDtpb9L7JAUZnFmJ+gyO9iVJI+oh4gc/666gy4+AUZtHGdPpn0z4tuBLBg6Pqwp
	kyGIms0l2dDCHUDRqUiuQlJF91m+ZB1L1W+tjCwUm1pzk9LdYNBlV47WcaXN/sKvo8u4pCdJ8mx9x
	qAV4nj0ibjcSd2heHqZQNYwmuMH03nsxNbliFOOtT+Tq6uPiugxbkecFEQ9YQi7gkwu/GsqTT6my9
	JB8jARMFZIcQH6+5YNO4aeLRurnT5SZ6u3UogXHslOFDpgcT43U1f9t3PkAFMFPJ6yIpW29KGoZzB
	sig30CeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJC8O-0000000GCcq-0G1Z;
	Thu, 05 Dec 2024 13:43:12 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJC6P-0000000GC8g-0wVk
	for linux-um@lists.infradead.org;
	Thu, 05 Dec 2024 13:41:10 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-215b4681c94so7409235ad.0
        for <linux-um@lists.infradead.org>; Thu, 05 Dec 2024 05:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733406068; x=1734010868; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qk/6gaKcK8bXcAudnFz4qes7wu5yd8vlxKwAF83BsY=;
        b=g+PkFlUh+fOLkamp0SlOTGT1qLoWghInmu5329xUe3lqihTyijly0DJNYl5+piwtNb
         fyI7tUWYQTiyDqzHX37G89taRPav/7NRBHdjU+gr0MrD2egeI4NOBd5MimUWIbH/r0e4
         4iF8hqlUmYMT5kFCucLBQRD/buePHBExerWQC4E6XONmstVrKuUGSyJIw3iUDx8mpQy6
         o0nMzWa2ikFJkL6x4590+qSjvGjBNJkbe4CkDwlqmeVkeZZ7eSO9v8I58Iatisau364b
         QBeWrBaE07usKPJbSOZnjjKkg94H/g2ncYP3xg9ZYOyLZCiZouDs0BGMCvvkThDxUGTt
         3U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733406068; x=1734010868;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qk/6gaKcK8bXcAudnFz4qes7wu5yd8vlxKwAF83BsY=;
        b=rlihRXZ9MWr7AbEjHExMdR275YcSwg048CvdpOOcct5IYpgrocLc3wgex4vhgWsx7j
         LRE4FwGlmgQT+SZ2GBSuH7M7WQKj2+xLGMw7aonGy5dcqkdrFjw3ZCfiZQYN8F0KeVnq
         dc3m1Uc+Pkr96rj2Aod2aX+SGdbyLLEx2JCFAG/rQfcOg3CziXeXiccdDPu/WvQ/JYYE
         6rpkKcDDC8X1+Z3QzWZtEh4wuAI+P4Z6v+7H3fQPfHtLYyr3RA5420GxP+WsNoZCF/hu
         FcLbW0mNHEwU9vF3+hjbbJWgMm3uXsCPbTuffkhNfPTa4rTIlK89Vfl4sjZp6YuJkkKJ
         tACA==
X-Gm-Message-State: AOJu0YziSJOBuvLLTzqM2e02QlwT+hn9chWhM6VMPciumVcURdq/sr0A
	zMnn/DVxm3BGILIM/omaAyAGpO9xeuyDGu5TQ2/9pe6MmQbCWnhOBrZO4w==
X-Gm-Gg: ASbGncu5O/rDdQSO6ZUtjAZNVBOpibfBYfc3IO2vvVavGoxSSsFF9VeyBSNXTkXPIpR
	B1HBhQGFbzb0AeQDfcWEmIN3G5sVsyv9yvRpahYXWuLjTi1adfpCP9p+w9DJ9ZOSiVPMhl5M9VS
	ED4e+oOi1ucOYrJO5S4SG4wbPShlNz1GD21MEnnX2Fhwa4LMy/cnLX1eQ/kk7ThzuMS71v4HRTV
	QtXsKZUFDLpql00fTvURxlJEs8Hqi0tLmB2cWL8WSDSyHFXSCpm5oN3payF3jlK8meLnBK3frX5
	1NzwR2KWSWfis7ns+9qnhl4JGeevqEluQKH1
X-Google-Smtp-Source: AGHT+IGublRebBEBXE6NldC2XfR4uA1jtjhbP5XBaO/QMtbc/XqrBlhsQFLeTaW9TlNg+/e60o6TKw==
X-Received: by 2002:a17:902:ec91:b0:215:8ab4:d00b with SMTP id d9443c01a7336-215bd10ebf5mr134879985ad.30.1733406067699;
        Thu, 05 Dec 2024 05:41:07 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156c289csm1281100a12.25.2024.12.05.05.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:41:06 -0800 (PST)
Date: Thu, 05 Dec 2024 22:41:03 +0900
Message-ID: <m2a5daw8ls.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v3 00/13] nommu UML
In-Reply-To: <8c1fdd162110f043447974b8606bec9c614c578b.camel@sipsolutions.net>
References: <cover.1731290567.git.thehajime@gmail.com>
	<cover.1733199769.git.thehajime@gmail.com>
	<8c1fdd162110f043447974b8606bec9c614c578b.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_054109_261749_A14D7216 
X-CRM114-Status: GOOD (  11.04  )
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


Thanks Johannes,

On Thu, 05 Dec 2024 01:20:04 +0900,
Johannes Berg wrote:
> 
> On Tue, 2024-12-03 at 13:22 +0900, Hajime Tazaki wrote:
> > This is a series of patches of nommu arch addition to UML.
> 
> Please next time you resend this, don't hide it in the old thread :)

ah, my bad.

I thought adding in-reply-to is a must but the document says it should
not for multiple patches.

I will fix it.

-- Hajime


