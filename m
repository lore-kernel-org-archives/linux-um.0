Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CBCE77197
	for <linux-um@archiver.kernel.org>; Tue,  7 Jan 2025 21:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F0W0PeuiyfBVSBBJFcPSxl1EJHKd/sfkxZP/U8feEIc=; b=0cpU+Nj8v70NuMRMGn0nTX82OV
	5fqMGqMMFJ7oBk2oDj0SWB07WPdIrs8LLErwbTkvTCKNPRl2eAyvX+5qFMPWjWu/q2nr1OVExpD/K
	MFMNr4iXUlcmqGI6PM9K3tizNdGRioCXzrCARokGEAvV0FL/Q8nDCnlIExoiPyAYWupnCpjAcUG1l
	Gu2qAo8XPwwTd8q4Ggzw4RVCVZj/wM/zg18fOWOMygcbpEfYl9q9ixks59uxdaJXlZVqBDFFS2RFw
	V5Ok0dv95ySwRDX5KcDBXcTrRabCIp6ujfnnwYifADrofgy4yGF5iNqFiel+o89yZQl6htXYeHpmj
	Hlc5BWRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVGo2-00000006IfI-1wIt;
	Tue, 07 Jan 2025 21:08:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVGo0-00000006Ieq-0Atm
	for linux-um@lists.infradead.org;
	Tue, 07 Jan 2025 21:08:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 455255C42B7;
	Tue,  7 Jan 2025 21:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE716C4CED6;
	Tue,  7 Jan 2025 21:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736284082;
	bh=FsQ9rVojwWSNItZQx3DH9iKfZiN5ugoQFXCHmx/YGs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahYA9h4/5faYWYask1/nxKmAo5pgfhc6McbePC0zE/yH7diy68r2ySjtzFjIRM6+H
	 PcpNp6dvXy4s4ZZRU6aAEEJKCl06Durs6E9t6YOP3Xr2xZfOYp0XcOFVh8TMUJPUJJ
	 JV9CUye45CTcLdYlWtQKHgKDAabz0MvYwWhNQBf92o0m0i27SI+qa1GnKvWCUYyc54
	 R0vyiOdQQaaQkMOlU0fJhenifxe0RGCRF8XLo+GPfEAg0WhmaQadyxJp7aLYBuxXBR
	 T+7wly1ZSgnRrG1wDYU75zQQsgf4BL4R/eF1x5J4m6XhtEDpoNs6L7oYOq1DR1ih5Q
	 aXcASeqiamoMA==
From: SeongJae Park <sj@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: SeongJae Park <sj@kernel.org>,
	linux-um@lists.infradead.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH] um: add back support for FXSAVE registers
Date: Tue,  7 Jan 2025 13:07:58 -0800
Message-Id: <20250107210758.80762-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204074827.1582917-1-benjamin@sipsolutions.net>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_130804_124450_0CE8ECDC 
X-CRM114-Status: GOOD (  13.32  )
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

Hello,

On Wed, 4 Dec 2024 08:48:27 +0100 Benjamin Berg <benjamin@sipsolutions.net> wrote:

> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> It was reported that qemu may not enable the XSTATE CPU extension, which
> is a requirement after commit 3f17fed21491 ("um: switch to regset API
> and depend on XSTATE"). Add a fallback to use FXSAVE (FP registers on
> x86_64 and XFP on i386) which is just a shorter version of the same
> data. The only difference is that the XSTATE magic should not be set in
> the signal frame.
> 
> Note that this still drops support for the older i386 FP register layout
> as supporting this would require more backward compatibility to build a
> correct signal frame.
> 
> Fixes: 3f17fed21491 ("um: switch to regset API and depend on XSTATE")
> Reported-by: SeongJae Park <sj@kernel.org>
> Closes: https://lore.kernel.org/r/20241203070218.240797-1-sj@kernel.org
> Tested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Seems this patch is not yet merged into uml/next or uml/fixes.  May I ask the
timeline or blockers for this patch?


Thanks,
SJ

[...]

