Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ED5C5321D
	for <linux-um@archiver.kernel.org>; Tue, 20 Aug 2024 01:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EuN7+YBAKmzog529LVv9sSISlD4oXFwMrmsyOUXPKMY=; b=t52TcYnl5Qn6uixNPGZLFPxMvS
	visPGLOGkW6Nfv9yU6J2IHr5vPHHu5RwpuvoFwPBF2V3g12w2nu/+mlhkvGhNfP0EFUMkCErCt5jz
	f7bffiu3Vg7Z6ZFacKDGQlHMhRYFI+MqadeROokIfujrCdeM/hmzPLntZzotazLuZkWJNJXhssoLJ
	gZq6VWwxv+dLN/NdcMEJ28jnEzCzCb2k8aBaTIP6qxXsMsTUGcxEtvj4u0wNHQ+r8KGD8JRbMxrOv
	/hTRMo4OaC19g6H+inV+/bQo2qZBMVeHl42LvhP9ff8smEeLVejac8OLJrgIL2uOOPi+mh+2fITnD
	/NEfVf0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgDJs-00000003Nwn-09LA;
	Tue, 20 Aug 2024 01:05:56 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgDJp-00000003NwH-2AB6
	for linux-um@lists.infradead.org;
	Tue, 20 Aug 2024 01:05:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 772B6CE09EA;
	Tue, 20 Aug 2024 01:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA95FC32782;
	Tue, 20 Aug 2024 01:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724115949;
	bh=0U7jOid/uP8Y+iIqM7ITqWrx8b2Snwx2qFv6PcPMlns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ohr8uPnMeT9PqbC27FNE2NUgwBSpD2Am8ljUhb2MkNtpvuqCxRgINXdfU+7Z5Ok4Q
	 oLhpzo7qQb2Jy/L9reXhcowB+4RKVOZlFzvsJaEDLoJ4G/pXRebjYmXlqoj8xddMJJ
	 umSfjfzu/bhamoXfiWzuJ1aWiSlwUJ4EuI/WZtuw=
Date: Mon, 19 Aug 2024 18:05:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com,
 pedro.falcato@gmail.com, linux-um@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Message-Id: <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
In-Reply-To: <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
	<20240819185253.GA2333884@thelio-3990X>
	<CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
	<20240819195120.GA1113263@thelio-3990X>
	<CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
	<CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_180553_761306_C5A1E0D9 
X-CRM114-Status: GOOD (  11.19  )
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

On Mon, 19 Aug 2024 13:16:32 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 19 Aug 2024 at 13:15, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ok, I did a quick hack-job to remove that disgusting
> > install_special_mapping() legacy case.
> >
> > With this [..]
> 
> I forgot to actually attach that "this". Here it is. For real, this time.

Thanks.  Do you think your one-liner remains desirable with this fix in
place?

