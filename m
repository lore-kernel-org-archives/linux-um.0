Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D491CD4857
	for <linux-um@archiver.kernel.org>; Wed,  4 Sep 2024 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=76uG9nA5Z2kXAd2nlaY3PPD7K/CyxDqr0+DKOaLWywU=; b=STU+vqK+RTFIyrEBsSSckh+/Xa
	kbdPzMOS7N0xazScu6nmuMIPwupPdUJdpySamAvHn4iVWSD5afq6/29a8kbBRD2P3MInNSLon13YO
	W/EM/i1uVbeOk8XntLGLt2duNHI9iOBCvsIIuFw6H1I0fPdwlaQHTpHJW9MwM4UTSZ/ww/1DaD/a5
	6nGAD5k5eXAzYe1OLMuuo+rU+szpu5ggzgQWuAAnTqqh1YFKh+xBY6y5tqj35TE3dLwO/SBemVNdH
	ym/JPhxnRFhPlzrLeVHF9uVMPctwWsYKu/1eXsIoK50MMW8FXH0q5BOIEgPSvF6uxOK2TuDa4bVCc
	rraJSyvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sltNF-00000005MMg-0kdP;
	Wed, 04 Sep 2024 17:00:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slsI8-000000056Sd-0Qqm
	for linux-um@lists.infradead.org;
	Wed, 04 Sep 2024 15:51:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725465090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76uG9nA5Z2kXAd2nlaY3PPD7K/CyxDqr0+DKOaLWywU=;
	b=JS8ay/0SU+4aqJti0/KIoqZmxxW/l2fWrJW0aXvF2zsEvJY7N39BAKa8iqw67rXmZuq8fT
	K9QmFNgyEfGoGGOGVPPGBa3dGu4z2HoKv2uXF9s+lVNuBz8CE7ZfcCQDX0YrtoVVlxTWc/
	Yr7YHoemwfuMnaLCyxGDGfaM4c4pVuA=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-OBaaX0cpM06azOrfAFvSoQ-1; Wed, 04 Sep 2024 11:51:29 -0400
X-MC-Unique: OBaaX0cpM06azOrfAFvSoQ-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4fd087d2821so2043286e0c.0
        for <linux-um@lists.infradead.org>; Wed, 04 Sep 2024 08:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465089; x=1726069889;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76uG9nA5Z2kXAd2nlaY3PPD7K/CyxDqr0+DKOaLWywU=;
        b=KA+Cl6RJ4xoLjIyvCw95dQuo6P84l5DvupIaISjc5R0xI25EUqPlq7g70hu9h8T4/M
         4HA85tUo1de+CV+VWYaDSlxKShAJvl/roCG3qqkrgQJaauvJro5dUsA9YiaVo0ABe6DH
         f1F29Em0Dpdn1KfTCsyt749qZ4b05IQ/6ZDhm2U9Pr3R6ZRLqaklxIrGJGxzLpFHBpXK
         0emvxZ3jTVbIxYRyHa33Vlvua6N5Ry/13xryGuCklEVrxotS6l9JbPwBrUPX641x+vRo
         /b8RVI1GgZk5QQtkfqfvtApWELwO1N30yYJtLPtVXC9vi6SileAYQWWHDC+1PRT2GjPY
         EhFw==
X-Forwarded-Encrypted: i=1; AJvYcCXViYGem5mD7+O0OK8w/rMxmV86Z12v+jFkzrmUkHsUEzr+NQJcP6CKKCgkyrMWco7TUTU71gIpgw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1gxYRgoft8MX/lgWJTIpHekbzmeEn6gyBOT6tFVSqHERxz4MM
	sGWpnFEnSQ9y0FRDsFGuVkCRfsuKxYgogFs6x7OBKBeJFmrEcVYtr9ob+Snpex6aNVZxxkcsQKv
	u2p1b2rubgAYq5Cn/4q4ENgiGaIiB6wP70a972s2gKfuWh5y1EINr73ImONFumw==
X-Received: by 2002:a05:6122:411b:b0:4f3:828:7a47 with SMTP id 71dfb90a1353d-500aad4a345mr13917540e0c.6.1725465088652;
        Wed, 04 Sep 2024 08:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6DuFNQkzu/koNhZpY20gpJZ5XX5BKL3S/FjTMXEDCyB3q8D3zZLHyV2mW6t2xJyy7IgmqHQ==
X-Received: by 2002:a05:6122:411b:b0:4f3:828:7a47 with SMTP id 71dfb90a1353d-500aad4a345mr13917520e0c.6.1725465088242;
        Wed, 04 Sep 2024 08:51:28 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d61b5asm635774585a.110.2024.09.04.08.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:51:27 -0700 (PDT)
Message-ID: <cff6d1fcd3331574a5189737f1f58774882649fe.camel@redhat.com>
Subject: Re: [PATCH] um: kunit: resolve missing prototypes warning
From: Gabriele Monaco <gmonaco@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arnd Bergmann
 <arnd@arndb.de>,  linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>,  Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, Richard
 Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Date: Wed, 04 Sep 2024 17:51:20 +0200
In-Reply-To: <942a2aa5fc93f6dc1bc88b3b25e59b044a7a425f.camel@sipsolutions.net>
References: <20240904135019.200756-1-gmonaco@redhat.com>
	 <942a2aa5fc93f6dc1bc88b3b25e59b044a7a425f.camel@sipsolutions.net>
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_085132_237380_9B623641 
X-CRM114-Status: GOOD (  15.57  )
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


First of all, thanks for the quick reply

> I get that you have this on kunit on ARCH=3Dum, but that makes it
> neither
> a kunit nor a um patch :)

Well, yes I wasn't entirely sure how to put it, sure people from
UM/KUnit know what this is about, but I agree perhaps the patch title
can be a bit misleading.

> Arnd had originally wanted to fix this another way, but that got
> dropped. I don't know if this fix is right, though I can see that it
> works. I have the same workaround in my tree, but I'm really not
> convinced that it doesn't have side-effects on other architectures.

I thought about doing it differently, perhaps using an additional
header file or even re-arranging the macro dependency, this seemed to
me the easiest and perhaps less risky for other architectures, but I
get the concerns.

I could perform some further analyses building it for multiple targets
(besides _it builds_ I mean), if you have anything specific in mind.

Gabriele


