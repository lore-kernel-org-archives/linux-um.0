Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMlbf-0003NC-RQ	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 05:09:15 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EMlbe-0007Qz-7e
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 05:09:15 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
References: <200510021213.40191.blaisorblade@yahoo.it>
	<200510041319.34431.blaisorblade@yahoo.it>
	<20051004115529.GD7992@ftp.linux.org.uk>
In-Reply-To: <20051004115529.GD7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041409.13277.blaisorblade@yahoo.it>
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
Date: Tue, 4 Oct 2005 14:09:12 +0200
To: Al Viro <viro@ftp.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Alexander Viro <viro@zeniv.linux.org.uk>, sam@ravnborg.org

On Tuesday 04 October 2005 13:55, Al Viro wrote:
> On Tue, Oct 04, 2005 at 01:19:33PM +0200, Blaisorblade wrote:

> For one thing, it doesn't link into anything; for another, NPTL or not, it
> won't generate any non-trivial sections - it's one static variable (*not*
> per-thread, etc.) and one function with a bunch of inline assembler in
> it.  Built as kernel object.

> IOW, this sucker is as self-contained as it get - .text, .bss, the only
> relocation being reference to static variable from code (i.e. offset
> relative to wherever .bss ends up) and the only non-local symbol being
> switcheroo.

Ok, fine - the old problem was due to linking it with libc, so it's fixed.
Nice and ACK.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
