Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <407865A4.4070403@upb.de>
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<185d01c41e23$5996cc00$2000000a@schlepptopp>
	<189201c41e30$d434cc70$2000000a@schlepptopp>
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
	<c58kbu$el1$1@sea.gmane.org>
	<20040410140840.GB5782@ccure.user-mode-linux.org>
	<4077FDF9.7070707@upb.de>
	<20040410170707.GA6492@ccure.user-mode-linux.org>
In-Reply-To: <20040410170707.GA6492@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] Network lags
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
Date: Sat, 10 Apr 2004 23:22:44 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

>>what's so bad about it?
> 
> It can put the host at risk.  There's a VM system for a reason, and it needs
> swap in order to be able to back out of memory shortages.  mlocking large
> amounts of memory subverts that and increases the possibility of deadlocking.

good point, but mlocking 128M should be like running the host with 128M 
less. so if i could tell the kernel not to touch a certain memory-area 
on the append-line, should there still be any VM issues?
of course that would need further patching of the host-kernel so that 
UML can access and manage the reserved memory.

>>well, what do you mean with managing the host memory? will be some kind 
>>tool or built-in option of the UML-kernel?
> 
> Both.  There is pluggable memory in UML, and a tool on the host to manage
> memory by moving memory between UMLs and between UMLs and the host.

sound good too, but what i have in mind is a more static thing. even if 
the host goes mad and eats all the memory, i still want to be sure that 
the UML-kernels have their memory region and this won't get swapped out.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
