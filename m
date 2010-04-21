Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 21 Apr 2010 12:49:11 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/5] uml: Fix warning due to missing task_struct
 declaration
In-Reply-To: <20100421104345.GA4110@cr0.nay.redhat.com>
Message-ID: <alpine.LNX.2.00.1004211244230.7579@pobox.suse.cz>
References: <cover.1271713955.git.jan.kiszka@web.de> <1d97cd7761a1eae73923b1adda4c6915a0647bb3.1271713955.git.jan.kiszka@web.de> <20100420100949.GB5317@cr0.nay.redhat.com> <20100420143016.GB30011@c-98-229-117-200.hsd1.ma.comcast.net> <4BCDDFBB.40805@web.de>
 <20100421060651.GB4467@cr0.nay.redhat.com> <alpine.LNX.2.00.1004211138320.7579@pobox.suse.cz> <20100421104345.GA4110@cr0.nay.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Amerigo Wang <xiyou.wangcong@gmail.com>
Cc: Jan Kiszka <jan.kiszka@web.de>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, 21 Apr 2010, Amerigo Wang wrote:

> >> BTW, I don't think compile warning fixes are trivial enough to go
> >> to trivial@kernel.org.
> >
> >Why?
> >
> Usually compile warnings fixes go into -mm, some coding style fixes
> too.

Well, I personally don't care that much, submit your patches whereever you 
wish. 

The point of trivial tree is to take off load from other maintainers 
(including Andrew) so that focusing on The Real Things is possible.

See relevant section of Documentation/SubmittingPatches.

But, as I said, I don't care that much. If you want to avoid trivial tree 
for some reason, feel free to do so.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
