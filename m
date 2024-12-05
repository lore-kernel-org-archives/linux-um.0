Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9172E7716C
	for <linux-um@archiver.kernel.org>; Thu,  5 Dec 2024 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zSnLOLI0OJIN6beCQ8pp40iUkpC/Omj3DC65BwJdmDA=; b=NZD1IrsokbXW8TVB167YBpqnjH
	mH1gdCX6eyl7cGvKLY+W47ARvH+xS5NGTnLk0rUUWyd9/ROgehgmV092b2+hzzgAj8akNESUrrE/2
	DjrMoCPLWOo8F9vtcF1zMzVGJrHNKl2kvaurPqOinPHnEOK7agGMhMI/xui1gEmJYHXTf9LBoqc/g
	edv9VZdmxVl/B88rQExYHhDYbPRzE6kpDNsXv0r990y0CAZkF3k8vcTUPNLjyX7PfZZFC+0toaLCt
	k25Rrc2glJkgloPL2ALzfwAO6EvNKIisdiwcEKUq2RTWf2YeqTqEteYObisggW9keQR8yWcmWi0Jd
	/jN0WKtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCSN-0000000GGxQ-2ZpT;
	Thu, 05 Dec 2024 14:03:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCNc-0000000GG3l-2hh6
	for linux-um@lists.infradead.org;
	Thu, 05 Dec 2024 13:58:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zSnLOLI0OJIN6beCQ8pp40iUkpC/Omj3DC65BwJdmDA=;
	t=1733407136; x=1734616736; b=S6yudu6U5edGR4OlS+sjZk+G/W9kXe+DOrqSuTBhSNYgvET
	+aAhNeoh2bRtKYq1waGd88DrLZ/fqyNfXA+Hps89Q0TCf2V/jRlAXKf4DyucNi4e9cfQOJ8HKRArg
	HqxdyPcrvSjAq0wYfaW7GvqVmjLFHxKpSui4gJgq0HRjw2olMaL6p0kGEVTkAyE9ShRHC3LkwCdnk
	UBjfql0XyfWjA/uo+Jx2czTSi7rfwWFBDf69xOSp+1/qBgHjn2mMhOu0Ibs4pwwlmMA+LSe50/XWw
	vki+NLhprNomZUVz9t7EQMzSQXrcSKolLnbUr7us5N5bIuVfJAszA5IoD3/DCoDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tJCNZ-0000000BLmg-2PiP;
	Thu, 05 Dec 2024 14:58:53 +0100
Message-ID: <b9115ae2c41429e720af9440d46ebb2614265fff.camel@sipsolutions.net>
Subject: Re: [PATCH v3 07/13] x86/um: nommu: process/thread handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com
Date: Thu, 05 Dec 2024 14:58:52 +0100
In-Reply-To: <m21pymw7vs.wl-thehajime@gmail.com>
References: <cover.1733199769.git.thehajime@gmail.com>
		<7e909114324f92d37dbe0a2f58443cf5ba606c6d.1733199769.git.thehajime@gmail.com>
		<2085ffbd1d5b0a908f26d0ec38a6d8719db5111c.camel@sipsolutions.net>
	 <m21pymw7vs.wl-thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_055856_679600_B150BE30 
X-CRM114-Status: GOOD (  13.87  )
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

On Thu, 2024-12-05 at 22:56 +0900, Hajime Tazaki wrote:
>=20
> > > +++ b/arch/x86/um/asm/processor.h
> > > @@ -38,6 +38,18 @@ static __always_inline void cpu_relax(void)
> > > =20
> > >  #define task_pt_regs(t) (&(t)->thread.regs)
> > > =20
> > > +#ifndef CONFIG_MMU
> > > +#define task_top_of_stack(task) \
> > > +({									\
> > > +	unsigned long __ptr =3D (unsigned long)task->stack;	\
> > > +	__ptr +=3D THREAD_SIZE;			\
> > > +	__ptr;					\
> > > +})
> > > +
> > > +extern long current_top_of_stack;
> > > +extern long current_ptregs;
> > > +#endif
> >=20
> > no need for "extern".
> >=20
> > you only use all that once, does it need to be here?
>=20
> sorry, I don't understand both of these comments; could you care to
> elaborate ?

Sorry, you obviously do need 'extern', I was clearly confused.

Regarding the task_top_of_stack() macro, I thought you only used it in
one C file, so I'm not sure it should be in a header file that's
generally included across the kernel, rather than a private header file
or just in the C file itself.

johannes

