Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E67CAC5AC
	for <linux-um@archiver.kernel.org>; Tue, 23 Sep 2025 23:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=krly78jms1sruv9/XadTy5gAIb5jk63ojUfswJkwWzY=; b=3j/dRLs5vZGDwAB2mk5rBXzQNi
	DiQ1Z4gbOvEj4JSE4sD3DHs6a+1nXTLJYmlvldwtI+OYEbKQ3ZCNOu6zSfiFna1lgCjEBoEKUDOhh
	XPt0zlEJLJA4ThSUB8qJUxdmOlOdLVQr5d8y4Qllm3R7UJhyjBICPd3pHRueyXsF81a3rIO2BW+yB
	v+bDrfe13kp0/zyr5Fk4bLAWTn/VcbQgOwRGyEKtJLRJi1FTXOQnPzAsKOKAIYYFvLX5amnlmgiQH
	IAwzdhi6GAakIPNPGHZKeHrIKAJFoxYg5BCB7PzOh1wa9ljBIzl220qcUyMxSg8mO/1AeGT3TKf1O
	zPxxqU3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Cnd-0000000FAxt-3EcM;
	Tue, 23 Sep 2025 23:51:57 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Cnb-0000000FAxY-3EJX
	for linux-um@lists.infradead.org;
	Tue, 23 Sep 2025 23:51:56 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-77dedf198d4so6872123b3a.0
        for <linux-um@lists.infradead.org>; Tue, 23 Sep 2025 16:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758671515; x=1759276315; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krly78jms1sruv9/XadTy5gAIb5jk63ojUfswJkwWzY=;
        b=Obs60BRnNUOQZtJhAVMd28ExRg826hfgWrwp6u2dIlQpFjVH/b+BMo+pZn4rWD6xU/
         Hy/ZbMoYLhHfgrLiKbHWEqyzEmw+z/LpiMY18TJdP5dw5+km2EOud1YNCErfzQR/0wG+
         CvjHQbrGZftkHNj3PbLmwdumTrshjrffMDZ6RGlO5Zm1WBuFL43CVFQNQBKv/KhxsC3T
         lZM+RwIe1LGCfe08Yzm+95MGqNk/259NYO9yntNPYEVBjxl2rxGLOvPe2o43NOORpoh3
         79u/4heUjb5Cbi745pdQjwcGcnNOwg+dRQPTgFDsOH4xFku7U8XTh7DRJ8YiLt2Mlsdi
         c7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758671515; x=1759276315;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krly78jms1sruv9/XadTy5gAIb5jk63ojUfswJkwWzY=;
        b=wYg61LUUZT5P4cINg5wCP6IPiNqaburEKV7h5V2kVwbuB6quEaASmWw0RYylavVzgZ
         c2aYmTmvjBSqC5MFXJgi4iGND9V3E3g1V+9Ddse0XBlx1G+ecGXy0eA+go2ryaWnPteL
         Eixo2yuLTZI2nsIGAGWsp/fE7vMQJ24V8xC7zOKiCV886nK284LR9R8j7tybVatI0Krz
         FlN8GdGEuLU+AUWNJMWGlp2+ZYNWFUkPE7SqKMo7jPLRj4hkN2kLzEgCmiI/TdRz3x6m
         MdHqQbICkpZBQzNKG8+WQVAgh6n47P/NN+5kt4PkzGpAyeE1wKSL/Pd4SSTSneq837MZ
         oRMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiWqOK0aWMtquzCe3Hzj98WHp05L4OX6JZZG7cm4/ngZlT0J5ZGMviOiYOQN+o5c+VEQOFTtatNw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4eqUcS3BoCVhmNWb0DrsKi/u64CXUhBXqT/zcdic1lCithXmI
	buOxMc3yfpCjNwqqKql787H9alXuklXTAUn9Huouhvc4QLB0iWm3IcRr
X-Gm-Gg: ASbGncvaOqcT1jT0cwupnvwzrwVZnMc9Gs4NN00DhkidTV58d5uT6eEcMFlzFbKHLMW
	g7shWoPKJU7FyPP59KebGzWMKPtXRW1/LVjZ1o8z3c+VtI7WpLLWKxH1lOGObsnoOnhTDOjkiHZ
	MbGBVTw+fL7x+JN2wiNhuBpS1fB+awobxzFwDBa/x9m9bduLm4XxYqik8gXykuq573E+nvEXG6z
	dD3u5NqJqQMcvYsUP+db7L5pnMjAdoy32drS69MP4YYtKiWEfqTq5dPaaWol7mK6MRCkkG+srEO
	GV76orBJ/1bm45K2wHLUxkANY6ExF0FLxVMBKx5HFHgTJMLIVbJNdNrcF/wyyjbSsjDgUFm0+XB
	8znBL7F3U6JbEmUHZLpiwwviw9nWvnRp5tQhW9SeWsy3gxZVjgIPgrsK8pbZ6slO6217YpXiScq
	ihE77h3yAr
X-Google-Smtp-Source: AGHT+IGJd40fbeCL7mt0AGb3l0yu5exWtbqkd4Ul5ggag0wEHkuE1unELJ6+RGpDizF17gDR3Dq0qQ==
X-Received: by 2002:a05:6a20:7345:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-2cfef316ed3mr6555170637.46.1758671514828;
        Tue, 23 Sep 2025 16:51:54 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe7607c8sm16949307b3a.58.2025.09.23.16.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 16:51:54 -0700 (PDT)
Date: Wed, 24 Sep 2025 08:51:50 +0900
Message-ID: <m2zfak7mnd.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: geert@linux-m68k.org,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <23adb61e95275251e459513a03ab7d2bcf1f2e07.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	<m28qib8g1r.wl-thehajime@gmail.com>
	<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	<m27bxu949d.wl-thehajime@gmail.com>
	<CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
	<23adb61e95275251e459513a03ab7d2bcf1f2e07.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_165155_812928_9306112D 
X-CRM114-Status: GOOD (  17.38  )
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


Hello Geert, Johannes,

On Wed, 24 Sep 2025 02:13:47 +0900,
Johannes Berg wrote:
> 
> On Tue, 2025-09-23 at 17:42 +0200, Geert Uytterhoeven wrote:
> > > 
> > > currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
> > > so we cannot select it when CONFIG_MMU=n.
> > 
> > That is a fairly recent change, see commit 8fe743b5eba0abfb ("PCI:
> > Add CONFIG_MMU dependency") in v6.16-rc1.  As this is not a "hard"
> > dependency, perhaps it should be reverted, iff you are willing to take
> > care of the casual breakage?
> 
> Why though? UML with PCI can't really be a functional thing, only a
> testing thing, and testing PCI on !MMU when that is actually impossible
> in non-simulation is pointless?

currently nommu UML doesn't come with using PCI except building under
kunit (ARCH=um), but I have in my mind to use it under !MMU
environment, so would be an option in the future.

and this series doesn't include PCI w/ !MMU.

so, I would propose the modification to revert the MMU dependency when
time has come.

btw, what do you mean by "hard" dependency in this context, Geert ? 

-- Hajime

