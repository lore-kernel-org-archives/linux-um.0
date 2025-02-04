Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBFBC02194
	for <linux-um@archiver.kernel.org>; Tue,  4 Feb 2025 12:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ncXCJ+zHPbN3f5rrcfMt1o7e2x8dlJZHs3XvC9/KaU=; b=gubNgjIsRtzSHf71t0InSXJEPn
	gjohCHWtOifL2jTh4MCyXdwgAAnkQcYj9S4dVJxGO1SwqPHtLvsKyRQDprp+5htq/vUXrCPqfWrdu
	e3qDaRlGUV/Fa9y2CjXCWEkpaYAgHYTw12zUvl76NwlrWlYaFqa1dloZoIg2Y9CG811YUH1PklwhX
	ZdrHGmoAbnFhM+OoJNkDhjU0dYVTnHDJJohxntt8zUd01oBg6dH0pquznHbib2DDcKlKWDCm6xNFZ
	FEaE1YKYgr9Yn0y9H+pija2cE21DA5U7GfZWf7wg11GO8dKO5DUTlq+73JmDg8ssTDMLm54O80KoH
	FxyIon9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfIBK-00000000RNC-40n4;
	Tue, 04 Feb 2025 12:37:34 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfI0i-00000000Q1P-310n
	for linux-um@lists.infradead.org;
	Tue, 04 Feb 2025 12:26:37 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso1429561a91.0
        for <linux-um@lists.infradead.org>; Tue, 04 Feb 2025 04:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738671995; x=1739276795; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ncXCJ+zHPbN3f5rrcfMt1o7e2x8dlJZHs3XvC9/KaU=;
        b=YsUTKt7G4e4qW6jRsiyw+f5HdHogRR9XjtLe+xCmhPnd+zisiRloE8LNeyyG15odgZ
         e3Crw1f2QL4yWQgUSKICtiCb60yTqTmm8Bv3c0SqyUX9I+btg4Tmx1bvAZGWOFTJr4Mh
         YYYMQlNGZAdsllkNyYAWRQBe6fmUrC5Y34SLGRFAFoQX8bsqOmO/7ehz1KCU/bVFl/YW
         6sHAH+DIGKBt8sTbMDat2sD2UJ2L3mzCN3Tvx2SbL9DJVw6GqC85p9UMYEsCzKEDDCWz
         reeG1jK2Jr8gcujs66Pl4wsPmNwbeStBB/DRWuP3O/zAZ2S5OHCmKBI1o5AuPavio0Ka
         fOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738671995; x=1739276795;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ncXCJ+zHPbN3f5rrcfMt1o7e2x8dlJZHs3XvC9/KaU=;
        b=HbgDzX65+G2uqFwZl9dP9IZtnKoDdcYHJyJTnyy4/yV5/ARnqI+7S0P/zWkiXqy6cs
         MuKZXqdBXsdO+vGlMDBkIP41/Y4ZCnUU3doztEwZIktBgb1TqHbn339JqQce1iiMfSez
         k33mliD60xGDWzuhKAar5cmTYJluFAdzMlyTq8uBR+SA3LVr/JVVhK/KM75BwHObTFWh
         foyllS5NAsttpNQfNn+RGD0GhkHi8cX9k15672Vw8O+V8WycX39JGbmojQVYVevYl0MW
         RfGM8DsKr7jeEDd4bDxNb3F6aDiilvMcLArudwPAMzToySZwscoXaVdbaaXa4YK0fP4P
         LQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYu+eqeb8i0LoTIVx+apRtgHcQpLGBYBZ0sCCZDTFduhF/XVbdKaTq1n2N8q4tkNzLtf/39n+V3g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+4D9/CXp9MaZx6ZTVMsIfwv8e8M3MmetehoBjvz2flzC1J5lA
	0sGHZbuvQ2RCxMzyQ2N/ilGSRx8ipGbOkigG1fbIVvfkXJhmYTNx
X-Gm-Gg: ASbGncsE/3lsgdfppRMoSwdviY4G7RBq65tCgacGxFyFR+WAyTu5OR1LxtakZiuIE6z
	H97tFglSurpK9yyOmQn/4Au3/9C3x8L0B2PhliWKLc1ewSBwh/rxqDarIoY2CokHnqZ4WTxJPax
	Gn1C4v1R9/WTkeNaO+19VtOsAZGabCq4fKgh3Cb6ycEFEKj2U/yeSeEXBzZ5PN8sHzeRKvdl4aE
	ZJF+0X2V0b9N7kv0qCTdtMEvET9vKWPgSNycmBkfLegnnqs3PZ0LpSViENdaokEmRNUrcur9lDK
	k1mSleS8VC1zt2lV7TQlwJqB8ehls4cstTbGobVNUKJ1rQh9zmPlrraBd8Fq3NF5TbU5+Sy/u6D
	rgg==
X-Google-Smtp-Source: AGHT+IGfFqjWn5jDeujlSfDPKt+RV9k44BpVE9YkTL7sFgXDw1aXwK/HK+tHtBJmF3jwnnT32dVOXg==
X-Received: by 2002:a17:90b:264e:b0:2ef:2980:4411 with SMTP id 98e67ed59e1d1-2f9ba26b850mr4438016a91.9.1738671995223;
        Tue, 04 Feb 2025 04:26:35 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9c316d034sm774792a91.1.2025.02.04.04.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 04:26:34 -0800 (PST)
Date: Tue, 04 Feb 2025 21:26:30 +0900
Message-ID: <m2y0yl28w9.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org
Cc: ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v7 00/13] nommu UML
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250204_042636_753863_3E0AFA33 
X-CRM114-Status: GOOD (  14.03  )
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


Hello Richard, Anton,
Cc: Johannes,

On Mon, 20 Jan 2025 15:00:02 +0900,
Hajime Tazaki wrote:
> 
> This patchset is another spin of nommu mode addition to UML.  It doesn't
> change a lot since the last version (v5), but contain clean ups.  It would
> be nice to hear about your opinions on that.

Hope you're doing good.
I'm writing this email to ask you for a review to this patchset.

I have been addressed comments received so far, and trying to shape
the patchset as a minimal size so that we can avoid confusion by the
new feature.

But still wish to see how I can improve the patches so, it'll be nice
to borrow your eyes to look at the patchset in your spare time.
Johannes gave me a bunch of feedbacks but I would also like to see
other maintainers of UML.

Thank you in advance and looking forward to see your inputs.

-- Hajime


