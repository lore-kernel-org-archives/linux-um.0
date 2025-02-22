Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D824C021B2
	for <linux-um@archiver.kernel.org>; Sat, 22 Feb 2025 04:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zK7Q2y4vb1Jl3/aS9MBSQWpnKf9/zrIOVxSewBZmwJg=; b=oxXxebb2NKh65LoOOB1RKDxrhB
	bYg/NIuVluOgrhJ8l71n6pVQ4nTgV4pa6AcRADgeVE7eotPnh9BPG4v9kCSryha3wAu4R5Qv2Gqk+
	DPSPpk1MMxmgvYkt8aW9g5nGlPh1AzCljVQqsSoUo8wcMuR21/2DlwHlVCTPqDTfhgHNgvIwumG7+
	oxiqxMC61uQv7qI+DKePi2DOj6pT0z+OIHP0RkWfoICIL3nYH7fGv5/2UBR8gRaVQmbnh7vbGGEvg
	yhdr6dfPryABWOd1FV+AypihhKIYyfi6lumg0TenLGbVoxTYp6d+9n0eo8vpbpIWfhd5jy/t7YspB
	7bhD/gWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlhZH-00000007Scz-3uYV;
	Sat, 22 Feb 2025 04:56:47 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlhZF-00000007Scd-0iNc
	for linux-um@lists.infradead.org;
	Sat, 22 Feb 2025 04:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zK7Q2y4vb1Jl3/aS9MBSQWpnKf9/zrIOVxSewBZmwJg=; b=ISd9hrzWXrpL02sSPfl5grZm4N
	OJp0CAQv3yrKxnknEU7KGWDEVMlTfLGAtrH3qw+7n30pO5S0/ir++dmGoijujkkuoeIhyYF4X04sC
	UfdOwtYU5OilalGsqgrlhMFSWVxYOe09PBjkEoTCNy5e6n8eg0LtzKdhowS+D54SNwoua8/7LiWES
	eVmuM1YDiKrq8ZOlavxoxJ6xVZHIMonVRSWxz8A27L07vH+9cX1tFY16dhoRpHNc6BHQ6ScGmHA7O
	Yhd427npxUuD2zEax0QZsBpKkEzual4Xm7dvjxqFovlmK4Pi0pSdD2xzNJNtF+6UPZ6jqkzGmwGus
	Dmg0S1Wg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlhZ6-00000004fZs-15x8;
	Sat, 22 Feb 2025 04:56:36 +0000
Date: Sat, 22 Feb 2025 04:56:36 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct
 dentry *
Message-ID: <20250222045636.GP1977892@ZenIV>
References: <20250220234630.983190-1-neilb@suse.de>
 <20250220234630.983190-2-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220234630.983190-2-neilb@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250221_205645_212995_FBE001AE 
X-CRM114-Status: UNSURE (   9.90  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, Feb 21, 2025 at 10:36:30AM +1100, NeilBrown wrote:

> Not all filesystems reliably result in a positive hashed dentry:
> 
> - NFS, cifs, hostfs will sometimes need to perform a lookup of
>   the name to get inode information.  Races could result in this
>   returning something different. Note that this lookup is
>   non-atomic which is what we are trying to avoid.  Placing the
>   lookup in filesystem code means it only happens when the filesystem
>   has no other option.

At least in case of cifs I don't see that lookup anywhere in your
series.  Have I missed it, or...?

