Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386A8CA0EC4
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 00:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j4r1hppquktqtYidrhW4W0wl7fe8offrZaopf6cG3G0=; b=RLBMrAOIkqf8SGbOvzTDjeM1yc
	i10kBrqau7EWp5lxQPvTnZRGme+3MHsic4thcDXPwpRkDzruO+3QBrvtcL/cMaUOfr5aZoIzxFlXx
	LwVg0VnpPkrh0mMUN54OokkHetREp+hecOhhJ/yRaZFIYKLAev7KE0jXFe8Z/4oLhXk6EVFcYhApM
	by3v4QSDzPMoX/+nvvF6+Bms0D9x+WtVAADfQOHqa3z3Ypkzu8wPmeBHov6tOGVqhWpQo7Lm7LVYq
	EbPDyHf/W+GnFMxQAPj245n4JtUH1ZQcgYIaSf+TYNjOOn7i47hM+zdz/jy7rYf0buiowzMId4aAK
	zaotOH7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyvl-0000000CFmD-1OUO;
	Wed, 13 Aug 2025 00:01:25 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyvi-0000000CFlW-10gi;
	Wed, 13 Aug 2025 00:01:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j4r1hppquktqtYidrhW4W0wl7fe8offrZaopf6cG3G0=; b=cZbBypArsAwEupU5gvJSbx81kI
	Qosd5QsgwcTBqjCvjrl9+522yt1DsRHkxW3rP4QAtNBLuPkNqySvn9xNhx4W8UKAuQRjCZFER9Q+q
	OU7f9ZV2fnoJgxNmuLvs+ROm2HQIttuS7sdzJM4TKl8JXUJt7kHFJ0HzLbIvH539ChpirDHa95hk0
	0jIldmck0numN0slLAIZ1NO2d/wYZ2QGgElgnPrudAOXVUCPogdbljQ+lo4cAZuF/fAYQ7+h58qa0
	Y+ivu7VmgfbRR4UATQ5PHl9u0DWkjAMVf4kUbfjIu4pzP85eSzA7U8m0V2v8gQf19C/Fc36DoyW7p
	DX85i4rQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulyvN-00000003Gyx-2z1h;
	Wed, 13 Aug 2025 00:01:01 +0000
Date: Wed, 13 Aug 2025 01:01:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] VFS: prepare for changes to directory locking
Message-ID: <20250813000101.GW222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-1-neil@brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_170122_277217_044B098B 
X-CRM114-Status: UNSURE (   9.22  )
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

On Tue, Aug 12, 2025 at 12:25:03PM +1000, NeilBrown wrote:
> This is the first of 3 sets of patches which, together, allow
> filesystems to opt-out of having the directory inode lock held over
> directory operations (except readdir).

[just a quick reply for now - I'm going to be away for about an hour,
then will review and reply]

