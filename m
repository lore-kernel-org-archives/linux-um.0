Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQdDt-0005to-I0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 19:23:53 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BQdDs-0007g0-VA for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 19:23:53 -0700
Message-ID: <05a001c43e12$7affe2a0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
	<20040518175904.GB29114@ccure.user-mode-linux.org>
	<1084987654.2250.4.camel@chartreuse>
	<012201c43dcb$402ca6a0$2000000a@schlepptopp>
	<1084990661.2255.28.camel@chartreuse>
	<018a01c43dd9$0173f270$2000000a@schlepptopp>
	<1084996157.2256.36.camel@chartreuse>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 20 May 2004 04:30:55 +0200
To: Laurent Vivier <LaurentVivier@wanadoo.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, blaisorblade_spam@yahoo.it

Hi Laurent, 
i wondered about:
"Checking syscall emulation patch for ptrace...missing"

so  - i dig into this:

the uml-patch needs to be adjusted to the fix you gave for the host patch:
in arch/um/kernel/skas/include/ptrace-skas.h
i changed :
#define PTRACE_SYSEMU 25
to
#define PTRACE_SYSEMU 31

whoha - now sysemu patch is running with 2.6.6  :)

same positive effect: the getpid loop runs MUCH faster.
i have tested some other commands and if i run a "vmstat 1" on the HOST, 
i can see the context-swap-rate drop down significantly.

great!

laurent, can you post the sysemu uml and host patch again in ONE mail, 
containing the corrected defines?
others will probably have it easier this way!
(maybe some notes about how it works and what it does would be helpful, too)

thanks a lot!

now we need some real-world performance tests/comparisons :)
regards
roland

ps:
i will do some more tests. maybe blaisorblade already wants to mention that
patch in his 2.6 documentation at: http://www.user-mode-linux.org/~blaisorblade/ ?






>in include/linux/ptrace.h ,
>change
>#define PTRACE_SCEMU            25
>by
>#define PTRACE_SCEMU            31





----- Original Message ----- 
From: "Laurent Vivier" <LaurentVivier@wanadoo.fr>
To: "roland" <for_spam@gmx.de>
Cc: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Wednesday, May 19, 2004 9:49 PM
Subject: Re: [uml-devel] [PATCH] host context switch reduction




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
