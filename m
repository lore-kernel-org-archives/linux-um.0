Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gu8yL-000497-14 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Dec 2006 06:51:09 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gu8yJ-0002z6-KO
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Dec 2006 06:51:09 -0800
Date: Tue, 12 Dec 2006 09:46:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061212144648.GA4093@ccure.user-mode-linux.org>
References: <Pine.LNX.4.62.0612121048340.20902@pademelon.sonytel.be>
	<0A01463223B8164194908CAC85B66A1201324F53@ZMY16EXM67.ds.mot.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0A01463223B8164194908CAC85B66A1201324F53@ZMY16EXM67.ds.mot.com>
Subject: Re: [uml-devel] Regarding getpid
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Krishnappa Abhijith-A21204 <abhijith@motorola.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Dec 12, 2006 at 06:12:24PM +0800, Krishnappa Abhijith-A21204 wrote:
> Ok Thanks. So actually getpid() doesn't cause mode switch.

Sure it does.  Any system call does.

> But is it mandatory to execute  getpid()? If yes why

That's the way ptrace traditionally works.  PTRACE_SYSEMU, which came later
avoids the need to invoke some system call.  It just nullifies the system
call in the expectation that the tracer will emulate it.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
