Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20201C54E41
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 10:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2ziBA3HqIA4iJc8We1k4+k/3Xk5J4Xq9ZX+wSv/5J2Q=; b=AAKVLEIHkJtZKsUiqpW4onj13x
	M9AVRwglxFFStK6Iin7K0IIKem/XgQeESB0aC/V2ByOY78C00KzE24XfcYetU83F1DqtekC6EbXPP
	t3AxtmUrRBGttI1PF1jC+vKEKNXeYKHTibrauelQcUYF3hXV299WHvKRU67pnHhsXhSNH9N4YSDOk
	9CQTGjEloBNHWts+NisieeW505BTsdJgbotJyEEENsTLmShjZ72/oeaAXIXUHZTr36oCiMkncUlvb
	IbL+wpPamJ6+6ArQpGj6uf67XUBP26eyMdq46HCDBOIkAsDUl4fuegjziu5a2sYdywoC7ajZZMr1R
	M9bc9OPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhS8I-0000000D5eS-1Z4Z;
	Tue, 05 Mar 2024 10:34:50 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhS8E-0000000D5b9-2VU9
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 10:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709634886; x=1741170886;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=CKWqMeXaguj2O1SU6aYTYqiVH3n8gyOTaC81E2YhK+g=;
  b=D7Q9cjD2UshvOTl6U1qNi8q/JD6as6i6OL/n0Z5R7aXkmU1gtMLTZGFH
   7be7PzR+XB5hIaA19y8gJwApGoUNhTBt8GYKTiUNKnws7lvn0/EcLcCnp
   dhsRdrxjzmh6sEqtglGWTheRl89H7l/g+IzGbL0Nox0xXeSHIiD8aOq8O
   4zJA8AIBguhqV1pnGdBg96dpsmhibIqP6zk3r8JGjOc3rxnDzJcr9vDdw
   0t8smf7J2DtY3qdnuXhsPibo6xLzvAyGat1/P/ighT48CGVlmZGjQpcCb
   wdQVoyVINmfyS7MalmAFdvUEl7WSqj9S7dRfdalm0W2YwivGp418kfB5c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14824322"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14824322"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 02:34:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13926501"
Received: from omakhlou-mobl4.amr.corp.intel.com (HELO localhost) ([10.252.51.143])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 02:34:42 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: intel-xe@lists.freedesktop.org, Lucas De Marchi <lucas.demarchi@intel.com>
Subject: -Wmissing-prototypes warnings in user-mode linux
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date: Tue, 05 Mar 2024 12:34:39 +0200
Message-ID: <87jzmh2chs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_023446_686352_FC166B82 
X-CRM114-Status: UNSURE (   5.29  )
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


We're seeing a lot of -Wmissing-prototypes warnings when building
user-mode Linux. For example, our CI hits things like [1], and it's just
extra noise in the build.

I started adding some prototypes, but I lost my way around the arch/
subdirectory a bit. I'm not always quite sure what should or could be
included where, or whether a new header should be added instead, etc.,
so it wasn't going as quickly as I'd hoped.

Do you perhaps already have plans or, better yet, patches to address
this? Feels like it should be fairly quick for someone familiar with the
arch/um codebase.


BR,
Jani.


[1] https://lore.kernel.org/r/170963008487.503981.6735326012843985651@8e613ede5ea5



-- 
Jani Nikula, Intel

