Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50444C4167B
	for <linux-um@archiver.kernel.org>; Fri,  1 Dec 2023 19:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tt4VoE87JLOfTrJPPSXo0vgDxgqgJgly7s6qG0iICLg=; b=DTsONcghqr9JJ3ew5CNaxKaju+
	BpQNfXJc1pNyWMZZ9cUZI9f9fNQj/CdRuh+aYt5NLKMGSDqXphDf6UFaG4SdlFxWlPywCWyoX5d3n
	WIwfI61H7YtoLl4oxoiYAft01pDUYPuLSu9nKmpSDMXafnfIeONlNuSl960fLm23cfdYmB1rg0v9b
	+p25PIXt9nGjV4PnqFvt8LW6LqXdXezh9/us9eXtALcUJdvjgGTNnyowP8UNxpTtJUNnTBAqKn+zb
	OPdyXdZRbdsDASf3pK9Zh4NFO22IO4RKdSWU5m04VqPRmVFTUT4pW6AQCM8upw9YXeK8poOT3w+9i
	RZBGTcbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r99BM-00EVzr-2Q;
	Fri, 01 Dec 2023 19:28:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r99BI-00EVz5-1v
	for linux-um@lists.infradead.org;
	Fri, 01 Dec 2023 19:28:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701458886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tt4VoE87JLOfTrJPPSXo0vgDxgqgJgly7s6qG0iICLg=;
	b=iWsOncjauu7FFPX2g5gmSRGpaSdDMmld9kmH6AgT1MFvzIr1rP1hMWXKFPcaR+Xx7V8h4U
	xsE88M84KXurkz9HDSjuBAAwQQ27LdLknSFwwxqEgMN1HNwu/dEclnEWT5S+xXRt3FNRYD
	xBokrSuQ0fc9AgwEEOCrq1W42/lsO8g=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-8oGRQk68Po60EsiixtGoUQ-1; Fri, 01 Dec 2023 14:26:18 -0500
X-MC-Unique: 8oGRQk68Po60EsiixtGoUQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b85da398acso1392546b6e.0
        for <linux-um@lists.infradead.org>; Fri, 01 Dec 2023 11:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701458777; x=1702063577;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tt4VoE87JLOfTrJPPSXo0vgDxgqgJgly7s6qG0iICLg=;
        b=mUevhEJpDaPTgy+ylbCkQ50D2vzp3pIVIPdtJUWES8q3onCytWbiUsjVJeR8Bv7YKo
         8ovwbNOjkE2VcmZWvdccFDtjcZj8dt2tPcDbNfLKY9ICzifj6xw49c/xVksVpoJ+btvc
         YWOJERL0Rnl5jHxtXS3ZJACmw0F0r+3syQlGCVcsYFVGKQFGLTBp1+ENDzYs/xHhUaCa
         e/q1EKrN3WXLIqsHor5S1eu0ErHwtJHHuKWim6vYHFgr5RCMxvZ3E9zaQ1KaXxU2SWfU
         Gd+6ZxU3+bUGkTbJxbYSxF9w/LoYRlxjVXtoEATIVbR2+A22GMXC+8NA5WeTtke+nBvh
         Wh2Q==
X-Gm-Message-State: AOJu0YyS+oZbXdWjoae8y61JDO9q/riof+LTF5bFW3ueAEiZSFqdnxtM
	Bih9o+qoQVudtykmuUnFXSMaw5HAmYPlqWN9QvMysgVrg/ghHX4Wy81LXufAutMbV6+Z4kRd7LH
	h+RP+dMYL08W8yZIL3Pxbj730kZt62sig
X-Received: by 2002:ac8:5ccb:0:b0:41e:24aa:81a0 with SMTP id s11-20020ac85ccb000000b0041e24aa81a0mr35409647qta.62.1701458738912;
        Fri, 01 Dec 2023 11:25:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0Z0PZy06L+nM/mBwW9vEOgc6MD91PPMLBJrnR+KnmmAlOHfnc8OSUMs0flBnu9l6FNWSCFg==
X-Received: by 2002:ac8:5ccb:0:b0:41e:24aa:81a0 with SMTP id s11-20020ac85ccb000000b0041e24aa81a0mr35409587qta.62.1701458738102;
        Fri, 01 Dec 2023 11:25:38 -0800 (PST)
Received: from m8.users.ipa.redhat.com (2603-7000-9400-fe80-0000-0000-0000-080e.res6.spectrum.com. [2603:7000:9400:fe80::80e])
        by smtp.gmail.com with ESMTPSA id d9-20020ac851c9000000b00421c31faf05sm1740104qtn.1.2023.12.01.11.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:25:37 -0800 (PST)
Message-ID: <e1b3ccb744d67e6214cf206ba8480cb3e35694cf.camel@redhat.com>
Subject: Re: jitterentropy vs. simulation
From: Simo Sorce <simo@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov
	 <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, Stephan =?ISO-8859-1?Q?M=FCller?=
	 <smueller@chronox.de>
Date: Fri, 01 Dec 2023 14:25:37 -0500
In-Reply-To: <8ddb48606cebe4e404d17a627138aa5c5af6dccd.camel@sipsolutions.net>
References: <e4800de3138d3987d9f3c68310fcd9f3abc7a366.camel@sipsolutions.net>
	 <7db861e3-60e4-0ed4-9b28-25a89069a9db@kot-begemot.co.uk>
	 <8ddb48606cebe4e404d17a627138aa5c5af6dccd.camel@sipsolutions.net>
Organization: Red Hat
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_112808_729150_B7DAB502 
X-CRM114-Status: GOOD (  17.21  )
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

On Fri, 2023-12-01 at 19:35 +0100, Johannes Berg wrote:
> [I guess we should keep the CCs so other see it]
>=20
> > Looking at the stuck check it will be bogus in simulations.
>=20
> True.
>=20
> > You might as well ifdef that instead.
> >=20
> > If a simulation is running insert the entropy regardless and do not com=
pute the derivatives used in the check.
>=20
> Actually you mostly don't want anything inserted in that case, so it's
> not bad to skip it.
>=20
> I was mostly thinking this might be better than adding a completely
> unrelated ifdef. Also I guess in real systems with a bad implementation
> of random_get_entropy(), the second/third derivates might be
> constant/zero for quite a while, so may be better to abort?
>=20
> In any case, I couldn't figure out any way to not configure this into
> the kernel when any kind of crypto is also in ...

Doesn't this imply the simulation is not complete and you need to add
clock jitter for the simulation to be more useful?

You can use the host rng to add random jitter to the simulation clock.

Simo.

--=20
Simo Sorce,
DE @ RHEL Crypto Team,
Red Hat, Inc





