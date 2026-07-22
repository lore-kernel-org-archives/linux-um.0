Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DC1C44536
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vf6t/F8jlzKSrL/OaIPpfpaAitCScv74YCIjD12OsCg=; b=bN5S0nBjDuhAglnCZf2H7FfDef
	mRJkrOubXArTcSX/cEABzFQIFgNmCAX1Crd6KWARJabyDspYkfd176ymmugzUjCbQmv33mUJ4YAqg
	eUliuOpT8CA+KWR7RWS+yL99yzTEzsZZFDEvc3QRbCVg34kPDpmw3MlYoFVMJCS8dnfuPrxpFEFRU
	QAUWcdqc0BmjUa7O79WoWl8YoyU5dcn7zIAYzlafCj9X8NdGdSElh8NpkkPzDhb6pFED9tcp0sR3v
	gORb9n8b/ujeMX269jUrcEgrRC1lgIfcerJzw7a+6HROAFpGzMISsXzB1j0jkM1Z/8rJv6yMB6upT
	tOiqGbFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeNP-0000000CntO-0RWU;
	Wed, 22 Jul 2026 21:21:15 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeNN-0000000Cnt4-0TmL
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 21:21:14 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-cbb973e6749so423948a12.1
        for <linux-um@lists.infradead.org>; Wed, 22 Jul 2026 14:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784755272; cv=none;
        d=google.com; s=arc-20260327;
        b=e7y7Huiqw8jVndte59bUDlTvRbCVgRNN5Nyn2Gt2YdqkvRRwifkOftXys0MOEP2O3f
         hfuOoTd5czEzh/QQgXT6GnJ52HZ4PfixZgmiVAFioLQ9gjdUBRBeQJlyxWnwPIHVwN3a
         sB7DA0lwr2zIWVauPnR4QbHM2BsPDOlOCj74ak+LCBxmMEiPfoRDo9+eE4K+wRA2QnHp
         RKe3ZDk/sM8hpDOKC7fbLW6maVDsrXFn0HXgtzCRuTHF9yhEDgLiRRwMwBjvuDteuc35
         UABsGLvMRgVKwdIH4964ylGaK/PeiM3SyQ3y2aXbhixDb9nL7J8z7C/nX1OHm3SXFT8t
         Y5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vf6t/F8jlzKSrL/OaIPpfpaAitCScv74YCIjD12OsCg=;
        fh=8b4M2xGm19LYPJ6pwc7zGSkLfe5rzszdvUOUtJ8D1IA=;
        b=qyhKTp2HAB96P7gHVPPbniVf86/ESVCAx84M13zg+GpweEmLVK8X94BWKsUC0Sv9wg
         k0WdifOJBAYGaOomHdpWJW7q5oifxR7xJIkgiWRKuuEbPjPDPY9TgZJTg5pj88IZ8Rya
         3JjMb85gJML32h/9dRAR2F6B2TompdHE6IPKzhCOGWyoHXGZPZx27xB/g5GMQ0Nds5ky
         ATp7xg8hRgq304hBw68maWkU0PGQs2R9K0qKyBDxIehWbOw11qhAMMsVehQNoooHUfyH
         aw5XDq8GKEIgDm+Qr5FoWasQz1KzcXEtzA4Ak5AHjtVryxvpkcid8NnVjuSdtDBr9tnS
         GdGQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784755272; x=1785360072; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vf6t/F8jlzKSrL/OaIPpfpaAitCScv74YCIjD12OsCg=;
        b=EXrXG3pclsIr4HEoOG0bUdQ7dY/x2dZk5CMg262+yK+z62m8LFkCHPQLO+qjTqqHv5
         1P5SBdaYLxDn84uqpoIiuhr620J515C8d8Om3eb4EY72qaiWvh0V+xLkC36vduB7Jdt3
         eDvOq+RwYsDFTVyQyf0W5To/aQl4F48xY9209s6vrlqHDEhLcbQ/lAH+N5pYsxg78ojo
         HPxJOmm0sqgWmYtOxtSph+M3ltJM4dpVK4d5WAcVaWUiJBzp8hpWsvo6VDLB68sEeMUi
         Zo/BFm9CH4eYpqnTNTLiqHFNEgMh6qri7JJkG28/wQOf3kd6BF8HRiIoYxsh92bz7o7V
         OUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784755272; x=1785360072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vf6t/F8jlzKSrL/OaIPpfpaAitCScv74YCIjD12OsCg=;
        b=ejSjaeLoHcSPguLMdk8/qdr8vg2FTd7E3RbTnKuCCLInuY64A9IvFll9pM7O6emKam
         IhCiLFrG36JhYR13cPBLKccYm7jfO6xDJNvJ9HvRZ3EEhyW0vv4dcyMhiQ7TI5bGXUVs
         LRu8oKPYXlgR2fNe9h2Nlm8hm1QEex064K1KJ4wW7THIMLbi4mRo4ti56FVTXlvT48Cx
         V8oh2aaairPVxx7pBGNmeb7+MhSXxr4bbZbXNobhUC5qet+oMXsLgWMkbhjNcFSVZ7I6
         9QhQBax9GtBWpAeP/Huw843Psq5OXkKKF6FkAPfIJ5IfOV0uZNIzkCRy+sTsyTlWlqnL
         t0tQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpie1EEeztI090NktQKCaPhQVow3JD7fJRnSWLH7st6xX7FG3ZvI+0WNE2g2A2qF0eeEeUS7uqjgQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw4f8MT6mU3+7IcDLBTgFu1reJMt0ynyClf1Wvo4Cks1MxUC6Qi
	5NHomAGfxrdTLmOcHWK4ByIrxM8e4d/6SmRYccaHXIOlBydu1I77B87nEcY48h+GzN7Xczm/HCs
	2jVSdvx0V6IHRmVq1ou8lnlSNSMVst2Y=
X-Gm-Gg: AR+sD13VltiqgnEHFomYAQ9jSBCV2GkYUuw4nNRoTlUqL14K/SwNd9ZrAymaxI8w8JG
	Q9KkyzlAYCOi/MU+HSwmlCEwqzesrm4WgQ68XUFYPchcI0e/r+SZgSq9hrNuUb8aVjCllzpPXeR
	xsuRCqWWBKI6zCJI5FJKnYZZQbCjfisBXitp9zWdUveooDTMKjwxzYA42NBf2gDqJpzecqrYoQT
	QzMXpvIV6Wzj583ohJxbrThrjUaWD6WOMTI8DIQSAifKBMxxVuXJzXPwwKx2+0FJBNtS8nV
X-Received: by 2002:a05:6a21:600c:b0:3c4:2c02:eabf with SMTP id
 adf61e73a8af0-3c44b1e9c43mr188835637.60.1784755272214; Wed, 22 Jul 2026
 14:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260622124750.1694957-1-michael.bommarito@gmail.com>
In-Reply-To: <20260622124750.1694957-1-michael.bommarito@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 22 Jul 2026 23:20:56 +0200
X-Gm-Features: AUfX_mx8ESNmaIaU2zFuFgcTthQp5DfNkVU2ay4tV8k_bo2kUm3izafxizKqCRI
Message-ID: <CAFLxGvxPCNWWiaWHDSFDD1OQ+3O=kyWK_fQsMX0QYWUQ2ehb-Q@mail.gmail.com>
Subject: Re: [PATCH] um: virtio_uml: fix heap overflow in vhost_user_get_config()
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>, 
	Tiwei Bie <tiwei.btw@antgroup.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_142113_154653_AEB401DE 
X-CRM114-Status: GOOD (  17.43  )
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

On Mon, Jun 22, 2026 at 2:47=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> vhost_user_get_config() sizes its reply buffer from header + payload:
>
>         size_t payload_size =3D sizeof(msg->payload.config) + cfg_size;
>         size_t msg_size =3D sizeof(msg->header) + payload_size;
>         ...
>         msg =3D kzalloc(msg_size, GFP_KERNEL);
>
> but then receives the response with msg_size as the payload cap:
>
>         rc =3D vhost_user_recv_resp(vu_dev, msg, msg_size);
>
> vhost_user_recv() reads the header, then full_read()s header.size bytes
> into &msg->payload after checking only "size > max_payload_size". The
> payload area is msg_size - sizeof(msg->header) =3D=3D payload_size bytes,=
 so
> passing msg_size as the cap lets a peer set header.size up to msg_size
> and write sizeof(struct vhost_user_msg_header) (12) bytes past the end
> of the kzalloc(msg_size) buffer -- a slab out-of-bounds write of
> peer-controlled content.
>
> Pass payload_size, which is the size the payload area was allocated for.
>
> A malicious or compromised vhost-user backend triggers this during
> device probe (vu_get -> vhost_user_get_config) with no guest action,
> which matters in the confidential-computing model where the guest does
> not trust the device backend.
>
> Fixes: 5d38f324993f ("um: drivers: Add virtio vhost-user driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Reproduced on a UML KASAN build (ARCH=3Dum, CONFIG_KASAN=3Dy) off this ba=
se.
> A stub vhost-user backend that answers GET_CONFIG with header.size set to
> the full msg_size makes vhost_user_recv() full_read() 12 bytes past the
> kzalloc'd reply buffer; KASAN reports a slab-out-of-bounds write in
> vhost_user_get_config(). With this patch the oversized reply is rejected
> (-EPROTO) and KASAN is clean. Benign control: a correctly-sized GET_CONFI=
G
> reply succeeds on both stock and patched. Before/after logs available on
> request.
>
>  arch/um/drivers/virtio_uml.c | 2 +-

Reviewed-by: Richard Weinberger <richard@nod.at>

--=20
Thanks,
//richard

