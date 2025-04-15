Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64453C369AB
	for <linux-um@archiver.kernel.org>; Tue, 15 Apr 2025 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GhGX2Gld5nEWaX//R4Z1bBeTvGhalt1zlNsb95NKu50=; b=HnV73qyQ3h+BJBTu3jrf6bfXig
	131x4+yZH3zuykft/t3hSKOqE/WBeIExgNOpIDQY0onTvTDL9wAbJYy85hCAFM1lZKYiEHo/lguWZ
	xDP2xCq92SoiAPAW52fBmoOKCkDroKi/WM2c/JOBr6fc1I2mGERKY8ARJDoR2+48ApNcMqt+eihOL
	waHBknVAsF9zd0QpWO03EDIOaCaZuDtvprZr9HUvMHjQ6dcHa9z7Pi6RnzqkwX/V+o/kchJoswr8O
	bIGsH6T2DNA05uZF6QJSHESnkPp5Ubeqa63xHkswq5PoSUHaRjJU7Rbn9CJPXLzPX2Rr6mPFPosxB
	DsS/54fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4jQQ-00000006SW9-3KKO;
	Tue, 15 Apr 2025 16:46:18 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4j9I-00000006Pfh-37lR
	for linux-um@lists.infradead.org;
	Tue, 15 Apr 2025 16:28:38 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3032a9c7cfeso1037103a91.1
        for <linux-um@lists.infradead.org>; Tue, 15 Apr 2025 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744734515; x=1745339315; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhGX2Gld5nEWaX//R4Z1bBeTvGhalt1zlNsb95NKu50=;
        b=L0hLYdUitTq74dIedr1lCL2iv4SpWJz/kHSaxCa1vGjvHOumxSX+JtQPSMnzc+ljoZ
         1HrDNlkVpP/P4yy7JXMm4AldEjafiGu87na/MRxGj7kqu5wFAzi23DDFwigcXUiIAGRy
         hQRJv4BBPG6xNOXDb6cq23j6qZemkWBTtavwWIBRhsE14RFunWbayLBGrl0qrd/jgM07
         EN1C+rLwCZyNNo/PEUvnaq3epdAuTpS56iLlMbYSa44Z+SemSOgf2LsJFbsps6CibKe6
         5MVdul8kAXDFQ8CpQ2IkQ3YgpKyXUoxLXXazXqS0BMhwM5UheQX2fTumOZpbZmVNY5ws
         hgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744734515; x=1745339315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhGX2Gld5nEWaX//R4Z1bBeTvGhalt1zlNsb95NKu50=;
        b=iggEQOKI7o075XB516UwtYpm4S0CbFCXfzD+Jhed3ELV9PuqLXK35xY0Anwag2sWi1
         1F8t+O+B8iIdr/IEIr/dqOElIzCbluRAFKGOw+Oox1XxdDGNJeWbcYxib+upy0Y40aAo
         TzXHgrlRRtYEtZOMEBUHGZeffK8xl0BG1+rI8WU+Ggbgx07Ss7u+nZ0pE/tsiYIP2T8j
         rFK46YSdzvl8K8iSbVLYw7uHdiiZ6bYNJYfE2AC2FHJYvA2VdNChMXbQrKFeLAerfidg
         KWeq9Mdu4Qb/C9e/YAYP/isF0+JXiyUhj9JDrzNY9dRGyNdbM3kKWdu7rHCBnZWKVoQC
         Gj0A==
X-Forwarded-Encrypted: i=1; AJvYcCUnHVIqD0OcrCC/K0stx5ObqSXEJloYLjeZjDLUhNgAdvzR3bECvm2HEd7EOuBWOP667hcJ1YEjTQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxreyIjFaDV6/EXufcnwsDYdNozautPReYv4UMzhypJBUxt7CdS
	i/lETDLJaia4l9Mc556KtplwSZ/OJu18Rbw5fsG+0bf473bzcVBPSUG17rgD82V8TvVrD1oIdZB
	1QDqrojtVe/Io+Fl157Mq/sf+/Ve5E2Vlpas=
X-Gm-Gg: ASbGncs6OIM6mDBorurseBJvGNxqUGFOx7RbNoObADKd+R1bhGOhEhITBgmaNW7p3pK
	IoRs77NVDqlrzyXO74osS7alL41MmqRVkfTGqdpO6/TvBxLQSpRN8YGTAxOHaJznUOle/zMd8j+
	u6HNUtUb2DS6V9Bo2UxRDq6m6V6Lz1IiPX
X-Google-Smtp-Source: AGHT+IH7DuWw2+Ji1/JVUUE6uHhtXC92IfxsebFP/13Uv3c8VTSL84EUu6WlHqcTmwxo8LeGFx2QSi+jDgjGVV/VHOE=
X-Received: by 2002:a17:90b:384b:b0:306:b6ae:4d7a with SMTP id
 98e67ed59e1d1-3084e75753emr2484613a91.3.1744734515441; Tue, 15 Apr 2025
 09:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250412005341.157150-1-fujita.tomonori@gmail.com>
In-Reply-To: <20250412005341.157150-1-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Apr 2025 18:28:23 +0200
X-Gm-Features: ATxdqUE4hmSdsGSuyUlL13WPDkdl-YxIKEIGL8veqbyYbS6fb8zNgY_VAJuTw28
Message-ID: <CANiq72=Grg+T-c0+TxcyubHj4kvHPQKiVm3AZp5DgeUVXsitEQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: helpers: Remove volatile qualifier from io helpers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, geert@linux-m68k.org, logang@deltatee.com, 
	sbates@raithlin.com, dakr@kernel.org, dinguyen@kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_092836_784242_4C79584A 
X-CRM114-Status: GOOD (  11.21  )
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

On Sat, Apr 12, 2025 at 2:54=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Remove the `volatile` qualifier used with __iomem in helper functions
> in io.c. These helper functions are just wrappers around the
> corresponding accessors so they are unnecessary.
>
> This fixes the following UML build error with CONFIG_RUST enabled:
>
> In file included from /home/fujita/git/linux-rust/rust/helpers/helpers.c:=
19:
> /home/fujita/git/linux-rust/rust/helpers/io.c:12:10: error: passing 'vola=
tile void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wi=
ncompatible-pointer-types-discards-qualifiers]
>    12 |         iounmap(addr);
>       |                 ^~~~
> /home/fujita/git/linux-rust/arch/um/include/asm/io.h:19:42: note: passing=
 argument to parameter 'addr' here
>    19 | static inline void iounmap(void __iomem *addr)
>       |                                          ^
> 1 error generated.
>
> Fixes: ce30d94e6855 ("rust: add `io::{Io, IoRaw}` base types")
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

I don't particularly like having different signatures than the other
side (since we could e.g. eventually have a check that they match
etc.), but given v1 it seems they could also be eventually gone from
the C side anyway.

Cc: stable, I assume, too?

Thanks!

Cheers,
Miguel

