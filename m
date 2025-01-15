Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5223BC02183
	for <linux-um@archiver.kernel.org>; Wed, 15 Jan 2025 00:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TW46IGEwcLTrNPKU9if3JKv9ydeNNuh4nwl552OT9JQ=; b=YCa6132z6icTLAG6SWPzqIzJAH
	hq23WEh87CyJPjNWj9Vc7vEkdQC8PEnblg8f0QagzGvm5b6V2vmBc3aAw7vE/SY15xdBtjKgwyo94
	RSORgR6Gcuw7OAYeJElyVfthmksj/UrA5KKhDtVAgtTMT0tnUfElQTXBzlCFUpL5Vdn6piD+S0MtU
	e5icC+iel8uz6W7MyW53XkEOpmS13DjVxON4NuO8y8LcYTCwDKxC6BN7xHx9rMAditn+p/tk7U4ON
	uaCo3EMy3zu2vzxmelq6Quf1epAHx0GZwKscmJ3lhJGxnQno6BpkZzvTIoPZS7fvVn2pMD4CgTkmd
	r4S/XEMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXrER-0000000ACJw-1Udk;
	Wed, 15 Jan 2025 00:26:03 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXrEO-0000000ACJQ-2obV
	for linux-um@lists.infradead.org;
	Wed, 15 Jan 2025 00:26:01 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2166f1e589cso131184005ad.3
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 16:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736900760; x=1737505560; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TW46IGEwcLTrNPKU9if3JKv9ydeNNuh4nwl552OT9JQ=;
        b=FqSDWb8UrdBys/vFmEQw/D6YnPr4HcQ5okLL8Yxb6Jr/ricZJBDDxGYFRp3P9UR9A+
         C2QDumFybUCyoWDBoyDl+GKIvKH0QE4VOxPM0+e9a7FHLKFGd7/0zNc5NY4joZQUqATI
         rKLmDkNU0mLnxHbnTVHnr6GCEJRr4QNCKhioOvKCn5iQHnygbGcHVd8QWGbgNbFELeRE
         TE+kMYQgmMyNOXfDRo8OwGHqqqbFLvOTKb+PWVx7rrXywfLjjJZvwWRn9UGIMV/o/60k
         lnWZFySfE4Mq310p7nYg0oTVanZ8VvZ4HI/Id8Yfy5kVjKsfGq6wKgKISPTvEqmG2iYG
         q/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736900760; x=1737505560;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TW46IGEwcLTrNPKU9if3JKv9ydeNNuh4nwl552OT9JQ=;
        b=QTfs3OX/skItXfvYOvyzOo8w/QxiyTDyg5/3WHXRzCSjDuFl0s59Fx7m1/oPgj2LQC
         9twDOtvSCwycIKAmVivaddkCv4/4n6c3fl9Hk4OfKfytzWANQcBakGuGVcdUIJ/ILp5b
         fzZ7wYBvsb2niVgp0pio0IQagmi0JJMbMV9XgwvHUpu0qNLDXqIjVPujcLlcU11OMofd
         d/qnp0lku3tkHpPtooAl1un0EDT7bDna2YIaKaayiqFwuYv2AGZy4PdGJraYYQ0JR1V6
         OV06cFCF5odlpWLlnU3m+ZID1iWdawSXu37Ak6gJAJGoYDJHffxKN8UiL7xTcqmWoCPJ
         bxNg==
X-Gm-Message-State: AOJu0Yxv59G3GEnIrWp5tLTn4bSV8Xogkk+MdanPI0jHY19djII8pQF8
	I17mOl5LCHYbVBngyidWtZEMlC2ttkWvBePhpgA/N4zjWFmkbiOu
X-Gm-Gg: ASbGncvkWV2eWEXHu9UM9HUnvtoiZhG3U7JShstUQwj+sAx9Kw87weXjOp1m1Ksozjn
	2X7nzUncy3jydsKmchhO5gZ3SgBtYYyfxUMJPUXjO+pkJX03kbB4jhqKWWa5B7oGf0nmyWfYzKA
	YoVtGnyBEF7HDa+m+QWoZ889+mLHSkyNkS//QTQ4NbKQkaz7KLb6GnUiFZh0eDb9FD/aXCBCshG
	BpLfS4GRvM3myR2njC1uhDT+Tu2fNNbaNQxSiBZxpByFVO9aDRst4Lm7tS/i8fcfjrC2nW7+RiZ
	Q5dvk2qGmbvkkhwsxuM2/usmDEGFKflpLzxqQ057Ewk=
X-Google-Smtp-Source: AGHT+IFuUPvm2lMtzL9JTwLQgJrCEvAPtCOTNNVVdavhRSW0hXaAx8upTmCj31zWvlS01MSnEZiwdw==
X-Received: by 2002:a17:902:d2d2:b0:216:3dc0:c8ab with SMTP id d9443c01a7336-21a83f3ee9emr388683475ad.9.1736900759899;
        Tue, 14 Jan 2025 16:25:59 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21e279sm72834025ad.134.2025.01.14.16.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 16:25:59 -0800 (PST)
Date: Wed, 15 Jan 2025 09:25:54 +0900
Message-ID: <m2cygo6hyl.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v6 00/13] nommu UML
In-Reply-To: <3db55c1586f66718c871b678ec10d6c2aa88fbb3.camel@sipsolutions.net>
References: <cover.1736853925.git.thehajime@gmail.com>
	<3db55c1586f66718c871b678ec10d6c2aa88fbb3.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_162600_713752_0DB32CB3 
X-CRM114-Status: GOOD (  26.36  )
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

On Wed, 15 Jan 2025 03:53:36 +0900,
Benjamin Berg wrote:
>=20
> On Tue, 2025-01-14 at 20:30 +0900, Hajime Tazaki wrote:
> > This patchset is another spin of nommu mode addition to UML.=A0 It does=
n't
> > change a lot since the last version (v5), but contain clean ups.=A0 It =
would
> > be nice to hear about your opinions on that.
> >=20
> > There are still several limitations/issues which we already found;
> > here is the list of those issues.
> >=20
> > - memory mapped by loadable modules are not distinguished from
> > =A0 userspace memory.
>=20
> Maybe I am missing it, but I do not yet see proper FP register
> handling. This will be needed for task/thread switches and also signal
> emission/sigreturn. I am attaching the test program that I used to
> verify the correct behaviour when dealing with the recent changes to FP
> register handling in UML.

thanks for the test program.

I didn't address your comment on FP register handling as I couldn't
see any reproducer that causes the issue you raised (and maybe didn't
understand well the problem) so, the attached program helps a lot.

Though nommu code only works with musl-libc, which I cannot use that
as-is, now I see what you meant with the first function, test_fp().

(none):/# /root/test-signal-restore
pre-signal: 0.5
post-signal: 0.5
floating point register was not manipulated

Tests on task switch (test_fp_ptrace) might need more work for me as
nommu only works with vfork(2) and vfork without exec(2) may not test
well on the implementation.

and also I'm wishing to have this kind of useful tests as a reusable
way; as now I'm going to add a new configuration for UML, you're also
going for another SECCOMP mode over MMU, we may have at least 3
running modes for UML, which I think we should share the test
framework that we should pass.  Not sure how it should be but using
Kunit is the first thing in my mind.

I'd like to work on such things once I've done this initial part for
nommu.

thanks, will get back here once I could see the right way to fix it.

-- Hajime

