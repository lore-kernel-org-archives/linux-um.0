Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHjUv-0006gk-FW for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Mar 2006 07:25:45 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FHjUs-0003w9-OT
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Mar 2006 07:25:45 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Real fix for rejected patch uaccess-warning
References: <200603072031.18574.blaisorblade@yahoo.it>
	<20060309165725.GC6040@ccure.user-mode-linux.org>
In-Reply-To: <20060309165725.GC6040@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603101622.41518.blaisorblade@yahoo.it>
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
Date: Fri, 10 Mar 2006 16:22:41 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Thursday 09 March 2006 17:57, Jeff Dike wrote:
> On Tue, Mar 07, 2006 at 08:31:15PM +0100, Blaisorblade wrote:
> > To fix that, we should remove some excess constness. Try the attached
> > patch

> That's certainly a lot simpler than what I had.  I'll drop it in my tree
> and see what it does.

I've now seen that while that may fix the problem on 4.1 (and please, do test 
that), on my 3.4 it causes new warnings like:

fs/proc/proc_misc.c: In function `write_sysrq_trigger':
fs/proc/proc_misc.c:686: warning: initialization discards qualifiers from 
pointer target type

686:		if (get_user(c, buf))
where "buf" is a "const char __user *".

It's complaining because "const" was lost.

Ultimately, I think we should remove all this copying of pointers and do like 
i386 in this regard - there is only one cast to do, in put_user, as I 
mentioned in last mail.
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
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
