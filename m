Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BBBC982D2
	for <linux-um@archiver.kernel.org>; Thu, 17 Sep 2026 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=; b=Z+AnEcmmNEc9xDqFqBM4IDnVZO
	4omDSeCrXNhtTmyXpHISj3xa04NfTipgtRo3oQYtlJg8dfUAOzFAr2tFZ1IiQXQPbc9I3suzJ+1FE
	GAWDWvCU800rxDOGVu1yyCLsTwonCRFNuRwJkkzNo1v4Plixz2FbTR/eo7OlvPveQB8OXs5iQK7AX
	xKIEfxPlg4YrWSP5rYLnofoXchplFThfBGrc3GWMofEJWSFN5bIoYv33NzJFnBJnfkae6vzwG4Wgd
	1sajNEGtkloycuRfeDiODTyr3OqVSjlUz2mIPVfs5LD2KCNTX5z3wVgDe9qURbq3+qPf3CtY2acWl
	MiFb18ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FFo-0000000Bysv-0VTx;
	Thu, 17 Sep 2026 16:46:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7FFl-0000000ByrH-2ADQ
	for linux-um@lists.infradead.org;
	Thu, 17 Sep 2026 16:46:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
	b=ZTTX6g4mYj0vlRM1lqShOllZvQyzIx2owUz//QT3uX3LDPwvQ13gLfFul3EjOEEnhQRL8+
	IgQ/7XdL20/z2P4kFnyzkp7ERWfZuLKKKkUCSaqJIXTrE/hkbCg/FbDPz+nqS3uMZjRKFl
	rRIN2A0cBVjwRsvMvG/YvP3IE3QaPqs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-hdbNU_FVMa6PwzjtE6f3xw-1; Thu, 17 Sep 2026 12:46:26 -0400
X-MC-Unique: hdbNU_FVMa6PwzjtE6f3xw-1
X-Mimecast-MFC-AGG-ID: hdbNU_FVMa6PwzjtE6f3xw_1789663585
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2945f5e851so95782666b.1
        for <linux-um@lists.infradead.org>; Thu, 17 Sep 2026 09:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663585; x=1790268385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
        b=z1xZpIekIh0NweDbwlFoSoCO6jaYkIdHqx1DrdiyA0jC4hhgcLlwms5VPeaSbCD9Tz
         NlxNpKy2B/9/310GWaasnfIeuznbS27C8arSxp8r9+r9nURldMrNXOmI45VaQV5Oi/ee
         2H+lvHQNeRX25cdGPgFHSu+8y28K1AlRIh1+/8uxoNH6MuF2uQF1724nXw29zs1bSVvJ
         YvxmLwoe7MKrA76dXZ7ZWWqzftGw9xfmYxMg6GPnDYuaV7ycX5fwYcjwr3xd9ky8vrTp
         0e7yD1wQsakUrBAxGgs08GyOWzP2Lnq2kOIm0JN9VuXBQPIgF/0ay/DfLXArf5S/sXNe
         n2tQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVHsYVDNznRwJ/1dh88qi9ExA2AtBRI1WVGLksY+kEuGdYm0RnI0lAurs8SiHvZMQIzPGHdDa+yw==@lists.infradead.org
X-Gm-Message-State: AFuF++k8I1sKJqAZuL+WMngzxAFJfoG+XQWQAPcpOyN3BD8WO3lprsOq
	4AIqqXzqgCLBf10Qx8hW54okQ5lOE8HwNAXTJC0DxDkrdnWEHrygnTz9X03zUppXARQ05fgTI5g
	8zVGB8cO4pDCac9bvvI94B4141oAoq2RQyTkN+pen6FpQRIcuPqP3nmSCDrKht6pkIlBtSyPioP
	Zphyi4/ETSk+Z/7R+wI3eyPbBIice3cODKA/yqHoGS
X-Gm-Gg: AYBFou3SrRdOiEYeMpmvgVVt0zlleAv3mDpjhVj6P4wIAooyJAlJ8VV24RJrvXD0pXT
	DQzXnQtfWjAXQdvav7kKphB5iF4Gc+rX15hti17h7Dq5rDs48BHLpsgInCKBAq71taw0ziT6s5T
	YNtZTFOOv+DlnhTfJXAV08mZLSKfAfz2KRJavAC0dthQsy1SVTKqPsolkQIZXu8ze8yZ7f8IT65
	ChAIqKIRX+oxqzu0S49A2vF17yx0Djx/viGXgX/Cer1AxDXbBzXL/7Xy/i5KEGC9pMh6kGNd3l/
	Kj8=
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id a640c23a62f3a-c29e53184f0mr504525666b.42.1789663585465;
        Thu, 17 Sep 2026 09:46:25 -0700 (PDT)
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id
 a640c23a62f3a-c29e53184f0mr504523266b.42.1789663585091; Thu, 17 Sep 2026
 09:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>
 <apkuNj1paR_GO3x9@willie-the-truck>
In-Reply-To: <apkuNj1paR_GO3x9@willie-the-truck>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:46:11 -0300
X-Gm-Features: AcwNN1UTQywdGW9xqj12KwNHAYLGfDNNso402GZvP3WcYYwXGdDJ7Oiz7qML_cg
Message-ID: <CAABTaaCoNztwDUA-HPp4LaikxL4dxk-1bvCCpoZEGD4rnds1oA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] arm64: pass pt_regs to audit_syscall_entry()
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
X-Mimecast-MFC-PROC-ID: 4Ax3HBEMWLtb-Wdb9ncWB__FlFTQFGj3OV52xvXlxE0_1789663585
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_094629_615712_160A3A18 
X-CRM114-Status: GOOD (  15.98  )
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

On Thu, Sep 3, 2026 at 5:22=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 02, 2026 at 11:43:37AM -0300, Ricardo Robaina wrote:
> > audit_syscall_entry() now takes a pointer to pt_regs and extracts
> > the syscall arguments itself via syscall_get_arguments(). Drop the
> > individual argument registers from the call and pass regs instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  arch/arm64/kernel/ptrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index f743cbec1c3a..65532b2a8cd4 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -2476,8 +2476,7 @@ int syscall_trace_enter(struct pt_regs *regs)
> >       if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> >               trace_sys_enter(regs, regs->syscallno);
> >
> > -     audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1]=
,
> > -                         regs->regs[2], regs->regs[3]);
> > +     audit_syscall_entry(regs->syscallno, regs);
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Thanks for doing this.
>
> Will
>

Thanks, Will!

-Ricardo


