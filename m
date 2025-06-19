Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D80C7EE24
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SaXuixrWp6MYXZLfgSHfhs0/fVgTYn7J90oes9s/Ux8=; b=a0JvhmgXWXCoFpPnNlc0Qnqu7p
	ETT+044SNAJYIVVTVUyBrvfX/oah+5tyIYcp2xKDWHCWMxCklTgHirp0vO4pUeL4szBQaw3e+J6CG
	kQnshx0IKIHH5HgFyXldeMMZW2ZW4b10qjUa+1TwdWf4DdSp5hCCEajp6sJ9L9sFsAMETu3zj+jO9
	TLxNtAL6HVmBBztLX+jK27d2B4xMZuXwKRbPlKbPw1L+klVL2EWwo46XsiuT2bLE4l5AuobcgEYF2
	JlQWstPf8FRDUi35F4eSE1OOfkcQ0bk+EUXXFJHEhYtOF/J54PK4Go8jCNvvvXWmlElBqsT3f2eNe
	luhfkdsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSIea-0000000Dejn-40yN;
	Thu, 19 Jun 2025 17:02:20 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSEHz-0000000D2Fo-118V
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 12:22:44 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-747ef5996edso541779b3a.0
        for <linux-um@lists.infradead.org>; Thu, 19 Jun 2025 05:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335762; x=1750940562; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SaXuixrWp6MYXZLfgSHfhs0/fVgTYn7J90oes9s/Ux8=;
        b=gpk90tSTb/Kr3sPocqgJQLCpTqdMnVDMLUikCyWbxn9p3p65ttUVf6MW7cioyfJZik
         o5MDCJPY59EAfE4UEof9QZ24FTEFJPbzGPzjDjUhbJAPxp/w7d1cZJshky/ADajIrchD
         xxtSsWw7pzzr4wjeTL/NpjDIjnnpf+tNihwBHIXsm/HmRSh8uiZs831u57nSLrrPHcEl
         iz7obqiygzYzUCrtwXnWd0qq86CTKWVVFP39jtkxtJWAuEwvqJVj5gNE4+Bv7pwMB0rq
         MRXSOvU5uAx8auOAYMBeVhfwwRghxg6lPE01bKZFcvN6IVpBEEflhoDrTljSnAna6+t2
         lcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335762; x=1750940562;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SaXuixrWp6MYXZLfgSHfhs0/fVgTYn7J90oes9s/Ux8=;
        b=ve4KzfgTfaVNtYGmDkRJEgDhZoPa3GdHON9QAxh8fmOuF7GISrw8dUDGanKE7OOsNr
         cM9Pw562hxTKZt/NWscDqlSW1leWijn4GJlumTD2MOm/WJBbWRL/09UIIQwx5x+BNcqs
         Itr0MrrRGYX713xCDTEprXu2vJjL7gUGBR2rgypN051/c967chJIKfHlACZ0TBC2XFxn
         hf9aTiz/LG2SAqFYdFkyWDpJQShQM68evojblqd7ooFK3fqn0EN6lt1CKqjFrSu4z6Qz
         2u8r5FjF6LbtKXK4DHldZgaZs9E/zWZ+ggBBIVmY4FoUJleSfVjw0DJ6hLC5/mL90MiR
         4Ymg==
X-Gm-Message-State: AOJu0Yy3CSgvjQManNisuFjXeiWLZHDSQqMpXCOOfJO1S6zkIRVcoR4o
	IR38PqFaTYPdhEYVpdUjUqYO1weOWAf4UahS5uW4SDn6XF9Ujip1SYosBRFEg5Mx
X-Gm-Gg: ASbGncs2z72UOwaaTuLIelVtS4Lb8ewkFC89sbLKyGdGI1j95n+i84hbWVwFxnIRqAB
	wOPwPrKMSijtIL3BKH1+1fTakIdTdFavbYNR1MXEx/jhXuDM+F+Q0ZCC6H0Nvhl8h3R2gfM9G5v
	6Eh2YKgQ0I0zGXMZbqFPwls/VOHAgj9+6IgGSHlDOSFb48MxzzLUWwpKXxq+rdkOKHsBpn9VHoS
	nJKd3GzLy0TCnzf/15ai44IakWhOaUCk9jL1oaLNxKHXKLxQlkfrb6+RI+JpcIVX58JM5/CZEU0
	r4+v250sJJQQL6L/HFDJOA9krOAmy0vCGyuwzZlMIolvwpPSkIY4l8ocLc7fhinpxp94yubhPK/
	ee6iNLBwmk6grkPddMptXf+60QUgFrAtsEwMPMYTu/Ss8y/vcD50yru3JsGg=
X-Google-Smtp-Source: AGHT+IHZxLRTpx9hCAxSDNhzjhuyoOI6Wrn+VhpMQGgP5vgN7RFUZno+5odFWDhNh6HlRZSaShry2A==
X-Received: by 2002:a05:6a00:478c:b0:748:e0ee:dcff with SMTP id d2e1a72fcca58-748e0eee3a9mr7464159b3a.11.1750335762257;
        Thu, 19 Jun 2025 05:22:42 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d255fsm13522153b3a.172.2025.06.19.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 05:22:41 -0700 (PDT)
Date: Thu, 19 Jun 2025 21:22:38 +0900
Message-ID: <m2a5636hv5.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 06/13] x86/um: nommu: process/thread handling
In-Reply-To: <55ff3fa8f19c61745933e7814029cef526271eb4.camel@sipsolutions.net>
References: <cover.1750294482.git.thehajime@gmail.com>
	<031503649a24799bff082cf917c36550f4820181.1750294482.git.thehajime@gmail.com>
	<55ff3fa8f19c61745933e7814029cef526271eb4.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_052243_279960_6BEE8A2C 
X-CRM114-Status: GOOD (  12.76  )
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


Hello,

On Thu, 19 Jun 2025 19:36:04 +0900,
Benjamin Berg wrote:

> > +void arch_switch_to(struct task_struct *to)
> > +{
> > +	/*
> > +	 * In !CONFIG_MMU, it doesn't ptrace thus,
> > +	 * The FS_BASE/GS_BASE registers are saved here.
> > +	 */
> > +	current_top_of_stack =3D task_top_of_stack(to);
> > +	current_ptregs =3D (long)task_pt_regs(to);
> > +
> > +	if ((to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] =3D=3D =
0) ||
> > +	=A0=A0=A0 (to->mm =3D=3D NULL))
> > +		return;
> > +
> > +	/* this changes the FS on every context switch */
> > +	arch_prctl(to, ARCH_SET_FS,
> > +		=A0=A0 (void __user *) to->thread.regs.regs.gp[FS_BASE / sizeof(unsi=
gned long)]);
>=20
> Hmm,  the comment mentions FS_BASE/GS_BASE, but here you only handle
> FS_BASE? Is that intentional?

thanks for the comment.

my intention is only specific to fs_base as I saw the register needs
to restore during this switch while with gs_base I didn't.  I can
update it if I see a real issue without it.

The comment needs to be updated (I guess this is copied/pasted from
the original arch_switch_to comment).

-- Hajime

