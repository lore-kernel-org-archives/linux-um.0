Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8C1C001DF
	for <linux-um@archiver.kernel.org>; Mon, 24 Jul 2023 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5ntFZqVd33+5xeGbpzPBRWFrqXEsWtdW9xhNtlp4KUw=; b=sDFYZGsv17wZzN
	ykpBFEcVJYxe2wh09X1TbSnYxMtU+l++XHlbVKwNk9gkzICvE/tuZbx/rXSgzRRVYbS37XdnbAdLH
	d/06iKmMvipsvnP6vJ0jiVmuAnpsu7WNo1GIzp7k3srfogsVedqzqNWde1UjlUcF4koQz4WE8F4zG
	cD06nb0SGeyYBz01darGUBqZhx7BuKWRwVcpuZ+U8atzmIUgPjg4Zbr2W2m/w2X0CXJSQWXY6xDxS
	ktzLX5j7i+Beu940vIsDc4lVPIJds6aHWYyJkygPK0OKGIyRECIJ59AHw1Q2y3yaGsbDODEbxExux
	zts+BG0RhLLrBY61mY3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNwbt-004cIv-0e;
	Mon, 24 Jul 2023 14:32:29 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNwbq-004cIC-2c
	for linux-um@lists.infradead.org;
	Mon, 24 Jul 2023 14:32:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690209146; x=1721745146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2/7McPeueNkR5CKjfh+1JkwAc43EdhYfRO57egeVcAM=;
  b=hcC5oYlZFsDJnLhGbyYFtp2RNdwPfKXgMV7j1Fy8mn8g3xf5WXgjxU7i
   OvfVIZrXNfvwsfQUcPYtFtr7jLvLQiDUUmS5Hgf3ZYpgUVWSt4a2OVeLJ
   /ZMPE2nr8E59wtdxnzElnReYCkkMy+LyMrOP7VSLRJpkcLz1hqpCzuh5+
   yeWYTDARqKoqpecgEKEZavjDz8M5EVN52ecTvjKa3+ADs7JxX8rTw44t2
   M0vL1DxQn1mouejak+poAzVovl4S22Dk7bV5b38P0hHUrq1milQP1/jAg
   7qjxF60eXJFPhkjOeUhbs5yZ8U0gXyhPPp/o8f7MZIbDFqo7+aT4MnAfy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398363213"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398363213"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 07:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="790986953"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="790986953"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2023 07:32:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qNwbS-00H4oV-2M;
	Mon, 24 Jul 2023 17:32:02 +0300
Date: Mon, 24 Jul 2023 17:32:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Yang Guang <yang.guang5@zte.com.cn>
Subject: Re: [PATCH v1 1/1] Revert "um: Use swap() to make code cleaner"
Message-ID: <ZL6LYvUpuRtwmWXZ@smile.fi.intel.com>
References: <20230724142307.28411-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230724142307.28411-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_073226_872448_AF6BBB89 
X-CRM114-Status: GOOD (  12.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, Jul 24, 2023 at 05:23:07PM +0300, Andy Shevchenko wrote:
> This reverts commit 9b0da3f22307af693be80f5d3a89dc4c7f360a85.
> 
> The sigio.h is clearly user space code which is handled by

Should be .c

> arch/um/scripts/Makefile.rules (see USER_OBJS rule).
> 
> The above mentioned commit simply broke this agreement,
> we may not use Linux kernel internal headers in them without
> thorough thinking.
> 
> Hence, revert the wrong commit.

Missing Reported-by

> Closes: https://lore.kernel.org/oe-kbuild-all/202307212304.cH79zJp1-lkp@intel.com/

I have just sent a v2: https://lore.kernel.org/r/20230724143131.30090-1-andriy.shevchenko@linux.intel.com.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
