Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5EBC531DC
	for <linux-um@archiver.kernel.org>; Tue, 20 Aug 2024 21:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/qBbIdE12tBC8jy3M3AIScxm0SURUOtfr0PSYL5bF8=; b=CdP9dDXuL7fX5r7zLdDm/s5xEy
	pqhZZ9ncA7pbgwqpp9OauXxUFshK9j6hGZiiLWsOTrZx6fxN55fMMaHE3IUXNPMy1rbXqm7kI6JKh
	ggs9kRav/DTlKdQhDclyhpvLs9bX3IhJjUwSD8uu7lw8mgca0avdKmCxrx+CnmsZJ4DGtS9kdyrOG
	BXJSyhDco1hYwSZTpKkmeY1KPCU5KfOUwsseUtRcpM+XuQH4lM3PVp2D88zO9SGPceF/9fXN3s4FO
	xa5IsTtd5nBthYmyOPf6cYFusy9Jjc3FYeUOPx1+yI4dO2xs6stHZTXaSOat6s4e92WWV7lHx/yrk
	l9S1OWqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgWX3-00000006hTM-3P4u;
	Tue, 20 Aug 2024 21:36:50 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgWX1-00000006hSm-3bPI
	for linux-um@lists.infradead.org;
	Tue, 20 Aug 2024 21:36:49 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so5342836a12.1
        for <linux-um@lists.infradead.org>; Tue, 20 Aug 2024 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724189806; x=1724794606; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B/qBbIdE12tBC8jy3M3AIScxm0SURUOtfr0PSYL5bF8=;
        b=dSbEK97Sf6Ja7YB9iW5u6LkglekWQ6BXakkrNOowFxVuLieLohXsvOMh5abq8NPtxq
         8jXEdgsz8SD0zKF5Goi3dXm5Pg89nI4un3+OL+HPfuQgJq/fxjidKapxKphVb/NGpCOH
         ctKE3Ucm3lGb1nRd+6b3u+8W66TdfnpNsDA4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724189806; x=1724794606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/qBbIdE12tBC8jy3M3AIScxm0SURUOtfr0PSYL5bF8=;
        b=ibL/Xr+7Jgf6j48hyipOuVPo7hztU+5yptHxrVZA7/s5C0dxzgtM3MDuNgil21TNR8
         JKjxj06kayERNhZd7pIqoz/7nxEAZCokrwTNlx5EJt1YAFeT9Y3iD02goiBkBSti7rDQ
         wkIwT6AYwozBADxt5XtBWjzU+BtRwQiUyxnN6UnfjTWMOFFMqBALKzun4TaMq+rX1hFn
         rmxnSwieLiYtyh/Zxq4hhDljYKZs1+OcNtQlVrm0saG7m4KozzKLmVmXs5HpttXcSw/O
         NK25EzR0VedL/N8pdRF4ArX7YWowNqIkmpN1a33rKHpbkoP6O5jpHe49QY2Vin55sy2q
         bebQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkxdI3l0pkwXruA4TUZDhl3EktuIFT/6u0Cfn0CbzllvCIbdu1KogUXxP+bl3KBA97nnesoXjCkA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxNKkP7FbfzXrYWtrr7qpPx+6wZ3DlJQGug6l2ow7DGNpJbGoEf
	p50hmwCxG/dWBoOvZxfSx3BxxQHde9dEUWhZqc0yI7MXUaFD8HP690gtfDPE/2MPx9zwZpNhcc2
	dYimEBw==
X-Google-Smtp-Source: AGHT+IGsiL2D1Zu+UTtETSe2XGjfGWZn2IepByFMIiFr/WwR8EX5q6SvAS5+cTTBj78hC5xu7RAH6Q==
X-Received: by 2002:a17:907:e61c:b0:a7a:c083:8579 with SMTP id a640c23a62f3a-a866f9b0ae1mr24001666b.62.1724189805164;
        Tue, 20 Aug 2024 14:36:45 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d00f0sm804929566b.87.2024.08.20.14.36.44
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:36:44 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a843bef98so677391266b.2
        for <linux-um@lists.infradead.org>; Tue, 20 Aug 2024 14:36:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDS5fZLwJOHx/CAiiAap/4dI/Q5tgWoSThBrXuFwvd2MxA/dGxkhjqmmr6/U8rC28KDT7ou4u3XA==@lists.infradead.org
X-Received: by 2002:a05:6402:354d:b0:5bf:b29:6eb4 with SMTP id
 4fb4d7f45d1cf-5bf1f164130mr60685a12.21.1724189483542; Tue, 20 Aug 2024
 14:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
 <87y14rso9o.fsf@mail.lhotse> <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
 <dff57198-7955-ec09-8909-671982834673@landley.net>
In-Reply-To: <dff57198-7955-ec09-8909-671982834673@landley.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 14:31:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Message-ID: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Rob Landley <rob@landley.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_143647_925145_E8E2E595 
X-CRM114-Status: UNSURE (   8.91  )
X-CRM114-Notice: Please train this message.
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

On Tue, 20 Aug 2024 at 14:17, Rob Landley <rob@landley.net> wrote:
>
> Hexagon also has &&vdso_page which I don't understand (but have a toolchain for
> somewhere to at least smoketest...)

The '&&' is just a typo. It should obviously be just a single '&'. As
mentioned, the only testing that patch got was a x86-64 UML build
test.

Fixed locally.

               Linus

