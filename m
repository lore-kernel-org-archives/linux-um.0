Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0D3C4828D
	for <linux-um@archiver.kernel.org>; Mon,  5 Feb 2024 12:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=16pfJG8Ao44Ai9FeuGvUaebUBv7e8Qfxw5HytfZxiYs=; b=aTY7+x+C3rqx7gEGbEuLZUhY6o
	zNVIq9emLNbLLEYIgYQrgqqA4vVC7Jizz3fev9SL/X/0ZC7lC7mRhqVGPxKapGQgsp7hOPnwy8L/s
	rsfETiGV5MlD6eFWlRseWxU3ZjevdhriRf6gKBJvj+QOxGs7UvcY3ltJwmvQ6pihWrIsHXZYLK+Nz
	A088Jszqu/jIhtbUr3+Z355M82cd6L/+aROAc3r6k/n9sRdeK6ANDlTo0XTa1FUPubviONiXHfnpm
	n0+aDJAcmZFWjzSMtBTTGV23gPVTd3M8rqgJCxYCdGb9cdya8qa9/bT8u84d62HJ4hS463GpIGIhK
	gUW8eFIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyYS-00000003KZ4-0gaJ;
	Mon, 05 Feb 2024 12:58:32 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWyYQ-00000003KYG-1RBN
	for linux-um@lists.infradead.org;
	Mon, 05 Feb 2024 12:58:31 +0000
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="406137"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="406137"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:58:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="933149291"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="933149291"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:58:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rWyYH-000000024fG-31Hx;
	Mon, 05 Feb 2024 14:58:21 +0200
Date: Mon, 5 Feb 2024 14:58:21 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 2/4] string: Allow 2-argument strscpy()
Message-ID: <ZcDbbUU0zCqhJ6It@smile.fi.intel.com>
References: <20240205122916.it.909-kees@kernel.org>
 <20240205123525.1379299-2-keescook@chromium.org>
 <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_045830_440679_ABA900F0 
X-CRM114-Status: UNSURE (   9.52  )
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

On Mon, Feb 05, 2024 at 01:47:08PM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 5, 2024 at 1:37 PM Kees Cook <keescook@chromium.org> wrote:

...

> > +#define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)
> 
> (dst), (src), (size) etc.

No need.

...

> > +#define strscpy(dst, src, ...) \
> > +       CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
> 
> Likewise

Likewise

-- 
With Best Regards,
Andy Shevchenko



