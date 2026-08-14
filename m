Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212D6C5B572
	for <linux-um@archiver.kernel.org>; Fri, 14 Aug 2026 18:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=; b=r2X02MuVlHdf3Jo0JMURMWvJem
	ZHjPaZVWV/tlNsFrBt3elJ7nmTVx7y2BKpH6xjSxnBvHo3T49GaUGSDyhm0A3y4oaqm56XEwL5H0A
	p0rwfKVQNROiCT4V5cZfvgO+slk4xcGzcY0tvzp4WDHtQNrMWs34VlPtpKBYho+70RGK33TPcq1rb
	wF7yR4d32YmTbZK0p+N/v6IFToRokwciZz501lVXeV9oONGQdKXDqJIXqeIAmnttn+fpT53n/U/A4
	gzHuFWd6KjIdaGUeAYIarCaJTxn0ysGxXLjq14LjzaVV2Rh95DWB3Sb66fqKK1fiMBIU4JU9DBnB0
	jsQLjPzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuwmr-000000033Go-3XcG;
	Fri, 14 Aug 2026 18:37:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuwmo-000000033G3-3G07
	for linux-um@lists.infradead.org;
	Fri, 14 Aug 2026 18:37:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786732664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
	b=hrZu+qdoz3Xn9mJSNltKFNpdHGMnq6olmPGRf4aELEhsFnGrW7xHZ6rqspnCW9wOyXStXC
	WN/MCTBGnklfTPNI5L02lycGCvPOS//UzyqZGzw22AY8VP6r5IJzqJ+mHVDs894vgxMwhh
	tr+ub+1uuAOWs2b3AH1+JnG2hEDBtPo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-4Z_7ugT9OTe1W2-yGXUccQ-1; Fri, 14 Aug 2026 14:37:42 -0400
X-MC-Unique: 4Z_7ugT9OTe1W2-yGXUccQ-1
X-Mimecast-MFC-AGG-ID: 4Z_7ugT9OTe1W2-yGXUccQ_1786732662
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a17c89d8c1so1461438a12.1
        for <linux-um@lists.infradead.org>; Fri, 14 Aug 2026 11:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786732661; x=1787337461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3Bw7xg93wntK2DGSQ+p1dtb5GSU+jYFMAY4ihssDQ0=;
        b=RhsrFPlDNu8c4hZYay+tqzwKY3QQAKot3suWansqNIaJNrBt4xhPgW6vfj2A81AGEG
         wIO+xsR/SDlKR2NQGLsI98jiMqw8yVWx6tkPO+kBsms5xw7nHAImDSYA7r7MIt74d6mI
         +reWLRCqonlCY00GR5tf1vCl+M0EDA22me5CdzAS7ANSzs4Cwkq3ZiVqWBbGIJ5PTAOo
         +RwO1V4uKFGEVnC+k5R3W7ft5FTzMdlzxvt9satm4BBIrKDGMMi1JdAl3Hgc6YY39Mjd
         d1S1VpcDU+veUzzAkoAhA2+rB7iEMr2ssT5v93l53B7FdheJqh6KsiGq3eHqOuBzoreO
         ZfQQ==
X-Forwarded-Encrypted: i=1; AHgh+RofXLGTKCamiD50WcnOpHEiU47ruFETG1mhk2nk4EhJRYcgk1NXGhvjUt1pvfTaRQDQ/6M15RcKMQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwBYGTolwHyY/qMAEOWrL9Zpqgc8kz26ZRSdPL/VidRpAaz5xCG
	YWqbSufy0CK8RQoVnouNdW+BCa/3ooHWUAuvbUHsNrA9XdKGSfptNt2XTCyOmuqHbMS3CsMjQLY
	3Ak0xkeoyXnCn7TyGE7eM9P5D8yEkG/92WHZxedtOCdoLELefDumR3proAcWRZA9Jj61F8gbt4r
	YXuOXLa/5IOytRxo3W39qCOaGUDy51JMzjlAIhB5dN
X-Gm-Gg: AR+sD12TTT0EX/cCLYBIhDb1AMApJsrOXOmuIL7GlAegbWtQNAOpLV8UxSyneVnwaTb
	to+q8JBpd5bJ6G5zPI1yIJ2Tx+a6pRTy0O71cUleoOD4Z/QYcmlyAnTddtAnd+QczyoBiTpstyK
	w2nexcCkQ3WFun1FUr/o0q0+MJGyaC9qPqexjKJ81ZPuK0O7UsAm7CxvuxV3wyL+/2pI9Eo+a1r
	2zo4hKZUDhZGtZGBDaKTeU054iFSgU2Gw2oapkkSNtEqg==
X-Received: by 2002:a17:907:1c94:b0:c20:87f9:875a with SMTP id a640c23a62f3a-c212a23ba41mr343799966b.30.1786732661682;
        Fri, 14 Aug 2026 11:37:41 -0700 (PDT)
X-Received: by 2002:a17:907:1c94:b0:c20:87f9:875a with SMTP id
 a640c23a62f3a-c212a23ba41mr343797466b.30.1786732661284; Fri, 14 Aug 2026
 11:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1786626275.git.rrobaina@redhat.com> <an7Udt-luZfJO71U@willie-the-truck>
In-Reply-To: <an7Udt-luZfJO71U@willie-the-truck>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 14 Aug 2026 15:37:30 -0300
X-Gm-Features: AUfX_mwn2tCHNr249W_00_JVZBPk2OAqZsqdPsMuBo2JtJrJsV0GhfYgrjHGFrM
Message-ID: <CAABTaaCcyTLV5TdmzZfpP6LMV+5GeCKqotPoJrb0u9n0h-TaHQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] audit: log all six syscall arguments in the SYSCALL record
To: Will Deacon <will@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, guoren@kernel.org, 
	monstr@monstr.eu, tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n9AdQqpV_GL96SFH-QmhMEK1NQFIozK-z18bjaczQrA_1786732662
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260814_113746_919915_ADEB27AF 
X-CRM114-Status: GOOD (  14.68  )
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

On Fri, Aug 14, 2026 at 5:40=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Thu, Aug 13, 2026 at 02:02:50PM -0300, Ricardo Robaina wrote:
> > The SYSCALL record currently logs only four of the six syscall
> > arguments (a0-a3), silently discarding the remaining two. This
> > leads to the need for auxiliary records when audit-relevant
> > data lands in the 5th or 6th argument of a syscall.
> >
> > This series extends the SYSCALL record to log all six arguments,
> > by adding arguments a4 and a5 inline within the existing record.
> >
> > The audit testsuite runs successfully:
> >
> >  # make test
> >  make -C tests test
> >  chmod +x */test
> >  Running as   user    root
> >         with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1=
023
> >         on   system  Fedora
> >
> >  amcast_joinpart/test ................. ok
> >  backlog_wait_time_actual_reset/test .. ok
> >  bpf/test ............................. ok
> >  coredump/test ........................ ok
> >  exec_execve/test ..................... ok
> >  exec_name/test ....................... ok
> >  fanotify/test ........................ ok
> >  field_compare/test ................... ok
> >  file_create/test ..................... ok
> >  file_delete/test ..................... ok
> >  file_permission/test ................. ok
> >  file_rename/test ..................... ok
> >  filter_device/test ................... ok
> >  filter_exclude/test .................. ok
> >  filter_exit/test ..................... ok
> >  filter_inode/test .................... ok
> >  filter_saddr_fam/test ................ ok
> >  filter_sessionid/test ................ ok
> >  io_uring/test ........................ ok
> >  login_tty/test ....................... ok
> >  lost_reset/test ...................... ok
> >  netfilter_pkt/test ................... ok
> >  signal/test .......................... ok
> >  syscalls_file/test ................... ok
> >  syscall_module/test .................. ok
> >  syscall_socketcall/test .............. ok
> >  time_change/test ..................... ok
> >  user_msg/test ........................ ok
> >  All tests successful.
> >  Result: PASS
> >
> > Ricardo Robaina (13):
> >   audit: log all six syscall arguments in the SYSCALL record
> >   alpha: pass all six syscall args to audit_syscall_entry()
> >   arm: pass all six syscall args to audit_syscall_entry()
> >   arm64: pass all six syscall args to audit_syscall_entry()
> >   csky: pass all six syscall args to audit_syscall_entry()
> >   microblaze: pass all six syscall args to audit_syscall_entry()
> >   mips: pass all six syscall args to audit_syscall_entry()
> >   openrisc: pass all six syscall args to audit_syscall_entry()
> >   parisc: pass all six syscall args to audit_syscall_entry()
> >   sh: pass all six syscall args to audit_syscall_entry()
> >   sparc64: pass all six syscall args to audit_syscall_entry()
> >   um: pass all six syscall args to audit_syscall_entry()
> >   xtensa: pass all six syscall args to audit_syscall_entry()
>
> Could audit make use of syscall_get_arguments() instead?
>
> Will
>

Hi Will,

Thanks for reviewing this patch. Yes, I think so. I'll fix that in the v2.

Thanks,
-Ricardo


