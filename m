Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7C6E77183
	for <linux-um@archiver.kernel.org>; Wed, 18 Dec 2024 05:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q90jg2GcG7kkoOSKZ0PgHyORxJAhQFlbWWHphQB0sUk=; b=qn7MVNgy9BEdHmVkQPssAVX+1+
	P8AucMeJyZQgBqdUNatiYUx3tjOdiWWh7ZLeEsLxTb798N1saDPxAQpTsKGHWjZZRJK0uY/wwK0oK
	QWHws5c32bj+ic7iaPeBKgAgnv7PGJ/Px7ieM/wt1Hw9z5UZBitpA1h4RtbOgD93pTbCmD0rIV9mv
	Dy+ouOMpQr0gqT9X60cEqq4Wxre3Xz7Zr6bPHpr3r0RfZ7+8eNb9Iqc/1q0gcKEoATu2WQT0N30Ki
	qAYufsh0qNAP7/z6rWkKVeXgWGc+W8nlkU2KuL1Oia1OJlFgfg0IzmQLUtwG4R69LQ3jyoWwCAgve
	/45/gq3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNmSF-0000000FcoE-0WoI;
	Wed, 18 Dec 2024 05:18:39 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNmNJ-0000000FcGW-3U6f
	for linux-um@lists.infradead.org;
	Wed, 18 Dec 2024 05:13:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EA0CEA424FF;
	Wed, 18 Dec 2024 05:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4EBC4CED0;
	Wed, 18 Dec 2024 05:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734498812;
	bh=VPTtFnOKIaVkSJH4d+mJXyyCMDm4PV2Y6+2mcEZO76E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+EsTW84x8keIwUTvkRWbYosyLbTo2I6umG0mVCEyDCeegk2KQjQyHtZQ5oRJnCgC
	 yNChtyIr674JyBKPoJLDWldDB/JdJIF8/xB47vAIPHom3J84T5GThkEvHsFZ4Hjypu
	 1VcI5yKbK2uR84tBs9yULm2AzxBuYopTCT5V6Bwp0yFQheF7v6iDaO7wkzApOXScgX
	 tLgEDapvz5RnDH8MTiauHNSr5eqbVgxisHp1FGdWFzpOX5XUyBGrTC0Frrzt4g44FB
	 PkcWEWKdmOeMWtY2aKQvIPl0j1H2btJPIHtSNdxp0QtQ7zDPizKXLPL0j4dcGXfaqG
	 76ewPadvNMJKQ==
Date: Tue, 17 Dec 2024 21:13:29 -0800
From: Kees Cook <kees@kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
	Liam.Howlett@oracle.com, Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
Message-ID: <202412172113.21E002F0@keescook>
References: <cover.1733998168.git.thehajime@gmail.com>
 <d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_211333_931950_AF37F958 
X-CRM114-Status: UNSURE (   9.05  )
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

On Thu, Dec 12, 2024 at 07:12:09PM +0900, Hajime Tazaki wrote:
> As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
> loader, FDPIC ELF loader.  In this commit, we added necessary
> definitions in the arch, as UML has not been used so far.  It also
> updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.
> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>

Acked-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

