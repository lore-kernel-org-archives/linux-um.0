Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1O4XLl-0007eH-LS
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2010 10:40:09 +0000
Received: from mail-pz0-f190.google.com ([209.85.222.190])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O4XLk-0004sL-OS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2010 10:40:09 +0000
Received: by pzk28 with SMTP id 28so5081804pzk.11
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 21 Apr 2010 03:40:03 -0700 (PDT)
Date: Wed, 21 Apr 2010 18:43:45 +0800
From: Amerigo Wang <xiyou.wangcong@gmail.com>
Message-ID: <20100421104345.GA4110@cr0.nay.redhat.com>
References: <cover.1271713955.git.jan.kiszka@web.de>
	<1d97cd7761a1eae73923b1adda4c6915a0647bb3.1271713955.git.jan.kiszka@web.de>
	<20100420100949.GB5317@cr0.nay.redhat.com>
	<20100420143016.GB30011@c-98-229-117-200.hsd1.ma.comcast.net>
	<4BCDDFBB.40805@web.de> <20100421060651.GB4467@cr0.nay.redhat.com>
	<alpine.LNX.2.00.1004211138320.7579@pobox.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1004211138320.7579@pobox.suse.cz>
Subject: Re: [uml-devel] [PATCH 3/5] uml: Fix warning due to missing
 task_struct declaration
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jiri Kosina <jkosina@suse.cz>
Cc: Amerigo Wang <xiyou.wangcong@gmail.com>, Jeff Dike <jdike@addtoit.com>, Jan Kiszka <jan.kiszka@web.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 21, 2010 at 11:38:53AM +0200, Jiri Kosina wrote:
>On Wed, 21 Apr 2010, Amerigo Wang wrote:
>> 
>> BTW, I don't think compile warning fixes are trivial enough to go
>> to trivial@kernel.org.
>
>Why?
>

Usually compile warnings fixes go into -mm, some coding style fixes
too.

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

