Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbHHl-0000aA-KW for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 07:57:45 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IbHHk-0005Z7-3L
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 07:57:45 -0700
Date: Fri, 28 Sep 2007 10:57:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070928145734.GA7010@c2.user-mode-linux.org>
References: <a6f02da10709280506v2d897a36w24e3887cce1048d5@mail.gmail.com>
	<a6f02da10709280509q39bfb9bavecc02bc67a5e304f@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a6f02da10709280509q39bfb9bavecc02bc67a5e304f@mail.gmail.com>
Subject: Re: [uml-devel] Fwd: How can I write a programm on host to ptrace
	processes on uml in SKAS mode
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
To: fang zheng <benbencan@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Sep 28, 2007 at 08:09:06PM +0800, fang zheng wrote:
> How can I write a programm on host to ptrace processes on uml in SKAS mode  ?

skas3 or skas0?  Sounds like you're interested in skas3.

But why does it have to be done from the host rather than from inside UML?

> Is there is some examples about ptrace(PTRACE_SWITCH_MM,
> userspace_pid, 0, mm_fd)?

In UML, sure.  But it looks like you found that.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
