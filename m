Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4624CC77B73
	for <linux-um@archiver.kernel.org>; Wed, 19 Apr 2023 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QL8qdc2x+u0nktRhgFDCJk00Oek/4yY+deg25HyubF8=; b=slVLfNyJrWm7nXYOkaw9Irg932
	6iEmxHv7Jr4iwOBNdcpQ95ZCopbRpteUvIT2i7rLq9z+bkTJdriWRCNJ1ZLNiLCZ2K2EW8B1sgRL3
	TpDUhBcXDyGAseaEnCSHKFPVty90HR/27OVcFj3Uu9/ijcnT1Nue8XpVjwr9YgrHjlXWk00Pj7vRV
	BEVqWs7YkHgS0FJZ1pJOhrlBbDtlkBiodMU5wTimg4wZTF16As6wg0sitFr6754YZlzmUna1CvOE2
	ukwfzv3y1ryDfF4IlaAV6en8NLravwatO+yW1HQsS9i+lWy0Q875Zr8LpuHM8XKp4X3P/2tAwYUcv
	m50a6nqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp9W5-005l20-01;
	Wed, 19 Apr 2023 15:14:41 +0000
Received: from michel.telenet-ops.be ([2a02:1800:110:4::f00:18])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1plnoo-00Esez-19
	for linux-um@lists.infradead.org;
	Mon, 10 Apr 2023 09:28:11 +0000
Received: from ramsan.of.borg ([84.195.187.55])
	by michel.telenet-ops.be with bizsmtp
	id ixU22900W1C8whw06xU2r7; Mon, 10 Apr 2023 11:28:03 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1plnog-00GSzz-R6;
	Mon, 10 Apr 2023 11:28:02 +0200
Date: Mon, 10 Apr 2023 11:28:02 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: amd-gfx@lists.freedesktop.org, linux-um@lists.infradead.org, 
    linux-wireless@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.3-rc6
Message-ID: <3aa83a95-a755-416d-d8fd-8363bbd0edf6@linux-m68k.org>
MIME-Version: 1.0
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_022810_534906_6DFE680E 
X-CRM114-Status: GOOD (  13.66  )
X-Mailman-Approved-At: Wed, 19 Apr 2023 08:14:40 -0700
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

(resend with the right subject)

On Mon, 10 Apr 2023, Geert Uytterhoeven wrote:
> On Mon, 10 Apr 2023, Geert Uytterhoeven wrote:
>> JFYI, when comparing v6.3-rc6[1] to v6.3-rc5[3], the summaries are:
>>  - build errors: +2/-0
>
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: 
> 'struct cpuinfo_um' has no member named 'apicid': 2157:48 => 2157:48, 2157:41
>
> um-x86_64/um-allmodconfig
> um-x86_64-gcc12/um-all{yes,mod}config
>
> seen before
>
>  + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 
> 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]: 
> => 6163:45
>
> v6.3-rc6/sh4-gcc11/sh-allmodconfig
>
> seen before
>
>> [1] 
>> http://kisskb.ellerman.id.au/kisskb/branch/linus/head/09a9639e56c01c7a00d6c0ca63f4c7c41abe075d/ 
>> (all 152 configs)
>> [3] 
>> http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e364e56293bb98cae1b55fd835f5991c4e96e7d/ 
>> (all 152 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
