Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FBCCAC5AE
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 23:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZJ1sgli7ptqR62/CrqjdmqyeswCTgFuJHQ9m7NV2USY=; b=bSygagggmhSEm57MaF4mFD/9rN
	97flp8pEWeGfy+dyyq1vZv1maGXfE208F1Ds34nIR/BLrSPJxmGgAWIhPQCDaGfprRuTg0n/m6Ccv
	9DkdpZHfvxofCRbEmuFvmk02CpMkT8FuwHaghsdmd0KYqAUHoS4AVY449jPguhvfF+q5XgA3KeZrg
	HM+Jod9NxjHHFnVmKRdij4XVfZFts2nKXF5WAl/zZSWKqkIfXBccStWiYyHIBbT+jozHb7EJKj59Y
	wMVAAGxh7GzKjSnINg51ydGbSFJbYbEDYsR1Kwy7pFDGuL8PblbAXgtEhWOr4B9NfP3xSSjc6gz20
	EBE3quuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1YtG-00000004g1q-2uP4;
	Wed, 24 Sep 2025 23:27:14 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1YtE-00000004g18-2Gs2
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 23:27:14 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-271d1305ad7so5844975ad.2
        for <linux-um@lists.infradead.org>; Wed, 24 Sep 2025 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758756432; x=1759361232; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ1sgli7ptqR62/CrqjdmqyeswCTgFuJHQ9m7NV2USY=;
        b=DAG0IUcyX/4VR5gAT6z5eHRwuJp0TQ3VGRCov8czmfGQSBKvaZw9AKVgc6O4prD2SE
         ZU7qiKidd4BbS3LAkSpm52KIN6oXtyBgzrCnHpOJFjYoxZOYpy+BPjcpN6J8DK63Lrig
         lVn3uxD0NXXXh+eztDMjoLNLbk1mrk6z98ph3AMbhygHM49blpLQhOvd/qxfTDeQM16i
         lpYv9qXeo8I5Bbfh87J/Rn3v5gTAygAxCT0rfWFNWnjGSo3UpROmXpWFx3PJTEv+6rUm
         ieLNNQMtUZczpSLuYCiuCI4VokIPRrV1M6bb+VoR4OeuUmq7fcSlxtOkmPV4iEgRXj6M
         zzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756432; x=1759361232;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ1sgli7ptqR62/CrqjdmqyeswCTgFuJHQ9m7NV2USY=;
        b=rFyXdCU9WSoVorryJYg/DT9WGteli7WAurmFfUZlF/BgAdUi2fZITyq/9zPOXa1Sso
         t2aNIRaBqGjwmYO5wh3bhyqBfo6CFKwbjLeV+4LC9PpntjfHLyIS2psmWeabdJFgzy4B
         ZPSRYaJhqOnsDfQ44A4Gr55ZXuEzzyKa+P4HkKWM47v+4PmIcxK0HETqdsH50lcejngS
         gC0W+oFEHxNMBcE9+nDHL/PtRacujwtL5IHvItrdZccdMvaW4o8fLf77xQ3GqiKgKtui
         YsEfSQYSWGxgx9M40QUJTCU4SQwgO8Hns5k2s027xjES4iLA0NGwGumg+UfxLtFdyB39
         hCWg==
X-Forwarded-Encrypted: i=1; AJvYcCWxn5860YGAmO1DwLTDKUXRPD4bp3Lhlu0AZaOZQvX1ibW9V8YpdEkhhwmOKrxYQ0vvb6eZYTE7DA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxcB9d0famiXPpT4Sth+NLada0wgjuObpHcQupai1y8ngFy+lFG
	oIfK4WUtzqtpxBOyfbL8HzaxB0rk30mE/FRcvDat7AuhBhHkUeg3QW7z
X-Gm-Gg: ASbGncuBWM/gx0+CczehyXWxX3e84jRlE7+hVaNoyDNrGkFFIDolEylZrmCqL3EM3vR
	rh5dygapH0likr5/CecJM8dT+nb3PvGHbDAzV0sNlp5TezfOvL3EdbxqxJVW2JT96nydyzLS99/
	pCDiecGDSDE9WLalg5uY5HPPXm3Jf2Tcwb5xTBuksWW07Td9dpVP2e8dKvHSXn3BBUBehveGnda
	Y4+YqQ+7MioPl8+tpXGqztK2vbD5XfVD+svVXdBru4oZXGDfBuAXFchhPFyOGCtTXId8jFSDbmL
	oBAgBNV4SfnEUCoiw+U9XGVocuY3DpqKcQML+PmDg0kLCfnldDd4+npDfDOGoKTC02pcB4WQ3Vz
	3bLFn984dAuTvsgDnKi68P3Nw0dtavP3yiKuUHmsXguFp3o6KqmOPMZWJ6dR8y6S0nsRTTtWnSG
	lFSzIRao0Kr8ViQJv/7SJC2A==
X-Google-Smtp-Source: AGHT+IH/KDLvQBQ7UfQ+ug7/uqqc5vZ4hRiu7RY+Ut1AjNGo+pZ/b3uV5AW21gKl38+5adHmTwsrgg==
X-Received: by 2002:a17:902:d507:b0:265:982a:d450 with SMTP id d9443c01a7336-27ed4a492e2mr13671305ad.40.1758756431589;
        Wed, 24 Sep 2025 16:27:11 -0700 (PDT)
Received: from mars.local.gmail.com (KD111238238118.ec-userreverse.dion.ne.jp. [111.238.238.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab64c7sm4012795ad.130.2025.09.24.16.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:27:10 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:27:07 +0900
Message-ID: <m2qzvv77p0.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: arnd@arndb.de
Cc: johannes@sipsolutions.net,
	geert@linux-m68k.org,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <b55251bf-625e-48c3-8c60-eb4f8358f397@app.fastmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	<m28qib8g1r.wl-thehajime@gmail.com>
	<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	<m27bxu949d.wl-thehajime@gmail.com>
	<CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
	<23adb61e95275251e459513a03ab7d2bcf1f2e07.camel@sipsolutions.net>
	<m2zfak7mnd.wl-thehajime@gmail.com>
	<b55251bf-625e-48c3-8c60-eb4f8358f397@app.fastmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_162712_579443_E682B2F0 
X-CRM114-Status: GOOD (  24.08  )
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


Hello Arnd,

On Wed, 24 Sep 2025 20:03:11 +0900,
Arnd Bergmann wrote:

> > currently nommu UML doesn't come with using PCI except building under
> > kunit (ARCH=um), but I have in my mind to use it under !MMU
> > environment, so would be an option in the future.
> >
> > and this series doesn't include PCI w/ !MMU.
> >
> > so, I would propose the modification to revert the MMU dependency when
> > time has come.
> 
> The reason why it's currently disabled is that it was causing extra
> work to fix build failures in random PCI drivers that individually
> have a CONFIG_MMU dependency. Since we know that none of the NOMMU
> boards we support uses PCI, this was an easy way to avoid work.
> 
> While there are still developers that care about NOMMU Linux
> and test it on the platforms they use, the NOMMU build failures
> usually end up in code that are irrelevant for their use cases,
> so neither the platform owners nor the driver authors care deeply
> about fixing that combination.
> 
> If you want to be able to use PCI drivers on UML-NOMMU,
> you can probably use
> 
> config PCI
>        depends on MMU || UML
> 
> so it will be ignored by the build bots on other architectures.
> You'll still have to decide whether to fix driver code when
> regressions in PCI drivers happen, add 'depends on !UML'
> to individual drivers, or just live with randconfig failures.

thanks for the detail information.
yes, when nommu UML wish to use PCI drivers in the future, I'll take
this approach to be able to use it.

-- Hajime

