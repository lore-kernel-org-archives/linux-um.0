Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9138E6FE35
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8M8GA5wTPXmSLrx9FTIzUyj9hJDt8jzt4lodKKeZpO0=; b=AE8ciewb8TkIdw
	0X+6/QY6PlN6qVSxSNBrNamDQronH0rRsxmT3YujJ2dGcC14HSsrHJ0Cp+bsPrLSSR4VIZ1OIXozH
	tNuwAeFrn/I2SJUDbbOJrcT15NzbSiNtIAHIECoYN3QtRByrenUEkUdpdpGDpaz6qsxWR+zz4vA8E
	f604wevzUReVoyLW7kzW3Ago5k+qaNL1dw50MvEzDLG+fWKoMN5jiHRNjNufhc3oCSQYSYn5BLCII
	WBlybORapeoSQ+mmDGZuDOQfSeUihULwCy2wjFLyvNja/uB4SNLXEB5D+EA6Dnlu2yjBLmUgMTEGI
	96esIHRmW/WzQoodjWGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjh19-009Bjw-2r;
	Fri, 22 Sep 2023 14:20:27 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjh17-009BjO-1S
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 14:20:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/XGLyjHA1eQQtAiXVhvqbi2kHwROLm8uB2Z8UX8+Egk=;
	t=1695392424; x=1696602024; b=fheEM4e45eQuRoLWPR6pwKGlGa8OpORot6myGzoZ7TZdpy8
	P4jkXPkJufTYBfRQu9n2S+klMICXKJtGVZKRQMA13gP+GOZbCpuNj94JXFsIUSN5nWleMnQOpV5qj
	0OT/mzokFuTJxZwuA69Skk7WqUBCjX9W4gunz6DlY30XYQZChUy5nrgGtq39WZlswGq06DKTaOvc0
	rBWMsvVxQNbJEa+zhldvCBhjqUSzm+nKwpoI5zWtUXwOZ5YISsmmSAQB/6Vh9fPahY9MAj/nkKWLX
	DuT4Iv54lX/asfqjOcPy9KpYiUYkS8BIohlyl8xcMHaSgIUGFbRfx1SYvfwUzdZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjh14-00FOu7-0t;
	Fri, 22 Sep 2023 16:20:22 +0200
Message-ID: <10536e1e18d190e3f9d977511fcabb1d730aaeb6.camel@sipsolutions.net>
Subject: Re: [PATCH] um: clean up mm creation
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Date: Fri, 22 Sep 2023 16:20:20 +0200
In-Reply-To: <88e0568b-6860-9042-7f8b-ab53edb4242e@cambridgegreys.com>
References: <20230922131638.2c57ec713d1c.Id11dff4b349e6a8f0136bb6bb09f6e01a80befbb@changeid>
	 <88e0568b-6860-9042-7f8b-ab53edb4242e@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_072025_493127_B65688AC 
X-CRM114-Status: GOOD (  25.02  )
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

On Fri, 2023-09-22 at 14:41 +0100, Anton Ivanov wrote:
> On 22/09/2023 12:16, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > While enabling PREEMPT on UML, we found that the call to
> > force_flush_all() cannot be done where it is, it sleeps
> > while atomic.
> > 
> > Further investigation shows that all this seems at least
> > a bit roundabout and possibly wrong wrong in the first
> > place - we copy from the 'current' process and then flush
> > when it starts running.
> > 
> > What we really want is to start fresh with an empty mm
> > process, then have it all set up by the kernel (copying
> > the original mm contents as needed), and then sync it
> > in arch_dup_mmap().
> 
> Is there a way we can come up with COW here?

Well, I kind of thought we _did_ if we have arch_dup_mmap()?

Need to understand this better.

> > 
> > We should do the same for the LDT, so need to split that
> > to be able to do this.
> > 
> > Note that this fixes what seems like an issue - we look
> > at current->mm when we copy, but that doesn't seem right
> > in the case of clone() without copying the MM. This is
> > probably saved by the forced flush later right now.
> 
> We will need to work on this.
> 
> It is nearly twice slower than the current approach on a find /usr -type f -exec cat {} > /dev/null \;

Hm, that's annoying. Guess I have to figure out why.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
