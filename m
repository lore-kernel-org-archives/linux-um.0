Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1LQ22d-0005AU-R8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 16:04:27 +0000
Received: from mail-ew0-f21.google.com ([209.85.219.21])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LQ22b-0000uj-26 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2009 16:04:27 +0000
Received: by ewy14 with SMTP id 14so3228831ewy.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 22 Jan 2009 08:04:22 -0800 (PST)
Date: Fri, 23 Jan 2009 00:04:01 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20090122160401.GA9732@hack.private>
References: <49773C2E.9090608@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49773C2E.9090608@gmail.com>
Subject: Re: [uml-devel] [PATCH] x86, um: fix GETREG/PUTREG macros
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
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Jan 21, 2009 at 04:15:58PM +0100, Roel Kluin wrote:
>When these macros aren't called with regs, e.g. with foo
>this will incorectly expand to foo->foo.gp[*]
>
>Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Good catch!

Reviewed-by: WANG Cong <wangcong@zeuux.org>

-- 
"Against stupidity, the gods themselves, contend in vain."


------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
