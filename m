Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BADC7115B
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nfj472nEIt0x/8o/mwSyE6w0gQhW/2elN7P//R13lvo=; b=JkmfvnBDQLu4fajUJtdAyIio7I
	eCfAfcgnlTgKP+/xDsAEZCj3BzSf6nJaMvonSucUqQ12BZZ+GF/bWz4/XA/FCWJnoHMzMx+74qirM
	oTCVvdzDwW1yXtOeAl5Q/rx86TAS0rZ8Zr7xfl7m3B1EEvvkGW3P4MLQgsc5DmFCxMAn2adMjEuQM
	NUrcHtfT1frhcZSkvzi+YPTPtnp+c/r4IMgwgxgu2JRF36DsMozQw3KYiLblOQoANZRIl6mPsCuEQ
	nMo7lHOaCXQC2UPdU0zwElHvcoNSgeQKfv26YLQSIa/z1STW9v4qS2CLTbnuMmsVh/msmrCuCMrHD
	MOsnZ2uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSHVb-0000000DXgO-15hP;
	Thu, 19 Jun 2025 15:48:59 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSEq7-0000000D6yO-1D0M
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 12:58:00 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2353a2bc210so7033735ad.2
        for <linux-um@lists.infradead.org>; Thu, 19 Jun 2025 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750337878; x=1750942678; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nfj472nEIt0x/8o/mwSyE6w0gQhW/2elN7P//R13lvo=;
        b=hMLvorOCSVbG9T8nfL26VJovWi8AmrZdqd+l6TWTb5G6QYiU/8YslhYE34svYu6Qvc
         w6oBYYYbQ7pt3+/tp/QyUgy8cvtWkI7FsyAAQ0Nagza028UIRQpsdeGyVk5Vw6hrOpCo
         OIJ1PsdOynu42mrLWQlnWHcmPZDXStez0ckY6h35iZ2iOiZKVxvMeu63VS3B2FJaJBED
         bXpnO/XLAioHo5WnQpgafI3TsqnnKQ0+j6CDfBZfA7hI/yAVBV7BRHlMVD+p5s17HxJp
         Z6YjYlGtVflqcwyjWJnFjFt0nxKOFEQthyAbqOi1HbG+CAcdbvMyCT0rfstImz1gJTVo
         vPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750337878; x=1750942678;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nfj472nEIt0x/8o/mwSyE6w0gQhW/2elN7P//R13lvo=;
        b=as++tIzMePoPOmkR3QckqM62M0Yv/Rk1xKU3A8P+3lILvIlltL9r93Kq3pz9UoHaAb
         rZtKhRr2/qiLN4SchCHC2VYaOP3t2721Fk72epZbM4YxixsdbB2mnw54/oIM03s5l8gl
         BM0U+WiPiYiaOgFfnztjpIngwqXf47Yy3YsU/dBtYDBZo4BvCB0OADgjCEuKcyNLR3a5
         7EiY1sh3Os7P4ie8WZQCa5zf07ef3v8R9/E6osZwovMkxUErpEwqDb/p2PquSzLi3vuB
         aSxRuDPL6+Mddw1T5M+GQ01iF2j21BuQNL/+q10Vxf87oEQnHJiU1FjQn/14HTcfQyA9
         Y9gg==
X-Gm-Message-State: AOJu0YzfqGqhHtsOsNBMF8M2to0d5N8WIcb4LHpDX9pI+Fe0eMPY0jA9
	txRgc8SesGdXd1XzBvviNLuCt86ZZ8Xjds6EaWetOLYNivuuQ3oyqp+a
X-Gm-Gg: ASbGncvMDMT/cMST9NsGdj2bHlYboS23scsDZc+5TgIlLVIaPwrLs7KJM/PvffFuyks
	Xg+MeTmVJN6h7rdZZVx6/Sw0lGJUmA2uYCjsYpJELLuCHW2+a/gSwTN/But0Oif7uoo0wd/NwFn
	JMFXTzlSn4/kAs2bu6C3bqLD4RG0rUi/BkP+U0dZMsqDi238MR2fGyVGI9SeZVeI9eLZKGS32iA
	QvwbcUOrHUJqy2t+y+lHyN80fnka8Rb+y+EnU07Q+brsbyxDHOC8YQFmlG+d7uwTf11H2k/7X/6
	4Bak7HpNOljLJuSo4lpI/VVZ1i2Jg8q2lLYXG0i5/50LI3o/tKlM7MgYZJEq2TxWa+SPqsPtTVm
	yav94DRIqZ5rbjG2V5wP8EZSwv92p02pkyLd/7hLtr47l9+uZ
X-Google-Smtp-Source: AGHT+IEcS8PC34Qc1drEU4mGIDe5xqm3bz0ahIefSK6fW9WWRz6ZRz1DLuPVhxl2BM1IpwlbBCb3fQ==
X-Received: by 2002:a17:902:ccc8:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-2366b3fe71amr319874135ad.50.1750337878399;
        Thu, 19 Jun 2025 05:57:58 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de78ce2sm119250435ad.95.2025.06.19.05.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:57:57 -0700 (PDT)
Date: Thu, 19 Jun 2025 21:57:55 +0900
Message-ID: <m25xgr6g8c.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 07/13] um: nommu: configure fs register on host syscall invocation
In-Reply-To: <2231a777eef3cdb339fe98af4618f958ed658df6.camel@sipsolutions.net>
References: <cover.1750294482.git.thehajime@gmail.com>
	<2863dab9b3f9d6536b73623398a3f39e4ae70957.1750294482.git.thehajime@gmail.com>
	<412c514334ac14a992cab3e7b86170b96d60be1c.camel@sipsolutions.net>
	<m28qln6huv.wl-thehajime@gmail.com>
	<2231a777eef3cdb339fe98af4618f958ed658df6.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_055759_324707_F749A52D 
X-CRM114-Status: GOOD (  33.39  )
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


On Thu, 19 Jun 2025 21:38:47 +0900,
Benjamin Berg wrote:
>=20
> On Thu, 2025-06-19 at 21:22 +0900, Hajime Tazaki wrote:
> >=20
> > On Thu, 19 Jun 2025 19:40:49 +0900,
> > Benjamin Berg wrote:
> > >=20
> > > On Thu, 2025-06-19 at 10:04 +0900, Hajime Tazaki wrote:
> > > > As userspace on UML/!MMU also need to configure %fs register when
> > > > it is
> > > > running to correctly access thread structure, host syscalls
> > > > implemented
> > > > in os-Linux drivers may be puzzled when they are called.=C2=A0 Thus=
 it
> > > > has to
> > > > configure %fs register via arch_prctl(SET_FS) on every host
> > > > syscalls.
> > >=20
> > > Really, I still think that we should "just" get rid of libc
> > > entirely
> > > inside UML. That would avoid so many weird/potential issues =E2=80=A6
> >=20
> > I'm not sure if I understand your point.
> >=20
> > Q1) what do you mean by 'get rid of libc entirely' here ?
> > =C2=A0=C2=A0=C2=A0 do you mean the following code block adds the depend=
ency ?
> > + int os_arch_prctl(int pid, int option, unsigned long *arg2)
> > + {
> > +=C2=A0	return syscall(SYS_arch_prctl, option, arg2);
> > + }
> >=20
> > I guess this can be replaced with inline assembly instead of using
> > libc's one.=C2=A0 but this is the code under os-Linux, which I thought
> > we're
> > allowed to use the host code ?
> >=20
> > Q2) "That would avoid so many weird/potential issues =E2=80=A6"
> > I'm new to this;=C2=A0 I'm wondering what kind of issues did you see ?
>=20
> Oh, I am just being annoyed by libc in general in UM. It isn't specific
> to this patchset.
>=20
> An example is that we need to keep malloc() working for libc. Which I
> would think is kind of weird. Or we had issues because libc turned on
> rseq and that was inherited into userspace, causing random crashes and
> such.

I understand, thanks for the input.

> > > Doesn't change the fact that FS/GS needs to be restored when doing
> > > thread switches and such. Though one might be able to do it
> > > entirely
> > > within arch_switch_to then.
> >=20
> > I believe this is already done in arch_switch_to.=C2=A0 This particular
> > patch does the control to the host context.
>=20
> OK, need to look at that again a bit. I haven't really wrapped my mind
> around how everything fits together, so I probably got some stuff
> wrong.

anyway, thanks for your time to look at this.

-- Hajime

