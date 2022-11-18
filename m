Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635AAC433FE
	for <linux-um@archiver.kernel.org>; Fri, 18 Nov 2022 21:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a0Fcege+95xW5ErghTfAGD0oDqhR03tZuheJBur/Lko=; b=uuK48uf8iyBVA6
	F3kRopEK05gqYbbaQ/UrkqSiD8Zf+AXCcXBs0ecXVh3oBvvrutqllYS1aZ4qQ7yidWizb+QNzw7au
	Ft7uqu6df/Q7u5/UnNC9brKtHjqnbj70mc/0va1T2JqzHYXey29/T7IHvIz4JMp8gyVSrKIgMTxi/
	w+qnXAgm/OrVdwcQNk8N0HzsjxwSyx7UVxOCRJ6BHT28Unlb0uS4THRCYM95PKSXbegca7oG/j2Nb
	VEswAeLBcYH7NuebcSSVViWHZp2eWsJFN666HLwhn8gyHx+XMUBAF2t2XCMhPPydGoQiWS29cvIsj
	8B6d7N/tfRmjpJd6+rtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow97P-008IKL-LI; Fri, 18 Nov 2022 21:41:51 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow97N-008IFJ-7J
	for linux-um@lists.infradead.org; Fri, 18 Nov 2022 21:41:50 +0000
Received: by mail-qv1-xf33.google.com with SMTP id mi9so4228774qvb.8
        for <linux-um@lists.infradead.org>; Fri, 18 Nov 2022 13:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEmbr3CpckQIhKpXHWOoRcTosgu064ftFbEADinoMhc=;
        b=A3PrIIpD9uqHtyy7k/x0ry2h6mxexs0T1AsiGMbwSMqa2YSaY9zlbV8ozgpl1BUzs/
         03L8QBonbm/cFSGhSBAkBred68QUKY1HoVSV+eyM/0EtQvM9PTN/xPaZvtKa847jA8sA
         VpJjTeH3QJxx8RjrixBlJX1TV5tUNqvcSEj0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEmbr3CpckQIhKpXHWOoRcTosgu064ftFbEADinoMhc=;
        b=Wop2LZ0vtwqhM6lZu+oh6f3eNQfqJe1JhVvGNhTGOnQeH3prOOliNSYTeBZRg9kuZ4
         uIFGRqA9VE+qZJgg+uGNme584lhGmiQZ0WvgbUVOkVPAHLIcpEcMx2xR/EP8rLRCJj7a
         QhMSXRsjiRybqSsNknYrJvshFnBNPAR2pF5IjBpkom7vCGd9oHP4HShUWIBopi4OeJiQ
         DfE/7KFgFEC2IMnIk169BerX97plicekp4GLdXWKm69MoLP3DqSO68uXpGDIAJQBVzzF
         HwtwZdjcD80vThvD9Uzhhy+IXT6YLsomfmV7CpcK+ygTek78UXncHRNyNWk83dIA8WCt
         7S0w==
X-Gm-Message-State: ANoB5pl27HIYuk2nNHSOIbd0E4NhYY8sVwTIlNyCyL3NIQU86U1Q+Ac/
	Ve+WmxPkL+9TvfaTWpnvqgcLzA==
X-Google-Smtp-Source: AA0mqf5SkmMjfiQCyPWnw3LPK5kTi2HGiiAioVTxXYSKxGesJaW2XRgvfUmuM0G6e9p9x8uuP5bYww==
X-Received: by 2002:a0c:c682:0:b0:4c6:80d9:844d with SMTP id d2-20020a0cc682000000b004c680d9844dmr8496003qvj.34.1668807707055;
        Fri, 18 Nov 2022 13:41:47 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id f1-20020ac84641000000b00343057845f7sm2608807qto.20.2022.11.18.13.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 13:41:45 -0800 (PST)
Date: Fri, 18 Nov 2022 16:41:44 -0500
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
Message-ID: <20221118214144.cqvo234tjmo2bagn@meerkat.local>
References: <20221012191142.GA3109265@bhelgaas>
 <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com>
 <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
 <20221013182912.k4deh5v47rjbpnnl@meerkat.local>
 <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
 <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
 <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_134149_301876_4AE3BAE3 
X-CRM114-Status: UNSURE (   8.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, Nov 17, 2022 at 09:58:31AM +0100, Geert Uytterhoeven wrote:
> Is there anything from us you are still waiting for?
> Thanks again!

Nope, it's just waiting for some cycles. I should be able to get it done soon.
Thank you for your patience.

Cheers,
-K

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
