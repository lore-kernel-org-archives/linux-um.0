Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1125FC7EE31
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aeUHbst5u6uAyR1ycfeU07wkwThxzbqj2XsMrc/HWnM=; b=K70Sx+c8WjqXDq+ELPo+Mc4o/n
	0Ig5XGswcemnWgnams25ncC5g9RGl+dUbHSQBbtCvCQeDNTH/i3BzAV9NEbNlRkJxr+Yn13tX2/aL
	w8gADCFaISLRuKh/iXL9Kg2E97w2XoWt4kY5HKFjzyUpm/UK/15SXJbXE0G9wNRg/gGQ/iW8o+kCT
	XsWe6d/A2epnOKw3CFYNT9jHT1+ykSIL83ni9V5MU7dEB+Lgzr5kKYFfSq4+j1+DoDedhJME25GJr
	emygIXKpLJ5GJg1VNfx23BuK5Oe6VJv9VcU639NWhPpQUItjh6hQ9MOG8hfpPZKbhHxA+SeYxpsPS
	d4gHlagQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUU34-00000009T4R-35ZG;
	Wed, 25 Jun 2025 17:36:38 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUPVh-00000008fQQ-44GK;
	Wed, 25 Jun 2025 12:45:55 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-553dceb342aso5263170e87.1;
        Wed, 25 Jun 2025 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750855552; x=1751460352; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeUHbst5u6uAyR1ycfeU07wkwThxzbqj2XsMrc/HWnM=;
        b=iHMMLKKkZbyMNf0uO943QLtDqhfni6OdXDGA+2UtJHbaDvwVgFL5ois+rQPhQY3B2c
         xSLfnteipooZgx0Kdsr+oOetIe/BU+CeCvA0BqWBJZQFeeLbUs/tca8qrANWioQXODVH
         jL5alhoMAycX9ryzdZKQzs+5Pz+6mVQS/yQXDh+cEfyyYoz5mRjThPr8krp3hneVO/M2
         sjdICbMkVN6NMp1aU5UQLmekUINe24mYYLDzMzrVT9x44HVCD+qyD99xNC4/oNj6w/QF
         bedoL889dNFIEUnm3H5OgV0mNZvZU7t+Qf7BfAR8MB/RkEv3saXJDrGnQmTr2S9nNf3L
         Ttng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855552; x=1751460352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeUHbst5u6uAyR1ycfeU07wkwThxzbqj2XsMrc/HWnM=;
        b=unIZxBTe3pEQ0t8DyI3JBgia4MjZ/gJzbCRcqMhBU4ovfHDh3QujRE1V/R5OPpUFXO
         aw/ktkHWSDqBxi67TjAbdecQswKS7hfHpS5pX6HJoGQ1+WHC5NpQ9kSjPFaHMYphMGMs
         32EMuZga6GjNpMWCS+ti6YRrzgoTAaw34fSASmVLvodLZesuvNBAJF5y6wpt1l13ePzO
         qruIHjDbYY5ZHU8ALstgV9sYtOcZ2n4nRM+wKZEvedusgeqQlBHqLRWhlfN0MgedN8OI
         EKFBRMp772aBFWsNg4w1krVNZ//LARjmLdIfd/vxHF8RBQ33JacZ6eJ21mMX+rqPZYO0
         Y5zA==
X-Forwarded-Encrypted: i=1; AJvYcCWozvNBE+QmWJIuTXrLUsyq2/2xbSegscEbYfEvZmhAUDtu71G69ClzsWDJit9XXrgfzLBT2rnwpw0=@lists.infradead.org, AJvYcCWrvqh9W5RWiOWLHZBZAMKErItYkQ/yn0qxyPK619l4kr9lCT5vtALK26DkuBsnUFa0VXWmG+C/GIQYDFfWVfFI@lists.infradead.org
X-Gm-Message-State: AOJu0YxmfjWeQWaSVXtX/igegDTF2R1BdZjiGp95rDJxxGbMqspcMW/S
	XkHPTarHb/sNaP81P4g8v5mcTYprMFdQNNOLR8Oaagp0ADgkG31QXyQ08e8FQJtXXd91Alq+OWi
	F3cSAUoiUVbvkYwIzj6obYhQwr6rfBXA=
X-Gm-Gg: ASbGncu4gRKU1dc6zoywqC9Jbf9QhYETL5BAmTkfjLOsBRysbrTfNWjxAO+MFrkFEyF
	FOPtf238/YMV35G6r8BHFx/IgJgLF3fDNluTVR47tWemvdwEBhiVKn5waQ0/TxjdCSNPL5S/ZqY
	m03sbUAMBZ56BnKMUlkwtC54pMtmkULfdZ9TwmNrtr6Q==
X-Google-Smtp-Source: AGHT+IGd+VQCTiJwy9G1ykD/0Nzx0GAzsfPqUCVqghBLVmwOBzPwEbsyyeyH2J2LllM1nMa0CK079KR9Ekpv1ITEkm8=
X-Received: by 2002:a05:6512:1591:b0:553:abe6:e3e7 with SMTP id
 2adb3069b0e04-554fdf5cefbmr869898e87.47.1750855551832; Wed, 25 Jun 2025
 05:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250625095224.118679-1-snovitoll@gmail.com> <20250625095224.118679-10-snovitoll@gmail.com>
 <4d568111-9615-4fba-884a-f2ae629776fe@csgroup.eu>
In-Reply-To: <4d568111-9615-4fba-884a-f2ae629776fe@csgroup.eu>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 25 Jun 2025 17:45:34 +0500
X-Gm-Features: Ac12FXyn774raFC9M0P_m_Yp5o7tYNYYaJPlJbUzpj4u5O7z5JIOhc_ux4m2QSg
Message-ID: <CACzwLxgVj3YD5faPj=09Z9e4WSEe-sD7Sqn4jhaT7eiePaUUMw@mail.gmail.com>
Subject: Re: [PATCH 9/9] kasan/powerpc: call kasan_init_generic in kasan_init
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	akpm@linux-foundation.org, guoweikang.kernel@gmail.com, geert@linux-m68k.org, 
	rppt@kernel.org, tiwei.btw@antgroup.com, richard.weiyang@gmail.com, 
	benjamin.berg@intel.com, kevin.brodsky@arm.com, kasan-dev@googlegroups.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_054554_008975_9EB1A494 
X-CRM114-Status: UNSURE (   8.24  )
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

On Wed, Jun 25, 2025 at 3:33=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 25/06/2025 =C3=A0 11:52, Sabyrzhan Tasbolatov a =C3=A9crit :
> > Call kasan_init_generic() which enables the static flag
> > to mark generic KASAN initialized, otherwise it's an inline stub.
> > Also prints the banner from the single place.
>
> What about:
>
> arch/powerpc/mm/kasan/init_32.c:void __init kasan_init(void)
> arch/powerpc/mm/kasan/init_book3e_64.c:void __init kasan_init(void)

Thanks, I've missed them. Will add in v2.
I've also found out that I've missed:
arch/arm/mm/kasan_init.c
arch/riscv/mm/kasan_init.c

>
> Christophe
>

