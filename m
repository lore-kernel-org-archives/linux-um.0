Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpgpW-0001WW-Cf for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Apr 2008 02:36:26 -0700
Received: from wa-out-1112.google.com ([209.85.146.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JpgpU-0004qG-LE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Apr 2008 02:36:26 -0700
Received: by wa-out-1112.google.com with SMTP id k22so7671403waf.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 26 Apr 2008 02:36:24 -0700 (PDT)
Date: Sat, 26 Apr 2008 17:35:38 +0800 (CST)
Message-Id: <20080426.173538.195417245.xiyou.wangcong@gmail.com>
From: WANG Cong <xiyou.wangcong@gmail.com>
In-Reply-To: <20080425175610.GA11188@c2.user-mode-linux.org>
References: <20080425175610.GA11188@c2.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 9/19] UML - Tidy ptrace interface
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Jeff Dike <jdike@addtoit.com>
Date: Fri, 25 Apr 2008 13:56:10 -0400
> Tidy the ptrace interface code.  Removed a bunch of unused macros.
> Started converting register sets from arrays of longs to structures.

Could you please explain a bit why do this? I think long arrary is OK.

Thanks.

Cong

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
