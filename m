Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F74DCAC59A
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 07:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qj4Q+ln53TMlKl8vivxQ4bA1KF8gRzVwWQSodcHaYwk=; b=cdmGVN4saNpnO4SLPceHjxBksP
	KVzusHzt79VwGctAnS5ENK9D+G0c0RQ/wuYOtvG6YgiEk3VNzPmxolqLnHFVS7luvPwtYxwjocFHA
	HTgMP0uCwDfDjN9WlmnQi7UxW+hGW7gZT97azgFROjOe8fASHWPTe6d/wBaZvDTxAFINI4QIIoCZt
	Il4HXWd8XUVPKWY0eEmNoleYQrCUyLga/1H3+7E8cGBwMPHxxUaKQE4D51Mo5BfehOJzmGII132yy
	+/EMOUGwO25umEQLqbPCbT9bMeFWgSAkleyfDFNuTEAuIe2WcqAeURmhIgdR60t1fxMqsMwSbYHyc
	8b8s1gLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Df-0000000GYtU-3X5Y;
	Thu, 18 Sep 2025 07:38:19 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Dd-0000000GYry-3zA9
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 07:38:19 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2445824dc27so6443655ad.3
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 00:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181097; x=1758785897; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj4Q+ln53TMlKl8vivxQ4bA1KF8gRzVwWQSodcHaYwk=;
        b=aGkaPg1g+6jIeskEZq9BdIvb81B5XDxhWh8CxPOX68qfszGwlccy7EXQLT0tU2tRgU
         FAa8Msr6Q4HiPSETVyHwB5MBIBnjr9ro+t/EoOC9jTO4E5LkRDnJ9yKqbt5VEa9odqeM
         /Z9ghiDIE9KgQel8e8gCwAbZM/UYnRwihN5MF17RbVupQA32jB/oo4qky+lvoId1triE
         UVrWjkYP7xfkjzPWWFXA6CPAaJ2zSlSgsrqTks02LH+05C4E5PtEDYjDKkzAfLgd8vhI
         Nrzy8Dd7Rzj4LYejcEb8VfCzqPBtXZQgRhTfiURW5LnxRnXpktsclj4+IZqJWRtZaRvC
         pCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181097; x=1758785897;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj4Q+ln53TMlKl8vivxQ4bA1KF8gRzVwWQSodcHaYwk=;
        b=Km68E619y9b8yGquGgq2DXEPF7oQTe0wST4pw9qaG6zpi6osEwEk4d02GkvlI7b1XD
         IW5KHj8uJ9BPYspiRoMh+3g0ex1YJP2O60O50bfWPmC4iPpiLtB9/UURR5ikIdeqk7qy
         Jf7HrC33KejeXB0sfhDYh8GMlqL3Dyxss0tdsIo2tRBNeFa07AiIgSmarp5CSqqyBg4r
         3b47sSlJ/eyaYF0He1h/7yLWGDp7PCILpjHFLz4u3slnREmZAynZ3wVcoqtGyZ89YePP
         bSnCLr9b5PRhFv1XeKxw1jOeb+cfNGNrJnEXMPN2zym6kaZJf7mlafpdsNzvw/0VroHt
         5l8A==
X-Gm-Message-State: AOJu0YwXzBEaYA+4rgFSxuCIuoiRHQmE3v4Gm+oVUB5JQWhU74KQSbQN
	I/9agUZeGz2kKR+bUvrJsSTNkb9Tge5qw74WdVkhafNOKGcHuh+eu/WZsWy4+Q==
X-Gm-Gg: ASbGncufjs/VyAYIq7zqP47ZO5G84n8UYJUiXBPe8bs1Ae1eEz7tIIQBb1Gt470cpPf
	Lo9cDT9v7E/PQsLIatdgP2dccPF9xjRS0+FdcL9cUlEKuceU8sgYDF2OhL0RDdQPNmEHWuUNasJ
	23CH4pjYaDP7ytWs+wnoy/urwd38uQgqVGaDIOpD2yxeofhzb8pJ1JAsR6FIMEprcFofGpwFCfa
	m4EtxG2qY9QKgqav6wI3szDlM8lGuZYP5Twv+hDcPZpOkxfTHJYmvUqESaMKLBcSY5p8ZAf14cZ
	v1OSYHixrlxQIp8OFa6U0khLbvju0YKONFFSyg0TPo72Zz1n6Ns72QXhILCXK0+6SZdTuxMI45C
	u+crQuAUMXzjAOebiRtrm2fPz+FsN8Zz98gYBc62fq+rJT9z114gj3bPnHEmXxCmYtxCXs0v4vl
	nx4m0jnMKGsteGesEJU+btxa/LPxM=
X-Google-Smtp-Source: AGHT+IHCWymmqh8qlbDIpoojQaPDf9+JIFsgk8hQf/Yt1/SICfDMa5fretaS9o89jnSnDm6Zife20g==
X-Received: by 2002:a17:902:f113:b0:24a:fab6:d15a with SMTP id d9443c01a7336-2681218fe0bmr45234575ad.20.1758181096722;
        Thu, 18 Sep 2025 00:38:16 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de5dbsm16738855ad.84.2025.09.18.00.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:38:15 -0700 (PDT)
Date: Thu, 18 Sep 2025 16:38:12 +0900
Message-ID: <m2bjn88b2z.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 00/14] nommu UML
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_003817_987411_52BEBB8D 
X-CRM114-Status: GOOD (  15.79  )
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


sorry,

I included an unintentional patch in the series ([PATCH v11 06/14])
so, will resend this version very soon.

-- Hajime

On Thu, 18 Sep 2025 14:15:53 +0900,
Hajime Tazaki wrote:
> 
> This patchset is another spin of nommu mode addition to UML.  It would
> be nice to hear about your opinions on that.
> 
> There are still several limitations/issues which we already found;
> here is the list of those issues.
> 
> - memory mapped by loadable modules are not distinguished from
>   userspace memory.
> 
> -- Hajime
> 
> v11:
> - clean up userspace return routine and integrate to userspace() ([04/13])
> - fix direction flag issue on using nolibc memcpy ([04/13])
> - fix a crash issue when using usermode helper ([06/13])
> - test with out-of-tree kunit-uapi patches (which uses umh)
>  - https://lore.kernel.org/all/20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de/
>  - https://lore.kernel.org/all/20250626195714.2123694-3-benjamin@sipsolutions.net/

