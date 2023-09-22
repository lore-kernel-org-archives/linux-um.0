Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C983CD4F5B
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 11:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WzOyVOUpzyG7KpJuge7C1/nDcXpcd0WF37m41gdmrHc=; b=WkBIob2UfPplcI
	oRJBJQY+8dSFU5/AtcpztnWca/LXzG8MH266O/DW8Hf6MmOoSDs/fCH51pwdz0MLeRbHYWV+RsxLf
	fK14BtLPCGIcYlRB7onDlr9eGrGZjaHwasb+X7O6RL4BDXu9YbRCFiwYHnV+K9l6uwVAOEdOEmFks
	AyYbX4aeX37ASfpYEtK4Py/8hSGP2adWf8nqOdMtqS5KcV6p6eMa1nBOzGZx21rdub3vJbIEiXx80
	ksLAoZ/NKtvfvrlOSlriNuQ5zyyQgIVP+OYHJPc/DwDLZIklz1RO3dhNgTJaJ9Lx1Dh4jpKD0ZQ6w
	yD0DFHmWaL8DAGdd0wCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjeAY-008w8o-0r;
	Fri, 22 Sep 2023 11:17:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjeAV-008w8N-0X
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 11:17:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p7KVNgSt4gx3DVbSPAszIu3Kfybo1ApTYgSxtQ8aaXU=;
	t=1695381475; x=1696591075; b=qC2CptMPXd15ei6/rpSGst9ARKrVqzGF6pUxuRSMZx4kLdi
	DIsnaLPivGv7pAkvLUttPlGXi+RWYhwc7rz8DpZMpkZf8P7OFW1jmgRQvSQLdxI2t2vVRcLvHttzx
	nJ0jvvas2RWUXE/ijbTGIRJvn9Jb4MKqKYl8noy9ZzDi/lxKfMp4ObMN2RNJdDvSgH3vZ4TrVSEZ7
	OdydMD+sMn6YTlImFAZMZoYkMyQFvTk3z3WoAuVIhZ0Zx2ty9hzc54/AlK5qoLi4BSQOU/gqyTAvN
	kVqOJVlWyqqejPC05dKe9NUq1wna6MvLImxRYV2BvIMrfZlUW58v+JPaJZ9VZbqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjeAT-00FDOY-0a;
	Fri, 22 Sep 2023 13:17:53 +0200
Message-ID: <b6c39036cffa4a062fb89b8267e9ee618ee1313e.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 13:17:52 +0200
In-Reply-To: <2e7356cb-07c9-bb62-7f4d-b0e4c7af88cf@cambridgegreys.com>
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
	 <ebed5822cb23b51208afa6c08187b486f8ed05bf.camel@sipsolutions.net>
	 <2e7356cb-07c9-bb62-7f4d-b0e4c7af88cf@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_041755_220582_9D53F5F9 
X-CRM114-Status: GOOD (  14.57  )
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

On Fri, 2023-09-22 at 11:55 +0100, Anton Ivanov wrote:
> On 22/09/2023 10:55, Johannes Berg wrote:
> > On Fri, 2023-09-22 at 11:51 +0200, Johannes Berg wrote:
> > > On Fri, 2023-09-22 at 10:19 +0100, Anton Ivanov wrote:
> > > > > So maybe that works - perhaps with a big comment?
> > > > Ack. Will add this to the patch and run it through its paces.
> > > > 
> > > We can also just get rid of it entirely:
> > > 
> > And then we can remove all the skas0 stuff, including init_thread_regs
> > and all.
> > 
> > Seems the cost would be basically that we now pagefault everything
> > that's used between fork() and exec()? But is that so much and so
> > important?
> 
> Needs testing :)

Yes. I sent a patch just now, works for me.

> Let's get the PREEMPT out of the door first.

Dunno. It has a conflict, but I think it's kind of a bugfix, the whole
mm creation copying from 'current' seems fishy when you consider
clone(CLONE_VM).

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
