Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DUqEJ-0000yt-OG	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 11:10:15 -0700
Received: from smtpout19.mailhost.ntl.com ([212.250.162.19]
	helo=mta13-winn.mailhost.ntl.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DUqEJ-0005IQ-2s	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 May 2005 11:10:15 -0700
Message-ID: <427E55E6.2000503@manchester.ac.uk>
From: Ian Rogers <ian.rogers@manchester.ac.uk>
MIME-Version: 1.0
Subject: Re: [uml-devel] Using SKAS, any examples?
References: <427895BC.2050201@manchester.ac.uk>
	<20050507031144.GD14445@ccure.user-mode-linux.org>
	<427D259D.3050306@manchester.ac.uk> <200505081902.25146.blaisorblade@yahoo.it>
In-Reply-To: <200505081902.25146.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sun, 08 May 2005 19:09:42 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Blaisorblade wrote:

>Hmm, no, that's not what SKAS allows. It simply allows to switch to *another* 
>address space. Yes, you can make arbitrary mmaps, so to replicate the 
>original address space and add some other maps, that you access even through 
>%fs if you want.
>
>But that's nothing special to SKAS; the advantage it gives is that:
>a) the parent can easily alter the child's address space (not the original one 
>it inherits at startup, but only the newly created one).
>b) the parent can switch the child's current address space through 
>PTRACE_SWITCH_MM (this could be emulated with running many childs).
>  
>
Thanks. I will implment an emulator through this mechanism. My current 
mechanism performs:

loadByte(addr) {
 pte = addr >> 12;
 offset = addr & 0xFFF;
 result = memory[ptr][offset]
}

you can imagine the store... mechanisms. Obviously the cost of the 
ptrace calls is going to be a slow down compared to this.

I hope to look into creating a patch to allow multiple segments in a 
linux process. So an extension to skas on i386 and I can get my %fs wish :-)

btw: a similar thing should be possible on PowerPC given that 
segmentation can be disabled for either or both the instruction and data 
cache. It would be neat to wrap this up in a module for the performance 
improvement of emulators.

>Now, the example almost work. The child can execute the syscalls, even if the 
>verification of the datas it gets is currently failing (I'll be verifying 
>that later).
>
>The main problem yesterday's version had was that the mmap's had a offset of 
>0, since the asid_mmap() loops will always stop at the first entry of 
>AddressSpaces[ASID].map_info, which had a 0 offset. Currently I set the 
>offset equal to the virtual address it's mapped to.
>
>Thanks a lot for posting the original version: the finished one will be very 
>useful for the testing of SKAS for x86-64, to debug it and get it working 
>soon. Bye
>  
>
Glad it was useful and thanks for your help - it's taught me what to do 
for my emulator code. I hope I can post some more things back in the 
future. Would the multi-segment stuff be useful for more people? Is 
there an obvious reason to avoid multi-segments?

Regards,

Ian Rogers



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
