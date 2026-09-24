Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FEDC98304
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 03:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MrfsdsMIsfq+eQAMfy2CBj4pLAaY3JeJv7+Gpgfo1oM=; b=RR1t2pDHqddEdjBkrnh95Y2Gvz
	6lJhcAipzK6eGDEL3d5xgI9LmByhhmSdN6qilhkwxsDs3Fm7VFr9krNg6Wfzb+gW4uZ9eTifQbBw5
	8g7TbnlDpB1HnPcXFcUO479/e4X/gNRWBSCsMOXWPAfEcb7nqNR8oOvieU/UuY+ZAkUNUdiSd/fVn
	bhmwfxwEKgUY0yL7KXLj53aWB2J+m/vBZGIq3Ya0g/8rTpnq9EJy1NxOEsOZ2GjqxUIyaTrmM1Ph8
	p+V2zFTcbyYk+jMIl9Xd6ziPJ9bIt7NV1dmgCBabZrEiDi/qN45v8/iFeL9Hi/w+m64zdJUesAEw0
	QCrn64+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9aPL-00000009y88-2BQd;
	Thu, 24 Sep 2026 03:46:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9aPJ-00000009y7i-2eej
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 03:46:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B782B60211;
	Thu, 24 Sep 2026 03:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC751F000FF;
	Thu, 24 Sep 2026 03:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790221560;
	bh=MrfsdsMIsfq+eQAMfy2CBj4pLAaY3JeJv7+Gpgfo1oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SbX0UL8Q689vIff6gsAdJW1z5tGgiIo+CjCotHzQlq2sEpxLj/E9vdHbGQwX7nx2s
	 Xbo0iCAJ3MQ4YpTI08sU0y08ZjQqE67E0ykWkS9bMKvxWh9NgbduoTAIc/OQCSO5jp
	 yq42n1X4iKEB98O5G9hGuD4Ar5g9sNCf+fPGsVDzfAm0BaRcYIbCNNkLKbjraVHwyb
	 0Gqcto/4E2j6Eu/h7tHofpuWwDl/LbeFq+8m9Y8MQ6iuredeOaKsfYgb9xSnWSh5M3
	 EGC6EUEe9i3ExIEILVMX6qGnEyCzzIrnMD78tf9DOusz5s8Sl1PjigXiP1IBd8SM5U
	 OPIlLKKuirbIA==
From: Kees Cook <kees@kernel.org>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	Alex Hung <alex.hung@amd.com>,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] um: fix CONFIG_GCOV for built-in code
Date: Wed, 23 Sep 2026 20:42:24 -0700
Message-Id: <179022133928.127266.18052172879787586674.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727195515.2306731-1-alex.hung@amd.com>
References: <20260727195515.2306731-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 27 Jul 2026 13:55:15 -0600, Alex Hung wrote:
> With contemporary toolchains, CONFIG_GCOV doesn't work because
> gcov now relies on both init and exit handlers, but those are
> discarded from the binary. Fix the linker scripts to keep them
> instead, so that CONFIG_GCOV can work again.
> 
> Note that this does not make it work in modules yet, since we
> don't call their exit handlers.
> 
> [...]

Applied to for-next/hardening, thanks! Only a 5 year delay. :P
What else is needed from the original series to get the full coverage?
https://lore.kernel.org/all/20210312095526.197739-1-johannes@sipsolutions.net/

[1/1] um: fix CONFIG_GCOV for built-in code
      https://git.kernel.org/kees/c/760f96b7f54b

Take care,

-Kees

-- 
Kees Cook


