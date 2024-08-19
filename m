Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4255FC3DA4A
	for <linux-um@archiver.kernel.org>; Mon, 19 Aug 2024 20:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6kUf3JuaMLYYiOtuZKtyG5uHrd9gw9QQ5nZ3PFBxZMk=; b=Vcr1FLRW8rLig6amf21BhLfsFt
	7Thuiry1NDZSxKIkSyeA6d3ps91L23OZRzAXBK43/FV9WS/R/5P+3C6QrHGdGJGbfa74D9bWkxI+1
	rtA+NCebCS8EWvkjNiLnjz0+2Nl/t9K7uSOg0Ikh6YVk5PmvHdFmyZwu+6vu1zHx05VFbNyUBBUiv
	Gcgmwwdtmio1nS21lLpgSgPvpGQ++1Z3zPIrXq0ReD2pG6eGZiOoiErZXVB11ifO6tsQZ5GdctjwQ
	XYwZzMF0nn/qAGJIywYQtXv1RHhyIy92bf0rjxokWvKlfnJQqOypWopneCoDRcpnsWaVYAz4aUYFy
	RozpMxvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg8nX-00000002qe1-2MUf;
	Mon, 19 Aug 2024 20:16:15 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg8nU-00000002qcP-1qNv
	for linux-um@lists.infradead.org;
	Mon, 19 Aug 2024 20:16:14 +0000
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-530e2287825so4974155e87.1
        for <linux-um@lists.infradead.org>; Mon, 19 Aug 2024 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724098569; x=1724703369; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6kUf3JuaMLYYiOtuZKtyG5uHrd9gw9QQ5nZ3PFBxZMk=;
        b=BM0QyEK0injJxEVAcqpJBn0yKOI2I3ZuorkrHaQEnIbGbirX29nuzm9RtuIF7SHcow
         f8zqDTgMx3I5rSGMNpPY3pBwMJU1hTpWiQGBZtbxFHFZGTHcDJKekPKht3meheF6P5lz
         NVR3GAEMtC0YoizDmRTkaHfTMywfQJS2JpCgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724098569; x=1724703369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kUf3JuaMLYYiOtuZKtyG5uHrd9gw9QQ5nZ3PFBxZMk=;
        b=Wxdc9f7Of6wU325mUs2Gu4yzNTeP69KG8CExI8tszXFJHr6u+NTmddGjum0hKznmfp
         MfkfPCtRunRUHt1W3k63R1j5Zeon0EkJa+vQDCKVeBXxbO1Pk8FLhro4X/ZuHrFK9FwY
         KMB6jTku+b4NRGprrx1v9Zvsvbdx2AHO3zOPulAcQbxyOje64h6TdEKCCwljhpWGTOUx
         hq9fegkw7LdcqsSS/01gWrt258y30Joekbo1S467j4DY0dH13+5fqT0Y3lxv+3d9Vl3J
         uUKRLfY8ctInXb44E5ivcm/WH1xLHif83Gs2W2WeViZ0UX+W9BeUAGQGcZZ8PRo/1+gU
         5HBA==
X-Forwarded-Encrypted: i=1; AJvYcCUTuRCD6Ghm7iYpjSF0DrFHLr99a/0QR3J0v1+D8I3b+WoBLBFbJ54pd5Fkj4BCp9Twxt/y50WN6g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwzO6WpZpRqgK26oCMC/SpOmS1kHy3qjrUz3VkYkAnb1b1rNkt5
	sXTG1xaxcxALGCNxC5rPU1ukINIEmYkovE5+yee0B21DpyTQbetf4mgYFbtFHgnj2gBMHEzY6KG
	u7qXzWw==
X-Google-Smtp-Source: AGHT+IFbeGazQByTNJpefKmbOz97LKbIhxdJR+3IKkSrSKX68XptiAy5Htb+S9UFaICpFwl5JE6AIA==
X-Received: by 2002:a05:6512:12c7:b0:52b:c27c:ea1f with SMTP id 2adb3069b0e04-5331c6ee29amr8437892e87.55.1724098567553;
        Mon, 19 Aug 2024 13:16:07 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cf40csm671240866b.57.2024.08.19.13.16.06
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:16:06 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so3478916a12.3
        for <linux-um@lists.infradead.org>; Mon, 19 Aug 2024 13:16:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUda6jjYq1xfiGZRsvIx31tX3zqVKSfI49JkI4VR4kMdakUDr7vF7FeeRtyO+x8Ngqr1Tb+E0slcw==@lists.infradead.org
X-Received: by 2002:a50:c8cb:0:b0:5a3:a9f8:cf20 with SMTP id
 4fb4d7f45d1cf-5beca8c7c0dmr6123102a12.34.1724098565883; Mon, 19 Aug 2024
 13:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com> <20240819195120.GA1113263@thelio-3990X>
In-Reply-To: <20240819195120.GA1113263@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 13:15:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
Message-ID: <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	akpm@linux-foundation.org, christophe.leroy@csgroup.eu, jeffxu@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, 
	oliver.sang@intel.com, pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_131612_499387_E4644B14 
X-CRM114-Status: GOOD (  12.02  )
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

On Mon, 19 Aug 2024 at 12:51, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Yes, that appears to fix it for me. I don't have much to say about the
> rest but others might :)

Ok, I did a quick hack-job to remove that disgusting
install_special_mapping() legacy case.

With this, the old "install_special_mapping()" mess no longer exists,
but I haven't even attempted to compile the result, because I don't
have cross-compile environments for any of the affected architectures.

Except UML. I did at least build it there, but it's not like I tested it.

Adding architecture maintainers and more architecture lists to the
participants. It would be good to actually get this patch tested.
Context for newly added people:

   https://lore.kernel.org/all/CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com/

NOTE! This patch is against my current tree, not the linux-next
changes. But it should entirely remove the case that caused problems
in linux-next.

                      Linus

