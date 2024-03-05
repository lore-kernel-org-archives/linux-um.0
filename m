Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085BFC54798
	for <linux-um@archiver.kernel.org>; Tue,  5 Mar 2024 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1yKYMtmdDbZPI6Evb2gqvFC2vUD/IFp5jq1YhO6Oc+Y=; b=0HKHD0wEiVkzh9OFiKgONWfV0K
	v8EHPXYzVOl41jBQPwui3Sn1pIsvHHWCekPdq1umNyokRYNTBRRSV7tFL1CF6/v4L674VIhP34wq/
	eewXkSv8gOwqfKd8OhPeR0wczBqxJF8A2SICYzaMzU1rhO1y8VtchVZ+O7MUYZUrKBRH1tkaeC7aS
	etMjr8uy4OTRAD8RZOyEg+pXO3a3BdgI0kQNt00YU7pwfcTpV0QYCqLlgZdeAFOSGnYhFAN58aIL4
	jpnhr2pnmIkiSq+OnruCthf4Z7nrVdz/faiGu/SUYbukLs7QWNnRblc4tYSr8Vl5DljpPELjCwAGm
	x3RzwuCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhV7L-0000000DsZY-3o5C;
	Tue, 05 Mar 2024 13:46:03 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhV7I-0000000DsYA-39xa
	for linux-um@lists.infradead.org;
	Tue, 05 Mar 2024 13:46:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709646361; x=1741182361;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9FYfbdaMxKGMXj+xYpy1/eVZZHsqi5THnS3dzKG2Y8E=;
  b=KLKC5atenGJS6MckHprieZkdoXHUWRXgoaSqJ9E+KGTezu3alWYAPWrr
   8gZ3RRNRVSwtEoT+HpyjXL7MKwa7bNDXtDcgTjfgMDa1au1UdBf/y0/8h
   XVIIz08bOHQ0OCYHlz7EX0Usu5+IWGXTVqmjwfmDyqciKMVoJ0nk7jQF3
   vhhdB7CFoOfQlfVTrO9uaE1nroB1pjdiY+bJla388v4qZnmc6V2VcaV+n
   zx2HzBKO0jh3Pcw7jhv7xYgc2vI/vN5VQVebPly+U7gG/c56MMPjzKP+D
   t4HF/gA6d8MOIgTVXpESiORw5ki1VTfm9Q8Zl6GVkJbAT7X9t4QKulvAQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4055537"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4055537"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 05:45:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="40374085"
Received: from omakhlou-mobl4.amr.corp.intel.com (HELO localhost) ([10.252.51.143])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 05:45:56 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Tiwei Bie <tiwei.btw@antgroup.com>, Johannes Berg
 <johannes@sipsolutions.net>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: intel-xe@lists.freedesktop.org, Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: -Wmissing-prototypes warnings in user-mode linux
In-Reply-To: <9d297bf5-4f54-431b-ab8d-c5be825f129e@antgroup.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <87jzmh2chs.fsf@intel.com>
 <5d1dfb9fce5d7647ff3203080416eadc9806059a.camel@sipsolutions.net>
 <87frx52btl.fsf@intel.com>
 <9d297bf5-4f54-431b-ab8d-c5be825f129e@antgroup.com>
Date: Tue, 05 Mar 2024 15:45:52 +0200
Message-ID: <87y1aw23n3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_054600_892352_F8998A7F 
X-CRM114-Status: UNSURE (   9.65  )
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

On Tue, 05 Mar 2024, Tiwei Bie <tiwei.btw@antgroup.com> wrote:
> Thanks for raising this topic!                            
>                                                               
> Indeed. To make it easier to review, the current series only addressed
> the -Wmissing-prototypes warnings that can be fixed straightforwardly (e.g.
> by turning into static functions or including missing headers). The remaining 
> -Wmissing-prototypes warnings mainly fall into the following categories:
>
> - Symbols defined and used in os-Linux/;                
> - Symbols defined in os-Linux/, but declared in kernel headers;
> - Symbols defined in individual files and not called explicitly;
>
> My plan was to fix the remaining warnings in followup series. Ultimately,
> I wish we can let cc treat -Wmissing-prototypes warnings as errors.

Yay! That's good to hear.

If you want to get build testing from our CI, using our configs, please
just Cc: intel-xe@lists.freedesktop.org when sending the patches. You'll
get the results in reply.


Thanks,
Jani.

-- 
Jani Nikula, Intel

