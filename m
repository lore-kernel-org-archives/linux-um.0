Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRajX-0003Ce-Mr for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 10:28:47 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CRajW-0001x2-Cs for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 10:28:47 -0800
Message-ID: <41910B20.7070102@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<200411021952.09095.blaisorblade_spam@yahoo.it>
	<4190F385.1000802@fujitsu-siemens.com>
	<Pine.LNX.4.58.0411091129180.1276@gradall.private.brainfood.com>
	<4190FF3C.1060105@fujitsu-siemens.com>
In-Reply-To: <4190FF3C.1060105@fujitsu-siemens.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 09 Nov 2004 19:23:28 +0100
To: Adam Heath <doogie@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it, jdike@addtoit.com, roli8200@yahoo.de, nuno.silva@vgertech.com, antoine@nagafix.co.uk, skoehler@upb.de, devel@muhlesteins.com

Bodo Stroesser wrote:
> Adam Heath wrote:
> 
>> On Tue, 9 Nov 2004, Bodo Stroesser wrote:
>>
>>
>>> To work around, we could use the by-hand-syscall for os_getpid(). I 
>>> didn't test it,
>>> but I'm quite shure, that it fixes the problem.
>>
>>
>>
>> That would mean each arch has separate asm blocks.  Why not just use the
>> _syscall macros?
> 
> Yes, I agree.
> But before doing any workaround, we should try to get a fixed lib!
> 
Meanwhile I did a test and created a patch for the problem. It's a
workaround only, since I think, the lib should be fixed. But it
works fine linked with NPTL and static, so it could stay with a fixed
lib anyway.

#####################

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Using NPTL, getpid() sometimes delivers the wrong pid, since it
uses a buffered one from previous calls. This buffered pid isn't
discarded, when a child is created by a clone().
So, as a workaround, UML should use a direct kernel call to bypass
the lib.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/arch/um/os-Linux/process.c	2004-11-09 18:16:07.149159600 +0100
+++ b/arch/um/os-Linux/process.c	2004-11-09 18:40:43.723686152 +0100
@@ -107,6 +107,8 @@ void os_usr1_process(int pid)
  	kill(pid, SIGUSR1);
  }

+inline _syscall0( pid_t, getpid)
+
  int os_getpid(void)
  {
  	return(getpid());


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
