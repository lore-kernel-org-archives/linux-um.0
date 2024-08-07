Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB49C52D6F
	for <linux-um@archiver.kernel.org>; Wed,  7 Aug 2024 03:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jy5sBXXGr2voNP18guOdqKk17MKFMl8ptCuzk1nlp0Q=; b=lEGqUNTDMWjJ+ZP/Wux2ETK9Qf
	qmCpNJzvHfyX5tUy20dbC73+/9Q46vgOXrhdoxtG2IniYBIc+zJwm3N88NS5QmFq3gi3LSHhKnCnR
	BYrr89CjkBapu7Clj5GKl7iiNdKIhGZZjKwpUq+0zdnGiDcKI9uZptTyb9ejD2d8OpmMtfpIlzZ6p
	oFIVnLbyp5gcr2euQQkxqhGm7RxDneNp9vyFuboOHtzgbfoz/gPjnx3fT265gulA1WxISgAiq4HwV
	8vM/wjTQDh2nLW7LOcMX0SJBE9jw9AyIzI97VifSAGmYq6kKLRzkJFsR0CQm+LGj5suGj+76NX+fR
	1zGDIMYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbXcy-00000003kRw-1OuD;
	Wed, 07 Aug 2024 03:46:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbXcx-00000003kRS-0tuq;
	Wed, 07 Aug 2024 03:46:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jy5sBXXGr2voNP18guOdqKk17MKFMl8ptCuzk1nlp0Q=; b=kBpsMhbZ+1Pgy99WHBD3YzI4XG
	Hqy0KiWbREOfNTGd4D85Ztw2vyfymYiId0v/fTjNdlVAQK/i5x/NoKEy/QsyytCQ29qGuUAPcq9Qm
	vjWq9+4BtI6nienJ8u7m7JMTT8t8SpdKlmHFaOFuyV61i2voDWVr/HNRi6uBFNEFEKkv5wF5jsRT4
	QsFXi0/Oqo98Wx1ic4RCpOZYs5IrLeuD9EiwRoO7eiq16UpiiqcAEe8uXB9oQygLNDqEwGOxHUSal
	larh/IiUtXsxc/JN3FDf2sNmqYdwc6o9DNqJ+ZGljoforqQ0namjXayDrOo23zksSQNAh0C4Om5cd
	UgGbrBrg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbXct-00000006gRT-3Off;
	Wed, 07 Aug 2024 03:46:16 +0000
Date: Wed, 7 Aug 2024 04:46:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <oliver.sang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Brauner <brauner@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-bcachefs@vger.kernel.org,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
	reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [fs]  cdc4ad36a8:
 kernel_BUG_at_include/linux/page-flags.h
Message-ID: <ZrLuBz1eBdgFzIyC@casper.infradead.org>
References: <202408062249.2194d51b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408062249.2194d51b-lkp@intel.com>
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

On Tue, Aug 06, 2024 at 10:26:17PM +0800, kernel test robot wrote:
> kernel test robot noticed "kernel_BUG_at_include/linux/page-flags.h" on:
> 
> commit: cdc4ad36a871b7ac43fcc6b2891058d332ce60ce ("fs: Convert aops->write_begin to take a folio")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 1e391b34f6aa043c7afa40a2103163a0ef06d179]
> 
> in testcase: boot

This patch should fix it.

Christian, can you squash the fix in?


diff --git a/mm/shmem.c b/mm/shmem.c
index 7d28304aea0f..66ff87417090 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2904,7 +2904,8 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	if (ret)
 		return ret;
 
-	if (folio_test_has_hwpoisoned(folio)) {
+	if (folio_test_hwpoison(folio) ||
+	    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio))) {
 		folio_unlock(folio);
 		folio_put(folio);
 		return -EIO;

