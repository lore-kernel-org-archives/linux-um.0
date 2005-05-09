Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVA2v-00028o-EJ	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 08:19:49 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DVA2p-00057x-G4	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 08:19:49 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Using SKAS, any examples?
References: <427895BC.2050201@manchester.ac.uk>
	<200505081902.25146.blaisorblade@yahoo.it> <427E55E6.2000503@manchester.ac.uk>
In-Reply-To: <427E55E6.2000503@manchester.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505091708.30730.blaisorblade@yahoo.it>
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
Date: Mon, 9 May 2005 17:08:30 +0200
To: Ian Rogers <ian.rogers@manchester.ac.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Sunday 08 May 2005 20:09, Ian Rogers wrote:
> Blaisorblade wrote:

> Thanks. I will implment an emulator through this mechanism. My current
> mechanism performs:
>
> loadByte(addr) {
>  pte = addr >> 12;
>  offset = addr & 0xFFF;
>  result = memory[ptr][offset]
> }
Ok, memory is a square array.
> you can imagine the store... mechanisms. Obviously the cost of the
> ptrace calls is going to be a slow down compared to this.
Well, if it's done only at setup, ok. However, can you please explain to me 
why it isn't possible to do it without SKAS?
> I hope to look into creating a patch to allow multiple segments in a
> linux process. So an extension to skas on i386 and I can get my %fs wish
> :-)
Well, it should be already doable in SKAS, with PTRACE_LDT (which relates to 
modify_ldt() the same way that writing DO_MMAP relates to mmap()). Then, 
after *setting* an appropriate descriptor in %fs (with PTRACE_POKEUSR if you 
need), you're done.

> btw: a similar thing should be possible on PowerPC given that
> segmentation can be disabled for either or both the instruction and data
> cache. It would be neat to wrap this up in a module for the performance
> improvement of emulators.

> Glad it was useful and thanks for your help - it's taught me what to do
> for my emulator code. I hope I can post some more things back in the
> future. Would the multi-segment stuff be useful for more people? Is
> there an obvious reason to avoid multi-segments?

Well, I've proposed some time ago to use segmentation for UML, but the 
proposal was dropped "because an access through segmentation is a little 
slower".

Quite frankly, I'm quite unconvinced (because any access passes through 
segmentation, even if normally segments have a 0 base and a disabled limit); 
beyond, Xen uses segmentation in the same way that I was proposing for UML, 
IIRC.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
