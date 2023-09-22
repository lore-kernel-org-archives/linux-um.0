Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83B6CD4F46
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 09:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E/87Nw3OTUguGcd7IPGjRTyliGHhKVzUOXpg6eutq+g=; b=ah5PGEhWo2V+XI
	1YMueW27x3kk3CaZRTG0+m5qOKV6j5X7MOzu/WQUlPGS+bnlxi5w/c5WkxX89GkU8uhSExDdAMTsN
	JBUlGm8map/NNle4zf3vbRLEwhYemRGY0Cib2S4MtNuYgNu+eX5hvOPli0S7OrcQCXRg8nf4YShvu
	cqjTJbnkk3B9iyQKz+MiQbb8zXJIbk3Gi5eqoYcWN2bJmyItQYBUJbv9JPkK/TPt76VNrhnV7sLI0
	QYnjm+6pjcfXPdZ1ZqGBeLFaIJxKe0gGOB1YPXBkEExT8cvNfD1ZwZr1TLoSU7gLYSuevfW+Vj4s6
	1PHGd93rttMCblRDW3BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjctE-008eOJ-2m;
	Fri, 22 Sep 2023 09:56:00 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjctB-008eO2-1V
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 09:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nxSpHJX3TDirER+YzPmBIWAi0yECm1x1afBuFyCr65o=;
	t=1695376557; x=1696586157; b=sC+eUU3V+R0WOssrHyFk3YCquilpnR9+6q6VIFeSZ0PliYk
	0HUIzeiHAicE7gIkODDUgCHHWbx043wVC1fMfoUp9jJDLgVueabbuNHiQruc+VtpjcrvxPO7CrDiR
	yV1khih4ajcNc8PcHF8ySuDZ4tdBjbpDXGY51ubEXZLcjgwxvd39zWu7XFeAF/7iVn4cKLkWKMRa1
	7MigC0iT8HyI1S1JLQUHORlhRL3LScqk0DYfbiPpJAOF/VQE5TKm9w1/Rs62ZmekbJHnbMxog5V+n
	Sh/pp4FE7A7teVBTS2CS5wCKthtFoYudkss9BAbU0gOlRRRxck8zskj3PalqItMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjct9-00F8Yp-1V;
	Fri, 22 Sep 2023 11:55:55 +0200
Message-ID: <ebed5822cb23b51208afa6c08187b486f8ed05bf.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 11:55:54 +0200
In-Reply-To: <428dc1a37ab12368e09c555e44b767b8aa042cfd.camel@sipsolutions.net>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
	 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
	 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
	 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
	 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
	 <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
	 <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
	 <40babfb4-ed65-dd0e-23aa-abdfaa9c7149@cambridgegreys.com>
	 <efaa802bcd0369665b3dbc10030c9ca88aa2cb30.camel@sipsolutions.net>
	 <1ce8c412b0d2bdfa176f1f783281e393da94ff6f.camel@sipsolutions.net>
	 <b8769840-1e33-f9bf-7a55-6ea805a1639a@cambridgegreys.com>
	 <428dc1a37ab12368e09c555e44b767b8aa042cfd.camel@sipsolutions.net>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_025557_520498_2B53DD47 
X-CRM114-Status: UNSURE (   9.57  )
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

On Fri, 2023-09-22 at 11:51 +0200, Johannes Berg wrote:
> On Fri, 2023-09-22 at 10:19 +0100, Anton Ivanov wrote:
> > > 
> > > So maybe that works - perhaps with a big comment?
> > 
> > Ack. Will add this to the patch and run it through its paces.
> > 
> 
> We can also just get rid of it entirely:
> 

And then we can remove all the skas0 stuff, including init_thread_regs
and all.

Seems the cost would be basically that we now pagefault everything
that's used between fork() and exec()? But is that so much and so
important?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
