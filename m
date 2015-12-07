Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1a5qKf-0002Bc-CN
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Dec 2015 07:35:37 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a5qKd-0004Kp-GI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Dec 2015 07:35:37 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1a5qKW-0007rC-6M
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Dec 2015 07:35:28 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
	by smaug.kot-begemot.co.uk with esmtps
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1a5qKV-0000Q6-LF
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Dec 2015 07:35:27 +0000
Message-ID: <566536BF.4000008@kot-begemot.co.uk>
Date: Mon, 07 Dec 2015 07:35:27 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <56645576.3050807@oracle.com>
	<be1558525adc02a338df071b9ae9a732@nixia.no>
In-Reply-To: <be1558525adc02a338df071b9ae9a732@nixia.no>
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
Subject: Re: [uml-devel] uml instance crashes when started from script
To: user-mode-linux-devel@lists.sourceforge.net

On 07/12/15 07:24, stian@nixia.no wrote:
> Den 2015-12-06 16:34, skrev Vegard Nossum:
>> Hi,
>>
>> I've been running into some odd crashes when starting my UML instance
>> from Python. This is my script:
>>
>> import subprocess
>> subprocess.check_call(['path/to/vmlinux', 'mem=2048M',
>> 'rootfstype=hostfs', 'rw', 'init=/bin/bash'])
>>
>> [    1.880000] winch_thread : TIOCSCTTY failed on fd 1 err = 1
>>
> I suspect subprocess.check_call() uses pipes and not pty/tty when 
> creating this process.

It does.

>  Same problem probably happens if do you something 
> like
>
> cat /dev/null | path/to/vmlinux mem=2048M rootfstype=hostfs rw 
> init=/bin/bash 2>&1 >log

Brgds,

A.
>
>
>
> Stian
>
> ------------------------------------------------------------------------------
> Go from Idea to Many App Stores Faster with Intel(R) XDK
> Give your users amazing mobile app experiences with Intel(R) XDK.
> Use one codebase in this all-in-one HTML5 development environment.
> Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
> http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

