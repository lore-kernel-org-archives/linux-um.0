Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JiBWa-00021Q-Tf for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Apr 2008 09:45:56 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user36276)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JiBWX-00056P-AV
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 05 Apr 2008 09:45:52 -0700
From: Nix <nix@esperi.org.uk>
Date: Sat, 05 Apr 2008 17:45:39 +0100
Message-ID: <87k5jcqmh8.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: [uml-devel] Lockups with the fixed timer code :/
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Thomas Gleixner <tglx@timesys.com>

The fixed timer patch you posted a few weeks back has indeed fixed my
select()-based timeout woes.

Unfortunately, both with the old kludgy approach and with the new
remain-versus-max estimator code, I see intermittent tight lockups of
the UML kernel-space ptrace thread, with that thread chewing all
available CPU time and the virtual machine, unsurprisingly, going
unresponsive. sysprof seems unwilling to extract anything out of this,
even though it has debugging info; gdb-attachment is somewhat more
informative. A few snapshots a few seconds apart in an instance that had
been looping for some time:

0x080836c2 in update_wall_time ()
0x080836b3 in update_wall_time ()
0x08083b32 in current_tick_length ()
0x08083644 in update_wall_time ()
0x0808368e in update_wall_time ()

I'm willing to bet that, in the loop in update_wall_time(), `offset' is
somehow going negative: and as it's an unsigned value that's a bit
problematic. Unfortunately I can't see any way that could happen, unless
something is smashing it or changing clock->cycle_interval and racing
with the loop conditional test.

I'll instrument that loop and try to figure it out.

-- 
`The rest is a tale of post and counter-post.' --- Ian Rawlings
                                                   describes USENET

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
