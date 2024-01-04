Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A22C47073
	for <linux-um@archiver.kernel.org>; Fri,  5 Jan 2024 00:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aAhexqYEZZTQ8/D0TgjmNmN1/eHmB/VZQXVAIaFEDcQ=; b=oy/4lSjQnPbLcij++99ydWn3Y1
	c4R63cHBfpZ70wwE/XN8N6rPNPKRsNASDKfA4MRdgqyE9UZp7qCayOffojBxoBEjRKoAPhcGc/3mm
	CXLRoY7bGKMuzU1BG/WXxiAb3yPhPgQF8MmS803roVTwpqRk6au6THZRpAcp/jTZnYVsz8MRtmWIo
	t/HdMXRGfwdi0PZfrTqqJCPKBGAtA/tB6ajyIuG9+cxgOeHtlYDh5M3NrNVIUGiaD2oL8kUP5xWui
	F3PnUaufY/gTbt8pb5u8R94ZmITktamc0MAub/TeZsRm2C7okHPq7KCUBeweNwO2niU3jhFs9fMpD
	pCehvLFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLYLS-00Fffh-37;
	Fri, 05 Jan 2024 00:45:54 +0000
Received: from mail-lf1-f51.google.com ([209.85.167.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLXEv-00FY7I-14
	for linux-um@lists.infradead.org;
	Thu, 04 Jan 2024 23:35:06 +0000
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso1142831e87.2
        for <linux-um@lists.infradead.org>; Thu, 04 Jan 2024 15:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704411302; x=1705016102; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAhexqYEZZTQ8/D0TgjmNmN1/eHmB/VZQXVAIaFEDcQ=;
        b=bxcJilbMaw2DDRw3qGAhXESP8K9teiFfKcDzsmHNn/JNWOgG/0WlSUAVnCQh98qoC6
         m15EMSNX9eqqjD2Bqus1WanBmnvixkB1qIOh/JMi3fPdmijqfsLSGUe/29mkVLS/AGvd
         3JHXn2heAQ9faFtdJN7cU78w3/VOKGmI6m5nrl5s7daBy8qLtepEJS6WIDaTSkbmLDqq
         0NQTCpyNSlIa9UhTBRzTKTA8bnj4J8znDIHZj0O7zfT2vRH6itQNqAsa4vDH7KsZL9Y+
         UfRBoZgxmzaROEJNkfJTvWf30Y1XJ0xV7kjBOPMXojAPtsWJrzpwpg0NBDddlfwk1YVH
         BZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704411302; x=1705016102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAhexqYEZZTQ8/D0TgjmNmN1/eHmB/VZQXVAIaFEDcQ=;
        b=IfXmYIbEbIEt3qaRix00s1sY+9gzHDZqd2I+UxIciObLS7mpmkwGp0lkT8+gpuUELZ
         69yHTbtz90Q7HMlhSfCJbG2WNFENAYi7pQCm4NBTCUsNNxqswLLJ8HlCItg03es3w+Ox
         bUZIAzk7yfWzhQtmkAyW2exH9qwut7yRI33Ze/uxHU+ruJgDOmJvzQTCNxF6QfaLEAjl
         GxoaNQXBW6UcWEI1jYdXlRA2pED91wrEAkKDpBNwTgokDL1BY9kmYKOGK5TNHWO9fB0b
         YL7W+SGw2Ses7WTdDz0/LBjRdvrsH0OBq10aos5B5eq7sssJiFbbph/Q6bJh0BpmNBs+
         H1RA==
X-Gm-Message-State: AOJu0YxGsGnywePQiQ0GXSQyRiW/8bn4cCT4DY9drBQSz1LQ0qkZRRsb
	9YHxBVkcar1Ed0sneZJ5k6q1rjSOzsy5FBQCPgyd8m71
X-Google-Smtp-Source: AGHT+IG2Acw6DKY5otFLCIZNBwXFkvHo8S7Jn6vDW6qhBndqCWknt1YNEqCdrjmH/l7pJV5yzxce4HgjQfwMdsHXLj0=
X-Received: by 2002:ac2:5f66:0:b0:50e:7dfe:fe86 with SMTP id
 c6-20020ac25f66000000b0050e7dfefe86mr281301lfc.271.1704411301625; Thu, 04 Jan
 2024 15:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20231110110348.1815612-1-benjamin@sipsolutions.net>
 <20231110110348.1815612-10-benjamin@sipsolutions.net> <CAFLxGvx6zVDy8pjacb8Dq9d884gTjpnPUapJ61GZAMy_39wGWg@mail.gmail.com>
In-Reply-To: <CAFLxGvx6zVDy8pjacb8Dq9d884gTjpnPUapJ61GZAMy_39wGWg@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 5 Jan 2024 00:34:49 +0100
Message-ID: <CAFLxGvxrGqX3LracvNr=PbK1QOgvRvXz0a0KD2Nq8OuH+OTTcQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] um: Rely on PTRACE_SETREGSET to set FS/GS base registers
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_153505_372428_EA8893C6 
X-CRM114-Status: UNSURE (   9.18  )
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

On Fri, Jan 5, 2024 at 12:05=E2=80=AFAM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> > Most of this logic was introduced in commit f355559cf7845 ("[PATCH] uml=
:
> > x86_64 thread fixes"). However, at least today we can rely on ptrace to
>
> Do you know since when exactly? I don't want to break UML in subtle ways
> on old kernels.

BTW: I have applied the series up to here. Thanks a lot for cleaning
up all this. :-)

--=20
Thanks,
//richard

