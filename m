Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgRgB-0008Mv-BO	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 11:22:59 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DgRg7-0001pR-Iu	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 11:22:59 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: SELinux for UML (was: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing)
References: <1118280325.10107.124.camel@localhost>
	<200506091920.34246.blaisorblade@yahoo.it>
	<1118339541.10190.105.camel@localhost>
In-Reply-To: <1118339541.10190.105.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506092026.24469.blaisorblade@yahoo.it>
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
Date: Thu, 9 Jun 2005 20:26:24 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: antoine <antoine@nagafix.co.uk>

On Thursday 09 June 2005 19:52, antoine wrote:
> [OT: Mostly SELinux discussion]
Updated the title too.
> > > Yep, that part is much more specific to my setup: the place where you
> > > install the UML instances is not part of the LSB, so I didn't include
> > > the file labels in the previous email. What is the consensus on where
> > > UML should be installed on a production system? (assuming multiple
> > > instances + possibility of a chroot)
> >
> > There is no consensus, so that should be parametrized somehow (if
> > policies don't have a builtin preprocessor, then sed is a good last
> > resort - put the parameters inside %%, like %UML_ROOT_FS_PATH%, and use
> > sed on that to produce the policy).

> It allows basic regular expressions with '.','*','?','+' and grouping
> '()'.
> I'm not too keen on sed because this would prevent the policy from being
> merged upstream.
Hmm, so there is a central repository of policies...
> Maybe now is a good time to choose a directory by default and users who
> deviate can use softlinks or tweak their policy.
Hmm, well, who uses SELinux will have to setup things anyway, so they can even 
move their files around. Assuming there will be a chroot too, using /chroot 
(which is mandated by Who Knows Who, but is used on Gentoo for the dhcp 
daemon) or better /chroot/uml would be good.

However, would a chroot work with SELinux or do you need to put the 
"chrooting" also in the policy?

Btw, I really need to allow UML to chroot on its own, btw... and options for 
changing UID/GID after setup...
From what I remember of assembly language (1980s), it is on par.

> It uses lots of macros to try to simplify configuration, I'm not sure it
> really helps. It is hard to work them backwards.

> > > > Allow execution of temporary files? Guess this is needed to avoid
> > > > /tmp being like noexec, but does this allow to exec a random process
> > > > on the host being put inside tmp?

> > > AFAIK, it would allow a file with this label to be executed.

> > This label is auto-given by some of the above
> > file_type_auto_trans(um_t, tmp_t, um_tmp_t)

> exactly! see it isn't that hard! (that's one of the macros)
Well, I'm good at guessing about unknown languages...
> Anyone in the um_t domain creating files in tmp_t will have these files
> automatically labelled as um_tmp_t.

> > or something like that, right? Is a normal user restricted from assigning
> > this label another way or anybody can give this label and cross the
> > check?

> No user can assign a label unless explicitly given the access rights
> (least-privilege principle)
Good.
> > > I was
> > > hoping that allowing just the directory to be "execute"-able would be
> > > enough but it is not. Is this due to the uml tmp-exec check? How is it
> > > done?

> > UML needs simply to mmap (PROT_EXEC) datas from the /tmp/vm_XXXXXX file
> > to work, and so it tries doing this very early, to give the user a hint
> > on what happens. 

> > On a fs mounted noexec this is forbidden, so possibly 
> > it's forbidden also by SELinux; however, it would be nicer if SELinux
> > could simply allow mmap()ing with PROT_EXEC without allowing file
> > execution...; allowing mmap() does not put a big hole inside protections
> > while allowing file execution does...means that if the user can supply a
> > program to execute, that program can be written to mmap() and execute
> > code from /tmp, but at that point the intruder could simply execute his
> > code.

> This one's beyond me! I can just about read selinux policies...but not
> selinux internals.
> I'll write another email for the selinux ML.
Sadly, by looking at the code, it seems that this is not possible... execution 
controls are implemented through mmap() controls.
> Antoine

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
