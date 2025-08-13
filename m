Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6650AC87FCF
	for <linux-um@archiver.kernel.org>; Wed, 13 Aug 2025 03:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZv6+PvJUXtJWPttoq47kMgqdSRNoX5QOTrEIOYs1uE=; b=gnVDyKybcUzMz3tI+maMwUevCC
	8T/+I0dKeogsy0zf5IzrggUBabEJ1d2CLoyh/SByynCTO/xX6zt+uTSnNuX8hsvdIvg23y5WrOIDt
	XVKTFBwk18aahyjk1+xFHwpKdfSCEks1W54nFNdjQBfgiRQPvAFhW4v3sg2fxxpY5cWoVluf5Ho7r
	IUup6YIEFzYZDluX9l7Qc/p7lIQcV5zp1A/kck60mJQ2t1eElvlVgIGM0ZWrrrc1ADEfVi8Pa9it0
	cGwLfetcDcF7GfnOl0xw/GV9t2wwdgyerwl+qBva763/tXGam1B9VzYcP5IsL39MQTBTrbBO/n8GX
	R2zWOV6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um269-0000000CVlJ-30qb;
	Wed, 13 Aug 2025 03:24:21 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um24R-0000000CVVx-1PLt;
	Wed, 13 Aug 2025 03:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mZv6+PvJUXtJWPttoq47kMgqdSRNoX5QOTrEIOYs1uE=; b=fAFNgc1auSoV8mA7b6YMBtX+j5
	rl8bDV/EeCqND0al4fPbDzIAEpPYcyF7qkiUImV7O4z6/z4uY4kXywRzc1pGW1crAJalXzhJBGEzd
	S6obRySg4KfM6Rlmcyo74FXF9pwKE1B0Uz9zgiAO73PqvC5pg/VHWinHUWiWDIDBgZElXJt0aq0XM
	tvIU6HFgTuPeaU4k8wfdhReTrAd/x6tskDlpsFNzLn1+69HtZ8V07NJFErG7xVWEdqrKPndQ4zIOJ
	yLXsMqeqHWjN1NAVE5WT0ZDeTc2PqoTipg/C9vNxL5JZKL1GnCqx5nKXIadgYfbGnlkr7P1ZiQwmV
	l/wZ3+4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um24B-00000004v1A-2JpQ;
	Wed, 13 Aug 2025 03:22:19 +0000
Date: Wed, 13 Aug 2025 04:22:19 +0100
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
Subject: Re: [PATCH 01/11] VFS: discard err2 in filename_create()
Message-ID: <20250813032219.GX222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-2-neil@brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-2-neil@brown.name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_202235_370843_18982FBE 
X-CRM114-Status: UNSURE (   9.89  )
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

On Tue, Aug 12, 2025 at 12:25:04PM +1000, NeilBrown wrote:
> During the time when "err2" holds a value, "error" does not hold any
> meaningful value.  So there is no need for two different err variables.
> This patch discards "err2" and uses "error' throughout.

I'd probably replace the first sentence with something like this:

Since 204a575e91f3 "VFS: add common error checks to lookup_one_qstr_excl()"
filename_create() does not need to stash the error value from mnt_want_write()
into a separate variable - the logics that used to clobber 'error' after the
call of mnt_want_write() has migrated into lookup_one_qstr_excl().

