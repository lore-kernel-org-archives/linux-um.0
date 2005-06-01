Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DdWe6-0001K6-SH	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 10:04:46 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DdWe0-0001WP-Rt	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 10:04:46 -0700
Message-Id: <s29d88a0.096@ORANGE.OUS.EDU>
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Subject: Re: [uml-devel] Problems applying patches to 2.6.12-rc5-mm1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
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
Date: Wed, 01 Jun 2005 10:06:01 -0700
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
Cc: jdike@addtoit.com

Blaisor,

Thanks! I've removed this patch while leaving everything else applied. The kernel now compiles. I'm running it and will report back once I have a backtrace. *sigh*

Tony


>>> Blaisorblade <blaisorblade@yahoo.it> 05/31/05 04:32PM >>>
On Wednesday 01 June 2005 01:01, Anthony Brock wrote:
> As an additional FYI, I just refreshed my copy of the tarball. I now stops
> during compile:
>
> # make ARCH=um && make modules ARCH=um
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SYMLINK include/asm -> include/asm-um
>
> < output trimmed >
>
>   SYMLINK arch/um/sys-i386/semaphore.c
>   CC      arch/um/sys-i386/semaphore.o
>   CC      arch/um/sys-i386/signal.o
>   CC      arch/um/sys-i386/sigcontext.o
>   AS      arch/um/sys-i386/stub.o
>   CC      arch/um/sys-i386/stub_segv.o
> fixdep: arch/um/sys-i386/.stub_segv.o.d: No such file or directory
> make[1]: *** [arch/um/sys-i386/stub_segv.o] Error 2
> make: *** [arch/um/sys-i386] Error 2
remove av-skas0 and retry, that's the more likely culprit at a very quick 
glance.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade 

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
