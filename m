Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE69C0015E
	for <linux-um@archiver.kernel.org>; Mon, 24 Jul 2023 06:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F+wjMBThoGRAzTL4qzWQCanIm2/jakf158MDeIHSluo=; b=U/j766pEcpfd0E
	NIT+ihkfyjeT+KULseh37TxKKaeQlL1xfE6aNSng7SN4UUCA99/ha+bhYWYSLYZ5Uw41i2PAOhTvF
	Q5mz8jNe2OZ16j9VnQbpg79UabPOyPJ0rPzb97AAZfSfdA2g+VOQZpP1kBHMyOQ2lK/cnRHyOra5B
	GOeC40jQH4DMCtU4bT8wqFrQ9FrUmpZc8YdsFzF2Wag8gnHEZP7oXdguw2FPlusTal3fI1rSsQUsd
	wvt8PMgPDfMEndw4fwC+hZ9QLTkugNELqraJhx2rsCmc1eKluaWWuQ+0PmeIM5UOWUBzYvKo2SvGi
	QlGltyrIkw1Uoroq/TDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNpRt-00320H-1y;
	Mon, 24 Jul 2023 06:53:41 +0000
Received: from mail-lf1-f43.google.com ([209.85.167.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNpRr-0031zA-20
	for linux-um@lists.infradead.org;
	Mon, 24 Jul 2023 06:53:41 +0000
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso5916429e87.1
        for <linux-um@lists.infradead.org>; Sun, 23 Jul 2023 23:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690181616; x=1690786416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2MRbPLz8TFpHcgcbByErm3/k9uRtAlDJrHvhV7eK88=;
        b=aVOXPrnN+6b2pP6ZTRlZKq1lmr15z4hcfhcc9fRHhGs9AqE/7bzgClzdp/i3fpZa2m
         VBCo+eLf/0E42TyKfD7tVm8+8B/iK2pNpFqAPJA22WlpxMC4iWdBv9zJNYu3k3Ew0M12
         lgPcj7+R7sFZwQfbNJpJfnQ1aCRvA231SlBE0JVtCeI55Jpo0sVArV/1fa2zZOKgolLY
         tV/ZCLOtythzAeJdOL6GpSfG1r85mkfX57oDtbGk066TkEGT9b+UcsijFLBZYp83Ojwy
         ScPS8rPOPPY54kElOzKkuM+Kf4wgCSj3bTPNTh8mzg7dcqYngJPqACWs25QLxSVEB5v2
         1L5w==
X-Gm-Message-State: ABy/qLbF8h2yllAUgWmYuEhKMe81WA7w6s0Xx/q+j4UvH5TIBYvnTSV7
	BrHpJDmk2FYi+I7VoW+9Cts=
X-Google-Smtp-Source: APBJJlHyUL8SddevDRp86zp9skRrtCY7ZxytlhvfUbcIGbAhM4p3M8xaCWlyhsPCCkHzHbWT0iLlng==
X-Received: by 2002:ac2:58db:0:b0:4f8:7513:8cac with SMTP id u27-20020ac258db000000b004f875138cacmr4008530lfo.48.1690181616114;
        Sun, 23 Jul 2023 23:53:36 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bcb8e000000b003fbc9371193sm9467366wmi.13.2023.07.23.23.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 23:53:35 -0700 (PDT)
Message-ID: <1e4fb878-a7a5-f8cf-a4c7-cc221b02f3c2@kernel.org>
Date: Mon, 24 Jul 2023 08:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] UML: use obj-y to descend into arch/um/*/
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20230721171857.3612639-1-masahiroy@kernel.org>
 <20230721171857.3612639-2-masahiroy@kernel.org>
From: Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230721171857.3612639-2-masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230723_235339_656453_19FC9A38 
X-CRM114-Status: UNSURE (   7.29  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 21. 07. 23, 19:18, Masahiro Yamada wrote:
> The single build rule does not work with the core-y syntax. [1]
> 
> Use the standard obj-y syntax.
> 
> [1]: https://lore.kernel.org/linux-kbuild/d57ba55f-20a3-b836-783d-b49c8a161b6e@kernel.org/T/#m7bc402e1e038f00ebcf2e92ed7fcb8a52fc1ea44
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
