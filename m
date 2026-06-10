Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0ACCD98CC
	for <linux-um@archiver.kernel.org>; Wed, 10 Jun 2026 21:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=; b=yKE0NlwEiGrtC00k0i9WlIKSz/
	9uQMODI0XRFMLm2XOBjHgn5HLF8uR9LF+eHU+F11m+HwU8MAt9njjtEWHoBOZZIVvQ1PANJqOQPOq
	aLHqy8ZCWHKv/JOgNel8pCqWC8SGPbgZikjDvQAJ+MATP3fGn17U6skdt7tH2VGCt6TrKUPlwMNUb
	FN+Jbxce2S+KBVkxYnBr+QULGKTGQkhrDTm162CPLWoeZ6tG/6kxqxSP2a0BlPppAnDtlzGX/VjAY
	XkBVzOL2x71vRBHWN3ZddGwr13m5JdewbMS4vFnFis/ul2+A39ELFY+SY9T5X1//47HdBkojuLyBO
	dRQA+n2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXQ8A-00000008MpX-0Uw6;
	Wed, 10 Jun 2026 21:06:34 +0000
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXQ87-00000008Moz-2ThZ
	for linux-um@lists.infradead.org;
	Wed, 10 Jun 2026 21:06:33 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-7ea16f090b4so91568397b3.2
        for <linux-um@lists.infradead.org>; Wed, 10 Jun 2026 14:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781125589; cv=none;
        d=google.com; s=arc-20240605;
        b=Qow4Ax42+wG9bmqeNw5cjw82RAFCPeai1zL7rIpwIQ9qRiIopN0tuVOfzODd/Ieymf
         X6zh7LNLOOrInk/GcV8OpTh0W1/cA5MM+fpWO2CMzdokmx34d6DiqaGngmSnOzHBW7UW
         hD6MC/sDL2ie9Q3Dp9J1uZEPvNZCct8P539CuQuMJg2gPLMZzZf259hcVIuFdYEvV4XQ
         gwuIjNs+rokLU1o8eaPl1Ny4OfddjvvyCxYmpKL2q05X94TJZWDGkliZr19KYi5kgIly
         USF8Ovuh+jAGAh84F5M0OOc9hjRI+gKC5nNibpdHsAhhcQE3RUEymn3mr+U9TYR0CkgB
         AYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        fh=GWr0/A7vDyJBy0GwiYzoh2kh2EJYo0RSyW0wSZvQvxI=;
        b=dzJbiqPrGuKyH7XhfSDKpV1kyvg/X4aoURJGWdWKcLZ/aONaYxZQqkKS1KhqhHt6RA
         K1PWclZDWdf+W0vIEjNJHs3A3aLJbS5qvDJVtvjAPx3EKZB3ZhTbQODHUx5OZetNKvvB
         UlS2OQxq83xMJfrJogSPoIGWHB+6GZbnP6LoTRFEG68LmIpISMWbDnZHAqD2Fz2pqsfg
         w3EZX+ZKLumUGAfHqFUvdrxD1eAWIoHIO8GFMC8ecYtAi3yEIY1/gw1wOVe8Hh8VvWhJ
         H+IdekTZwMctM6So7Xmxc5cTK4nzLGKjw0PkN/dPgUviUCaoU86NhfA5iScG8QDZOhmM
         P0Tg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781125589; x=1781730389; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        b=lHSV8Rvg+1/CiLfmfdzAiGvpSBDG5JlUghArxAHDDo7Iqx+j7A18JkY1gjhTQ50O4g
         kluvY1wA1E45mLp4yyRfJl5RwDQHzyIPYtBpo62258+KT09uo1DKwSBI32W1dRNuDxWz
         zjjqAxnG1AR6/46vFUk2pYvQuYJ7IpHApgvj6BctPgbI0wpm/vNzWIzG+oDguEXq2U5o
         6Bj0wodhc5nNkqJMN6qx4G+0Y0PxKkGYSBhEL55f6aTXY4XUc2rw180uValCvV4YZnOA
         CmHVvQVeLMhjcFqO9OOBKXuBNdW3WtWJybnBdzAHZCd7UEDas2zMo9B0BMwlLnSz8OzC
         +bKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781125589; x=1781730389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        b=mX5u0uLmjxp1k8ZTyaLBlmHcckoktLGakJGZiWnqgLO6Kg1lYIr3NF1ReMzeLNXb2B
         9TL/IkJtwuQY8NFJiYkCN804LLR3oD7QeIiLyit2G2H9N8GyYn1LggiPRs1V/PvWWr1q
         W2++ZXS77HP5JDT0DMnkQT9u2RQiMp+z3DmYcRArYnoAOmZsTjITl5j+c13JsRaZLSmQ
         qrmJAqoyq+/4OGDRP8ayPvJNrxnD05nwKeMwf5FmuPMG1BOynvTzRvALNom6PgBa3nr2
         e9FwnsVW5HhSM448Mo7/uFYSb6CYKdkWOk5UA3ciHN2Uh9Z0xFoZaoLIlNEpxo4ZhOPM
         rZ4Q==
X-Forwarded-Encrypted: i=1; AFNElJ825JHFLejDtddloPK1yRBSof7XeXHT+/zdnynDSKZn8k3ZDnkMy1OBtRAU+4MFNQIy0fKS/wPndw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzwcd0zqU5qO/VGweXdIlKRmSKMlAdUUGBYZ75ArTSSA8nC2Rgy
	bSsoPD0W5WEX4hFX0sshTd1X0M2R2jBc4icDK1+UBHlXf8IJ6iSVPS8eG9aIf1zjj2V/6FBK18M
	wP4LTHZzNqhaueDEvIRlWS404dFNxgfo=
X-Gm-Gg: Acq92OEr+Jc0uLgLdIpibeJ0zaWn1wmqytQRTh4qO1jXM1jEfG6zfA1QLSHkcNqsxdF
	AalkiuOCUOjQl//XeZmFH4XrleA2sMt55azYAwpY3s0JP/E2WIvBLNZItim46ptLhCrsjwUWUnx
	rFlFAHRR+aETJN92c9BG9iQ8JQwieYK0CMShDgHaXnY5a28VGWL2h9x5LAfg6U99Sp2exVWhrKm
	K4UljOQnAvjkF1CcZxGn1SnFud6wjO4ooUA+lQpynWr29J2e88A/jXbk1rRfXXBX8OY1lStt1C1
	alv3IBChcHjBZA48u/wdkUJ8BA==
X-Received: by 2002:a05:690c:45c5:b0:7e9:ab56:3c99 with SMTP id
 00721157ae682-7ed0adbb616mr276188567b3.6.1781125589039; Wed, 10 Jun 2026
 14:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-4-kees@kernel.org>
 <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
In-Reply-To: <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
From: jim.cromie@gmail.com
Date: Wed, 10 Jun 2026 15:06:02 -0600
X-Gm-Features: AVVi8CcLXClq9Fijm8VjZF47hQWmos5q_iXrehNZDw9kSOby-E_cMxEQI0SK-hU
Message-ID: <CAJfuBxwRuT1K=rjPX+sdNyYurEJ=OjqbJaSa_S6JnY6yzTwTvQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Baron <jbaron@akamai.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_140631_641375_7D4C17DA 
X-CRM114-Status: GOOD (  16.57  )
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

On Mon, May 25, 2026 at 7:35=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 5/21/26 3:33 PM, Kees Cook wrote:
> > Using Coccinelle, rewrite every struct kernel_param_ops initializer tha=
t
> > sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> > for example:
> >
> > @@
> > declarer name DEFINE_KERNEL_PARAM_OPS;
> > identifier OPS;
> > expression SET, GET;
> > @@
> > - const struct kernel_param_ops OPS =3D {
> > -       .set =3D SET,
> > -       .get =3D GET,
> > - };
> > + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);
> >
> > Using the macro for initialization means future changes can manipulate
> > the struct layout and callback prototypes without having to change ever=
y
> > initializer.
>
> Nit: For consistency, I suggest also converting the few remaining
> kernel_param_ops instances that specify only .set and no .get, such as
> simdisk_param_ops_filename.
>
> --
> Thanks,
> Petr

for the dynamic-debug changes

Reviewed-by: Jim Cromie <jim.cromie@gmail.com>

