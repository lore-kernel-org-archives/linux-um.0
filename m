Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7DEC7115A
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2osMFaTXEoQKV6XeTZU/cqIVMzN2KvnQjbjxFGVH8Ts=; b=TXiApbpQ7u1vd/v473g0DeUhU2
	1ATdBW4u7sHZfbuex37tw4IwaR8HXCQQ4yXcufuBvGR5w0Es/9urS2GcqyHnGYx8Dlmj5GprrdIL/
	aaX95OrrpOxnQaqeITZgb4wZEodld8msr91DEH+jv4QqdpPnlg/3juo8FOJbdFP3G44MJBbwwCOrc
	Az4z5Zxr5OGakpijvyIxlYnoNTC21s1sW7H1NpiR1FMVEdmoLqIbo5Pkvn4GIqQTEbJ6leW5xlnKV
	JJbrYGkj9fWXfbc9aDlhPOaK8IEjZAaOrCY4r3ijoiQggRKrBDtxAiV3LW01aNHhmL5IUV0b5vOB9
	YMsDZWSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSIeb-0000000Dek1-0u5L;
	Thu, 19 Jun 2025 17:02:21 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSEI8-0000000D2IA-3Myk
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 12:22:54 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-747fc7506d4so521533b3a.0
        for <linux-um@lists.infradead.org>; Thu, 19 Jun 2025 05:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335772; x=1750940572; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2osMFaTXEoQKV6XeTZU/cqIVMzN2KvnQjbjxFGVH8Ts=;
        b=daB4PDa/ejpBz5CZmp9d5obyfu1uTMNDwkHN6ZqaW7D7L+UvOqy7ckuDAdyF0KM5xg
         l0WMXvw1lIJRCCXVD1ReN/ANfYxjqU/Vy70q0eGJnMsDdJWWJuZ2TwjJup87dW2WH+hq
         W1KjS6bIXImcbQortxYYio0XLUdcPJvEniJXOmU6tQQQjZiNiQq+kspqY+LSnFqI+XbH
         hbr4tzK5AJGaCD1FmYltxz/tMc8uUvZi0ZxhgzNxVieLCwiyKPAANHHY7iurHAcrCA34
         vnQURGYKk6C3Jbh6FSdgMQg4jC7bW2Tcm+hb2LWSK+66BqFZIgJARFutR4ANCBoXQ8ip
         NSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335772; x=1750940572;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2osMFaTXEoQKV6XeTZU/cqIVMzN2KvnQjbjxFGVH8Ts=;
        b=LHUXWMptxCeYz7KW4baDdAcxWISF/SAb9VF/HW9kTSN5hz2ylnlGlWvWSkQMvdwe3t
         rQO6a5nyLmXd8dp2LzWKGJpwNgute4jwZ8GwjwB8By4uLGWIv2fp+ZQM5CHlNDPkunyO
         VCW7uxchwxA4rULnXw+w+J7Syhvfyql7Im7fj5fENL77UtKSX6iP270WXxa1jb8NMzOX
         H30nGLYShp05RgMDkiPeYsIg+gvS/kNYNtcKNc8oQB2fvOGo4AoUPaoLX1YhWYwhu1tY
         tCZSGS+tuubRVQxmzjWvrcKs1G0mW3L/C/2riQwd/3AZRJ3H1nABja6mitOty4++Vr16
         dSyA==
X-Gm-Message-State: AOJu0YzZT8ll6RNMDdo4qPl5aXXtRive28QwW14i49Vlq0WymLumaR49
	IOBiudza4MVyQeMR+QUulVyAIpr7365acZUpQIKsU7U6Q6LhKEoofu0TgGr08Ogv
X-Gm-Gg: ASbGncs3HHeeZRQD6dcOl9N+QrpCVdeezfk8Ntza/6+fq3OufOCGJnECStxZ/qJA2T9
	xKElClnVwlCfCuDr3q7dSi9VPHdaIyJiyk+mSIlrYp12TzUWSmZudbwz/lhHMYHW0MsiOG7HkyN
	MjnCf6mcL+1+Fzguhn3rzxqkZzOpovQgAadV32gUcHbp2v2LCH/QUVoI3RafjGRp3egOJ/M6GQW
	MNAFTDOmrfFeZEOENaN+4IKEicyvJsS9Z5rZahX09DyPIa+GPfg7tSi5uYVGYdSqpUR/QgW22K7
	94QM3A7U/MaHPbpoW7+08QTOVwAI9jOF/WWeHCPxF0lRNCgVD3//rSt3yWSGrzmnh6kTQJXspRV
	jzCl6zffed97wvpbDMVgs5C5vDYIl2j0+4CJi5jUaxerhnQC8bmJCalfX5DM=
X-Google-Smtp-Source: AGHT+IHZXFvkQQikWG9tX46V8AE6d5t+fw6ZH4UqiieeOGsznRlxIpsWhj4URdfIoZ5nSPjiRW7/GA==
X-Received: by 2002:a05:6a00:9454:b0:748:e8c7:5a38 with SMTP id d2e1a72fcca58-748e8c75d0bmr8642598b3a.23.1750335771864;
        Thu, 19 Jun 2025 05:22:51 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748f0c77b3fsm2947264b3a.19.2025.06.19.05.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:22:51 -0700 (PDT)
Date: Thu, 19 Jun 2025 21:22:48 +0900
Message-ID: <m28qln6huv.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 07/13] um: nommu: configure fs register on host syscall invocation
In-Reply-To: <412c514334ac14a992cab3e7b86170b96d60be1c.camel@sipsolutions.net>
References: <cover.1750294482.git.thehajime@gmail.com>
	<2863dab9b3f9d6536b73623398a3f39e4ae70957.1750294482.git.thehajime@gmail.com>
	<412c514334ac14a992cab3e7b86170b96d60be1c.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_052252_841100_E761D618 
X-CRM114-Status: GOOD (  20.35  )
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


On Thu, 19 Jun 2025 19:40:49 +0900,
Benjamin Berg wrote:
>=20
> On Thu, 2025-06-19 at 10:04 +0900, Hajime Tazaki wrote:
> > As userspace on UML/!MMU also need to configure %fs register when it is
> > running to correctly access thread structure, host syscalls implemented
> > in os-Linux drivers may be puzzled when they are called.=C2=A0 Thus it =
has to
> > configure %fs register via arch_prctl(SET_FS) on every host syscalls.
>=20
> Really, I still think that we should "just" get rid of libc entirely
> inside UML. That would avoid so many weird/potential issues =E2=80=A6

I'm not sure if I understand your point.

Q1) what do you mean by 'get rid of libc entirely' here ?
    do you mean the following code block adds the dependency ?
+ int os_arch_prctl(int pid, int option, unsigned long *arg2)
+ {
+ 	return syscall(SYS_arch_prctl, option, arg2);
+ }

I guess this can be replaced with inline assembly instead of using
libc's one.  but this is the code under os-Linux, which I thought we're
allowed to use the host code ?

Q2) "That would avoid so many weird/potential issues =E2=80=A6"
I'm new to this;  I'm wondering what kind of issues did you see ?

> Doesn't change the fact that FS/GS needs to be restored when doing
> thread switches and such. Though one might be able to do it entirely
> within arch_switch_to then.

I believe this is already done in arch_switch_to.  This particular
patch does the control to the host context.

-- Hajime

