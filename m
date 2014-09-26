Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XXQHr-0004Bt-Tk
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Sep 2014 07:49:55 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XXQHq-0000jf-Bd
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Sep 2014 07:49:55 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=falkor.sigsegv.cx) by ivanoab3.miniserver.com with esmtps
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XXQGj-0002Bo-AR
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Sep 2014 07:48:45 +0000
Received: from [192.168.127.2] by falkor.sigsegv.cx with esmtp (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XXQHi-0006n3-M4
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Sep 2014 08:49:46 +0100
Message-ID: <54251A99.1090305@kot-begemot.co.uk>
Date: Fri, 26 Sep 2014 08:49:45 +0100
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <1411404804-871910-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
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
Subject: Re: [uml-devel] Updated Performance Improvements patchset
To: user-mode-linux-devel@lists.sourceforge.net

I finally nailed the last stability issue related to the patchset this 
morning. It is an extremely old issue and I tried to locate the root 
cause for it with Richard off-list 2 years ago. Unfortunately it was 
without success at that time.

This issue is inherent in "stock" UML, but very difficult to trigger. 
For example, if memory serves me right Toralf recently reported 
something he ran into while doing trinity fuzz testing which looked 
exactly like that.

The performance improvement patchset makes it considerably more likely 
to show up.

The symptoms are  - processes stuck in D state with an occasional Z 
child hanging off them.

If my diagnosis is right there is a missing barrier (or for "big" 
machines fence)  in arch/um/kernel/exec.c right after the memory unmap 
in flush_thread().

Stock UML when run off ubd is less susceptible to this issue because of 
its heavy use of lseek/read and lseek/write in the disk susbsystem (nfs 
as in Toralf's case is more likely to make this issue show up). lseek() 
invokes a fence nearly every time it is called inside the host kernel 
resulting in the memory being considerably more in-sync (and the issue 
less likely to happen). By replacing these with pread/pwrite I have made 
the issue more pronounced.

I have a patch prepared which will work only on P3+ as it uses a 
verbatim fence instruction and it tests out. My question is - what is 
the "canonical" way of chosing the correct barrier here and should I 
bother with pre-P3 anyway (I do not think that you can trigger that 
issue on them even if you are lucky to have a SMP machine like this)?

A.


On 22/09/14 17:53, anton.ivanov@kot-begemot.co.uk wrote:
> This is an update of the performance improvement patchset, it
> addresses a number of issues resulting from porting what was
> originally written for 3.3.8 to the current linux kernel.
>
> Changes (where applicable) are annotated in actual patchsets.
>
> A.
>
> ------------------------------------------------------------------------------
> Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
> Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
> Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
> Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
> http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

