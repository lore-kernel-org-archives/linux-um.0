Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C80C3064D
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 07:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nyl7gb4F+nBk5fr79Yq6L2V+Ej7KXu+o/E4zt3ZCaLs=; b=RBxZ/tVW/iUaZUSb/yWDw0d7sv
	GqtUhjwtyEj83TyTFlLPGuLwueq0ucETmDQeHbekUPfya5Ow1tx6qssE7EBv+eZD/l6hFScOZ+NaH
	PGBVTEKJnBerd/hpJSPcz0RJYjHlppuvK/Kb4dSbF+wfdT5O/FgVWwkbjotM3WO1IF+PKtzL+qTR8
	czwtksU/FRvdNF/EfhCP6t5w8CX79H/faUad30o6Hqh/47gi2o6supJRCwI2sG1C1dWWeY0JwejxZ
	ZftbBSlZXBHXWyFq91RJmBeJSFjOhozOkrxw0+5TuR1V0YHpBV3Euf9iLLdhvBnIjX5l3Y0MHrejB
	ECzoaBJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOYO9-00000005vYi-2o3A;
	Tue, 02 Jul 2024 07:57:21 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOYO6-00000005vXM-16e3
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 07:57:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nyl7gb4F+nBk5fr79Yq6L2V+Ej7KXu+o/E4zt3ZCaLs=;
	t=1719907037; x=1721116637; b=SmDALXp3kayewHRZe90+X3o7dB3aDVmEEbYoUm3zoVWGevv
	H4Yf/0xMms2aKFDdrwJEm7tVVEDxg9LTHy5G+ZWMx7/iO+2SBUNb+fDVIt/VLvuMrn4LshzJVDafK
	Y0vX4EbUbsrtOY1m5pCwQSfbXW4q4tRxEi8R9CMYPa3XAWHrSl05nnV9WOQUtLKdqN/w0MCCmhTW0
	8xSwwlspVEpkkriVWri8L9sRMaOkBNbkuvG/Dy7CyGzojBwuqJjtl8GC1LaeqVe81MWQdKHCyK5sP
	cfbmFr4xa2r6wNz+HBMPubJuv1S50wQHIvKrK4cL31JVhjGnjxYFdHWZmRtYqIkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOYO3-00000004wJu-1QOd;
	Tue, 02 Jul 2024 09:57:15 +0200
Message-ID: <6e01a4c7ebf568f17f92e75621cb8dfe357fa651.camel@sipsolutions.net>
Subject: Re: [PATCH v2] hostfs: fix dev_t handling
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>, Arnd Bergmann
	 <arnd@arndb.de>
Date: Tue, 02 Jul 2024 09:57:14 +0200
In-Reply-To: <20240702092440.acc960585dd5.Id0767e12f562a69c6cd3c3262dc3d765db350cf6@changeid>
References: <20240702092440.acc960585dd5.Id0767e12f562a69c6cd3c3262dc3d765db350cf6@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_005718_382881_2C20C5A2 
X-CRM114-Status: GOOD (  11.06  )
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

On Tue, 2024-07-02 at 09:24 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> dev_t is a kernel type and may have different definitions
> in kernel and userspace. On 32-bit x86 this currently makes
> the stat structure being 4 bytes longer in the user code,
> causing stack corruption.
>=20
> However, this is (potentially) not the only problem, since
> dev_t is a different type on user/kernel side, so we don't
> know that the major/minor encoding isn't also different.
> Decode/encode it instead to address both problems.
>=20
> Fixes: 74ce793bcbde ("hostfs: Fix ephemeral inodes")

Probably should be Cc: stable too

johannes

