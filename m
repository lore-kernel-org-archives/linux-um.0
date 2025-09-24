Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DB2CAC59A
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 03:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pA0xAIiIUj8HYkYDN+N5NPIspAnSO8L0/9ezyiu4Zkg=; b=d+RCj61l0BQCDJ8aXCpEx+jq1c
	wX5M1ZJMI3EhYadNOEgQ36kkFZoSY2cF2y16DJet+jfRUbRoIBngEhkOeAyNBxdkmL8DEfKWtoAjq
	hQ3DOnqqU3MzgrSLRGsR5RDKa4Y8471yAo2svRXOzG1IoV0V/l8HXVx9L1IwQITYI3BUz9PuGML3p
	IvxGXqi0jKCepN/PJK8rweNM0Z1XshJ/QwjekEiHjbvwpFpbGeksgVvWf8JiEHhp2vz87rhLAVhz9
	/uL9rAaCBC31O9XmBE/oj77qpd23Yhant0wGdDtcRC3j1OT929fP+2yTpW3JMPbAIKHsXAIXUG4Vk
	LsWFUhBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1GEz-0000000FRbE-0Xvk;
	Wed, 24 Sep 2025 03:32:25 +0000
Received: from mta1.formilux.org ([51.159.59.229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1GEw-0000000FRaG-1lCc
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 03:32:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758684738; bh=pA0xAIiIUj8HYkYDN+N5NPIspAnSO8L0/9ezyiu4Zkg=;
	h=From:Message-ID:From;
	b=ZTC1ZAOPbItSLcuH3Q4AF76+z43R/myMWXl7riFopa3tfXZbdXv+1Z5gqMISMpDAl
	 xcO+8GRKZnO2+KLYSIfBD9KlY8bJ877stsWTvIiU7fCycdQFOC4e/Dr3um1mVatiCQ
	 vqKjwHDRGvY1fLVoECDZmdhUOidDl87I1ftWnwNo=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 27A67C06A6;
	Wed, 24 Sep 2025 05:32:18 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58O3WHSI009048;
	Wed, 24 Sep 2025 05:32:17 +0200
Date: Wed, 24 Sep 2025 05:32:17 +0200
From: Willy Tarreau <w@1wt.eu>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: johannes@sipsolutions.net, hch@infradead.org, benjamin@sipsolutions.net,
        linux-um@lists.infradead.org, linux@weissschuh.net,
        linux-kselftest@vger.kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, benjamin.berg@intel.com
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
Message-ID: <20250924033217.GA9039@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <aM15eChUObXfxLzs@infradead.org>
 <4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
 <m2y0q47mbs.wl-thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2y0q47mbs.wl-thehajime@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_203222_741899_ACE91428 
X-CRM114-Status: GOOD (  26.95  )
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

On Wed, Sep 24, 2025 at 08:58:47AM +0900, Hajime Tazaki wrote:
> 
> Hello Benjamin, Johannes,
> 
> On Mon, 22 Sep 2025 16:41:36 +0900,
> Johannes Berg wrote:
> > 
> > On Fri, 2025-09-19 at 08:40 -0700, Christoph Hellwig wrote:
> > > On Fri, Sep 19, 2025 at 05:34:09PM +0200, Benjamin Berg wrote:
> > > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > > 
> > > > This patchset is an attempt to start a nolibc port of UML.
> > > 
> > > It would be useful to explain why that is desirable.
> > 
> > Agree, it should be here, but FWIW it's been discussed elsewhere on the
> > linux-um list in the past and basically there are various issues around
> > it. Off the top of my head:
> >  - glibc enabling new features such as rseq that interact badly with how
> >    UML manages memory (there were fixes for this, it worked sometimes
> >    and sometimes not)
> >  - allocation placement for TLS is problematic (see the SMP series)
> >  - it's (too) easy to accidentally call glibc functions that require
> >    huge amounts of stack space
> > 
> > There are probably other reasons, but the mixed nature of UML being both
> > kernel and "hypervisor" code in a single place doesn't mix well with
> > glibc.
> 
> just curious
> 
> - are those issues not happening in other libc implementation ? (e.g.,
>   musl-libc)
> - same question to nolibc: is there any possibility that nolibc will
>   evolve as glibc does, and this evolution introduces the UML issues ?

Nolibc focuses on early boot programs. That does not mean it will never
evolve towrards more generic usage but this remains unlikely, and in any
case there's the goal will remain not to degrade the experience on the
original target (early boot). That doesn't mean there will never be any
breakage but we're doing our best to keep things in a clean and workable
state. Regarding threads, it seems unlikely that they'll arrive any time
soon. But if they did, assuming UML would by then be a long established
user, we'd certainly find a solution together (even via build-time
defines if needed).

Hoping this answers your question.
Willy

