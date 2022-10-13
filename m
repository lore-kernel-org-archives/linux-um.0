Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B4BC433FE
	for <linux-um@archiver.kernel.org>; Thu, 13 Oct 2022 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Iwen9Bng9m+w83wpgOldunOyt8X0Hgipian3AxLpb0=; b=SCkTv6mSCpkmiY
	wtdWwK2mSniliJx+qmg58w2pwhmITsdA9OKl6zZXSBWi9Wujsu9ykTFxJ6RJ99U5D2TPpJgJVN3z7
	dtpBuHfZ2r0k92TwtflUB3gKzi3THF9CO1epjAVIN2oFfujmQFhUQgpgHRfFdvAvJabgvYmocDMqS
	abjIKQjzwORoP7M4Tf8IKRPNEnVIvq/L4cYBOejtO0UzSfYFXgGH8aymW6XpcgpGZTIvcNJtrDp4c
	5My+RMLapTgAL37bRmNKc/mS9/QN5PtZ9pH7dYBrGqTxCX7PwP5fbCXdEioKQDNb5kJG5vmybgYUd
	kV6LWRzKBKTob0bLbkcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oj2xM-00Chfg-2v; Thu, 13 Oct 2022 18:29:20 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oj2xJ-00CheR-Gj
	for linux-um@lists.infradead.org; Thu, 13 Oct 2022 18:29:18 +0000
Received: by mail-qt1-x82b.google.com with SMTP id w3so2237387qtv.9
        for <linux-um@lists.infradead.org>; Thu, 13 Oct 2022 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+0Vad9BFbF32UPRLC61bpkOrYfkjxAqBsb66I31Wec=;
        b=BJdZnZLF+UmEbgAXLJaKi1dcnDWnlyL8dx4IkaVpS4ke3AnJG19c2Az4E4gsIr6i5W
         Owekm0O6buzWHEGHOo72ZMP4qnyDqwFFJiEXsynw3dTB+rEQFXRqg85n8Z8n/eoHJUKE
         FAWtRkCz+dmlqoD69LAY8MPc3svMV9e9xLNkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+0Vad9BFbF32UPRLC61bpkOrYfkjxAqBsb66I31Wec=;
        b=XI45ACIVgoQk1CuTYGLBC6tTJzNlIjX1xLFqU+GyMfGva6iwGJMCaX1sFnRmc4ETWG
         6E3anC/yvckF5p4u2GnXBPmnM9PODslg+P29rGTIu3IKGNtIDs5B76Q5P+hA8Dm6NASv
         +35kUGQ7WHwcM0waLKlhd0HneA+qAmaH6+Cab1yAN7vzSqVLSAMrml79scMTviDpc2Qa
         aIAzU8WsZIjtf1nQ7SxV22DaQVfGKWRf0VSZI/a5pTm2/jvP8AbLbpfcjynN++v6D4+Q
         aDAeN2yAvHl7pOjS7yiHYCpUVVpyQPWRJDFHoLXXYoq2gKQEY6d6hQz5pEa5ao/zQ1++
         I40g==
X-Gm-Message-State: ACrzQf3lzXfCvGMyoauEozRbpQGlD/igWZZn4LYyW23kp3Rg7McDMPXa
	KAf0LJMpY3IstYG9OS+wS9pXXw==
X-Google-Smtp-Source: AMsMyM6k3eSYdEzEWLMug9CKQBjYU2zgDGFeKo9DwRTD8flgbMPBj/OZ7nRE1caztt0CieR+AWkAaw==
X-Received: by 2002:ac8:5a8e:0:b0:39c:c815:76ec with SMTP id c14-20020ac85a8e000000b0039cc81576ecmr1032675qtc.508.1665685754651;
        Thu, 13 Oct 2022 11:29:14 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id bb33-20020a05622a1b2100b00399fe4aac3esm441022qtb.50.2022.10.13.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:29:14 -0700 (PDT)
Date: Thu, 13 Oct 2022 14:29:12 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>,
	anton ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-um <linux-um@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	helpdesk <helpdesk@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: Add linux-um archives to lore.kernel.org?
Message-ID: <20221013182912.k4deh5v47rjbpnnl@meerkat.local>
References: <20221012191142.GA3109265@bhelgaas>
 <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com>
 <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221013_112917_582355_F0A67872 
X-CRM114-Status: GOOD (  10.01  )
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
Message-ID: <20221013182912.Ee1pvO04t1atomn_FBwdZQguyA0q4Ftees95e316qaU@z>

On Thu, Oct 13, 2022 at 02:57:18PM +0200, Geert Uytterhoeven wrote:
> The first step is
> https://korg.docs.kernel.org/lore.html#requesting-archival-of-an-existing-list
> 
> It doesn't make much sense to start collecting archives if the lore
> collector hasn't been activated yet.

The archiver is now subscribed to the list. Once we have the archives, we can
complete the setup.

-K

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
