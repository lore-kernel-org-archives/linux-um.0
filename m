Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAC9C5DF66
	for <linux-um@archiver.kernel.org>; Mon, 17 Aug 2026 19:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+VUF7ClHIzAxSed6rdWYgpPYHD83ZO/w/ujAalOwtyI=; b=0A3+eZ7CllFVnH7CkUBdigIGgr
	oqJzbuSDF6vELELVwxl4xEmDNGJ6MvqssjSTOOaFJiTltkX21RmQgrkXpENryAdWTTzrTix0MBlF1
	KYMie7E/bcfgxGk4btEmyvXxw1o6e+iGZ1/bW7qGLq22x/SKHNuQVEbAeHKODz5UygGVv0M8Cub1A
	lQ4428FvziUhvIPmVksegnog5hvWbfCnFeBfZ2VEQlv1cVCiGkf0QTVTP1IeErNd9zYxUXg65c2H9
	36EWIeIfjJKtW9i/+pttTheBEsvldNG6C1ikJje4V48px5LYUxazZFnJOliMtGyAs0uzfZT+Hote+
	9rQIRonw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww2qm-00000006i8G-28WE;
	Mon, 17 Aug 2026 19:18:24 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww2qj-00000006i7s-1NDG
	for linux-um@lists.infradead.org;
	Mon, 17 Aug 2026 19:18:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786994301; x=1818530301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lbzjxMpmk0GXxJB/iLVlMyluggamXc2qIxngnzy+5wA=;
  b=mQr3hMnjg2Jdm4pn/vAD8klL2uBpCunG7HeVJfobvopbGMav51tbGlb5
   sK8vIFoGJoh1mxdVsQPb8Tt+m7pQLe7GoQqEI1CpKqCVr+cDQlaz1Uryn
   nT0k7eSTvx/Ok7uUMwCsiXRuwgyJLUefLqYJ4VJbIq+N5QJf/YKiLk3vT
   TI4dtX4OMIxbakgdbC4IAanqZrZMA5RFThDVo3zzSVldNf2M5QIInKvPu
   LCLQGiX7nDLA4PLUxgamC8MlKKTL6uZpPRmjI1p78CY0aKmaTqrnx8xxS
   vj5y9TSlxoDOcSFuJl+IYlzWYmutEFQsinv+f0dqSAZMnAsLoYGXoFF9r
   Q==;
X-CSE-ConnectionGUID: q9Y0JLVzQWGHj4czBwbrgw==
X-CSE-MsgGUID: RY4D+XX5RL2OZzRhS8vFLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87543994"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="87543994"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 12:18:20 -0700
X-CSE-ConnectionGUID: 8SHjbnmuRZiJuSwJPprAEg==
X-CSE-MsgGUID: vTiocIbETq6/qxbErWJdwA==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 12:18:18 -0700
Date: Mon, 17 Aug 2026 22:18:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v1 1/1] um: vector: Use %pM format specifier for MAC
 addresses
Message-ID: <aoNeeJL90rCZWS-F@ashevche-desk.local>
References: <20260603072958.107215-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603072958.107215-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_121821_406110_997F9782 
X-CRM114-Status: UNSURE (   6.16  )
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

On Wed, Jun 03, 2026 at 09:29:58AM +0200, Andy Shevchenko wrote:
> Convert to %pM instead of using custom code.

Any comments on this?

-- 
With Best Regards,
Andy Shevchenko



