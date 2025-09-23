Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CA7CAC5A5
	for <linux-um@archiver.kernel.org>; Tue, 23 Sep 2025 23:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gWOszAue/Nmd8O/Dpr4OL3qdoKFLGIalj3bb3gHaSE0=; b=Z67fsGn+PAKF7fjfwAsckEp/2O
	yg8NDZwlo6cAydSBojKINT1FAKFJ62fEyAz/xxrUMeCQygwXwaPC0ecH/vHcJfKlNAk2VW3mjmDXi
	tU8/psTdeR4xMLhpTpw/wm7P5Lwk7GPhK0jBcwdCWfBDav5DJkJVRktL7wD2frBGm9tFy3sDg5hIE
	0ydloBdgMKiOHTojkl+t+PWWPff76NXxWeSzyfAl9/CC5AGHlmSoUR66Sn3FLZVrC4N1UGk+68uub
	Lyvxi0T/I5RaUnVw9Ih1THavzMb6bJXgUn4HccnWbrvDH26a31pN9RNoiFQuzHUAzsjzGISoEe3uw
	ff76iwRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1CuO-0000000FBTS-1UAs;
	Tue, 23 Sep 2025 23:58:56 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1CuL-0000000FBSf-1Dv5
	for linux-um@lists.infradead.org;
	Tue, 23 Sep 2025 23:58:54 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-77f2c7ba550so2977095b3a.1
        for <linux-um@lists.infradead.org>; Tue, 23 Sep 2025 16:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758671932; x=1759276732; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWOszAue/Nmd8O/Dpr4OL3qdoKFLGIalj3bb3gHaSE0=;
        b=ledUdTddbrK16vDL9PiD7n+dPAvcXke77h2HGK205BKVcRhzCtVAumy9sTfXl3GiUG
         LLtJXveI67yBDKvik1BlB3AP6GYnwNpd6QIgZMx68LtwE7kiwgU8SXEVfolfiJ5rn3p9
         YmJcElek6M0fTqqLOMRsdOD0x11C73fpMlMeYqjXycMtFRY1//YgoOrKQsgryb4WDo2j
         IcbBRcebiCA+5AAVv0oHS60b/D1ngJ0wAjCY4f8hOS/XrH0ucwTg42R67hH3kkwD1nH2
         LZ5al2+SDwpQ09I9IMdPSR+vuopxG/10wIWJqIAXtDSoVqW0Od5r26qQKABTtzbDA8n0
         fqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758671932; x=1759276732;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWOszAue/Nmd8O/Dpr4OL3qdoKFLGIalj3bb3gHaSE0=;
        b=jONYrkuieEeyCj0R6deL1+fwa+JfW4lrCgWqG2SVfOHoIohbMPkMTWahq3L/ktm15V
         k3Auwre5yyT2h6oyL/1j+16csa84EIlpIEnnWTokwLRBeEIHvqJwftosCroC67FAM77g
         n9oMFamYGSYEWT4Kr4kO7PYwa6w4vYbvHq5Y3Qqus/7h5vIH468//Ct25IwJgKjubMKI
         U8ffR+PnQeW1rXC6i/WILRMITbYuPZcbaX0ugJRbiknvjswN7EhYZK49AlQZA7FUeMWa
         HOJ0un+RD5wPCyoIfNhgDmkSwXZLA/Cbgt17EOuDCv23lDdZ53mcC8sWJu5mZ53yj+9w
         pMlw==
X-Forwarded-Encrypted: i=1; AJvYcCWLqGKI00mFPN7va7eOZUMxtg0S1fK6w4WwEh5C4D4sUtCgnRIEKqUMARtyxMOpJ2TVl4Kw7Y6xlw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyjAlYWm4XINKz3WABOHSNZ6RviLRfe2JBZeqyAqg9rJVfYdfm8
	OC8wSc8o4IO6HrROWdaL/c+DC1ZEeXK2mJYZVi1fyocA1BEqKEWo9sXUQL2MPqGTavY=
X-Gm-Gg: ASbGnctnQCJjCh8W/oWEBJ1gj+0RLxlirOe4pcLZD+ccbLCCLI8zL64u7LfPLUK0bnH
	mBpcZEfMrnj1Zt1RX/WcaTBsfLp+sQ8HcnMDPYxP/8FblF/Q/VUGzxi7SgSWZXl7lnUkQwxAZne
	m/CFlsUnagH3pN8ei/nwZT/sgpOwdTrVvvYNUCJp885vEQ6uIRgkoc4xTLHXHHhhTDHTKUSjcNS
	XbKEjkE08Yh0UlFnCdl0sjcGk5/puvVwprNwYary4OPYuuIZENqQ/sJXcrY8uO9bc8iNgPspl0V
	KccHUHxfqyG8u6oryeRmYwg7o1/HMUU9IwlL7cTTuTv2ZDnVs7ub1hp6Q17FkW82W3+RfvZcChl
	/CzBStzQkGBolX8JPna8T9Uu+XqkDhcil24t2weD2vTggUkhWvqJC5jMF+cImyhP1HEXNVq+YBA
	g1VQveqk/M
X-Google-Smtp-Source: AGHT+IHfgNxvq5qCprtDBrZ2VNj7itGZH/QNHmXUVetkRVxp714PAaGhNh9xYeZI8JvzviTCjhbang==
X-Received: by 2002:a05:6a20:6a0c:b0:2ce:1b57:3701 with SMTP id adf61e73a8af0-2cff71fe6camr6132609637.28.1758671932351;
        Tue, 23 Sep 2025 16:58:52 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f613dbc5csm1372022b3a.59.2025.09.23.16.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 16:58:51 -0700 (PDT)
Date: Wed, 24 Sep 2025 08:58:47 +0900
Message-ID: <m2y0q47mbs.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: hch@infradead.org,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org,
	w@1wt.eu,
	linux@weissschuh.net,
	linux-kselftest@vger.kernel.org,
	acme@redhat.com,
	linux-kernel@vger.kernel.org,
	benjamin.berg@intel.com
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
In-Reply-To: <4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	<aM15eChUObXfxLzs@infradead.org>
	<4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_165853_333428_30CA839C 
X-CRM114-Status: GOOD (  22.60  )
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


Hello Benjamin, Johannes,

On Mon, 22 Sep 2025 16:41:36 +0900,
Johannes Berg wrote:
> 
> On Fri, 2025-09-19 at 08:40 -0700, Christoph Hellwig wrote:
> > On Fri, Sep 19, 2025 at 05:34:09PM +0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > This patchset is an attempt to start a nolibc port of UML.
> > 
> > It would be useful to explain why that is desirable.
> 
> Agree, it should be here, but FWIW it's been discussed elsewhere on the
> linux-um list in the past and basically there are various issues around
> it. Off the top of my head:
>  - glibc enabling new features such as rseq that interact badly with how
>    UML manages memory (there were fixes for this, it worked sometimes
>    and sometimes not)
>  - allocation placement for TLS is problematic (see the SMP series)
>  - it's (too) easy to accidentally call glibc functions that require
>    huge amounts of stack space
> 
> There are probably other reasons, but the mixed nature of UML being both
> kernel and "hypervisor" code in a single place doesn't mix well with
> glibc.

just curious

- are those issues not happening in other libc implementation ? (e.g.,
  musl-libc)
- same question to nolibc: is there any possibility that nolibc will
  evolve as glibc does, and this evolution introduces the UML issues ?

-- Hajime

