Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C399ECA5FCE
	for <linux-um@archiver.kernel.org>; Thu,  1 Oct 2026 08:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TnzQmvC3sunYN3GNXk1Foa5cJ0VirJG5aSp7n+hYENY=; b=jSvZ/Qo8FxtgegQwUh4miSz3rp
	hqMORBC8FaomLMI0x21Q2wywQq+etp3a5PgHLz7gusaUAI057UrtC/+ksReSKdKl6I0Ujd/E5+mEf
	hv6sexb3Uzt2xslaNLCw9s+Br3yf88Cfc1rBjnVZsqXQNQX0GphzzCdlVGMX4apHUDaXSCLMjlS8f
	giCVicapZPdl0NID1ZzZQhZ1tmrAik0Cg1xd0yQeQByoip67Wh1xK6sqAxB9llovn11PMzLAhkWAm
	QHvqknU9z8n3dk1+z7Z1fUVJYeaXkTnPpzGpWKNk3s5qrL58G9Fgjf3MEu0Jp1epaaaqM/ZFjE+sk
	gL8piKZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCCNS-00000008Dgk-3A1Z;
	Thu, 01 Oct 2026 08:42:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCCNR-00000008Des-0QrS
	for linux-um@lists.infradead.org;
	Thu, 01 Oct 2026 08:42:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CC07643E62;
	Thu,  1 Oct 2026 08:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A82A1F000FF;
	Thu,  1 Oct 2026 08:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790844172;
	bh=TnzQmvC3sunYN3GNXk1Foa5cJ0VirJG5aSp7n+hYENY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gRf36AbpG/tNmQziL1i7biGBsDrpNwePS1Hc7bPUNXRDlTe3JSL7h4VZXHkc5TyEK
	 /LsnOg34Y7B6NJ7Utc36TMCrNNJ1IuFksJEww5Np8KSmDpMzXijdqOGzdBlV5JFoej
	 UMJkCwMeXRkpF0Nj/QP/dbokZ9eFfYuu/3WJwWBwsdni72HmYC+TO7m3ofNPXvO5c+
	 XBaIlWGwN6T63hTPLEDp0qi02TKmljR+MmaHpPRcd3kqFtJ9y5Ru7GuFI2pf8OH0Da
	 itxDrLPVB9H0NKre8mVDdg3f8loxIEv5w19+TIXuUG+6eTu2yJcVnA+yQxqi+3BPJZ
	 OiasMCzsukuIw==
Date: Thu, 1 Oct 2026 09:42:44 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org, 
	liam@infradead.org, rbm@suse.com, akpm@linux-foundation.org, luto@amacapital.net, 
	brendan.jackman@linux.dev, liuhangbin@gmail.com, corbet@lwn.net, kees@kernel.org, 
	broonie@kernel.org, mhocko@suse.com, rppt@kernel.org, shuah@kernel.org, 
	surenb@google.com, vbabka@kernel.org, wad@chromium.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, geert@linux-m68k.org, 
	daniel@thingy.jp
Subject: Re: [PATCH v4 1/2] selftests: run tests on nommu architecture
Message-ID: <ar4br2vW7yZGd3gt@gremlin>
References: <20260929235711.2287931-1-thehajime@gmail.com>
 <20260929235711.2287931-2-thehajime@gmail.com>
 <bda5eeaa-7868-4d4a-9026-9e99347afd7c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda5eeaa-7868-4d4a-9026-9e99347afd7c@kernel.org>
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

On Thu, Oct 01, 2026 at 09:08:33AM +0200, David Hildenbrand (Arm) wrote:
> On 9/30/26 01:57, Hajime Tazaki wrote:
> > Architectures lacking MMU don't support fork(2) syscall and only
> > vfork(2) is available with limitations.  Thus, we cannot run kselftest
> > on nommu architecture as is.
> >
> > This commit addresses this issue with the following changes:
> >
> > - on test run stage, avoid calling timeout command when NOMMU=1 variable
> >   added to environmental variable, since timeout command uses fork
> >   syscall which nommu platform doesn't support.
> > - describe the difference of nommu tests in the document.
> >
> > So command line to build/execute tests for nommu should be like below:
> >
> >  $ make ARCH=um NOMMU=1 O=build kselftest-all TARGETS=nommu
> >  $ make ARCH=um NOMMU=1 O=build kselftest-install TARGETS=nommu
> >  $ NOMMU=1 ./build/kselftest/kselftest_install/run_kselftest.sh -p \
> >    -c nommu
>
> Is there a way we could derive that from the environment in one of these cases?

I thought maybe uname could help but our LLM overlords tell me no.

It pointed at something though.

In fs/proc/meminfo.c:

#ifndef CONFIG_MMU
	show_val_kb(m, "MmapCopy:       ",
		    (unsigned long)atomic_long_read(&mmap_pages_allocated));
#endif

So MmapCopy in /proc/meminfo tells us definitively, weirdly enough.

Therefore you could have:

function is_nommu()
{
	grep -q "^MmapCopy:" /proc/meminfo
}

if is_nommu; then
	...
fi

>
> I'd assume once could compile and run the nommu um variant, and within there
> simply build the selftests and run them?

Yeah be nice to have something that made it easy.

I'm quite excited about nommu uml in general for the purposes of easily testing
nommu stuff!

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo

