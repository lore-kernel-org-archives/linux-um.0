Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9317C624D3
	for <linux-um@archiver.kernel.org>; Wed,  2 Sep 2026 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TZ+MXL1cgyfSCQwzd4B83Y1gcdTqXTzpnMsgTcK9A4c=; b=oWjk28cGdWsMq1AUCUPxhJLnIW
	709AeN15+GnD0/irLbJHS6iH8O7vbSaKe7UjVywH2+zuCqKvrn8KVbI44rN7VjYTAg+zzR5fYoHsH
	oIVSci4ulnt7j9V8JguyDXlOz1udrrszp/MoIES0PhnHG4NfYLsZIUO1HO1Jca5kAky5xvILFrpCY
	jA7LjIjEWYd7m4244AOI7Z14vnzsUEIxIL0DUo1eSThv9HJF5JT8m7NbiMcupIdxyXH8xA9u9wyk/
	aHpjAt6hKPq+lF765RIc0Ef4t+pzD2uvkSEX0t6DSjikJrThWUduJEF6hNh4NVMD4eGB/Ilrq/BPT
	1oNzUxpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1omF-0000000FRI8-0qUJ;
	Wed, 02 Sep 2026 17:29:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1omE-0000000FRHp-3L3t
	for linux-um@bombadil.infradead.org;
	Wed, 02 Sep 2026 17:29:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TZ+MXL1cgyfSCQwzd4B83Y1gcdTqXTzpnMsgTcK9A4c=; b=gKtLhA402FIZUWD0kBo6eRha3I
	sDQaeOcJ/88nelrXoyDW4SM1SnkG7emsmKZvCU5zo7jb01ZIzQ3QL/7hzFpMSPEmAS515Np26gKa7
	fwcj53GH8M2r2vXKLiAX8e3YEbKJHMPXucB991gvyDHtLN0r3tWmyVJQ9qBXSpC1zcA6RQtSaR0L+
	nNRi2JHoTv58CRcaxyRRbMDwF76qOq6BjUjzjgOmUIcgBmrdUGP4Mx5KABDsg9J0QEVw2YuXoSWvy
	U86pu07upl38op50jF9dKWnCy7diPWIEC0v8le/0+OoUdUuOZIogUOqHbclKGvaVZD8unus8nkWRT
	mxkifdDw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x1omB-0000000CGqS-23U1
	for linux-um@lists.infradead.org;
	Wed, 02 Sep 2026 17:29:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788370162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZ+MXL1cgyfSCQwzd4B83Y1gcdTqXTzpnMsgTcK9A4c=;
	b=FCcl6/nex5yo/dVatACfuwRLPSj8DJEFmFUxFfYry95Z69OEArEHY/NiQEj3Tw66+whM1G
	+zkC91Cw6Am0aVoluyhggu5gQ00G1xGZCpnaKItVAHKMTG9JgkW8cQMFEAR8mfqu8g/+Bw
	vIK/9o4WcGFo3qeag/tMZc/bqRpDh64=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788370170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZ+MXL1cgyfSCQwzd4B83Y1gcdTqXTzpnMsgTcK9A4c=;
	b=KhrR54YwHc/hrL7AlgrIa/O3CmTUC2Ex/XVBC5f10cnBmLN/KgL/ApFwWX2N1jG/Tujh31
	FRMHxtmEi+KUCu+90jSXYU65JSY77yjxO6s9KXV2Jx/6LT5+VaA1wavOxXJjR6z1w2+KSh
	fTZCSkV65FJPy0hlEmFaYabhCRe2M90=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-aNLRFW2aOrGgUeZBTtXadg-1; Wed,
 02 Sep 2026 13:29:19 -0400
X-MC-Unique: aNLRFW2aOrGgUeZBTtXadg-1
X-Mimecast-MFC-AGG-ID: aNLRFW2aOrGgUeZBTtXadg_1788370156
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEC551834577;
	Wed,  2 Sep 2026 17:29:15 +0000 (UTC)
Received: from fedora (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D531730002F4;
	Wed,  2 Sep 2026 17:29:10 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  2 Sep 2026 19:29:15 +0200 (CEST)
Date: Wed, 2 Sep 2026 19:29:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Elliott Hughes <enh@google.com>, linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] x86: uapi: ptrace: guard register offset macros with
 __ASSEMBLER__ or __FRAME_OFFSETS
Message-ID: <aphc5Xf0HU0SWcTI@redhat.com>
References: <20260821-ptrace_uapi-v1-1-3de8638a29f2@google.com>
 <CAKwvOdkCGEYWnyJtWT=jArXkA47X==G0PU4UNV=s8htpA3Dg6g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkCGEYWnyJtWT=jArXkA47X==G0PU4UNV=s8htpA3Dg6g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: j8uf-ONqCci5q_ovRKFoApmF7uHOYT3PVEUZR44tYOk_1788370156
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_182931_780233_770EC9D5 
X-CRM114-Status: GOOD (  17.89  )
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

On 09/01, Nick Desaulniers wrote:
>
> On Fri, Aug 21, 2026 at 3:46 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > The register offset macros in <asm/ptrace-abi.h> are guarded by
> > `defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)` for 64-bit, but
> > were left unguarded for 32-bit. This causes havoc for userspace that
> > happens to use identifiers colliding with these short macro names
> > (e.g., EBX, ECX, EAX, DS, ES, FS, GS, CS, SS). Without this guard,
> > userspace is forced to be super extra careful with include ordering to
> > minimize the chance of collision.
> >
> > Wrap both the 32-bit and 64-bit register definitions under
> > `#if defined(__ASSEMBLER__) || defined(__FRAME_OFFSETS)`, and ensure
> > User-Mode Linux (UML) defines `__FRAME_OFFSETS` for 32-bit as well.
> >
> > Assisted-by: Gemini
> > Link: https://github.com/llvm/llvm-project/issues/217413
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> + enh (who pulled this into android for testing)
>
> Oleg, can I get an ack/nack here?

Oh... there is a little problem, I don't understand the usage of
(magic to me) __FRAME_OFFSETS ;)

> Or someone who knows better the
> history of UAPI headers?

Certainly not me....

OK. I'll try to read this patch tomorrow with the clear head after sleep.

Oleg.


