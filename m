Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F075E7716D
	for <linux-um@archiver.kernel.org>; Thu,  5 Dec 2024 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OnGmmFrWAxRJi8ATpOgUY9XrUxb6+O+nsaNSNpX8AXQ=; b=aG2Cv1vSDccpSenK1wuNXQCXDm
	kq7bO+dCDb1hs3171bdVOyGHUSmivgyrKmqvaSUlviMRZkZaU1N3V8m5Tn7P5c9aTAD0jGOt7w1zs
	wI+aV5hd3+EUb7BDeZirs13ILuknj9N2DoKIXOydzzLy18JLA0hJD1fL4I5RILIUorxyaHcooSCGx
	Zb9mff3entsXW75jCmLZkm4VVe2hbmqjDfta+VQGDSPeUPbjLAh4GdLjFEB36QHgsraHtzyt8N6NS
	Vm9IT5oGB9gacdONUtQexadTyHANXtwVP9ENmj2ZMfCEVdbWnANIBSIV4wZ+lAdRqdyB0iaCsNwsR
	e4LlBGHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCGp-0000000GEmd-2v20;
	Thu, 05 Dec 2024 13:51:55 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJCGn-0000000GEm8-2TZn
	for linux-um@lists.infradead.org;
	Thu, 05 Dec 2024 13:51:54 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-7258ed68cedso916936b3a.1
        for <linux-um@lists.infradead.org>; Thu, 05 Dec 2024 05:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733406712; x=1734011512; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OnGmmFrWAxRJi8ATpOgUY9XrUxb6+O+nsaNSNpX8AXQ=;
        b=fuzUJ1ullIv49DxMzBLaCaziTxVdhlihA9tqZNbIw59mqOcb9wPTG0VDyIpFYHUZBc
         m7XunAG1rJNw5/uSEzt3r74XXrZ5wpCtKzyMqBg1KdqV4U6fdcQc+aMf7kgMPRyei0F4
         5Nlpud3ckEdJcSho6DgadA/Ouy49ApTxbnA+GDedt3jidB77hsBS2BOE9FFyLiymWKit
         Ds/3od+eZlMQi+jiPWgqhPKaXurVVlcUxytDmQ6NZuurXfNiMfmZ2o5+g/EkNHhL6YDr
         Vmn82guziEyAUShE9J9xC3w9yl/J2OCAo4x1k6iWn/if2Fwt4g600yYobX20JOn+BvbV
         Uw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733406712; x=1734011512;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnGmmFrWAxRJi8ATpOgUY9XrUxb6+O+nsaNSNpX8AXQ=;
        b=HT2tZrGbsQRjz7EnrJ5Wp/W3JlCUzL5MALSGF/4qF0TPughdg2YeFvpBbQNnx7Q3ZF
         sCYtxMo92DHoWpynZXEV0ADzzG+oKXJGYGFxHYQQF3WwT0+DXZPKki4kYIjlkRvI2uTq
         bXj8Z13nsUXzwbyvnanWIOGmoBXYRzNkkK+4WiPOexMZ7t5CLCQ2Hvnqltt+twd+SvzC
         2NTwPuqlcNglEmC1bUFmEOdOx5CbAk1HorfPFBDp29nn9tezA80q2iN75iTgTY7E9/SI
         SkjIYv8msivcRfW/SpewAth5Liir/TZJckJWaTGCPShJiXcB9n+5TS3Dvr4eEXLOJFr3
         KTtA==
X-Gm-Message-State: AOJu0Yy3q5hqBTxxioUy/VdxDqBm/U/F3HEmDv0uBXoqyRrIDzDosGYJ
	M+MWJLk2KzqD9EMYFt7wHgE3DjPlk8Yqp87tdMohNfJbuF8SbTvP
X-Gm-Gg: ASbGncsM9lPBPT5ulmUKL4aPvG5t29wnt6umpozmI/H43oBqt5Z8MGeecN+dV+8Oaud
	Io6jTGMjJmusk73hvcNQpzLT05ya6VqcMb+lOMrvvsSIojPLtaMmMJnm4q013N2ujm0jEZU6OoX
	xKHb0buof/ShngZMO+p7+UnkNTQ4BOh33guNV0+rsAilyeEJJxK3B9tjouxvpWPLmRJLHZfmF7p
	zSZaDo4iVAEqhomOiMIrp52tpztoIdI4rMvGJV05oSlC+OMFfa45nmVTTVEAxspAC9y3rhQRq4b
	m8xTrIjVdK3rUBSCLYRVkCFfEKBpKptYrzi3
X-Google-Smtp-Source: AGHT+IFvX/bMsQHXC1lMBrVO0y75bhgyF9GN7IqQ/L7LuBeZcmTaeqV+PS25DH509RO60mbQG+S4kw==
X-Received: by 2002:a17:902:f686:b0:215:a80b:f6f9 with SMTP id d9443c01a7336-215bd1b4395mr113916415ad.8.1733406712345;
        Thu, 05 Dec 2024 05:51:52 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e6331esm12742905ad.101.2024.12.05.05.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:51:51 -0800 (PST)
Date: Thu, 05 Dec 2024 22:51:48 +0900
Message-ID: <m234j2w83v.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	kenichi.yasukata@gmail.com
Subject: Re: [PATCH v3 06/13] um: nommu: syscalls handler from userspace by seccomp filter
In-Reply-To: <c5c8a72aa008fd23fd1c7f64def54e94253b3016.camel@sipsolutions.net>
References: <cover.1733199769.git.thehajime@gmail.com>
	<f1aed0f9233f49880510e9506deddd52b33c2fc6.1733199769.git.thehajime@gmail.com>
	<c5c8a72aa008fd23fd1c7f64def54e94253b3016.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_055153_627275_77EC0E9A 
X-CRM114-Status: GOOD (  23.40  )
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


On Thu, 05 Dec 2024 01:42:11 +0900,
Johannes Berg wrote:
> 
> On Tue, 2024-12-03 at 13:23 +0900, Hajime Tazaki wrote:
> > 
> > +#ifndef CONFIG_MMU
> > +extern int um_zpoline_enabled;
> > +#endif
> 
> That doesn't make sense, there's no good reason these two mechanisms
> need to be mutually exclusive.
> 
> I think you should leave out zpoline initially, get all the other stuff
> sorted out, and then add it later as an optimisation where possible (can
> map at 0, can rewrite the binary, etc.)

okay.

> > +void trap_sigsys(struct uml_pt_regs *regs)
> > +{
> > +	struct task_struct *tsk = current;
> > +
> > +	pr_info_ratelimited("%s%s[%d]: sigsys ip %p sp %p\n",
> > +			    task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
> > +			    tsk->comm, task_pid_nr(tsk),
> > +			    (void *)UPT_IP(regs), (void *)UPT_SP(regs));
> 
> Shouldn't do that, not even rate-limited.

this was actually follow the way how show_segvinfo(), but yes, it
should not.  I will use pr_info() instead.

> > +	if (err) {
> > +		os_warn("SECCOMP_SET_MODE_FILTER (err=%d, ernro=%d)\n",
> > +		       err, errno);
> > +		exit(-1);
> 
> exit(-1) probably isn't quite right, it's more like a u8.

will fix it.

> > +	os_info("seccomp: filter syscalls in the range: 0x%lx-0x%lx\n",
> > +		__userspace_start, __userspace_end);
> 
> not sure we need that, but at least it's only once?

this is a message that will report at a startup after filter
installation, so it would be useful if the feature is enabled or not.
# and expected to run this part only once.

(and maybe I can put the following fix)

- int os_setup_seccomp(void)
+ int __init os_setup_seccomp(void)

> > +#ifndef CONFIG_MMU
> > +static void sigsys_handler(int sig, struct siginfo *si, mcontext_t *mc)
> > +{
> > +	struct uml_pt_regs r;
> > +
> > +	if (!um_zpoline_enabled) {
> > +		/* hook syscall via SIGSYS */
> > +		mc_set_sigsys_hook(mc);
> > +	} else {
> > +		/* trap SIGSYS to userspace */
> > +		get_regs_from_mc(&r, mc);
> > +		trap_sigsys(&r);
> > +		/* force handle signals after rt_sigreturn() */
> > +		mc_set_regs_ip_relay(mc);
> 
> I don't understand why this behaves differently with and without
> zpoline, it seems it shouldn't need to. Anyway, still think zpoline is
> future work.

I will remove the zpoline part.
When zpoline is used, SIGSYS signal is a sign of unexpected syscall
invocation, and raise this signal to userspace (with printing
message).

When it's not used, the handler calls syscall entrypoint instead, so
the code path should be different.

-- Hajime

