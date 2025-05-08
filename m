Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E5DC3ABC0
	for <linux-um@archiver.kernel.org>; Thu,  8 May 2025 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KHa5c35HdAD0qNDbzT5wyTDWI1+GDda8knYyNyxLCAI=; b=ED4UVhkBzDYXdlv4UrIAsGPwHc
	q5CoDI8pV6B2I8vTAo2mdth6D4r/Smm0vXgER9hMa6hXzvqgSEi1PO6eElAI5hhRNgOxrC1M/VDAB
	a7xzskI7VYA4YCo/FfxA0wvwsYhMz789Bg7q5hra4HO3bY7LNCVAbTveFIHraL4o+sfmivDNBU68n
	x6ARliZrKUZPpcGCHgPqhXaJET1EcUbTfIz87u7wF8mkyB+91AiIc+p9WbJtNQsT6m25rmTmrPsi4
	86vN5FmbK0HCXBv5xUC6B/tl6qSbJs246FEosOqLTZrmdGiv1m8O4gZExQioAaDooWIe0nqBxL00V
	IFqLezXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCxUP-00000000FYz-323M;
	Thu, 08 May 2025 09:24:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCxAE-00000000CUw-1h1f
	for linux-um@lists.infradead.org;
	Thu, 08 May 2025 09:03:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A343C445EC;
	Thu,  8 May 2025 09:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF01DC4CEE7;
	Thu,  8 May 2025 09:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746695013;
	bh=krItT6I4bxFVehf1B+09My7y/ZbPSgpXJkTUMpmp9Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpAHxus9YaUrH3sVmSVbztk3AagG0wXcH15swk6a1k/LZ+fID8F4YVOpU9FOylaNu
	 0aB2ZcVoqtXtJ8h/0rSlaJIWeidpPIEH/c9TaB6Zx51/lNc+hxOee6DlDxREk6qI3t
	 YHyWjqe2unQ+C9YKERvg59Dr0RkPgKsJkg2FH73VxfDDpl0OlRqc+Wt4jD0fYeZR/t
	 OHFWuJhbtFLsD4aLmILTlvBuuRIl4sGldrc81SCHTe7knekzE+A3aofaiu4yowW96z
	 n94bnkQEeTUbjLlACl/FWA0m5O738D+xIy7eGe33jtxcacdrhYfMYkFoiK8f5jy9uu
	 u0TVNBad/4tlw==
Date: Thu, 8 May 2025 11:03:29 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	lkp <lkp@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH -v2] accel/habanalabs: Don't build the driver on UML
Message-ID: <aBxzYZoPyATllU9c@gmail.com>
References: <202505080003.0t7ewxGp-lkp@intel.com>
 <174664324585.406.10812098910624084030.tip-bot2@tip-bot2>
 <007a7132d1396912b1381e96cc4401a10071ed24.camel@sipsolutions.net>
 <aBxyDyVT5QbOlhPq@gmail.com>
 <709b486f4cfb93e0feac12300e4f06a34f49fd27.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <709b486f4cfb93e0feac12300e4f06a34f49fd27.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_020336_371159_730DE33F 
X-CRM114-Status: GOOD (  14.25  )
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


* Johannes Berg <johannes@sipsolutions.net> wrote:

> On Thu, 2025-05-08 at 10:57 +0200, Ingo Molnar wrote:
> > > 
> > > I dunno. I guess we can put rdtsc() into UML on x86 as I suggested about
> > > the file placement, or we can also just fix the Kconfig there.
> > 
> > The Kconfig solution looks much simpler to me too :)
> > 
> > Patch attached, does this look good to you?
> 
> Yeah looks good to me. Common gotcha really.
> 
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Thanks, applied to tip:x86/msr.

> If anyone _really_ needs to have this driver built on UML (say for 
> simulations/testing, we do build iwlwifi for all the time), then 
> they'd probably want to replace the rdtsc() anyway with something 
> else there.

Yeah.

	Ingo

