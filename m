Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B90C531F9
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 06:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EgJ7WGmLghzBHWuXRFX7MDf35xLvpeCrf+L63h4agAs=; b=IWDJLX7xAuRBZduOS6FpCNgKOW
	AS9BXdlrmCB5TP3gm44jaDaI6Y/eZv9LW2TqZudFNxNjbqtij5BAjC0NIk4KCmK745SppmW9JyeCx
	Il/0S51FzidOagBMFnSYnRr5T7F2eteg3KbWOH4A8Ozgt3spQI6sA199qkdTD+gSW3HAXba9N1HvU
	bpjLSRSAVRcpHeVjJ5ipKa86O1bSETFuNUb1B16BB6nrzARQLEGg0avuiGweJfZNvZ5mXRHIYn24i
	7zv5oygP27SfryV8JWOmcgitam9m+/WMzQU4AhCn/Q0mxD/v9RfIYs2HcZIkJU/wXD4Vb/AQ8Cvpy
	4MZ0v4hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9nI-0000000Fdq8-0jWS;
	Fri, 24 Jul 2026 06:54:04 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9nF-0000000Fdpk-1RSd
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 06:54:02 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2cf50c6f235so1526185ad.0
        for <linux-um@lists.infradead.org>; Thu, 23 Jul 2026 23:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784876040; x=1785480840; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EgJ7WGmLghzBHWuXRFX7MDf35xLvpeCrf+L63h4agAs=;
        b=cyTqfOaoRk6vxWe28VpLqOqg1hwoHZQG0e6atlecohTHiBI+heoUXjwRIbytvZ44wS
         EbXLPpkZsd4r/ViCuTAYCSnloxMl5TiJLQnR1+hGMIUNbMh5q2WA7CJt7uUuSahM5ITY
         +d07sh3DvcttCEKLI8gwk0t2Scs8vjy6O0ohO0PpKZ++go//m5hs6lJgn3gzpY2sMnq8
         KylwZCjzWRYWURAxuSw+XZBr3iNERmBuKskaa6XR3IBQklpZuEft7W7cK3lKGA95DHPW
         +Jsv03xqaqXPhJ1Nb/rg//Qp7g9S3JCxTw4Ry559yYTTca5O/nkI/B2SQ18dn5RdgeFu
         W84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784876040; x=1785480840;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EgJ7WGmLghzBHWuXRFX7MDf35xLvpeCrf+L63h4agAs=;
        b=KQjQnXF6DENejisWlt7uPi7Th4whc8zWr2ViHBkecSgSbrT4YzgYuSCmfZ0RYEKrXg
         hMW4TlLHxafeof+lVdc3mWoNkPLqitSvAXCTMf9kVmWLpqo2cAq8Z/OJpa2pnfxYm74G
         febGiw8Jls2UR5/IMM4hbSQgsZFcu+eQudTAAUHMvQxP/u6cPfgPaH+aGaFCEjApS9D9
         dFk7PYn+0YHdnDKuT9+W3105uif+ijkRE0hb83Qwc6Zm//FkMqXDqAxIs/bCTosgn59p
         sBC9Bnwz7ftwjA/xK6uQQydIZ0MqkjEG4N7Dhqf9KmXe22PqJPbLR+8bWD5WJAAm6AUY
         RI4g==
X-Gm-Message-State: AOJu0YyJHKIxPQXt2zcymRFDEYIcF3LtVWIbCJgN2/LbUu8jdtfqpxxH
	bKsrK3zZtyg4e/cMDQTNDC6tu2KHeRr5xcyQl+ZbMnZ55y61A8fSTMFAkuLVuQ==
X-Gm-Gg: AR+sD10fOcl8AxTjYU12AZCKPT3Fdn96gFe6G9NOXbloFGZ10f2Wis+r1HPs/kg24Xk
	5r4/O4nhFzN8+LkGVskWs9llcKz9AuXUWRxDtio9ks44+AGq2bdNx1Yn6CQO2w9I6qWrvIG5OcJ
	hLNgAg3DGVEiiWbJB3qfm/cUJYu/p4kTaQuJ/zeSuFuXIliRChgrNUReXtLRoXct8+7fMrlFodJ
	fy6ZxjHfOIHLBbdxvGyrkhQ51U73/4Dcf69KXCuhMfpfYuAJpq0wDCk3A5efixAbTaDnnwHlkSG
	/xGCnHjz7BLzbWMAjTVANIAM7Rk2z1fpATJyQoQEYygRJXBGDUvb3rh/f+O0Cv50hw45xKch6JK
	hYF/+R4Q8CnLhx0saA10lveKzy9EGSVkaxXYY8mqPpuo+CKXeIabzZmqQ4wvKxX0SKouFzyVwOi
	lH7IboI1Vop1GNVWO16TDFc62ceFRiAUxBLiIdNL8HQJIMdcALX0vZFdb6/8+ycI71NCoyp2aU8
	o0Bxwk6qZExXG3HqUKC
X-Received: by 2002:a17:903:f8b:b0:2c8:4c29:afeb with SMTP id d9443c01a7336-2cfa730e98amr70411855ad.8.1784876040088;
        Thu, 23 Jul 2026 23:54:00 -0700 (PDT)
Received: from jupiter.local.gmail.com (179.62.31.150.dy.iij4u.or.jp. [150.31.62.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f350560sm46337545ad.68.2026.07.23.23.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 23:53:59 -0700 (PDT)
Date: Fri, 24 Jul 2026 15:53:55 +0900
Message-ID: <m1cxwc98u4.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	liam@infradead.org,
	ljs@kernel.org,
	ricarkol@google.com
Subject: Re: [PATCH v2 10/10] Documentation: um: document nommu UML
In-Reply-To: <d3df4236387840a77c74de7cb006771897a0ac68.camel@sipsolutions.net>
References: <20260723093633.140989-12-johannes@sipsolutions.net>
	<20260723113633.19c6669dc151.Ibd7a532eef856a1ea39699a263dfa8a9ded9dc20@changeid>
	<m1fr189ael.wl-thehajime@gmail.com>
	<d3df4236387840a77c74de7cb006771897a0ac68.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_235401_390655_589C54A9 
X-CRM114-Status: GOOD (  27.54  )
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


On Fri, 24 Jul 2026 15:49:08 +0900,
Johannes Berg wrote:
> 
> On Fri, 2026-07-24 at 15:20 +0900, Hajime Tazaki wrote:
> > > UML models this with
> > > +a **userspace runner** - an ordinary uml-userspace stub host process, started
> > > +exactly like an MMU userspace process, but with the whole of "physical" memory
> > > +(the physmem file) mapped into it at the kernel's addresses:
> > > +
> > > +- The runner ``exec()``'s the stub just like the MMU case.  The only extra step
> > > +  is that, once it is up, the kernel maps the entire physmem file into it in one
> > > +  go, at the same addresses the kernel uses.
> > > +- Because NOMMU never remaps, that single mapping is all a runner ever needs:
> > 
> > I was actually not sure what you mean here: "NOMMU never remaps".
> > could you care to elaborate ?
> > the subsequent parts are clear to me.
> 
> Yeah maybe, that's a bit cryptic. I mean, we have an MMU-less base
> kernel, so there's never any request to remap for anything, so
> 
> > > +  there is no per-mm host process, no TLB sync and no ``mmap()`` of individual
> > > +  page-table entries into a child.  Userspace code and data - placed in memory
> > > +  by the loader - are directly executable and accessible.
> 
> the original mapping that we make into that process is left alone
> forever. The map machinery in the stub is used only exactly once.

make sense to me, thanks.

> > For the alpine packages, I'll contact the distribution once this UML
> > is upstreamed.  And update this part with more proper information
> > rather than my personal repository.
> 
> Sure. It seemed far simpler to point to it than to try to have
> instructions on how to build it (I didn't even try), and I'm assuming
> you don't plan to remove it :)

I will keep this image location but using version number will easily
outdate while it's useful to present a snapshot for users.

-- Hajime



