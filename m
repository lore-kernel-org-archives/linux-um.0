Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgR2k-0006Ds-0P	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 10:42:14 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DgR2h-0003ps-MP	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 10:42:13 -0700
Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <200506091920.34246.blaisorblade@yahoo.it>
References: <1118280325.10107.124.camel@localhost>
	 <200506091724.50908.blaisorblade@yahoo.it>
	 <1118332604.10190.58.camel@localhost>
	 <200506091920.34246.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1118339541.10190.105.camel@localhost>
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
Date: Thu, 09 Jun 2005 18:52:21 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

[OT: Mostly SELinux discussion]

> > Yep, that part is much more specific to my setup: the place where you
> > install the UML instances is not part of the LSB, so I didn't include
> > the file labels in the previous email. What is the consensus on where
> > UML should be installed on a production system? (assuming multiple
> > instances + possibility of a chroot)
> There is no consensus, so that should be parametrized somehow (if policies 
> don't have a builtin preprocessor, then sed is a good last resort - put the 
> parameters inside %%, like %UML_ROOT_FS_PATH%, and use sed on that to produce 
> the policy).
It allows basic regular expressions with '.','*','?','+' and grouping
'()'.
I'm not too keen on sed because this would prevent the policy from being
merged upstream.
Maybe now is a good time to choose a directory by default and users who
deviate can use softlinks or tweak their policy.

> > > > They need a
> > > > little bit of tidying up but seem to work. See below (I extracted the
> > > > generic part - unfortunately some parts are specific to my setup).
> 
> > > Wow! Is this the "assembler-like language" that lwn.net mentioned?
> 
> > Not sure what you mean.
> lwn.net said that writing a SELinux policy was a terrible and complicate 
> task...
Indeed, the learning curve is quite steep.
From what I remember of assembly language (1980s), it is on par.
It uses lots of macros to try to simplify configuration, I'm not sure it
really helps. It is hard to work them backwards.

> > > Allow execution of temporary files? Guess this is needed to avoid /tmp
> > > being like noexec, but does this allow to exec a random process on the
> > > host being put inside tmp?
> > AFAIK, it would allow a file with this label to be executed.
> This label is auto-given by some of the above 
> file_type_auto_trans(um_t, tmp_t, um_tmp_t)
exactly! see it isn't that hard! (that's one of the macros)
Anyone in the um_t domain creating files in tmp_t will have these files
automatically labelled as um_tmp_t.
> or something like that, right? Is a normal user restricted from assigning this 
> label another way or anybody can give this label and cross the check?
No user can assign a label unless explicitly given the access rights
(least-privilege principle)

> > I was 
> > hoping that allowing just the directory to be "execute"-able would be
> > enough but it is not. Is this due to the uml tmp-exec check? How is it
> > done?
> 
> UML needs simply to mmap (PROT_EXEC) datas from the /tmp/vm_XXXXXX file to 
> work, and so it tries doing this very early, to give the user a hint on what 
> happens. On a fs mounted noexec this is forbidden, so possibly it's forbidden 
> also by SELinux; however, it would be nicer if SELinux could simply allow 
> mmap()ing with PROT_EXEC without allowing file execution...; allowing mmap() 
> does not put a big hole inside protections while allowing file execution 
> does...means that if the user can supply a program to execute, that program 
> can be written to mmap() and execute code from /tmp, but at that point the 
> intruder could simply execute his code.
This one's beyond me! I can just about read selinux policies...but not
selinux internals.
I'll write another email for the selinux ML.

Antoine



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
