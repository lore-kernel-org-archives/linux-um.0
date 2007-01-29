Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBSk9-0003SL-Q8 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Jan 2007 01:24:06 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBSk7-0005gI-8X
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Jan 2007 01:24:05 -0800
Message-ID: <45BDBD29.3040008@nagafix.co.uk>
Date: Mon, 29 Jan 2007 09:23:53 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0701281447490.3498@sparrow>
	<Pine.LNX.4.64.0701281600140.3159@sparrow>
In-Reply-To: <Pine.LNX.4.64.0701281600140.3159@sparrow>
Subject: Re: [uml-devel] Thread (NPTL?) support, 2.6.20-rc5-git3, x86_64,
	reproducible segmentation fault and possible culprit
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
To: William Stearns <wstearns@pobox.com>
Cc: Vince Berk <vberk@ists.dartmouth.edu>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

>> 	Vince Berk pointed out what appears to be a thread issue with uml. 
>> The "host" command, part of the bind-utils package, uses threads and crashes 
>> when asked to do anything more complex than show its help screen:
>>
>> -bash-3.1# rpm -q bind-libs bind-utils
>> bind-libs-9.3.3-0.1.rc3.fc6
>> bind-utils-9.3.3-0.1.rc3.fc6
>> -bash-3.1# host www.google.com.
>> Segmentation fault
I believe Jeff is debugging some of these issues.
Thanks for the test case though, couldn't be more simple!


>> 	The problem is completely reproducible; the root filesystem and 
>> kernel at http://ford.stearns.org/uml/ give a crash every time you actually 
>> try to look something up with "host".
>> 	Should I be talking to the glibc folks about this?
I don't think so, it is probably just a TLS issue in UML.

>  	As a side note, if I try to bypass thread support per the 
> instructions at http://dag.wieers.com/howto/compatibility/ , I get a 
> different error (following is with stock "host"):
> 
> -bash-3.1# LD_ASSUME_KERNEL=2.4.19 host www.google.com
> host: error while loading shared libraries: libnsl.so.1: cannot open 
> shared object file: No such file or directory
> 
> -bash-3.1# export LD_ASSUME_KERNEL=2.4.19
> -bash-3.1# strace -f host www.google.com.
> strace: error while loading shared libraries: libc.so.6: cannot open 
> shared object file: No such file or directory
I think that's because glibc 2.5 does not support kernel 2.4, it only 
supports nptl (unfortunately).

Antoine

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
