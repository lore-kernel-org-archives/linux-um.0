Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3180BC3ABB6
	for <linux-um@archiver.kernel.org>; Mon,  5 May 2025 09:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JrTntez/dnf8jPx7hJe6xrclQPktzro6rrAAerj1XGc=; b=1VR9giheO2lxGIc7AWNuzxpzc7
	Wa0Ugsb0l4MTNAstbBzwW9CGtiOj2kPYBcZaJ5f+LHCe1h3bw96u+fP/lbRMtl6lt38qyUwxHuV7I
	hnOVKUJsXQCN1UFLDpZOwrK2dPkcxsonWlomx2WmCauRBZkfVHZuhQk2Rv1y3EWzEJleji6RyeQ/+
	dY9rj/8spU/TC1Z8PNAR4Ixt1/A50wWPSZV+bX3zTbluHVEzy71QbH7h4ORunWazUgKB6YRdCWW18
	KcNZtye4QyWJIX9b5sNq60760y+YeBrIl6Yw102Y761VjFfT2tHbA7czHngHeklPLKTzD4zSz6Mn4
	q4WWLPTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBs0L-00000006tzi-0bu1;
	Mon, 05 May 2025 09:20:53 +0000
Received: from mail-vk1-f181.google.com ([209.85.221.181])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBs0I-00000006tyP-2Ijn
	for linux-um@lists.infradead.org;
	Mon, 05 May 2025 09:20:51 +0000
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-523de5611a3so1162007e0c.1
        for <linux-um@lists.infradead.org>; Mon, 05 May 2025 02:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436848; x=1747041648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrTntez/dnf8jPx7hJe6xrclQPktzro6rrAAerj1XGc=;
        b=qgqo2+k1dvGcA1wXpDGFDOfbHSjdBVWZJgoYJ8QDK1dEwZIi0IYzc/Y6N3ONDg6kFE
         QfUihoYPb22jSmo0qAoO7NhrufctBs/PS/yATkuJLRU+HzoRLsV5Cw4mLh+2sC6+N7P2
         xHDCTt9g416NPtMfm5aAtnoeE4+IwPlTtCinUThkgnp+OU1nn1uxYShcaoh6a7wqwZfW
         veY1ychzlcOuh3C1w4QC3EpyBzbndVDynCFDL8jECTGiumjsjw2JGpvooxEYF5JYS0hi
         G6KaeZfcVlUitT3WHBAkwfzw95vDiRH5LqU0IlyaqyhtQSIDj18k693owa6aOVqS4+2f
         o4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVOhbVEAYRyeREqy/yLKZsNbiYCTV9odCr/Lrvoh0Ppy9lE7y/IQQ3Rlvr9aj8cYDtUwrEV3Znb+Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzivxdRV09MdtDw/GstbXzqjGXaUh88gfzGGvJc1imqZ0Em/6ze
	9iQ/BDtoOItHyYeJzE4lcxNTC+YcIGqZyM8aTul87zu5M7SN/Oe4XiNC8Z15
X-Gm-Gg: ASbGnct1EHx2CntDfZ5JcgFBQUSIr5WIf22Kn3fYGHwvzlwkNkOX0EfrDVCeJOCQruR
	SgP2mpYjIMf57DexgRxjdhFFOKPN/f+ghksCf1xXtFbpZrjQCWYNM75G36u994RqEVhTsFwSHaG
	ADS6M64XlpkqfmW+ocYiKNTBlxRJWCw0pNmV/+9TEjloOleGqnRGPyS7xhNleuSAaJSP2IPS5DS
	Q9SFnNFeViO+I+hGZ3ssiStfjoQnJUyDgJj5JugiF3gWUGILLXqqqZVzfunLijNhxIZ0KXsDI3E
	uH7R/CXDsaDXAWVJpGjOQI81zPej9qYL/HWA3ivtIoLNqHyUXI1meEefH4qLV91CTjKJOMM0iBk
	gXkuXUUfQq4Qr+Q==
X-Google-Smtp-Source: AGHT+IETFcMWz8CwQtpWlKaWJr6MBgA5Si3cLJ9V5aPidphIcFhRjBIXILsDgI/Qvl5Oim5W1FjbmA==
X-Received: by 2002:a05:6122:2225:b0:529:24f8:dbdd with SMTP id 71dfb90a1353d-52b0688ba15mr2219826e0c.4.1746436848313;
        Mon, 05 May 2025 02:20:48 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52ae41ef652sm1446113e0c.43.2025.05.05.02.20.47
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 02:20:47 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86b9d9b02cbso1064947241.1
        for <linux-um@lists.infradead.org>; Mon, 05 May 2025 02:20:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPxnp7VOWN9IXr/4gsNRKfeH+ZPPFFRFh7HVjz1NJCoFwEjiXGti2z0XFiN9TYKg5o5BzGERrVkA==@lists.infradead.org
X-Received: by 2002:a05:6102:5e95:b0:4da:e6e1:c33c with SMTP id
 ada2fe7eead31-4db1477771amr3218060137.3.1746436847540; Mon, 05 May 2025
 02:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250503051710.3286595-1-tiwei.btw@antgroup.com>
In-Reply-To: <20250503051710.3286595-1-tiwei.btw@antgroup.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 May 2025 11:20:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUhWUhHczDG4ihB0cgUG9TTMo6Naszw6oogROnRCrOmKA@mail.gmail.com>
X-Gm-Features: ATxdqUENhpSV8CPgX33VGGaOUDIG6DLXeMDD31AxT2ccg3ncYF8ZgguS4roWWR4
Message-ID: <CAMuHMdUhWUhHczDG4ihB0cgUG9TTMo6Naszw6oogROnRCrOmKA@mail.gmail.com>
Subject: Re: [PATCH 0/3] um: Remove legacy network transport support
To: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_022050_584872_78C2D93F 
X-CRM114-Status: GOOD (  18.30  )
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

Hi Tiwei,

On Sat, 3 May 2025 at 07:17, Tiwei Bie <tiwei.btw@antgroup.com> wrote:
> Tiwei Bie (3):
>   um: Remove obsolete legacy network transports
>   um: vector: Eliminate the dependency on uml_net
>   um: Remove legacy network transport infrastructure

Thanks for your series!

>  arch/um/drivers/slirp_kern.c                  | 120 ---
>  arch/um/drivers/slirp_user.c                  | 124 ---

It's been a while I used UML, but slirp is what allowed me to run
UML on a machine at work where I only had normal user access, and do
root-only things like running Wireshark (then called Ethereal ;-), and
install and run apps that were not available on the physical machine.
Do the newer networking options support using networking on a machine
where you do not have root access?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

