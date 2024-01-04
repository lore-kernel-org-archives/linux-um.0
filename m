Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EAAC47073
	for <linux-um@archiver.kernel.org>; Thu,  4 Jan 2024 22:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=INgZHLe7zPCEqzaKKvQ4W7KRL+PjG3gu9gfz/Fkfyyc=; b=4ZEsaxpm6JT89zKcLTG5OL95GM
	zVH4Kz+duwUFzi8ti6WGrm1INJtv6m7Ab3fxqN5vZX8GvUrC7J7RvhcmC+ES3JcwOM8mBm9Oy40N4
	f4ictvKwzIocvTdxhBbYu27yz7Re/gqt6uKpQnRX3FnXOi2rDhuTpPRjoXNjUuzGHaWLbgsxU+SLc
	KWRGsoJUw7XsM80Z5zMPPqb3V0uG216JMvf18+pbMX4i1XwBtu3molnFKvi8PIF/TDXf08fTK0yEI
	0lHKFeDn55wtX2qSAEQFSIq4fq/7tGjNLwP9XN0cFew3OnpxARUj/tjvpMrNTDQfsWwZaGXWIE/6d
	iU98L2Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLWLo-00FMGX-0X;
	Thu, 04 Jan 2024 22:38:08 +0000
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLWLl-00FMFX-0X
	for linux-um@lists.infradead.org;
	Thu, 04 Jan 2024 22:38:06 +0000
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50eab4bf47aso44704e87.0
        for <linux-um@lists.infradead.org>; Thu, 04 Jan 2024 14:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704407883; x=1705012683; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INgZHLe7zPCEqzaKKvQ4W7KRL+PjG3gu9gfz/Fkfyyc=;
        b=YtUmFpeUWaBuxzgQqjvVhrPX5V5VQy0wJZ+ITYYdh8jGY9/S61TkvFIjkSlguz/1s2
         EABuI7Dek5gIrgltqblbTPhELxz/b87bjPOWYHwgYaD4IjN/B6/ABESH7UBar8WGd1ih
         UWbLHxXDUAYDUADOQ9HnU3GCw3s7iT/ZSxlgxfNDlrPqCecpTIAxjOtciNg5uaRrGNlj
         TK3dJPcHRfOSElGf4DgWzmlu/ZQRrp2bT6wFUqN/LA+msjhU9fZ0Zz60JQTtkAOLb8Db
         68Aw4gIcYp4WeUlPiCprTs1+YCgB20o22MpmpK4cNuyi7W7EuF/z2/j2PwDAGMDvUdiH
         qRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704407883; x=1705012683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INgZHLe7zPCEqzaKKvQ4W7KRL+PjG3gu9gfz/Fkfyyc=;
        b=ShnZOLllczwjKSVhV0XOrakhfAJohP6crgRzvSA0SqVWg/DKkCi43RQzCkEMpuxcVf
         ZiNA4b0wuVpPdSlz4h87ix08cKlz+DOk7S/mmDEM+iEDtZV36tVbO0xDl+BWplfEC7eI
         STmnZXSr+41VZNV3pQ1eq7TgCy1XLz54OK0g8h3PvgCPhkZakbxqiqoDYyc4mMIxBMVk
         L7FUQDsW+/eiKH8LEMkauTQctJebvmVhcue6dY2RnVkBKXbCHkQutDLLeSjTGE5AgWta
         qdoDeUcj+Yb0LQlr0w4EGTNOYrUxqrEETHxafzOUCW7v8jjXGTa/k+CZM7anEhrl33Av
         iPGQ==
X-Gm-Message-State: AOJu0YwcNPhrEL3Hhv641j50Sx2fv1zcvR7yDsk9m2wT0UDifcMYL3oZ
	yME8i7x8+Luad876Lzu6l+bisa+ba4JDEVIVipKBlPVh
X-Google-Smtp-Source: AGHT+IG3sZnZXX89uc6YzR0AR2J9tzrbLKW5ljVm61mA/LyGsLNa5UTl5Wrdu21j8axYLSJz2x3te6g8LC1rZ54VHHA=
X-Received: by 2002:a05:6512:3156:b0:50e:7bbf:f365 with SMTP id
 s22-20020a056512315600b0050e7bbff365mr610657lfi.31.1704407882776; Thu, 04 Jan
 2024 14:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20231110110348.1815612-1-benjamin@sipsolutions.net> <20231110110348.1815612-5-benjamin@sipsolutions.net>
In-Reply-To: <20231110110348.1815612-5-benjamin@sipsolutions.net>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 4 Jan 2024 23:37:50 +0100
Message-ID: <CAFLxGvxads6JaAgm2MvXKKJrJiYGk1oLa2EDC0YLemcQ866cvg@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] um: Don't use vfprintf() for os_info()
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_143805_200541_441473A4 
X-CRM114-Status: UNSURE (   7.73  )
X-CRM114-Notice: Please train this message.
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

On Fri, Nov 10, 2023 at 12:03=E2=80=AFPM <benjamin@sipsolutions.net> wrote:
>
> From: Benjamin Berg <benjamin@sipsolutions.net>
>
> The threads allocated inside the kernel have only a single page of
> stack. Unfortunately, the vfprintf function in standard glibc may use
> too much stack-space, overflowing it.

Another option is giving the helper threads more memory, we don't have
that many.
Did you explore this option already?

--=20
Thanks,
//richard

