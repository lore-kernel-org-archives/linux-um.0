Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1MJmTq-0006qM-LY
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Jun 2009 10:46:58 +0000
Received: from mail-pz0-f187.google.com ([209.85.222.187])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJmTp-000728-Vv for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Jun 2009 10:46:58 +0000
Received: by pzk17 with SMTP id 17so244383pzk.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 25 Jun 2009 03:46:57 -0700 (PDT)
Date: Thu, 25 Jun 2009 18:49:01 +0800
From: Amerigo Wang <xiyou.wangcong@gmail.com>
Message-ID: <20090625104901.GG6374@cr0.nay.redhat.com>
References: <20090620005524.25582.69677.stgit@menage.mtv.corp.google.com>
	<4A3F4448.30502@panasas.com>
	<20090622085735.GB6499@cr0.nay.redhat.com>
	<20090622205226.fee30ba8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090622205226.fee30ba8.sfr@canb.auug.org.au>
Subject: Re: [uml-devel] [PATCH] UML: Fix some apparent bitrot
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
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org, Amerigo Wang <xiyou.wangcong@gmail.com>, akpm@linux-foundation.org


On Mon, Jun 22, 2009 at 08:52:26PM +1000, Stephen Rothwell wrote:
>Hi Amerigo,
>
>On Mon, 22 Jun 2009 16:57:35 +0800 Amerigo Wang <xiyou.wangcong@gmail.com> wrote:
>>
>> Stephan, could you please also do compiling tests for UML in your -next tree?
>> 
>> Thanks!
>
>I would be happy to do this, all I need is for someone to tell me how to
>do this given we have PowerPC hosts so our X86 compilers are cross
>compilers.

make ARCH=um SUBARCH=ppc? Or something similar...

Thanks.


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

