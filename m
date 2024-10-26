Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA40D10BE5
	for <linux-um@archiver.kernel.org>; Sat, 26 Oct 2024 07:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QR4nkNQ6s0QG+i3Xc1et/grafV1vCXJl6gkJYf6b1/0=; b=xaPmFV9amnrEvDtU47ewOF4alb
	G/JfBwvz4L00wedeY+/fTFW+S+FXVHIRFZV3P91xymsL6vbhGfjRsNaVQGJPAc5J71dwOM7fyXaCZ
	vARzjePVmkG4kk2zyHsrMuItKJ07Kk95H1ePYLFK27AoONnYnCYR7ehRuhJ0Io3dC3XK0++nz+0q3
	0YheGSR8LgB1bn3mrAjGb9J+beY1rEBPI6qthGd9VALRU99gnn5vXSJl7wFEAacI53lEaVqY2DC+M
	V24sP/OBoTB1s1HhhzhS4dYoy2pqinLcPuIXjhBOxINOu/d2t9IkOZCMM1jBCTwPXc1TizMGNBEiH
	TNBqF0HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4bOe-0000000692z-27mZ;
	Sat, 26 Oct 2024 07:39:40 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4bJp-000000068Cx-412O
	for linux-um@lists.infradead.org;
	Sat, 26 Oct 2024 07:34:43 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-7ed67cfc1fcso1772641a12.1
        for <linux-um@lists.infradead.org>; Sat, 26 Oct 2024 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729928081; x=1730532881; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QR4nkNQ6s0QG+i3Xc1et/grafV1vCXJl6gkJYf6b1/0=;
        b=JoHSQrnts1HpGtPRche7i/lYua0iPvhMvWx7D6ozyiXHO19T2KawkgAx0prhAj2FBY
         qWmwm1RbzPnLVDafWLGkVOf5xY9SgYkzLI9ydNgc3ul/t0rH1uc1NGmr4LbbgTe1CRrG
         O0tVXKFXVubolNlrq/ppYtguifMRB9GadPcDRkV2aE/SDj2+7DHkLZJMu/IA5j7RihZR
         BmxK3Aiu/LZ31FaYIHObHSGy2KBEaeC8fumYKFleH484f6VgSrv6kU4ihgKDVFZgM8bD
         smwsEYe+0u/g1uUhtrIYfwpjCFGHlDmSNAwPkWSb8c9GLj26D3m4xl3om3Xl7l6ZuqLH
         +Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729928081; x=1730532881;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR4nkNQ6s0QG+i3Xc1et/grafV1vCXJl6gkJYf6b1/0=;
        b=UBXdf2AtuBjWP4slaDkaOoFNC/Ku8hFbce3y+9U73dUF2lExBtnL3NyNIjKNR8UsRd
         iZXdULpRE2X3Lh52lt6nLeO635SO2fpKaHpbAzIg+42/0izDFYnbKuLSDOMsHSy4IONY
         YAGElaMjR9y8K3te1fo2g3RNCPOMCML5eDhvNmZXxsNYDta1S/81E8L3BhsAExHwFYWq
         elu35U0I/8o8RnnKzXPOQvwp7dKKeTYzWU4UJvP7C01qcjT+aSRvyh6J0xZdosmuYy7p
         obEEV0XOKZn5jW5CQTVztNpvBE6CWMk/nW0d+pOu17wpCxjEDqH+bMJDBRaCBy+92D9B
         It1w==
X-Gm-Message-State: AOJu0YxnBsyCfMCJgNayC/HTfIp0GsIEFxD41o6uVt9Uft2JWJNz48bz
	R0ckX2wEH+afMAeDjDt7KMH/qpDNbIO9mncjVAa0zZ1hQ9C/iM85
X-Google-Smtp-Source: AGHT+IEi9sWjFVUIgCc+xnv0tZ0CUmspRfg5yxdk1XeC0Xp4D9apKlyn8t9hGC6kap65w1++0TTByw==
X-Received: by 2002:a17:90a:68c9:b0:2d8:a672:1869 with SMTP id 98e67ed59e1d1-2e8f11a82bcmr2391230a91.32.1729928079900;
        Sat, 26 Oct 2024 00:34:39 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e578001sm4817639a91.43.2024.10.26.00.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 00:34:39 -0700 (PDT)
Date: Sat, 26 Oct 2024 16:34:34 +0900
Message-ID: <m234kjiagl.wl-thehajime@gmail.com>
From: Hajime Tazaki<thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	ricarkol@google.com
Subject: Re: [RFC PATCH 07/13] um: nommu: configure fs register on host syscall invocation
In-Reply-To: <ed09a50887e876e7799626e03b47a603b43c0c8a.camel@sipsolutions.net>
References: <cover.1729770373.git.thehajime@gmail.com>
	<de4b12980873dac3074d591ab4ee0241d81c691b.1729770373.git.thehajime@gmail.com>
	<ae681534ae7c9484303c41522ec4b6a765a3d3ec.camel@sipsolutions.net>
	<m2ldycnwhv.wl-thehajime@gmail.com>
	<ed09a50887e876e7799626e03b47a603b43c0c8a.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241026_003442_053876_7D65E02C 
X-CRM114-Status: GOOD (  23.62  )
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


On Sat, 26 Oct 2024 00:22:48 +0900,
Johannes Berg wrote:
> 
> On Fri, 2024-10-25 at 22:27 +0900, Hajime Tazaki wrote:
> > 
> > On Fri, 25 Oct 2024 18:28:01 +0900,
> > Johannes Berg wrote:
> > > 
> > > On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
> > > > 
> > > > +static void sigill(int sig, siginfo_t *si, void *ctx_void)
> > > > +{
> > > > +	longjmp(jmpbuf, 1);
> > > > +}
> > > 
> > > Should this code use sigsetjmp/siglongjmp?
> > 
> > the code is referred from tools/testing/selftests/x86/fsgsbase.c and
> > the original code uses sigsetjmp/siglongjmp indeed.
> 
> :)
> 
> > I was struggling to pull the definition of sigsetjmp & co from host
> > headers as it conflicts with UML definitions of jmp_buf, etc.
> > 
> > Will look into detail again but would be nice if you have an
> > experience on this.
> 
> Hm. This is a userspace side so there shouldn't be much trouble with
> that? Worst case put it into its own file in os-Linux/ and don't include
> so many shared headers, I guess?

thanks, I'll try with this approach.

> > > > +int os_has_fsgsbase(void)
> > > > +{
> > > > +	return has_fsgsbase;
> > > > +}
> > > 
> > > Why should this be a function rather than just exposing the variable?
> > 
> > as it is referred in arch/x86/um code.
> 
> Yeah but you have to also declare the function somewhere in a header
> file - could as well declare "extern int host_has_fsgsbase;" or so?

agreed.  I'll update that part.

-- Hajime

