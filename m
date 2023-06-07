Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9136CC7EE2E
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 09:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X07sdBmgXiy3paf3yw4BIhADpjaj28FoWbLyJIPPWXo=; b=Bi8QPeKCqp/wO/
	i9OeITTHZCViuE76As2AKp+6cn5gNzBerA+K8Z9dUXCvrUipD49HwmPIQd4Bwp0zbBp+QASr91lTS
	sZ3tNia7hOpn38visU6NmeOKOkjH30zlg8QN7R0kXJ7JKm1MALXnykmgE1hIi46K+P8tnIhoKHqRA
	xxHQOAMHkSAr3qGWhVhcmZlYjtWoeoo6voThz77Wq2A2ObBAMD6R/oOHYV2GbZUjIF4PiofTyvLzC
	5sAzE0PZvYBs7txaFKiRstqeTevmPvrR3HGPEGQyEE1QtSfxHjWsw19iUL4P6u4TERAbKrFo7C1RI
	o96+KT6yje32UBSCnv0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6phT-005J79-0I;
	Wed, 07 Jun 2023 09:43:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6phQ-005J44-19
	for linux-um@lists.infradead.org;
	Wed, 07 Jun 2023 09:43:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=971JyQHlSoBOmn1o9U++qoGOP5XyVYimVV+hx5poVjw=;
	t=1686131005; x=1687340605; b=dZOYhasn+QZKZkSa/SKX/u0OT4sk0LR10jHgR0wdUGG1WgN
	f+d5pKibEBvJToyxDe7T7aTUcIcEEOir8qcpwKSyzRERI88ZUhsOnMtLU4Owe1sLathkYF1ajPRc/
	SipNlXw9jRkP20AK1kaUUc1S40rw7nS1CSc8TGj3SkexM+KprKL6NivKDtYGAFUGWLmZsfiNu2ZVl
	x5eNlb0s03r/HE8b/Lmn6LJUKFf7y/6LNhAfefEU4ihC0Xsz6bo0GlZzJQ7GAIrjS5ZZJfMldPDXH
	RUs34JWfux+zZC/wcWXkFQzL6AXuW1S6jmkmX2SawZhq9e1cKZyWtPemb/WO4GUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1q6phB-00GVI0-02;
	Wed, 07 Jun 2023 11:43:13 +0200
Message-ID: <4b1c8af737eb5bccba12883f32ec43f9f292f70f.camel@sipsolutions.net>
Subject: Re: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH
 v2] uml: Replace strlcpy with strscpy)
From: Johannes Berg <johannes@sipsolutions.net>
To: Philip Li <philip.li@intel.com>
Cc: Richard Weinberger <richard@nod.at>, Eric Biggers <ebiggers@kernel.org>,
  Azeem Shaikh <azeemshaikh38@gmail.com>, Maxim Krasnyansky
 <maxk@qti.qualcomm.com>, anton ivanov <anton.ivanov@cambridgegreys.com>,
 linux-hardening <linux-hardening@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>,  linux-um <linux-um@lists.infradead.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, kernel test robot <lkp@intel.com>
Date: Wed, 07 Jun 2023 11:43:11 +0200
In-Reply-To: <ZIBQWytL3zhWFLgd@rli9-mobl>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
	 <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
	 <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
	 <20230607042340.GA941@sol.localdomain>
	 <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
	 <2092891129.3692555.1686126895090.JavaMail.zimbra@nod.at>
	 <ZIBJadzmheKWCErq@rli9-mobl>
	 <a953b19efca20b470759b1d53beb957a11062ba1.camel@sipsolutions.net>
	 <ZIBQWytL3zhWFLgd@rli9-mobl>
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_024328_399281_C07F5EE6 
X-CRM114-Status: GOOD (  10.53  )
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

On Wed, 2023-06-07 at 17:39 +0800, Philip Li wrote:
> 
> Is that ok we just take this phrase as a quick improvement for first step, which
> is
> 
> "If you fix the issue in a separate patch/commit (i.e. not just a new
> version of the same patch/commit), kindly add following tags:"
> 
> This could help remind for most cases if not all. Also this allows us
> not doing "complex" judgement by the bot itself.

Sure, feel free. But yeah, that was the idea, that the decision logic
wouldn't really need to be in the bot, that feels very difficult.

Maybe someone else on the thread will have a better suggestion :)


johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
