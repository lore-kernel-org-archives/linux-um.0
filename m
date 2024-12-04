Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA408E77170
	for <linux-um@archiver.kernel.org>; Wed,  4 Dec 2024 16:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FmXZmjS7aUm2srkS6vtlFJNrPMYg9WZhHmqd/WYYupM=; b=jPw/J/s2lPgmRWvlpNZ4Kbk6Yw
	PVHohbnGUoGSIWO5fLMjlqII7i33MUjhSvtNHycEYyQtQsFjcxApenXRLmae/bTmclVMh/zbF/97V
	wb/sZs6vaCMdd3Ks+MHTS3F2XF6E2uur9Am+p7XN+RNJ3g8M+TfnKRw8xJHJbfS5oB/F+50PCkmO9
	y9M313mymo7HSlT8rssGQIiG/gzm2FuLLwp2s57JRdRUO7m0znPnEjqdMm+VR73rlkWf8htTpp7SY
	IOIDjOLRtq2OvEr1qa0ZI6yZxSijpL/OWHnmFULduovuz5qw04RYVYgkOydQOKC74/1WDO+iiajsa
	LQHRJLPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsNo-0000000DDGC-1v8h;
	Wed, 04 Dec 2024 16:37:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsNm-0000000DDFd-20L2
	for linux-um@lists.infradead.org;
	Wed, 04 Dec 2024 16:37:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FmXZmjS7aUm2srkS6vtlFJNrPMYg9WZhHmqd/WYYupM=;
	t=1733330266; x=1734539866; b=exm4jGov43rKPzkxxjqZgCeOw9lgq7OLpr3gXuKHXdUnVEk
	0qiUHEPzZgdyVnpcAeS6O5dL60eMH8zYRyPp3F4chckohDKSzNNu75Rcaxg5D9Lwc1diCeuubTywa
	yZ2oAQkPA08Z10m0MrBc0UPAsYYaNO2h8H/Av+3Xee2fQz8gxvVz9h6LTD/x7YOS8nIQfqViCntEG
	SbSAvM5264tltFYeV2yPA3e/TSqygbdcwJyAb2R8tncckg0hNKcoSpo4YiSNGzFF9aOJWZUrEXZcz
	xYS4XQt9aiT3WUuQs8/Zs/5l+3pO6f8ef67pHXOWjbblZlbaPTf+3ULeBjdXmrag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIsNj-0000000770L-2Uf2;
	Wed, 04 Dec 2024 17:37:43 +0100
Message-ID: <e0babc622127a88880460ecc129b907ab6d00940.camel@sipsolutions.net>
Subject: Re: [PATCH v3 05/13] x86/um: nommu: syscall translation by zpoline
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: ricarkol@google.com, Liam.Howlett@oracle.com
Date: Wed, 04 Dec 2024 17:37:42 +0100
In-Reply-To: <02330ee6c6676cc2f6501ec78f3a1f448ba1d3d6.1733199769.git.thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
	 <02330ee6c6676cc2f6501ec78f3a1f448ba1d3d6.1733199769.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_083746_516683_EFBE6EA7 
X-CRM114-Status: UNSURE (   6.26  )
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

On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
> This commit adds a mechanism to hook syscalls for unmodified userspace
> programs used under UML in !MMU mode. The mechanism, called zpoline,
>=20

I think you should just leave this out of the first version entirely.

johannes

