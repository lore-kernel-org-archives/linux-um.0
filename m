Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF1AC54EAA
	for <linux-um@archiver.kernel.org>; Sat, 28 Jan 2023 01:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wh/nefqBDyQdsm6w9korVFBCwOgW3PDWblh1fcBqoLI=; b=TdCbRADva0U90q
	ntf1+vRPyAc1TawcH8VASaJf0c32GttipGNKEpWjEqUAvjlbpfY5GbUImJpBI+y0UFKTVHFdFxxXf
	NUPa4UrI4yar0J0E16NGLJQHeLoE89IpQNqC8uqCQNZsmDFciPn45IUUuS0jCHMl87rREmOwt3BFf
	Uh35R8rMn7u6/VmbLdJjlrg3T+bF4+TOavrn9ewAdgT89tVCh7RlV2rtayNxUWqKnYWr+WVvpNXyX
	a+YhflF39geAWVOmN0CLgFon2hsWySebZ0OF7KLDP1ujfYZy/LilpHSf1Pi7/46B+Rr8/1ReWP3Lz
	j2LtvBSJeIUkAnYy9tVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLaEt-00H2Iy-43; Sat, 28 Jan 2023 01:42:43 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLaEq-00H2Ie-NX
	for linux-um@lists.infradead.org; Sat, 28 Jan 2023 01:42:42 +0000
Received: by mail-qt1-x82d.google.com with SMTP id m26so5624033qtp.9
        for <linux-um@lists.infradead.org>; Fri, 27 Jan 2023 17:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MlcziTN/ipm8fB+HkYIUMdMbBg/gfCHE1crLNdnMeD8=;
        b=sNb2DhAMhqSfngZdLPjNSAcVO63BRC6P6axz9Ot//tPDU3shuToCEeA5p3zAGpYAIw
         fuepmLo/6qoirOT4PSZRHeOHfTxqa1dhARzreSjeyM+co5IH34ulv2MbvEYsko+tjPcA
         Zw0hbzXrRsxz0Ap51aa7bTKfJGYO8oTnZKirMuqKsLp+e0YNYjdT8/Dk9zhxmVh4t+xI
         MDZ0sZVOTNtC5dkC5hkM/o+I+yExMsf0umx56ILVffh6Z/cLe3G9bra6JhWtJlyGnAlr
         aDgsr2Nb11MY7H1tMbYeUGhl0SF7WZBtmfVkiKCxLh7OP+qMe6e73NT6DyZw5ERBCWlb
         EAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlcziTN/ipm8fB+HkYIUMdMbBg/gfCHE1crLNdnMeD8=;
        b=n16iPP9vnBwbscLht6exu6BDnDaj/L21IhtbTYikuNyUOb3woz5CLxeGuQDJ2F54NZ
         KmHUv9I5hyGDOKAXBRGEQIhxAJA/8F/lWI7cYbB4PtEyBbsuzF4kxCu/iTxv5Uto3QLT
         vaC1a2rZGZYe4JhArjLS8P6erJYkjpKGU72Rm0hN+mLX1vkfn4LtAL5KT/p4Hq6w1cqw
         z6PHk0Ps1+y5j4/dLtK8w+dLKI3K039EoYDsXIOmUtJ783lvR6QusZ0gl5CNNoRnhznM
         pgb3W+gimhUMNl6IQHUhXVqpSj+k21tq9PtgXj5+ganpg2dfbPAuqBnuoo4fBRdI0qpe
         fVrA==
X-Gm-Message-State: AO0yUKVGM4iOXAn9k8aohtEgkrkcZdwV+oQCzVDcrjk7gVYsrcbAQ2MI
	lhJNEnY9tzHY47N7qISuq6vbBlyccyY0dNza
X-Google-Smtp-Source: AK7set/GA+n6TJfA49ctoN8WY7M0rGsb3uGw51KnBEGwF/buxYL4ODu9A1TWihDFRX6aaFd+0vZeUQ==
X-Received: by 2002:a05:622a:394:b0:3b8:2e36:9d28 with SMTP id j20-20020a05622a039400b003b82e369d28mr4705005qtx.55.1674870157738;
        Fri, 27 Jan 2023 17:42:37 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id l14-20020ac8724e000000b003b82e3623a6sm236942qtp.54.2023.01.27.17.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 17:42:36 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
To: linux-um <linux-um@lists.infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Johannes Berg <johannes@sipsolutions.net>,
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Glenn Washburn <development@efficientek.com>
Subject: [PATCH] hostfs: handle idmapped mounts
Date: Fri, 27 Jan 2023 19:41:59 -0600
Message-Id: <20230128014159.1741728-1-development@efficientek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230127_174240_975413_AABE1264 
X-CRM114-Status: GOOD (  10.28  )
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

Let hostfs handle idmapped mounts. This allows to have the same hostfs
mount appear in multiple locations with different id mappings.

root@(none):/media# id
uid=0(root) gid=0(root) groups=0(root)
root@(none):/media# mkdir mnt idmapped
root@(none):/media# mount -thostfs -o/home/user hostfs mnt

root@(none):/media# touch mnt/aaa
root@(none):/media# mount-idmapped --map-mount u:`id -u user`:0:1 --map-mount g:`id -g user`:0:1 /media/mnt /media/idmapped
root@(none):/media# ls -l mnt/aaa idmapped/aaa
-rw-r--r-- 1 root root 0 Jan 28 01:23 idmapped/aaa
-rw-r--r-- 1 user user 0 Jan 28 01:23 mnt/aaa

root@(none):/media# touch idmapped/bbb
root@(none):/media# ls -l mnt/bbb idmapped/bbb
-rw-r--r-- 1 root root 0 Jan 28 01:26 idmapped/bbb
-rw-r--r-- 1 user user 0 Jan 28 01:26 mnt/bbb

Signed-off-by: Glenn Washburn <development@efficientek.com>
---
 fs/hostfs/hostfs_kern.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index cc1bc6f93a01..876b73e05ac1 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -786,7 +786,7 @@ static int hostfs_permission(struct user_namespace *mnt_userns,
 		err = access_file(name, r, w, x);
 	__putname(name);
 	if (!err)
-		err = generic_permission(&init_user_ns, ino, desired);
+		err = generic_permission(mnt_userns, ino, desired);
 	return err;
 }
 
@@ -800,7 +800,7 @@ static int hostfs_setattr(struct user_namespace *mnt_userns,
 
 	int fd = HOSTFS_I(inode)->fd;
 
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(mnt_userns, dentry, attr);
 	if (err)
 		return err;
 
@@ -814,11 +814,11 @@ static int hostfs_setattr(struct user_namespace *mnt_userns,
 	}
 	if (attr->ia_valid & ATTR_UID) {
 		attrs.ia_valid |= HOSTFS_ATTR_UID;
-		attrs.ia_uid = from_kuid(&init_user_ns, attr->ia_uid);
+		attrs.ia_uid = from_kuid(mnt_userns, attr->ia_uid);
 	}
 	if (attr->ia_valid & ATTR_GID) {
 		attrs.ia_valid |= HOSTFS_ATTR_GID;
-		attrs.ia_gid = from_kgid(&init_user_ns, attr->ia_gid);
+		attrs.ia_gid = from_kgid(mnt_userns, attr->ia_gid);
 	}
 	if (attr->ia_valid & ATTR_SIZE) {
 		attrs.ia_valid |= HOSTFS_ATTR_SIZE;
@@ -857,7 +857,7 @@ static int hostfs_setattr(struct user_namespace *mnt_userns,
 	    attr->ia_size != i_size_read(inode))
 		truncate_setsize(inode, attr->ia_size);
 
-	setattr_copy(&init_user_ns, inode, attr);
+	setattr_copy(mnt_userns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
@@ -991,7 +991,7 @@ static struct file_system_type hostfs_type = {
 	.name 		= "hostfs",
 	.mount	 	= hostfs_read_sb,
 	.kill_sb	= hostfs_kill_sb,
-	.fs_flags 	= 0,
+	.fs_flags 	= FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("hostfs");
 
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
