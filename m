Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FLlxG-0005kL-L6 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Mar 2006 10:51:42 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FLlxG-0002kM-B2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Mar 2006 10:51:42 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] memory option crashes the uml bootstrap phase
References: <20060321142624.GA18505@SteX> <20060321145054.GB18505@SteX>
In-Reply-To: <20060321145054.GB18505@SteX>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Message-Id: <200603211954.08891.blaisorblade@yahoo.it>
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
Date: Tue, 21 Mar 2006 19:54:08 +0100
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net, stefano.melchior@openlabs.it
Cc: user-mode-linux-user@lists.sourceforge.net

On Tuesday 21 March 2006 15:50, Stefano Melchior wrote:
> On Tue, Mar 21, 2006 at 03:26:25PM +0100, Stefano Melchior wrote:
> Dear all,
> [...]
> I also noticed that, from manual page, if you use:

> mem=memory
> This controls how much "physical" memory the kernel
> allocates for the system. The size is specified  as  a  number
>  followed by one of ’k’, ’K’, ’m’, ’M’, which have the
> obvious meanings.  This is not related to the amount of memory
>  in the physical machine. It can be more, and the
> excess, if it’s ever used, will just be swapped out.
>
> - mem=256m it works
> - while mem=256M it crashes!

No, that crash is likely a race condition and the code treats mem=256{m,M} the 
same way. 
Verified in arch/um/kernel/physmem.c:uml_mem_setup and lib/cmdline.c:memparse.

However, test increasing /proc/sys/vm/max_map_count and disabling 
CONFIG_MODE_TT as suggested by Jeff, I've already seen this to fix this 
problem.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
