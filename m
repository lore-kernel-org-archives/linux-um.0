Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A6FCD5BD1
	for <linux-um@archiver.kernel.org>; Thu, 28 May 2026 08:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lMis8oI9nzQmxhD2cadrgYjkurIFfQSjVlT5txsPDq0=; b=xVtVRZ55uQ6ORM3LbYj9K/NAjX
	Ydo7S17yKhYXX+I66pLJMAdF9/nJcMzR/zO+WtJeT9eoKIAo8rFwgf9EQBWbi8D634lMfCGLAmqGJ
	XCY5Cm2+F1HEqbfF+UPBWi0yeH2KUyHLXtEoz2PbAMekUJmsyU4cwOWpIjZqpDARVBlYAKqqY+U1j
	7/vju2DERUh6Fw35lGaz+tt3qVaz4rlMjW976qriHzuOW+Ct3nhEQHfL3MHiWat3ju7zJCTLQVV/x
	8JZGB1IAUR8fwcFAPnU8bjZc0p755Vze5uVtnZwDtg4/TiTkDNqYAyztm4ssGp55Xs4Us6qH9iLVF
	G5K5kuqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSVwH-00000005MOk-3QOu;
	Thu, 28 May 2026 08:18:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSVwF-00000005MNz-0HOS
	for linux-um@lists.infradead.org;
	Thu, 28 May 2026 08:18:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lMis8oI9nzQmxhD2cadrgYjkurIFfQSjVlT5txsPDq0=;
	t=1779956278; x=1781165878; b=QGS4vBKCobzeMvK2GHTOCuZsj/r1S+F+tCUHPlR/uSB24hg
	DbqnmmMkgDL1ouu/JrsijMlnFWRtzvhUukJgXuzX8mnQPVXPOYZNRx45MnH+vR6CfLC7+C9TtcxjX
	8yARkz8lg2XAPwakseOfoGd0L6MmQtlF7N7hD6knRCO4bMU9NxWT3bq2BEXjn1FKBtZUkEOFWfsQM
	eLIgHX4sY40EbILRKmxssQRZnYseCr4HV8Cz7QBQIr9cKih1NKB/Hufs4AhfbIq01t6WwlS22hNiN
	GPDHFbo/hZ8mv7wE5FQw7UL8xvuPvwzjoBwOdBxpKAyF1YaZemhVFWR5zAquK5GQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSVw7-00000007CQm-3FrP;
	Thu, 28 May 2026 10:17:52 +0200
Message-ID: <21c2c12a804d662d74c3518267d90e045223583e.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: avoid NULL queue dereference in legacy RX
 mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Henry Barreto
	 <contato@henrybarreto.dev>, Richard Weinberger <richard@nod.at>
Cc: Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Henry Barreto <me@henrybarreto.dev>
Date: Thu, 28 May 2026 10:17:50 +0200
In-Reply-To: <a3be3b6c-3347-4b5b-97fa-2431cfb76623@cambridgegreys.com>
References: <20260527213524.45903-1-contato@henrybarreto.dev>
	 <b72e33e9d651f67ff2236b21fc13c3c78a99cb97.camel@sipsolutions.net>
	 <a3be3b6c-3347-4b5b-97fa-2431cfb76623@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_011759_103646_65BB8CC8 
X-CRM114-Status: GOOD (  11.21  )
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

On Thu, 2026-05-28 at 09:00 +0100, Anton Ivanov wrote:
> >=20
> > So ... you're effectively saying that the tap transport has been broken
> > since 6.12, released ~1.5 years ago.
>=20
> The one I use is raw :) It is the most useful.

Right.

> Tap badly needs someone to expose the socket which the kernel uses to imp=
lement it. I started writing a kernel helper at some point, but never finis=
hed it. It should be able to produce "stupid speeds" with it.
>=20
> And, yes indeed, this was broken by 612a8c8e0b43ba7e3d0e51f6f76a5fec4912d=
439 / 2024-07-05 which by the look of it I did not test for tap.
>=20

Yeah, I guess I'm just thinking that clearly nobody uses it, the
infrastructure isn't there (as you say), and it was broken for a rather
long time now and nobody complained (that we know of.)

So ... is it worth even keeping it? I'm fine either way, just wondering.

johannes

