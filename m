Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D10C19F32
	for <linux-um@archiver.kernel.org>; Thu, 27 Feb 2025 19:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lr8OD/cMnrFoxrLKGbUht4AEc4gitX1kJNyvDvjqWvY=; b=WoG/CZWPQZLmRAPnDrNVottyJY
	oe63Um1pU0IDsr5P80prCcWLDzSyjTgsPC2alIOo78Lami/SYMX4pzHqaSynw6PTf1w6f2iptP2g1
	IQJt1DMNcuYe40IYufY7YZSPZohvYpgJSxY3lknNEzmgcRcF2hoMdY/+jop9j3YaQ4nID/5a/tVb5
	ltUvc1pTusBKmqDmb8qF59QThrg6PbueFHD/NLr+WugS3S3tKU2e49kg93opfKqvJqHaskjBPXj4c
	pGAOTvaDwGvGnbpwhkVcGdgqiJxaJg8fXWdBDZ2btFedPdVmKPaeT35NN1dIo0eALL1EmbSFqG7Fe
	RpfOc4lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnjmv-00000008eO8-1rb4;
	Thu, 27 Feb 2025 19:43:17 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnj9n-00000008Otw-2YrE
	for linux-um@lists.infradead.org;
	Thu, 27 Feb 2025 19:02:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 892D761F45;
	Thu, 27 Feb 2025 19:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18C0C4CEDD;
	Thu, 27 Feb 2025 19:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740682970;
	bh=lr8OD/cMnrFoxrLKGbUht4AEc4gitX1kJNyvDvjqWvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDOvpApdyymL8nnu4OHG8tGJTMPUCMOpi9GGiNTg2kjF/upOTlqV2TgzflgfNMYjt
	 so/x/a3Qwptq0Evkh0IQSdAKDhSGsO6+3GJ7MEV1L5FrKa2pOyEbeM3NAqGtluNE+G
	 hsTQSPCcwj6x0Pdk3xIfkdTX0zzyM2BnNuxZ0ntsKkZu+/6pLGlEyJXgDJEIFmOJVE
	 4YQaTrJS9l0QIfyEifTjSewCZau/kTxCK06ZfNRjx+b9S/PdQLG/bdawGQ3Ru8YoBW
	 KENFbt69F5/7BGf/wkfYaMeYlQA/PRJmH5dtUav+NhfGM5sGKJ6ynfJlGy39ij1lNu
	 yxRHVLC5+jq6Q==
Date: Thu, 27 Feb 2025 20:02:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6 v2] Change ->mkdir() and vfs_mkdir() to return a
 dentry
Message-ID: <20250227-besten-havarie-9a8288ff4e80@brauner>
References: <20250227013949.536172-1-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227013949.536172-1-neilb@suse.de>
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, Feb 27, 2025 at 12:32:52PM +1100, NeilBrown wrote:
> It is based on vfs/vfs-6.15.async.dir plus vfs/vfs-6.15.sysv: I dropped the
> change to sysv as it seemed pointless preserving them.

I added that change so there's no dependency between the vfs-6.15.sysv
and vfs-6.15.async.dir branches.

