Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F311C64EC4
	for <linux-um@archiver.kernel.org>; Wed,  1 Mar 2023 01:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZSxKeqYGeI61Xqr7ivvlDt2KiZv7GryrIljWhARDCAE=; b=C0x3zFD01funA6
	tl8qlzJmU0hPd+MIktEKLzE0dT+KHd7CYpiN9YbH8kJcJOP7U6Expa54k7+WNZzsMdy2zF5O3i43z
	FQ3YvRRM6ZtZSi4nLwurRP5SL9PNkQJKHA26ELI+Ywf8nc16miwhfykZoPGf+FIOSQiB8k5Er86A3
	AWpiK51C6vvOA7cYREczqIcd2+Wit7QP53hnJ3eH5snIaMgypLGetO20S4J2NFvvHwwPVzecB0Fz7
	ERPWfeoyWUXrI+R8/P79HoBzAKgGOhq6bpNZmM0cWNC5hKjOEzXoBKqX/qFO9bFAz+sT61fbWmFGC
	Y+uxW9kztufQBIpo2+0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXBc7-00EmpV-FJ; Wed, 01 Mar 2023 01:50:39 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXBc4-00EmoS-CD
	for linux-um@lists.infradead.org; Wed, 01 Mar 2023 01:50:38 +0000
Received: by mail-qv1-xf36.google.com with SMTP id y12so8276530qvt.8
        for <linux-um@lists.infradead.org>; Tue, 28 Feb 2023 17:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=efficientek-com.20210112.gappssmtp.com; s=20210112; t=1677635435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mcrDBIGtrTEDjzonWUNUAc4MXuRWYEApdBnj/prlZpU=;
        b=dDKs5CP907SyA/Bjl9QDsBGZ56nJyMPapGC8bBkngXXKV1sqgR27+HEkCACRSCaOLl
         vLHnnYCcap/MfQncsNX7nqNofY9v49OyxdDsfwIE6LLSzmDCIpX8tNjBgM7wCd6ZBBjG
         92Xvh11XoHf0jiIbyL+CcMt++wiEAXwEph+dDblB0/3r0CuJ7n3E4U9XvRP47Yg9Q74o
         nSpWC690N+qR//1QyrR58O/7PNRJsuAYpiiqkCQTCihzM+i7RoiKGTIjMe2kBKBmvOQt
         JdoHVszfYpgUSAfwRN0LLNVztjr+MOfYHS0rADQ0TPR0lkgOQoQgaINpKmeJGV02/bzN
         ANEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677635435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcrDBIGtrTEDjzonWUNUAc4MXuRWYEApdBnj/prlZpU=;
        b=ud1yt3ddlyZTE9JpLI3CNS5LZxqs4v528h3bK0y+svbZVG/hx2ApPG6+3O1Ca+qrE2
         vxAWwKZUCmWlc+O1YcuVEz1l7emjngvTCuRN7R+R5ERLHUZXWBMJFUEh5u7K7AdRMvx7
         UGWiFWL63HyJut0nuEcJnQMm7qsJlBYrMpQCg52DqFT+MXDePo2oSwMXS4j31NfJ0ILI
         ue+TDv8W1qb1tHprD1W7IfqSMLr1yDvgYiqeIDadi+3TRiBic49kEORSzoo/E9YQwycN
         wI4JhkVp5szGP0wfkJVIeYIjuFtDArA3o+bm8HYun8glOfUjo/VyfjLTE2+TbEvgfPsq
         ckRg==
X-Gm-Message-State: AO0yUKU2dPB3uTBTSg9sY7I/lGc1eGfXvPcEYE6/36/5amePwWNwdMuc
	InWqv6VSIux0QQLaUKNDe0hjKQ==
X-Google-Smtp-Source: AK7set9a/p6WWFIvBuX9pL8jdiOxPQ2UPXugNGMeAAUTu0K6mSLmk0zzIXFguEf4CPa4Hbqn9ECGyA==
X-Received: by 2002:a05:6214:c43:b0:56e:9ab5:cd9f with SMTP id r3-20020a0562140c4300b0056e9ab5cd9fmr8229751qvj.39.1677635434870;
        Tue, 28 Feb 2023 17:50:34 -0800 (PST)
Received: from localhost.localdomain ([37.218.244.251])
        by smtp.gmail.com with ESMTPSA id d184-20020a37b4c1000000b0073b69922cfesm7750267qkf.85.2023.02.28.17.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 17:50:34 -0800 (PST)
From: Glenn Washburn <development@efficientek.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Cc: Glenn Washburn <development@efficientek.com>,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v2] hostfs: handle idmapped mounts
Date: Tue, 28 Feb 2023 19:50:02 -0600
Message-Id: <20230301015002.2402544-1-development@efficientek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_175036_665588_95D4CB37 
X-CRM114-Status: GOOD (  13.51  )
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
Changes from v1:
 * Rebase on to tip. The above commands work and have the results expected.
   The __vfsuid_val(make_vfsuid(...)) seems ugly to get the uid_t, but it
   seemed like the best one I've come across. Is there a better way?

Glenn
---
 fs/hostfs/hostfs_kern.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c18bb50c31b6..9459da99a0db 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -786,7 +786,7 @@ static int hostfs_permission(struct mnt_idmap *idmap,
 		err = access_file(name, r, w, x);
 	__putname(name);
 	if (!err)
-		err = generic_permission(&nop_mnt_idmap, ino, desired);
+		err = generic_permission(idmap, ino, desired);
 	return err;
 }
 
@@ -794,13 +794,14 @@ static int hostfs_setattr(struct mnt_idmap *idmap,
 			  struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
+	struct user_namespace *fs_userns = i_user_ns(inode);
 	struct hostfs_iattr attrs;
 	char *name;
 	int err;
 
 	int fd = HOSTFS_I(inode)->fd;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
 		return err;
 
@@ -814,11 +815,11 @@ static int hostfs_setattr(struct mnt_idmap *idmap,
 	}
 	if (attr->ia_valid & ATTR_UID) {
 		attrs.ia_valid |= HOSTFS_ATTR_UID;
-		attrs.ia_uid = from_kuid(&init_user_ns, attr->ia_uid);
+		attrs.ia_uid = __vfsuid_val(make_vfsuid(idmap, fs_userns, attr->ia_uid));
 	}
 	if (attr->ia_valid & ATTR_GID) {
 		attrs.ia_valid |= HOSTFS_ATTR_GID;
-		attrs.ia_gid = from_kgid(&init_user_ns, attr->ia_gid);
+		attrs.ia_gid = __vfsgid_val(make_vfsgid(idmap, fs_userns, attr->ia_gid));
 	}
 	if (attr->ia_valid & ATTR_SIZE) {
 		attrs.ia_valid |= HOSTFS_ATTR_SIZE;
@@ -857,7 +858,7 @@ static int hostfs_setattr(struct mnt_idmap *idmap,
 	    attr->ia_size != i_size_read(inode))
 		truncate_setsize(inode, attr->ia_size);
 
-	setattr_copy(&nop_mnt_idmap, inode, attr);
+	setattr_copy(idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
@@ -991,7 +992,7 @@ static struct file_system_type hostfs_type = {
 	.name 		= "hostfs",
 	.mount	 	= hostfs_read_sb,
 	.kill_sb	= hostfs_kill_sb,
-	.fs_flags 	= 0,
+	.fs_flags 	= FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("hostfs");
 

base-commit: 7fa08de735e41001a70c8ca869b2b159d74c2339
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
