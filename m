Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGETL-0000HQ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 02 Nov 2003 01:24:35 -0800
Received: from [217.73.128.98] (helo=linuxhacker.ru ident=[A2zmtF3nMOOSpqYTzWKLe0esY2uvZAIw])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AGETJ-0002xe-RE
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 02 Nov 2003 01:24:34 -0800
Message-Id: <200311020923.hA29Np9K029637@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [uml-devel] Sleeping process getting segfault signal
References: <Pine.GSO.4.58.0311012137370.355@altair.dur.ac.uk>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 2 Nov 2003 11:23:51 +0200
To: m.a.young@durham.ac.uk, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Hello!

M A Young <m.a.young@durham.ac.uk> wrote:
MAY> I have a reproduceable crash, at least with certain host kernels (eg.
MAY> from RedHat's current beta), and a 2.6 uml kernel, and get errors like
MAY> sleeping process 1786 got unexpected signal : 11
MAY> immediately after I type halt in a uml window. Does anyone know what might
MAY> be going on here, or how I might debug it further?

I see similar problems, but unrelated to 'halt'. They appear ocasionally.
And are very much like that problem you reported earlier (about copy from user).
It happens in the same place for me, Jeff's patch that converts *jmp() calls
to sig*jmp() is present in my tree.

Jeff: I finally hit the problem yesterday with extra debug code to save the
sigmask. Here's what I see. (also include sigjump buffer that was setup later
than sigprocmask was run).

sigmask = {__val = {134284288, 0, 0, 0, 134284288, 0, 23441, 
    0 <repeats 12 times>, 2776382020, 0, 2776381980, 2685736023, 2776382020, 
    0, 2776382020, 2776382172, 2685229112, 0, 0, 0, 2776382068}}
jbuf = {{__jmpbuf = {-1518585548, 800, -1607600160, -1518585268, -1518585740, 
      -1609727948}, __mask_was_saved = 1, __saved_mask = {__val = {134284288, 
        0, 2776382332, 2776382324, 1, 2776382372, 2776382372, 0, 14, 7, 
        2685735890, 115, 642, 2776382324, 123, 0, 134284288, 135492232, 1, 8, 
        2776367104, 2776381732, 2685239162, 29, 2776381744, 0, 0, 0, 0, 
        2776382476, 2685735368, 29}}}}

Bye,
    Oleg


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
