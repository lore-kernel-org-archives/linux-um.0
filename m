Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDA3D7495E
	for <linux-um@archiver.kernel.org>; Wed, 30 Oct 2024 07:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DpWnGCoIDJZ5+b+a4BqhyygyqQSOflZ46KZvpLf5uZ0=; b=2zVz6ZN2o0rbFtuDZKeRVCC467
	KPPIcQmRICNNGBBjfBpJbNOlL8tofelu+60AD8w5hPEBye+nwBvb62SgmmHqOr7T+EPd3lFxSuSSm
	52r4JfNE9RxIU8sMRBvm5Mg+Wppn0jb1KR55/yuHlNNDc2YnCzUIfg9r8BsPAdbbVOSRm0s4si3ux
	qk+kAto1FZHg9cO4zhXDq+ScERTJsXq44giIMOj/JXXTvXzgQh2XhnOTVFnbwBM80FQ/5V+bFQQSK
	8b46KGt3XwUAw35QAdcb7nE84fjXvbZsvVdSfm7WdFKSL5yS3fJCFPArYHKWx83sGt1i6t2A35mby
	RLPZufWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t63E9-0000000H9py-1pGU;
	Wed, 30 Oct 2024 07:34:49 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t63BP-0000000H9IW-1Zxw
	for linux-um@lists.infradead.org;
	Wed, 30 Oct 2024 07:32:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DpWnGCoIDJZ5+b+a4BqhyygyqQSOflZ46KZvpLf5uZ0=;
	t=1730273516; x=1731483116; b=NgkDp19xdqcltVQecJ4wkTPn5Xz67hXCtPvFiSIs+HStxTB
	r9T+Ew9Eq3PX1RkxOgiGKozb+qVZoPOmb0E0gzbIfRFWRDzKbLl8/nV5HetwlQ3SKd/4uEz/uTFcb
	KJ0Q9HQYMDErNtKiMdIzNbnHgk03/uFKXTcjX2Se9sLagJmvznUGv5P2x0Cj4k1eBQ2le7yUVQSno
	DyjK5XvWIzQAeidZUoBmvGlx1WC5eT+UEGVM7eJiJNhNaUnho86ajO+x6J0gitVOJfsC6m6OUAAo9
	adeLTmdgSmcnYsGeQzlIX3wef5VRdnVP+yTUpQsqUSUzKsmJbKuEdUUMsHaeJNzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t63BD-00000009F9L-3xES;
	Wed, 30 Oct 2024 08:31:48 +0100
Message-ID: <2592d27930288d6631076de4f2f11c9f269f362a.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Remove double zero check
From: Johannes Berg <johannes@sipsolutions.net>
To: Shaojie Dong <quic_shaojied@quicinc.com>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Benjamin Berg <benjamin.berg@intel.com>, Tiwei Bie
 <tiwei.btw@antgroup.com>,  linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Oct 2024 08:31:47 +0100
In-Reply-To: <20241030072609.1645401-1-quic_shaojied@quicinc.com>
References: <20241030072609.1645401-1-quic_shaojied@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_003159_448131_2AA43B66 
X-CRM114-Status: UNSURE (   6.08  )
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

On Wed, 2024-10-30 at 15:26 +0800, Shaojie Dong wrote:
> free_pages() performs a parameter null check inside
> therefore remove double zero check here.
>=20

Ok, so, I get it, you want to make some cleanup - but you've just send
pretty much the same patch *six* times (although most of them were
incorrectly addressed) - if you want to find something to experiment
with please do it elsewhere.

(And also, why resend this again _without_ a new version?)

johannes

