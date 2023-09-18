Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C578CE7A89
	for <linux-um@archiver.kernel.org>; Sat, 23 Sep 2023 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1B8DOPf6RBy6VLkyDjKY0ktwX/nq7YL5TfxqOSWk7E4=; b=SBdliasNn5JKHi
	O01ksvfaUk8hPgCcuS5OcQvq+NHpfPy9Hlb3RUi9yJSl0iOhNx4+cdaY2jrIstf/jzUGxuHcg6mXc
	KWIKFwwSryl6KcwTDoHZNYkpQDRFU/dAWr+98Y4TuXThLin8fTrOsEu1ztLA/ae0iT5FtaePtYX6e
	V0ODVtTTDOSROlMueTRN83cCVhxTTiDXBx6kbrZNM62UukrJ4oCrDU98+UQKaBiMFYEEpnzOQS7Ok
	80sz83edgEuKDTLsnctZJ9Was71ziw7V/KzZ7cDuJcepvvVhke+IQm2XgYQ0OKfbBjlghlwEes4xM
	7iY3kmnUTy2COj0Lvgfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qk4CZ-00B7fx-0A;
	Sat, 23 Sep 2023 15:05:47 +0000
Received: from mail-4317.proton.ch ([185.70.43.17])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiHIX-00FtXd-2C
	for linux-um@lists.infradead.org;
	Mon, 18 Sep 2023 16:40:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
	s=protonmail2; t=1695055231; x=1695314431;
	bh=MxvEGHu4PtwN8mGrIyQuS2LPbQNlvfj3VnD5jiLU7lc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VgM7sEMUObxhy8J/FthQz5uVyKAzVBVCMwGKG+3ouY5osT0Rb1fa86tMORiLFRjz8
	 cGV4vKiEX+WES/DiNV0lIlKlHd4aSr7dnzsR0QgTgFXP06iCrX/AW2yQwkLyhbqeT7
	 8lP1XTKgFPtQdDkGVx7/ZDVPz/ti0NLUlDayxIMork8EC4xUGPEMpTt1V4h2e2r1Bw
	 bX7nkazpz3KeGSWLwAS/3zQ4q/hRmSOjAjHbbf+GXOofQSbQdV5zlEzUI3MITqLG4x
	 OzqnYnrdRx7M+pWjb+3Gd64OygYOf85Uz+uvJBJRHvLdeBbMTVU9XTEZs3pelB+GWU
	 6/gdC44vi6a+Q==
Date: Mon, 18 Sep 2023 16:40:22 +0000
To: peter@n8pjl.ca
From: Peter Lafreniere <peter@n8pjl.ca>
Cc: anton.ivanov@cambridgegreys.com, geert@linux-m68k.org, jack@suse.cz, johannes@sipsolutions.net, linux-um@lists.infradead.org, reiserfs-devel@vger.kernel.org, richard@nod.at
Subject: um: Remove CONFIG_REISERFS_FS from defconfig
Message-ID: <20230918164017.8827-1-peter@n8pjl.ca>
In-Reply-To: <20230918163544.8604-1-peter@n8pjl.ca>
References: <20230910232640.113938-1-peter@n8pjl.ca> <20230918125744.4342-1-peter@n8pjl.ca> <20230918132614.zmmuc72purc2psik@quack3> <CAMuHMdWzN0Gs2FTQDFeBLz2498dv3ZYCBL2xOvL5YdHAveaH9g@mail.gmail.com> <20230918163544.8604-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_094033_893770_DADCDD07 
X-CRM114-Status: GOOD (  18.42  )
X-Mailman-Approved-At: Sat, 23 Sep 2023 08:05:44 -0700
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

> > > Makes sense but I've noticed there are many more architectures that define
> > > CONFIG_REISERFS_FS in their defconfig (sh, powerpc, mips, m68k, ia64, arm,
> > > alpha). So perhaps we should do this for all of them when we are at it?
> > 
> > The policy for the m68k defconfigs is to enable all available exotic
> > file systems as modules, so support for them is available when needed.
> > 
> > Please let me know why this should be changed, as long as ReiserFS is
> > still available in the upstream kernel.
> 
> 
> I understand that policy and it makes particular sense for older/hobbyist
> hardware like the m68k classic where ReiserFS is included in make defconfig.
> 
> However, ReiserFS is deprecated and should be phased out as best as possible
> before its removal, and pruning config options for a filesystem that is
> considered obsolete and should not be used on the newest kernels is a step
> towards that.
> 
> ReiserFS is still availiable to be configured by anyone who builds their own
> kernel and is still availiable in all(mod|yes)config. As such I can justify
> the removal of some old config options that doesn't actually remove support for
> the filesystem when it simplifies the deprecation and removal processes for an
> ancient, largely unused filesystem.
> 
> Please remember that users who build and install their own kernel on hobbyist
> hardware should be capable enough to select one Kconfig option if they happen to
> need ReiserFS. If not, then removing ReiserFS from the defconfig on a kernel
> update is an easier issue to work around than waiting to remove the filesystem
> from the tree entirely.

Though as Jan said, you're free to not accept a patch removing the config option
until the filesystem is gone for good. I just feel like it's easier to remove
ReiserFS from all defconfigs in one fell swoop.

Cheers,

Peter Lafreniere
<peter@n8pjl.ca>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
