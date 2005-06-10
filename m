Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dgl0W-0007TH-I3	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 08:01:16 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dgl0H-0002ad-7X	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Jun 2005 08:01:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 711C8AEF83
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 10 Jun 2005 15:21:30 +0100 (BST)
Received: from mail.nagafix.co.uk ([127.0.0.1])
 by localhost (viper [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22199-12 for <user-mode-linux-devel@lists.sourceforge.net>;
 Fri, 10 Jun 2005 15:21:28 +0100 (BST)
Received: from [192.168.0.1] (unknown [81.1.90.211])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 36745AEF82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 10 Jun 2005 15:21:28 +0100 (BST)
Subject: [Fwd: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing]
From: antoine <antoine@nagafix.co.uk>
Content-Type: text/plain
Message-Id: <1118416536.10190.340.camel@localhost>
Mime-Version: 1.0
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
Date: Fri, 10 Jun 2005 16:15:36 +0100
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

I thought this could be of interest to all UML devs:

(as far as I'm concerned, the /tmp is already in its own space in a chroot so
this is not an issue)

-------- Forwarded Message --------
> From: Stephen Smalley <sds@tycho.nsa.gov>
> To: Blaisorblade <blaisorblade@yahoo.it>
> Cc: antoine <antoine@nagafix.co.uk>, SELinux <selinux@tycho.nsa.gov>
> Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
> Date: Fri, 10 Jun 2005 09:35:27 -0400
> On Fri, 2005-06-10 at 00:57 +0200, Blaisorblade wrote:
> > However, since UML is a virtual kernel, between its task there is executing 
> > programs, in the memory of the virtual guest; this memory is represented by a 
> > host file, because it must be shareable by different threads (each of them 
> > matches one process/thread executed inside UML; actually there are 
> > complications but this is the base idea).
> 
> Shared anon mapping?
> 
> > A note: this file is later deleted to avoid it being touched by the host; what 
> > I was thinking was if this could be extended to deleting the directory it's 
> > in (it could, and this would work); then, maybe the execute permission could 
> > be given only to the directory, and the creation of such directories could be 
> > restricted to UML (well, given that you make UML put his files not in /tmp 
> > but in a reserved place). I.e.:
> 
> It is already the case that a separate type (um_tmp_t) is being applied
> to the file, and I presume that the policy only allows um_kernel_t to
> create/modify files with this type, so policy should ensure that no
> other process can touch the file and that no other process can trick uml
> into using a different file (because um_kernel_t will lack execute
> permission to any other xxx_tmp_t type, and thus the mmap would fail).
> 
> > only the UML "role" (I don't know SELinux so please correct me) can create a 
> > folder under /chroot/mem; those folders become of a different role
> > with auto_trans, inside those folders you get execute permission with "allow 
> > um_kernel_t um_tmp_t:file execute;", and those folders get deleted as soon as 
> > the file has been created, opened and deleted, so only UML can create an 
> > mmap'able file; race condition to check here if the attacker creates a file 
> > while the directory exists but not difficult to solve; I guess this is 
> > possible with SELinux.
> 
> Moving from /tmp to a dedicated location with its own type or using a
> shared anon mapping would make it clear that we are dealing with
> something other than a normal /tmp file, as well as fixing the
> noexec /tmp problem.  As far as an attacker creating a file, policy
> should prevent them from being able to create a file in the necessary
> type to allow execution, so that shouldn't be a problem.  Naturally, if
> uml itself is subverted, it may be induced to execute arbitrary code
> from the memory.
> 
> > I don't understand the domain concept... however, by "indirect execution" you 
> > mean simply running /lib/ld.so <fileName>, don't you? In this case, since the 
> > kernel must just mmap() ld.so and not execve() it, couldn't we deny 
> > execve("/lib/ld-linux.so") via the checks you mentioned above?
> 
> Yes, execute_no_trans would also apply there.



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
