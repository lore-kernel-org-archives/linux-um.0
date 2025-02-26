Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CEAC021BE
	for <linux-um@archiver.kernel.org>; Wed, 26 Feb 2025 03:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gfLaod49ckkklrS5HkMhsUUQYxad/szdqQ5Z3G50Xxc=; b=NwvNnndSEzI7pLjyPc451/zv2N
	SIHuW9GOwiYRZgMjftvRFcXFmj6HgwC4sIY1tPawvVsOSd1ZWquW8IMjX8y6qz9TL7xOqiMkb8WsP
	8Z2gThxeoZ9c4G5zBjVaGhLtA+06kYQx54FPuNVm2JeFXB5qH/O4KECDYO9a9f4XW0eVrBXy/KMxr
	pt/DsGMjKnaOBgw3jrq4ivCpcMweiRwZJ8tLA2jBXN6LLnh7xiFxe7k1BAlPj6xJfZ50CAqxofFs5
	kn2GYU3C2qSbzvBWhAEkPQach9UqLWOHy6KlbcAq1ywxlsxMvj0wZFqmjWvoGiGAZADhfJv9CIp3T
	uVDeWK/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tn8Ch-00000002Iac-170y;
	Wed, 26 Feb 2025 03:35:23 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tn8Cd-00000002IZu-3wtL
	for linux-um@lists.infradead.org;
	Wed, 26 Feb 2025 03:35:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gfLaod49ckkklrS5HkMhsUUQYxad/szdqQ5Z3G50Xxc=; b=tF0QJu5lrPkZBMtLbiLy4Bz1tH
	WcfomiLvJTogVrL3Tm3HLUWsQkmVsguQ3kKBOQtM8U1GP7NJTm4ssI9t7V04farVLYkNl1rieqwyh
	AYSqiINBHrXOLqT/4WE0ylXNEahosCIQYeUXTO05cznqwrBCaYnLaDJ4v/F2/+SMW77u27JkdVbk7
	POrmBkRBps1JfVkaaZcTMMr9f1snr1/bo7w0g/WJqGnPjJENRjtAM1aQzSSkLMGj7I9isyfI6s1mj
	u5K5s0hWNEvdijcR5mlFiz1dJ7GYBCwzTYwxiL+DTreVwX0/EmcMRkQcOUucQheqL6UTfDWQNlXXN
	fRD4wEqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tn8CQ-00000008k3i-3dIs;
	Wed, 26 Feb 2025 03:35:06 +0000
Date: Wed, 26 Feb 2025 03:35:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"xiubli@redhat.com" <xiubli@redhat.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"okorniev@redhat.com" <okorniev@redhat.com>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
	"jack@suse.cz" <jack@suse.cz>, "tom@talpey.com" <tom@talpey.com>,
	"richard@nod.at" <richard@nod.at>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>
Subject: Re: [PATCH 1/6] Change inode_operations.mkdir to return struct
 dentry *
Message-ID: <20250226033506.GE2023217@ZenIV>
References: <>
 <50e6b21c644b050a29e159c9484a5e01061434f6.camel@hammerspace.com>
 <174053988113.102979.18024415194793753569@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174053988113.102979.18024415194793753569@noble.neil.brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_193519_984200_1C7E05A7 
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Wed, Feb 26, 2025 at 02:18:01PM +1100, NeilBrown wrote:

> Thanks.  I'll submit a patch through the VFS tree as I have other VFS
> patches in the works that will depend on that so having them together
> would be good.

Do it on top of mainline, please (say, -rc4) and let's put it into
a separate branch - easier that way to pull it into other branches
without causing headache.

