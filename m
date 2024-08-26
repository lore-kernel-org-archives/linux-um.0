Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A138BC5472E
	for <linux-um@archiver.kernel.org>; Mon, 26 Aug 2024 11:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fb2vFbZU1/uneDqqDL5XaTwiDdzbdGc48udHknNFNZo=; b=h/Dfhw7aN84C7wLWHEcXD+wWlU
	THKf45CtPEtRFwj0OKl6JRHZZMMtgZzvT2b7/gBQKdv3UXg8C/6tcNFzeQSk+QV6NCZMVa1UXvEhk
	oc4trO42bquGZZuie7RiBwz7CI3Zl11FTNU7lNBwo4tFHDL93yvObHDiI0iCOcu6GMfUGP1tOm94q
	RgjAlP2kE2KNm6xUOFRDE6IWfe3Nwb/yWsRwFwc53HhckiEtOjwPHJnFf8LNduL5iZFy5EcPvX8ND
	akoPiTolcM4cntnow/jLGkiGDXSmA0XR62Jls0y6GmVCL/7P2MG1Q32vXjymDlJpTzfba05eJDP7T
	wvIkhKUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siXSP-000000073FY-1WTp;
	Mon, 26 Aug 2024 11:00:21 +0000
Received: from mail-yw1-f172.google.com ([209.85.128.172])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siWKn-00000006lCp-1JuM
	for linux-um@lists.infradead.org;
	Mon, 26 Aug 2024 09:48:26 +0000
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6b5b65b1b9fso33749297b3.2
        for <linux-um@lists.infradead.org>; Mon, 26 Aug 2024 02:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724665702; x=1725270502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fb2vFbZU1/uneDqqDL5XaTwiDdzbdGc48udHknNFNZo=;
        b=HaiTpxkNGrV9zpxWINPj3UKlG46VLIe+nR4BtrKVu7MX5XBlOQxBItvHfefe/HGAJ8
         WVrW5uzDRnBrwQX87LNzaBkcSAH9E/wXhJP0xlsjz6MKDHh12/kWFO2xp/Ew5WaHl7Fi
         +yaq4nwzwQhHG66j0OyQ7al8PhNk0445MAi9vMYLnfzdPEJGS3ys54JF0V+Y8H2zA+gm
         fehMu0E7n5yN8GDQepNMSXXPczXDfHYL75UF+yGk+BMtBHPU1ye3zmK84Vwt8a6BQVgU
         YWKzIOxtanTZIMU4RW0pP2ZGe7ZN3AkMcnIelbwdnQjmRgvGX3H0hQiZHm81YXJBD+x7
         CDjw==
X-Forwarded-Encrypted: i=1; AJvYcCV7B8jOD1hMA/CELdeFyswXuVLQ0wOPekABAcFF1iiAcmpRg5w4sm5cQK6mefnlyG61IxRwLKKvgA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7a+GuihjQIVKTPDrOm2J9UTpvMK4M1VFYawqrQ4ZQowEpR3aG
	5PizhuFN9U0nWg1yUZyy+nzrA6chzjrNJaa8XioR3LcERRp5YekhY4LdaBk6
X-Google-Smtp-Source: AGHT+IGeH84IR44rqIroU0zlsrLjQg4Gs7zgCDxSPaM98YIOqqJDQ1B+8/gTiCubTOlxgDkUEZAAdA==
X-Received: by 2002:a05:690c:56c3:b0:6ae:6c9b:378d with SMTP id 00721157ae682-6c6286bd776mr101673747b3.31.1724665702482;
        Mon, 26 Aug 2024 02:48:22 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39dc52875sm14515477b3.108.2024.08.26.02.48.21
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 02:48:22 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6b44dd520ceso39748127b3.0
        for <linux-um@lists.infradead.org>; Mon, 26 Aug 2024 02:48:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUI7RUd7KKru+7JvsZ6E1USWB5zzUi4pD+V1YcOzGdIjCp9LeHK6HoZNNH7MWvVbfQVWc+ZlkzIxw==@lists.infradead.org
X-Received: by 2002:a05:690c:2fc4:b0:664:c541:60e5 with SMTP id
 00721157ae682-6c6286b952cmr74076937b3.36.1724665701590; Mon, 26 Aug 2024
 02:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240824120449.2517046-1-cuigaosheng1@huawei.com>
In-Reply-To: <20240824120449.2517046-1-cuigaosheng1@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Aug 2024 11:48:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWkAVQ2p-fGm2nanZz_sMxns09pgBijEtkP9sX2o7xgwQ@mail.gmail.com>
Message-ID: <CAMuHMdWkAVQ2p-fGm2nanZz_sMxns09pgBijEtkP9sX2o7xgwQ@mail.gmail.com>
Subject: Re: [PATCH -next] um: Remove obsoleted declaration for execute_syscall_skas
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	benjamin.berg@intel.com, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_024825_375953_C42BB076 
X-CRM114-Status: GOOD (  15.20  )
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

On Sat, Aug 24, 2024 at 2:05=E2=80=AFPM Gaosheng Cui <cuigaosheng1@huawei.c=
om> wrote:
> The execute_syscall_skas() have been removed since
> commit e32dacb9f481 ("[PATCH] uml: system call path cleanup"),
> and now it is useless, so remove it.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

