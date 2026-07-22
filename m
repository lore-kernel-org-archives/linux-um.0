Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F208C4453A
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 21:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lWKGdUJK+uimazR3BfvsfjrUWidl968frY23CLZK8tM=; b=kUADsH5V3lIsKZNC33ST5UFE6k
	R+JNpikDGvQs7UPOVlfdyAkD6eP1fJ0mfV6kcPM9qcNPj1wbwY+QkpzxCJxkSSniDmezPnAmMSEQW
	/Nd3KfuAgaYWw8MnZAl2YLweWZJRJypb7SPMlSAhMVGyQrHdemZr2GbpvFcbNgt/2BBUC2vkyyaTn
	Zn+TOvCoGBYeoH1ZlG8wIofNaRJHmGyJNPSuVOGBvQiisGfQGP9LHc2mCoeQCf0t8RSE5sHTAr943
	3mVIZ6RnD5Kn6M/Q4rthDZMLlS9tv6XMV6azwVEDD03P0gxofObDwvZnAWga7JBlJiW8DjSVCDlxO
	oqnViGYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeJN-0000000CnVD-27lS;
	Wed, 22 Jul 2026 21:17:05 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeJL-0000000CnUl-0tBY
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 21:17:04 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-848643382fcso13951962b3a.1
        for <linux-um@lists.infradead.org>; Wed, 22 Jul 2026 14:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784755022; x=1785359822; darn=lists.infradead.org;
        h=content-type:mime-version:cbc:user-agent:references:in-reply-to
         :subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lWKGdUJK+uimazR3BfvsfjrUWidl968frY23CLZK8tM=;
        b=DqIAlQ/bWEcjrvgIvGlH/+ePszoaYn39vRJt1jye/PyNv4ShApjF/M0K/JAFRY+DKQ
         71rfmAldAXHqL/6qXePSX3AA9htQAlpWhdF5qeXj6Ok3katdxiDBbnfxnVifDF61FYiZ
         wcTiz9yov/DBgyx1VPFca7yvJld0KDZN6VY/A9t+GPNxkZ4jBVCsQZKVE+Gs7acOLeRy
         5AO7j2Uic98n5wPmIhVtx48um5MDF7WH20ptThAezve/HbQzZujOObOr/Im480TdR0Vv
         Z2bCm8iRNbrZjp+xKl4uBsOohM6QK6q4QO7b2wY9fHdWWM6iBAAAsCnMtpucnXK2s6vi
         kQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784755022; x=1785359822;
        h=content-type:mime-version:cbc:user-agent:references:in-reply-to
         :subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lWKGdUJK+uimazR3BfvsfjrUWidl968frY23CLZK8tM=;
        b=mqiYOBV7SzFSxrKZDGC0Y/BVe8kqBZa67l1mQG4MogbjCQK+K539fo4SLUzVfvtBXl
         U/z2lpj5Hnp4j1udPi1t9WSPw/glPpqkspfQeo4gF67bXCY3ODbQ53ZhJZ6HC2Y3F/8a
         To0DYDY4GDXnNIeb79nfEachZAQo4kxdll3rhRUsUWDqhhTCwVx7bJ3Q2gDlE4eBUese
         MYp2BxHMHAe7JSXRMb8ztVxaGkhKMBDwc2ou4oOoWH6O7JUzSY8V0UocIF7/pNHI/SfP
         Xhyolo1abqrJ8mZjRi9d/5eV3gby4/CdazkY8bHHmj7ORSV8a1AtyJ479hO5nBe2qr68
         RRuQ==
X-Gm-Message-State: AOJu0YzH5LjNzWjleiCIJCDaIk8sAg8huAf8b1NUU7+s830jcwYjrbWD
	ixkYB5AJBgSlTUO2qRerM3MvHhiiIEnrDraJIea/QW5TxjLcC4nfTwYC5CFYhg==
X-Gm-Gg: AR+sD121lECyGNkCjAILM7HFsEcg0dazlCSOdsBD+yBZhcUWWrLWiOoHi9tN7T1G6mh
	d8i+s09L6aeQkAvUPc5iUJqMMCdfn4p/MWRujb5fvb6fktDvn86Sh8e3tQoh16/PUwB+zpRdsfB
	Lzk3t+++kPfwVRvbPaI//WIypznxgPoE8Dz4BBCSlLO9ObgY0kTvUI+BixELb0XUI1pSSey2fdX
	jhxsUpzEzSyLN5OeiAaCuny9hBzC6lhxywT/7GeBFCyLeSwGNAhyp6yHr+VB5OCrjdMIi2oR/n/
	27BC849raoGtfbZeIhSV0w7fnBOHaPm1d24VLgw5/tYErBqNOGNMQbzFMOC7JhoG2wYBTR78lgc
	cNlMud0HG0niScRkd+kzo1BKIl6HAoLQas8IlYFJLyi+oRWEnoo6SWaG2Nl+4OgqjIaGzIEFINW
	Xaqg82VYD6ujA7yo++aAgHvLRugEKYpB6Jcm4nSVcrue3bOOcnYNqKhRJOx075HhTabXaGtxTQy
	1OB6iPCA/9WfTss16jg/8cbmm4pLY07XEShAuA=
X-Received: by 2002:a05:6a00:c8f:b0:847:9367:e054 with SMTP id d2e1a72fcca58-84e2c2082e7mr565981b3a.57.1784755022040;
        Wed, 22 Jul 2026 14:17:02 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175ce455sm1893874b3a.48.2026.07.22.14.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:17:01 -0700 (PDT)
Date: Thu, 23 Jul 2026 06:16:59 +0900
Message-ID: <m24ihq4tdg.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, ljs@kernel.org, liam@infradead.org
Subject: Re: [RFC PATCH 0/9] simplified UML/NOMMU approach
In-Reply-To: <860318a2d3434c35c3bf188776093cb46f2fe152.camel@sipsolutions.net>
References: <20260720185103.530603-11-johannes@sipsolutions.net>
	<m28q735044.wl-thehajime@gmail.com>
	<860318a2d3434c35c3bf188776093cb46f2fe152.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
CBC: thehajime@gmail.com
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_141703_255486_D873F09B 
X-CRM114-Status: GOOD (  29.60  )
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
# +Cc: Lorenzo, Liam,

On Wed, 22 Jul 2026 16:46:31 +0900,
Johannes Berg wrote:

> >   um-nommu(seccomp)        3533 
> >   um-nommu-skas           27844
> >   um-nommu-skas(seccomp)  26387
> 
> I'm a bit surprised these have such a huge difference, do you see any
> obvious explanation for that?
> 
> But I'm also still not really convinced that it matters at all.

I have explained this in the message below:

https://lore.kernel.org/all/m2y0nqwbzg.wl-thehajime@gmail.com/

# was also covered in my netdevconf talk but in a backup slide.
https://speakerdeck.com/thehajime/nommu-uml-netdev-0x1a?slide=28

> > What is your plan for this RFC ?
> 
> Well, first I wanted to hear what you think :-)

:)

> > I'm pretty fine with this (skas nommu) mode for nommu UML; it
> > is certainly useful to detect more bugs if it is available in UML.
> 
> Yeah, that was mostly my intent - to show a path forward for the nommu
> (kunit) testing in UML, without all the other complexity.

understand.

> > I would also like to ask maintainers if my nommu approach can be an
> > opt-in feature only when specific kernel config is added, probably
> > marking as '(EXPERIMENTAL)' or `if EXPERT` condition, as there is
> > potential benefits (speed, less host process use, etc.).
> > 
> > But if you (maintainers) wish and feel this as not an easy option,
> > I can work for it with later patches as an extension.
> 
> Personally, I've always mostly thought that there isn't really a good
> use case (or perhaps that you haven't really convinced me of one) that
> actually requires the speed benefit, but I guess I can't really decide
> that by myself. :)

understand too.

actually one of my motivation to give a talk at netdevconf was to
present a use-case of the speed benefit.

but I'd like to rephrase this motivation in a different thread; I wish
to move forward nommu UML as mm folks (cc-ed) might think it's useful.

> > btw, maybe I need a better name for (my) nommu code using different
> > syscall handling, with regard to skas (i.e., separate kernel address
> > space) mode (e.g., CONFIG_UML_NOMMU_SAS (single address space) etc.).
> 
> Oh, I didn't even remember now that "skas" was meant to mean "separate
> kernel address space". To me this is all a quirk of history ... we
> probably shouldn't read too much into it now.

Personally, I think skas still does make sense from the host address
space pov;  uml kernel and uml-userspace processes are in different
address space.

that's what I meant in CONFIG_UML_NOMMU_SAS in my previous email.

-- Hajime


