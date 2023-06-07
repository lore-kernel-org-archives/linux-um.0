Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688EFC77B7A
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 08:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yFP1adJi2NhFurSEUzx8kbcpytCo4tIXZQVtOy/qYNE=; b=kpmb4cBBW4Lny9
	e+X47cTh6DqyyaXDG9XdewB0a1CY1pGEwujLPmTk9uSPDYlQ/6ODOwwltT2KQK0+IW8cjNHztn2Xy
	xc9usp7HbDL46nnJZS5QsV8ra8RXFX6uycDGkQ5FH+i7AArId3lNhFKt2ASF043dKUqtgnsG8Jg5+
	ZetzdU5pSe4ouZPvGnBLzqO+3GrRMnrs67/q+hnu08BMn4EdKQ0aDZLSygB9czdVZi9D0c6jULKhr
	j9WXR1ELusF79s0GnwkRUaiA5sz3L61aSbAKAy9iuE0lWeoLrwt/XCjqMsmSugyfCbjxu++Evj02l
	M2nTENVnIlT3TcAUdSaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oWs-004yFU-07;
	Wed, 07 Jun 2023 08:28:30 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6oWp-004yDN-1Z
	for linux-um@lists.infradead.org;
	Wed, 07 Jun 2023 08:28:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Hg9joOitzyrlswtLr/eslIOSFjCc+Bk2gMqM/S9yDPw=;
	t=1686126505; x=1687336105; b=tZr3gy+jWK4SMsoCOqZ79S28KMRH36/HCfW50mY/BJ+dgbb
	zamYlk2C0CMXgj/ZyLVpbkqjPuSx9kfznL8ZAjWB7/Cln4uh2H8/4KBbbehlz3ddbkX52p4k242fZ
	f3iPvvqOBS0EQkR+Gxme0kyr8mqJEQ3GJSZMgKW07wWfsnTLq2LlrviKyTQ2wyhIoH4GwOkqOzxmz
	zYu9w1Ik/mCfopPK54UCrp519nVRTcvWs2poStGypEbN+N0qxfz8a8GcbMHDCg8KY/JgCPXkV0b3O
	r+wWiav9XZr8dfXpJJWfQs7FItvEMSBV+MBuZOiQZ8Hp1E0aKhaBb1zkZUDgIMIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1q6oWa-00GTQu-27;
	Wed, 07 Jun 2023 10:28:12 +0200
Message-ID: <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
Subject: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH v2]
 uml: Replace strlcpy with strscpy)
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>, Azeem Shaikh
 <azeemshaikh38@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Maxim Krasnyansky
 <maxk@qti.qualcomm.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, 
 linux-hardening <linux-hardening@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,  kernel test robot <lkp@intel.com>
Date: Wed, 07 Jun 2023 10:28:11 +0200
In-Reply-To: <20230607042340.GA941@sol.localdomain>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
	 <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
	 <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
	 <20230607042340.GA941@sol.localdomain>
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_012827_532904_0E811472 
X-CRM114-Status: GOOD (  16.31  )
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

On Tue, 2023-06-06 at 21:23 -0700, Eric Biggers wrote:
> 
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes:
> > > > https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@intel.com/
> > > 
> > > Are you sure Reported-by and Closes make sense?
> > > AFAIK the report was only on your first patch and nothing against upstream.
> > > So stating this in the updated patch is in vain.
> > 
> > I left the metadata in only for the sake of posterity. If it's not
> > helpful, I'm ok with removing it.
> > 
> 
> IMO using Reported-by in cases like this is harmful, as it makes commits seem
> like bug fixes when they are not.

I've yet to see anyone disagree with that, and yet, the robot actively
asks for such tags to be included in patch resubmissions.

On the one hand, I can understand their desire to be recognised for
their efforts. At this point then we might suggest that we introduce a
different tag, say "Improved-by:" or "Issues-found-by:" or something.

On the other hand, I don't feel like we should give a robot more
recognition than we give _people_ reviewing, and we currently really
only recognise them by a Reviewed-by tag. Then again, that doesn't work
with the robot - it is pretty much looking at each patch and only
comments on a small fraction. We also really don't want it to comment on
each and every patch ...


So it seems we should ask the robot maintainers to just stop suggesting
those tags?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
