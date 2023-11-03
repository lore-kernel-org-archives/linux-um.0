Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DABC4332F
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pEIrYnwmS1VIbTqr634tG8u5SlgaU7P1gtKNaGubOrQ=; b=eVc9spWvT4MLg4
	/TQgTTBI1Tli7Qy+8DhycNP6u/6qCSAoaiuCUMfcwNmbqTWPxkFYiVmkwv6uK2Uw7GUV8arwtcdyf
	cetVf7jR8ga4pnNDx9g7yutrfjmAwKGK0sGm/veRmVgbjcuHG8g190/Qn9C/IeESdClJ2iTj3JrOd
	iGDSZchPG0gcPjHjnM5FQulrOuHiuo5xhwiy01YQ70mmqEtcKTU/ZPltU21GH/WpFnuZ2iQ0tpn0F
	CocZax5FJeBe7gl9dNXqizYMOrTcJ/E7WHH0WFE4yW6eM9MsTmPbGLANdCMuSi7cLGL6qWpa9Py72
	iXsjhU6Jg8/5O+JOFnww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyzij-00C33M-20;
	Fri, 03 Nov 2023 19:20:41 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyzic-00C32t-2T
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 19:20:40 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qyzAk-005FZs-TS; Fri, 03 Nov 2023 18:45:36 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qyzAg-008oKz-0R;
	Fri, 03 Nov 2023 18:45:34 +0000
Message-ID: <219bb21e-b1c6-ee93-1d41-332ae107adde@cambridgegreys.com>
Date: Fri, 3 Nov 2023 18:45:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 11/11] um: Remove all TSC flags when using Time Travel
 Mode
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>,
 Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
 <20231103-bb-timetravel-patches-v1-11-e2c68efcf664@uni-rostock.de>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <20231103-bb-timetravel-patches-v1-11-e2c68efcf664@uni-rostock.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_122034_822648_F2B8F7BF 
X-CRM114-Status: GOOD (  17.62  )
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

On 03/11/2023 16:41, Benjamin Beichler wrote:
> In time travel mode, the internal time is only advanced at discrete
> synchronization points, while the TSC register continuously increases.
> Although the TSC registers remain accessible, we remove the TSC flags to
> indicate to programs that properly check the TSC flag before reading
> that the CPU lacks a proper TSC register.
> 
> This change is primarily cosmetic but may encourage some programs to use
> gettimeofday and similar calls for time measurement.
> 
> Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
> ---
>   arch/um/kernel/um_arch.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index b1bfed0c8528..6bfd531b5f87 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -30,6 +30,7 @@
>   #include <kern_util.h>
>   #include <mem_user.h>
>   #include <os.h>
> +#include <timetravel.h>
>   
>   #include "um_arch.h"
>   
> @@ -284,7 +285,8 @@ static void parse_host_cpu_flags(char *line)
>   {
>   	int i;
>   	for (i = 0; i < 32*NCAPINTS; i++) {
> -		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))
> +		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]) &&
> +			!(time_travel_mode != TT_MODE_OFF && strstr("tsc", x86_cap_flags[i])))
>   			set_cpu_cap(&boot_cpu_data, i);
>   	}
>   }
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
