Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF620C4332F
	for <linux-um@archiver.kernel.org>; Mon,  6 Nov 2023 20:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lntC4OXAWTa9veP8xWLXfu2IR5ktNlATIFCF2GRYabs=; b=2TWLuyKyLKFNeM
	+sHUXpelRRPMSSCLw20C4cGe29UFKZWUW3kfwtr1W/xkfpO5s7aP1qrI42pfpc6MEetCBAaZHnZ5U
	WmOKMI1hiRrLntGV/k1K5PbI08AoyjbEVtoIoAJZQ0ZDKDJCfKSoSVE/6f1kS52a4yYbx2sABS04l
	o8B5ElFnmJIH28BrwJ/cVexQ+RfXFvdNh+jPwO48E75hUKdsjfCWtm8YBkjIi/Ksdql9bs4K2IpMV
	6Aqgpn8scOAk+ehL0HNxYsBepMNNvSqgyPI9zRJR2URjAzhv9ShuvcLU4UzL4fsxN9NnefoyHbydP
	kJboonuUCAihpa+k155A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r06a8-00HXh3-1r;
	Mon, 06 Nov 2023 20:52:24 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06a5-00HXgZ-1J
	for linux-um@lists.infradead.org;
	Mon, 06 Nov 2023 20:52:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=k0yeE5bE+R89tmhaSQ1wIxDV13PU+PvLyBCEUGPFzMU=;
	t=1699303941; x=1700513541; b=DIAJLJSyWGM7C/ZdjvfH27mx21wjDNgXnNgh7RjNeTx4aOV
	uIK1c+xiQ8O3r+ZPRmL5Meduce6FUKtjdCgyKbU5iqEagc951r5HRYo6N8wLTv8ysAmd4iFcjoQ1a
	7EENQCEtBO3DfeX+AMhZVUc/0IlEWuEethMWTYxzvYAgVzOtLXif/laBbYBdqOZX9m9c4qA5Vhcpv
	ijSbOTNH8vHfhqNeogJyAtIrnt4pSeZmpskzbyKJdT3B2c05PpEpF87yYDon1UTjBzpwP4Ss7wUap
	eSAZ9bqxPH5eoyUhhR8hGfGZZeFZYKu9Zj9ncHhJuk7XOli9op92cp++i42e4h1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r06a2-0000000FtZd-3la9;
	Mon, 06 Nov 2023 21:52:19 +0100
Message-ID: <75661ee39acb1c59132aae0e4ac20ce20bb3a92f.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 11/11] um: Remove all TSC flags when using Time
 Travel Mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 06 Nov 2023 21:52:17 +0100
In-Reply-To: <20231103-bb-timetravel-patches-v1-11-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-11-e2c68efcf664@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_125221_462298_8501865C 
X-CRM114-Status: GOOD (  17.76  )
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

On Fri, 2023-11-03 at 16:41 +0000, Benjamin Beichler wrote:
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
>  arch/um/kernel/um_arch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index b1bfed0c8528..6bfd531b5f87 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -30,6 +30,7 @@
>  #include <kern_util.h>
>  #include <mem_user.h>
>  #include <os.h>
> +#include <timetravel.h>
>  
>  #include "um_arch.h"
>  
> @@ -284,7 +285,8 @@ static void parse_host_cpu_flags(char *line)
>  {
>  	int i;
>  	for (i = 0; i < 32*NCAPINTS; i++) {
> -		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))
> +		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]) &&
> +			!(time_travel_mode != TT_MODE_OFF && strstr("tsc", x86_cap_flags[i])))
>  			set_cpu_cap(&boot_cpu_data, i);
> 

Makes sense, but the code formatting is all wrong ;-)
(indentation should only be to the logical level of the parentheses)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
