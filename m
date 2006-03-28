Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOMOn-0008JK-Gx for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:10:49 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FOMOm-0002Wm-SN
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:10:49 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <dvv6ir$ajn$1@sea.gmane.org>
	<20060328200219.GC21540@ccure.user-mode-linux.org>
	<200603290005.38074.blaisorblade@yahoo.it>
In-Reply-To: <200603290005.38074.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603290009.46534.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Re: (implementation idea) Re: uml and
	nonstandard memory splits?
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
Date: Wed, 29 Mar 2006 00:09:45 +0200
To: user-mode-linux-user@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Jason Lunz <lunz@falooley.org>, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 29 March 2006 00:05, Blaisorblade wrote:
> However, this doesn't happen because we already implement the "top of the
> stack" detection technique in arch/um/kernel/skas/mem.c. So we've
> well-tested code doing this, even if maybe at times suboptimal.

About that code, 

$ find arch/um/ include/asm-um |xargs grep HOST_TASK_SIZE

finds no mention of CONFIG_HOST_TASK_SIZE anywhere else, so that should be 
removed it seems (unless it's for S390, but that port is stalling - there's 
no point in still waiting to merge it, we must either merge or drop it 
depending on the fact that we have at least 1 active user).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
