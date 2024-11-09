Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B9DD64076
	for <linux-um@archiver.kernel.org>; Sat,  9 Nov 2024 00:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8s1naaMTCLKcqneooY9UpL2oLq908kArX2vP95JWJ5k=; b=k3hCi1cY3d/T+dEbOTGvVMzTnB
	vRez+9lIupkfAb8Lyowi95r4MaFpUY9iDhGWNUtX2xxVZOtLURKH96ewEm4fydopSw6rfvfDuYNB9
	biHYEWtl5ZfhX0BiuJVnviVkJgYkOnq7yCT72fjDP6HXE2cibOZ6HrkT+KJMgq5WJAp1ZdtGPqncj
	H3nsHOKEFO3T5RFSp+AbWHX7L9oPH4RMoGvfoEdQP/8fekO0hfXzFhBL5nZy7oL5db2CxBLpLMD9F
	gIJz0Z25nzRjx5hCcmkW+81RP0MbLf63OqpqPZRtu0AOWSypvfMIloR5bGkEcFts41+pa9IsXNp9q
	EvhKQMww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9ZiA-0000000CNvE-31Xc;
	Sat, 09 Nov 2024 00:52:22 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Zi8-0000000CNup-0xwd
	for linux-um@lists.infradead.org;
	Sat, 09 Nov 2024 00:52:21 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so2265518b3a.1
        for <linux-um@lists.infradead.org>; Fri, 08 Nov 2024 16:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731113539; x=1731718339; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8s1naaMTCLKcqneooY9UpL2oLq908kArX2vP95JWJ5k=;
        b=RGTZqbY4UIk+KXkcqEb3sxH/Ewlv/LYWfYOTcHLA8ba6xZmBiRG8jGTQosl/DaB3UI
         UkL2DOaKKFvoR4iJqmT8TgsTAPAw+jv5YUommfyFZ/nW+eDYZMA0YNF6NVfVabmg47Os
         TRUe2F9r1VPIA5LNlJc2u+c4U+olUSHvGEItG4GWZEm7fm0zzsDncbyx5RObGrl+VtCW
         KXpOOXqunE14+zE4cRp+SBAW8o6QO94KKk2fXMDqGkpaeFjOu1q6Eqx4soZ1p2Nr9Ff8
         vYCPD3C75USzlI6HP1tzZhTKJQh+uJUjc9hk0VChxP8DR1H6SStBOdclS4lRn6KoRqbU
         pq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731113539; x=1731718339;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8s1naaMTCLKcqneooY9UpL2oLq908kArX2vP95JWJ5k=;
        b=NQdk+U1wK+0Td5nB30DMMzdmvoBb8XyXOde2miB4TGSFg7LK2wzanWhV3Lm3pFBbrp
         5Bwt9hHRBufTOLWZiI9R6mYM88Z5wSY0ygA+CK0n+NuVjSQtELS2x+1q0sx1qn8YbwZr
         j30UaOLy3hyQ88m2dxHan5FWsozxf9XKx/d5sBLlxVQ7kkMcQza/6zf4U/XQWHttw26X
         Pn4vnq6mLUSBW0NlzSwF54+y9iqonx+ByHI/om6l2UFvYM0QwVdvxP9eYL1evRj8bVxV
         IMtoEvwCUUaQs74ccEV6mEK4m+dPHvENIAIbIqsJYkfXaKMXee4YLTiSDLd1GTibPwuC
         sQrg==
X-Gm-Message-State: AOJu0YyNMXQo67m2pSTqa1A2ZEIv1tMI87U6GIxhGJWZl3ITuazAnfyF
	UL4HTRU4+UcxcBR4bauDbb2KiC3wPT9LrknHchT3vOa9SrZ4xV+P
X-Google-Smtp-Source: AGHT+IH1Dvs2+9grev6vA5oXps7G8Ko71XvjZ97J98tBFE/EBysMxm85cYZ4JTe+kdZisjqykkWXAA==
X-Received: by 2002:a05:6a21:9994:b0:1db:e917:5755 with SMTP id adf61e73a8af0-1dc22b1aff7mr6917140637.30.1731113539124;
        Fri, 08 Nov 2024 16:52:19 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7c76sm4506338b3a.48.2024.11.08.16.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:52:18 -0800 (PST)
Date: Sat, 09 Nov 2024 09:52:14 +0900
Message-ID: <m2v7wxfcu9.wl-thehajime@gmail.com>
From: Hajime Tazaki<thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	ricarkol@google.com
Subject: Re: [RFC PATCH 00/13] nommu UML
In-Reply-To: <m2plnigcxt.wl-thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	<f482739aa05abd80479804054e4affe23f0dc6c5.camel@sipsolutions.net>
	<m2y129hpx5.wl-thehajime@gmail.com>
	<1246523a29aeca3d727a359ebf8ccd931631e1ef.camel@sipsolutions.net>
	<m2plnigcxt.wl-thehajime@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_165220_326731_EF5A3342 
X-CRM114-Status: GOOD (  12.36  )
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


On Wed, 30 Oct 2024 18:25:18 +0900,
Hajime Tazaki wrote:
>=20
> > > > > - a crash on userspace programs crashes a UML kernel, not signali=
ng
> > > > > =A0 with SIGSEGV to the program.

after investigation with trying to save/restore FP registers, I found
the register is not the reason that userspace programs cannot
handle/recover with SIGSEGV.

the cause is; I tried to call (!MMU version of) userspace() in segv()
function if is_user =3D=3D 1 (I configured the variable based on the
address of $rip), but without returning hard_handler(), which is
caller of segv(), SIGIO has been blocked even after switching the
userspace process.  Thus no console input is processed.

With that issue, I didn't include the patch to mark is_user =3D 1,
resulting kernel exit with panic().

I unblock signals (IO/WINCH/ALRM) after segv() && is_user=3D=3D1, then the
userspace can recover/handle the SEGV signal.

I will try to implement this in a cleaner way.
Thanks for your comment,
-- Hajime

