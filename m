Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4357DC3DA4A
	for <linux-um@archiver.kernel.org>; Wed, 21 Aug 2024 01:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bqLgu5rCY6FwxrHMn3oG9AZSGc/vl8klIaH3jFWN1QY=; b=SEMGkeo205qz9ORfVnB1+/NIC5
	YCDOd1eOXrhaBX4K833TURgSV4PF6SbD94Ky5/MOYp2RYl6//dj6u6MXyvNeBtq1/aAp8Tptp+X1i
	HxBldmYVUO3JWRn70LdX9wN+HELkZBKrYx4M1vcBxI1k8uegME/06Ru/xOJt1c9Itub3GQHKvSRRM
	0bKG6oFMI9IbOVhFKsteks2RVNT1Fk6X7Rjw/K9W6mQJVLNRmVbniRVT6A+tUtfDVAX6qRY1UN+ex
	oq4gXTLsxN42s9RWHNSMyC/Fdy+5BIMpgBGa/7QAKGl57HatDr3Vi1P+lzjHxHodvB/y09maIBcii
	W1NrTZUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgZzq-000000079mX-0Fns;
	Wed, 21 Aug 2024 01:18:46 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgZzm-000000079m0-24Im
	for linux-um@lists.infradead.org;
	Wed, 21 Aug 2024 01:18:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4C2BDCE0599;
	Wed, 21 Aug 2024 01:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2772C4AF1C;
	Wed, 21 Aug 2024 01:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724203118;
	bh=bqLgu5rCY6FwxrHMn3oG9AZSGc/vl8klIaH3jFWN1QY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J7HW4rBxhF/HrPEjaCJdLiVU49cBPm7VSaD9bLo71rgfjuow5pC1T829ekAR5qhbt
	 y0AJp1Dye1XHvNgijTcPSn/K+3aFMY0KrpEYB4Jf2LPy+9du5uUB+wosLhZdsiMS2H
	 3sOrZ4VDg694Av7PSihHm8BXGsBxnjelk958OsxQ=
Date: Tue, 20 Aug 2024 18:18:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rob Landley <rob@landley.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian
 Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
 jeffxu@google.com, Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, oliver.sang@intel.com, pedro.falcato@gmail.com,
 linux-um@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon
 <linux-hexagon@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Message-Id: <20240820181837.4d470b8837db618827b7bef7@linux-foundation.org>
In-Reply-To: <CAHk-=whvR+z=0=0gzgdfUiK70JTa-=+9vxD-4T=3BagXR6dciA@mail.gmail.com>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
	<20240819185253.GA2333884@thelio-3990X>
	<CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
	<20240819195120.GA1113263@thelio-3990X>
	<CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
	<CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
	<87y14rso9o.fsf@mail.lhotse>
	<CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
	<dff57198-7955-ec09-8909-671982834673@landley.net>
	<CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
	<67108df9-7374-a64e-ca82-8c46d67fb55b@landley.net>
	<CAHk-=whvR+z=0=0gzgdfUiK70JTa-=+9vxD-4T=3BagXR6dciA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_181842_743179_59BD7CAF 
X-CRM114-Status: UNSURE (   9.46  )
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

On Tue, 20 Aug 2024 16:14:29 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Andrew - I think this is good, but there may be other issues lurking.
> Do with it as you see fit,

Hey you know me, I'll merge any old thing if I think it'll help nurture
newbies.

