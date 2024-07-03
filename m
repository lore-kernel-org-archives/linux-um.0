Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9267C2BD09
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 11:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MnvNwdGE17PL9pXvc06hvJg4YtHWpKU/6J6Wnaq5CXM=; b=zF4Y6zUhI+asbrAiqjjWx7G7MQ
	2z/Z2TrgCn4+06tNYRuen3fI6iArD4ECmnCG0MGzZ7DS2aCZMAmKhU135xZ8ZObFaEC+OXutD/sg7
	i2Ngwn6mzmlDJNUcX575C+ey+QSXZD4xv76mJb5EOzDz+47SL1AAx6lldzjG/L/elwrSmf51JWdLi
	AmYs7e3ZX3QArqnckcHRNefD2LANusYfXactC2AuBSSjRJY0xjZHKyPo/6i7IyBpVcotuUMyRdrZ+
	H4sQ19zrfGrnHXokVQds6j+CwTuGpFAdWidDwhpkOTRmVXfaI0uEy0kQ+Hxp/5+5u+l9iGJNdTp78
	00BEM5Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOyEV-0000000A1c7-1iq1;
	Wed, 03 Jul 2024 11:33:07 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOyES-0000000A1ai-1BfM
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 11:33:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MnvNwdGE17PL9pXvc06hvJg4YtHWpKU/6J6Wnaq5CXM=;
	t=1720006384; x=1721215984; b=bbs3pp5RoyBOInDmkVdNKcMUy65FZ41OHvSHIxooBLn4E/g
	I0whfyhOa1Y9RTChgABpJqHzXcjOLBBawHZXyTyZRTJ/Cfph+VSQEDOgYm7GWBCRvxWd54B2qIJhp
	DCkUti7JG6lLdsnObEQDwDIUHp6/jXvb9+KO4My1D+LiNAYubJ3mztcbFNX8IuKLrfaN5iKPzukV8
	RrrfVoCt1j+Fh29nsM7O5sHV02DzII+lI0Cwp7lYgjjHj0raq3+pABHrbbADpuEigM5RncKLrUmpQ
	MBIcrJJTk82BikEMroHvqP0NJq5Ch7nYr8WYgtFEDpuBmy+lCoujQmS1Jj7BM3+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOyEN-00000008mrK-3pit;
	Wed, 03 Jul 2024 13:33:00 +0200
Message-ID: <87bda96788c79f613f3ad8a84eaf9ca794ed35ab.camel@sipsolutions.net>
Subject: Re: [PATCH v6 7/7] um: Add 4 level page table support
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Wed, 03 Jul 2024 13:32:58 +0200
In-Reply-To: <20240626135350.493110-8-benjamin@sipsolutions.net>
References: <20240626135350.493110-1-benjamin@sipsolutions.net>
	 <20240626135350.493110-8-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_043304_343201_3EEF8B17 
X-CRM114-Status: UNSURE (   9.59  )
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

On Wed, 2024-06-26 at 15:53 +0200, Benjamin Berg wrote:
>=20
> +choice
> +	prompt "Pagetable levels"
> +	default 2_LEVEL_PGTABLES if !64BIT
> +	default 4_LEVEL_PGTABLES if 64BIT
> +
> +	config 2_LEVEL_PGTABLES
> +		bool "Two-level pagetables" if !64BIT
> +		depends on !64BIT
> +		help
> +		  Two-level page table for 32-bit architectures.
> +
> +	config 3_LEVEL_PGTABLES
> +		bool "Three-level pagetables" if 64BIT
> +		help
> +		  Three-level pagetables will let UML have more than 4G of physical
> +		  memory.  All the memory that can't be mapped directly will be treate=
d
> +		  as high memory.
> +
> +		  However, this it experimental on 32-bit architectures, so if unsure =
say
> +		  N (on x86-64 it's automatically enabled, instead, as it's safe there=
).

You copied this but it's not actually true any more - three-level is
never default now.

johannes


