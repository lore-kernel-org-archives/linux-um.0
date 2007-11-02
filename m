Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Io0Gs-0004Rt-Sq for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 10:25:26 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Io0Gr-0002s9-7X
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 10:25:26 -0700
Date: Fri, 2 Nov 2007 13:25:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071102172516.GA11400@c2.user-mode-linux.org>
References: <20071102022749.GB8583@swingline.cs.wisc.edu>
	<20071102155131.GB5760@c2.user-mode-linux.org>
	<20071102162239.GA13481@swingline.cs.wisc.edu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071102162239.GA13481@swingline.cs.wisc.edu>
Subject: Re: [uml-devel] building 2.6.24-rc1 with VDE in a non-standard
	location?
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
To: Erik Paulson <epaulson@cs.wisc.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Nov 02, 2007 at 11:22:44AM -0500, Erik Paulson wrote:
> include/asm/ptrace.h:50: warning: "struct user_fxsr_struct" declared inside parameter list
> include/asm/ptrace.h:50: warning: its scope is only this definition or declaration, which is probably not what you want
> include/asm/ptrace.h:52: warning: "struct user_fxsr_struct" declared inside parameter list

Humm.  Looks to me like you should be getting user_fxsr_struct into
ptrace.h as follows:
	defined in include/asm-x86/user_32.h
		included from include/asm-x86/user.h
		included from include/asm-um/user.h
		included from include/asm-um/ptrace-i386.h

The sticky point I suspect is the user_32.h, which depends on
__i386__, which Al Viro sent in patches removing.  However, it all
works here.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
