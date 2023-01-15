Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84900C63797
	for <linux-um@archiver.kernel.org>; Sun, 15 Jan 2023 21:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o28rYdrQWfvNloru5DaXIDLLiVIczm8DGuJpTLm9iRg=; b=kIKr/QnM3N0wCL
	mc7Vr+pH1rIu0mcuTgVOwLn9M9LVD+pUZ6xBgs88DPUEJTDSz0Ggbwy6bYDp9PmIoWVX9WBFYob0g
	m4BhjUNk+XhHTLUMVa83ITldTjEwXrE6j3jyWUA1TeSqWBdos8TM6JgB1qukpC0YbczCPoZyN5/fJ
	cVosiw3nM8VeYboSjU5dN3FMc+tDI0yJy69yjJjb7qlcqMsZL13YWovouYjGSrr51y3GAAuZa55iC
	IIndnYN69xkJb6qJLieBDi+ApcECD6C4AHV0Aksl6PBFZoyJw5nieqFgG3BE5Kx69U8hcs4hlku4L
	MERGzXf3n6BcLz10+vQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHAlt-0082t9-NB; Sun, 15 Jan 2023 21:42:33 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHAlq-0082rv-9J
	for linux-um@lists.infradead.org; Sun, 15 Jan 2023 21:42:31 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4c131bede4bso357925647b3.5
        for <linux-um@lists.infradead.org>; Sun, 15 Jan 2023 13:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xpe4Cs3apB57NmbKcRVMVjPZWhlGE6DeZrb0ougpU28=;
        b=k7HNDvA7yBT2mWSvDi79UVBz+CTOTJxivdKBWOkTKdKCBTdGeV4Qur+c4zpR8AsfNB
         1KLgCdZAFoki8bE/a43ZAGDx2tY3odmvCyQEzR2J5XMsM8f9GuZS3Q5OQq9U7mX9+OV9
         Z+EP3EPEd8EzX/G9S9iuiFGpBNTwGY62+zGhT3pIy2XJoog0Cl1sasnj8Aip0Efl7iar
         HqGK0NzTsz9DgUo1GwG8uGCsIYJtZyu1d7kz1QlFXlR15FoHsjG16pHrUQDDpum4m51t
         DUoX64rMkrnGKS9WUZ+aEwVWrQLGAx8NYREjibiDqgQlUJT9En2AtSowp4yb7RTYjlI6
         1MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpe4Cs3apB57NmbKcRVMVjPZWhlGE6DeZrb0ougpU28=;
        b=nbuqyzg4TbXjp/lsxVcSh0/xSdHUpRcgHOh8R7HVbrsPuTQuse1Fot9Xl3sDXCt7ih
         obngbb0DXzlmEitlnkUf433eL6Irot4O6L0bK+JpCsPmINWE2Obe1ORRVTAi0o4apWa9
         SqSENH9AVxHJyBC2qS6X3q2UTNOA5U38LoOwLwnRyil6AuUJVUKP35aWLjBkL6Dts/nE
         sigbp4HEOWeoC0vCxpsFBFkpQcgw8sboue1HdOfx48BYoZwanZ/mqTh0LuZocnWnMLlE
         hCHJPcqTIi1GQuyy1muSKXYhZ9QHSf/F9Ux8lJTHQhEvNRnoJCGHFE/xDt1NP4QzPZ2l
         OuRw==
X-Gm-Message-State: AFqh2kppQ+RYaE7F+8AD6a7uohdIUE0xc3zaTu/jk3nvki7m4Kiiohws
	f6C9nF88omQMRMnWuTz+DZzG4j68jjZ+TPGnCWU=
X-Google-Smtp-Source: AMrXdXsk6dgb8lDkgSAQXZMZISxptaZIMBqYuDQ1ggVsAY1+5FIgdyIo9AdxAd74n91Tpn8TG9IG5P46Q45S6KQkCuo=
X-Received: by 2002:a81:b60b:0:b0:45c:d900:f30c with SMTP id
 u11-20020a81b60b000000b0045cd900f30cmr4284866ywh.256.1673818949084; Sun, 15
 Jan 2023 13:42:29 -0800 (PST)
MIME-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com> <20221217044436.4138642-4-davidgow@google.com>
In-Reply-To: <20221217044436.4138642-4-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Jan 2023 22:42:18 +0100
Message-ID: <CANiq72nXMsnUsJNZOG-QZiCVOqa9dRUSMc4RAS3ExLZNJ7VhHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: arch/um: Add support for CONFIG_RUST under
 x86_64 UML
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, rust-for-linux@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org, 
	kunit-dev@googlegroups.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, 
	Jonathan Corbet <corbet@lwn.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_134230_354737_8273E420 
X-CRM114-Status: GOOD (  10.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sat, Dec 17, 2022 at 5:45 AM David Gow <davidgow@google.com> wrote:
>
> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
> index 6982b63775da..a526ca1c688b 100644
> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -17,3 +17,5 @@ Architecture  Level of support  Constraints
>  ============  ================  ==============================================
>  ``x86``       Maintained        ``x86_64`` only.
>  ============  ================  ==============================================
> +``um``        Maintained        ``x86_64`` only.
> +============  ================  ==============================================

Nit: if there is a v2 for another reason, this could be swapped to
keep the list sorted.

Cheers,
Miguel

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
