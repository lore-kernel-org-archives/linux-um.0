Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47353C021B8
	for <linux-um@archiver.kernel.org>; Thu, 27 Feb 2025 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dP1bPNy+lHZjsnn6YNsOn4jH1eyiBdO5lTAAWRz8GnI=; b=4KyJdDMsQKFtmtDz+6yLDnOSkW
	hgN6+78nXAb5ZCc/tOAcuNGn5gWuc76I+FA0I8Z8NK52dNHnooth2tHm+0+2oy/UW4S2aGvNfysl/
	t9QY8bcCmNHjmNsz6wHSpyQeUC4MzfeDXYYzq31DEFSRxa9lw1bqZJ1Mj5aBy+CXPE+uzRn5gHA9m
	toscyP5uAyiFlk2TfPkqr2Dqp73YNpEW57MPpqxYgiB/gwyIEYoK1O89cJ+Yk6plx3zj9ZhTA90B2
	uJGvw1DVUkTAY4/sHvUv5DGEKN+f7w3mEB0pOGWzOIjiciT/BG0PUlGQ+x1/nzmk5ep+QSzcBoR+5
	t8//4Yqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnSsj-00000005xww-0ze9;
	Thu, 27 Feb 2025 01:40:09 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnSsh-00000005xwV-0xwy
	for linux-um@lists.infradead.org;
	Thu, 27 Feb 2025 01:40:08 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C365321186;
	Thu, 27 Feb 2025 01:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dP1bPNy+lHZjsnn6YNsOn4jH1eyiBdO5lTAAWRz8GnI=;
	b=u08A+whY9HPi82eNKNi6NBpw/0yooU5Rc+wCm6UR5x1aiEZUlD0EhBT6SdYyQRh08/q5D+
	c3Cq1bGZvdRAvEAPiw5nsKK8kRVJrDI3Q8i6itlW/X21el6Vkb3ynKqYVjD6If2fv83cWx
	ouZsX6rTSxBVA4Di+tOia5Rq7RWkLhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dP1bPNy+lHZjsnn6YNsOn4jH1eyiBdO5lTAAWRz8GnI=;
	b=xl1+cA2Xm7ijRyut64mqXOdMKSFclvP/NlOPDbtrmoDh7s1H33qhhw4yM9Vh6Ryzlytlxy
	90+LezvCO0MZF3BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u08A+whY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xl1+cA2X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dP1bPNy+lHZjsnn6YNsOn4jH1eyiBdO5lTAAWRz8GnI=;
	b=u08A+whY9HPi82eNKNi6NBpw/0yooU5Rc+wCm6UR5x1aiEZUlD0EhBT6SdYyQRh08/q5D+
	c3Cq1bGZvdRAvEAPiw5nsKK8kRVJrDI3Q8i6itlW/X21el6Vkb3ynKqYVjD6If2fv83cWx
	ouZsX6rTSxBVA4Di+tOia5Rq7RWkLhE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dP1bPNy+lHZjsnn6YNsOn4jH1eyiBdO5lTAAWRz8GnI=;
	b=xl1+cA2Xm7ijRyut64mqXOdMKSFclvP/NlOPDbtrmoDh7s1H33qhhw4yM9Vh6Ryzlytlxy
	90+LezvCO0MZF3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3355134A0;
	Thu, 27 Feb 2025 01:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ccc9HW7Cv2e9EQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Feb 2025 01:39:58 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6 v2] Change ->mkdir() and vfs_mkdir() to return a dentry
Date: Thu, 27 Feb 2025 12:32:52 +1100
Message-ID: <20250227013949.536172-1-neilb@suse.de>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C365321186
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,vger.kernel.org,gmail.com,redhat.com,szeredi.hu,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_174007_423690_08BAD82E 
X-CRM114-Status: UNSURE (   7.28  )
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

This revised series contains a few clean-ups as requested by various
people but no substantial changes.

It is based on vfs/vfs-6.15.async.dir plus vfs/vfs-6.15.sysv: I dropped the
change to sysv as it seemed pointless preserving them.

I reviewed the mkdir functions in many (all?) filesystems and found a
few that use d_instantiate() on an unlocked inode (after
unlock_new_inode()) and also support export_operations.  These could
potentially call d_instantiate() on a directory inode which is already
attached to an dentry, though making that happen would usually require
guessing the filehandle correctly.  I haven't tried to address those
here, (this patch set doesn't make that situation any worse) but I may
in the future.

Thanks,
NeilBrown


 [PATCH 1/6] Change inode_operations.mkdir to return struct dentry *
 [PATCH 2/6] hostfs: store inode in dentry after mkdir if possible.
 [PATCH 3/6] ceph: return the correct dentry on mkdir
 [PATCH 4/6] fuse: return correct dentry for ->mkdir
 [PATCH 5/6] nfs: change mkdir inode_operation to return alternate
 [PATCH 6/6] VFS: Change vfs_mkdir() to return the dentry.

