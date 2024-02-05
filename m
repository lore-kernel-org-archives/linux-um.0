Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACE3C48297
	for <linux-um@archiver.kernel.org>; Mon,  5 Feb 2024 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bB5gRzK7YHzgVRxGpxNgOVf4O6/K7swad2ToV5RJYSk=; b=DHdTEKPqJlXpw3+Wg1VYYSsmc2
	IeLFU6HxjsihlQyQykeWqJqSUnXklbsfvhnaYA1Bzg8XyDuvqm8+jofirCJWbk0VfNkkGgzbDRk6B
	FaPNwEB2ADTfOhdkEwTWIP+LMfnewBwA/E6aCkAPtxLIS5yTd/oFJ9hWiARQjpELrclYV5tyOq0Qv
	OR5dVzv8F5/PqHQlUWzEHuppFtOkJHHM5pPtyeosVSS+yAjvjtZfK5ZEnb1CNQcbFwJYra4OPZX05
	DTwZUbP4mxRwljSdzdTbvbqQHSRAvxw9Vq+Jxo29LcGeombhXfMGT7TGQZTAjqBtYNoPfPHFHo2W/
	D/RywyVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWz9Y-00000003RgA-3GKA;
	Mon, 05 Feb 2024 13:36:52 +0000
Received: from mgamail.intel.com ([198.175.65.20])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWz9V-00000003ReM-34T9
	for linux-um@lists.infradead.org;
	Mon, 05 Feb 2024 13:36:50 +0000
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="429087"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="429087"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:36:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909299407"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909299407"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:36:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rWyX4-000000024e4-2Lle;
	Mon, 05 Feb 2024 14:57:06 +0200
Date: Mon, 5 Feb 2024 14:57:06 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Justin Stitt <justinstitt@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 3/4] string: Allow 2-argument strscpy_pad()
Message-ID: <ZcDbIleAJcipUk5E@smile.fi.intel.com>
References: <20240205122916.it.909-kees@kernel.org>
 <20240205123525.1379299-3-keescook@chromium.org>
 <CAMuHMdXnW0ycz4y0m6d2yb_cAB4pjLmpveVBnL4sLNATtm388A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXnW0ycz4y0m6d2yb_cAB4pjLmpveVBnL4sLNATtm388A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_053649_834117_27E661AE 
X-CRM114-Status: GOOD (  10.03  )
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

On Mon, Feb 05, 2024 at 01:48:51PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 5, 2024 at 1:36 PM Kees Cook <keescook@chromium.org> wrote:

...

> > +#define __strscpy_pad1(dst, src, size) sized_strscpy_pad(dst, src, size)
> 
> (dst) etc.

Makes a little sense here. Are you expecting, e.g., dst to be 'a, b' (w/o
quotes where a and b are expressions)?

...

> > +#define strscpy_pad(dst, src, ...)     \
> > +       CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
> 
> Likewise,

Ditto.

-- 
With Best Regards,
Andy Shevchenko



