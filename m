Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D438FD5F8F
	for <linux-um@archiver.kernel.org>; Wed,  8 Apr 2026 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cKSNMqLJz0NGN18IiNVAGIQZTI4URku+1Rx2DUYJKdI=; b=Z3zHXxsBb13reIXjQzw7G02uFm
	he2nnhYkzwhDrK1qbVtCCEoiU/w5b5lrZtt6b3yv0iJ80IJISmAnPY9p+XTqI/0uiFhzc9gKTJGMQ
	yUOVXpkTlHUBnyFaoakMRpCDV1/4ZQ4GZ9ZK31HxhatD/EtvYkWRXSma5flWSTzBPWc7QoGTv4txV
	2zTmAxr+jWwfcv9TJaqBBXmCiQB07/e15yCV9N05DvBUZm9y4wJ/67OBzrHCgS9v7pHqJG/vYWMzt
	WmCzptfw11dqwPN4/VKcfuKb3ncWHUheW6Mf5T62kMC/OedxLrohvLaaPmLdvgO1v40uELwDTVCkq
	6sjCARzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wANMA-00000008R4H-03dH;
	Wed, 08 Apr 2026 07:29:46 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wANM6-00000008R3M-2b2V
	for linux-um@lists.infradead.org;
	Wed, 08 Apr 2026 07:29:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cKSNMqLJz0NGN18IiNVAGIQZTI4URku+1Rx2DUYJKdI=;
	t=1775633382; x=1776842982; b=CBBjJwEwDvkzFAGmpSEl72J6WUoKgw36YnIEQl4/PGsvJg2
	HZYsLqc/uvWn745Ja3VWUel+X/6ctj5A0J4kOQWETTRQS8CGh5Qe+ze67gJdptBeUO2aVs8SqlN0x
	xdsgFiPX4wG3/OPNlNDV3fmgs1RwS9/z9wtnStEpQ6YasRv934d/DydN58ToksBvcKvKk5nQ4/r2q
	0ga/TmVmXJHSl9K3DqJcJPG7UuIXnp4G8P0wFEH6sZa/EQ3eLppo48Diq+CBQtI56N5dTMO3/svgt
	F62MT8cb/8hn1c8HaRdYldEtPq8Iq/gol9ea69gWhLu50EpD5O3cUl7SgcvcoJlg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wANLy-0000000E6Xj-2Vp7;
	Wed, 08 Apr 2026 09:29:34 +0200
Message-ID: <cedc3888ff787d821508f51f54ae7876ebc71bda.camel@sipsolutions.net>
Subject: Re: [PATCH] um: mconsole: use bounded version string formatting
From: Johannes Berg <johannes@sipsolutions.net>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: akpm@osdl.org, sergeh@kernel.org, clg@fr.ibm.com, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 08 Apr 2026 09:29:33 +0200
In-Reply-To: <20260329030946.32410-1-pengpeng@iscas.ac.cn>
References: <20260329030946.32410-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_002942_657472_A3927A8B 
X-CRM114-Status: UNSURE (   3.87  )
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

On Sun, 2026-03-29 at 11:09 +0800, Pengpeng Hou wrote:
> mconsole_version() formats several UTS strings into a fixed 256-byte loca=
l buffer with sprintf() and no length bound.

You really should line-wrap all your commit messages.

johannes

