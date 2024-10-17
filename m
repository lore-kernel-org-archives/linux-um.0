Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB43D2F7CE
	for <linux-um@archiver.kernel.org>; Thu, 17 Oct 2024 12:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YSnSp0r4RqmfOCJ1eCsDm0DfkQki2jgFL8MrJv2HVr8=; b=2+4bWdzhnXSVRhuv6z6HMZDBff
	x845W/IV/nmc+EIFhV+D4Ysf2o756N3l7biBU8ilNRy0pPh1Hm7ZQfrwwQF3LLuf6Yadd0LrYywHg
	b5Cy+0rU9WT3CVv/8YPxRNvOX2kh7BprkdVhJo7YqX3BKuW63sCvV2lib0RKwAm4W1Qk9lO8InZAZ
	BDukaUKnn4QpkZh9RpwGZMYeULjyEhFTn2s2rMqXZJXDvLJXpDljLFaZaUk0W7S+Q3r+he1KovzXd
	R5msb64jABr85d2mAWD/pNlb2Lea79zrRpHALqSKyFkJE0kCYWe/Npgk20gdUdD7NW6sNSMfIvIni
	wrAOe+Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1PGI-0000000EiwN-1ERt;
	Thu, 17 Oct 2024 12:05:50 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1PGC-0000000EivY-13zL
	for linux-um@lists.infradead.org;
	Thu, 17 Oct 2024 12:05:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=YSnSp0r4RqmfOCJ1eCsDm0DfkQki2jgFL8MrJv2HVr8=;
	t=1729166743; x=1730376343; b=EKulbi5+XTBx1uJ7JWGlkXiCDIDiVH+mK1O3YlhipL5ERLj
	UvaUT/E0o612FiVQgW8F89r3DatbBryuCLUHjGlnHSs49aYemoDQx5s7QMh26in8/FbWcegnJvdNR
	Qt2jj9Z7msY4yp7ZEOm32TCSeOrkkpAFsJPUKldX7VBPb9AFLlRHmg+vC/QvP5H8xKWVSQ4s81+JU
	hPz+qK2I1gZ7q+hHTSdmVcIMnKKy3ooXFq/aBeA66/JCUuiGor6j605IVRBVNPuX7YwEUvNDNkzJz
	r11qjfFC/wR81b+veFf5oyQ+3O16ZOiEb1nIpxsPOK1s2e+JTSScjX7hDjPIBVUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t1PG7-0000000DuXK-3IPN;
	Thu, 17 Oct 2024 14:05:40 +0200
Message-ID: <9b9b26965e8ca5cdf9b05b5d56a418a2941fff42.camel@sipsolutions.net>
Subject: Re: [PATCH v9 02/10] um: use execveat to create userspace MMs
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, David Gow
 <davidgow@google.com>
Cc: linux-um@lists.infradead.org, KUnit Development
 <kunit-dev@googlegroups.com>,  Kees Cook <kees@kernel.org>
Date: Thu, 17 Oct 2024 14:05:36 +0200
In-Reply-To: <49ef8267b4c2cbce11698a377330d92327b332d3.camel@sipsolutions.net>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
	 <20240919124511.282088-3-benjamin@sipsolutions.net>
	 <CABVgOS=boUoG6=LHFFhxEd8H8jDP1zOaPKFEjH+iy2n2Q5S2aQ@mail.gmail.com>
	 <49ef8267b4c2cbce11698a377330d92327b332d3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_050544_313555_59C9D4A9 
X-CRM114-Status: UNSURE (   9.70  )
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

Hi,

On Thu, 2024-10-17 at 10:18 +0200, Johannes Berg wrote:
> [SNIP]
>=20
> I wonder now if the SSE instructions generated are memset() and that
> goes away with the patches that Nathan just sent to not have the memset
> (which was due to -ftrivial-auto-var-init) in the first place?

I am guessing it would not fix it. I can reproduce the problem if I add
  __attribute__((aligned(16)))
to the "stack" variable. That is sufficient for GCC to emit an
offending movaps instruction for me. The -ftrivial-auto-var-init=3D
option will not affect that initialization.

> But anyway all of these pretty much sound reasonable. We don't need much
> to happen in the stub here, simpler is better.

Yeah, and I guess c) really is sufficient by itself.

Benjamin

