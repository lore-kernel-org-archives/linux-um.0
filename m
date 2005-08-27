Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8x0v-0002mx-UJ	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Aug 2005 02:30:13 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E8x0u-0008PS-6I
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Aug 2005 02:30:14 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] gdb ignoring skas breakpoints?
References: <430FC6BF.2020806@oracle.com>
In-Reply-To: <430FC6BF.2020806@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508271126.10514.blaisorblade@yahoo.it>
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
Date: Sat, 27 Aug 2005 11:26:10 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Allan Graves <allan.graves@oracle.com>, Jeff Dike <jdike@addtoit.com>

On Saturday 27 August 2005 03:49, Allan Graves wrote:
> Jeff,
> I thought i had this thread trace thing several times, but I couldn't
> get gdb to stop on breakpoints, its like it was ignoring them....   it
> thought everything was in thread_info.h.  And it listed the right code,
> and i could do like b 26, and it would set a breakpoint for line 26 of
> the correct function with the correct filename, and then just ignore it.
If you break on an exact line, then it may still be that you found a "no-op" 
line (which means for instance comments, but GCC optimization may make you 
wonder).

However, apart from that, I've seen that happen too when trying to do things 
like break panic. I think I've never seen it working. I don't know if Jeff 
has it working (he's been staying with gdb 5.x to avoid lots of problems in 
new releases).

However, please first disable TT mode and checks if that changes anything...
> (gdb) info b
> Num Type           Disp Enb Address    What
> 1   breakpoint     keep y   0x0806f607 in panic at kernel/panic.c:74
> 2   breakpoint     keep y   0x0805c254 in switch_to_skas at
> arch/um/kernel/skas/process_kern.c:29
> 3   breakpoint     keep y   0x081e5ac5 in schedule at thread_info.h:50
> 4   breakpoint     keep y   0x081e6037 in schedule at kernel/sched.c:2747
>
>
>
> Any suggestions?
> Allan
>
>
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
