Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgQeO-0004dx-GS	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 10:17:04 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DgQeL-0007aw-MN	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 10:17:04 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
References: <1118280325.10107.124.camel@localhost>
	<200506091724.50908.blaisorblade@yahoo.it>
	<1118332604.10190.58.camel@localhost>
In-Reply-To: <1118332604.10190.58.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506091920.34246.blaisorblade@yahoo.it>
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
Date: Thu, 9 Jun 2005 19:20:34 +0200
To: antoine <antoine@nagafix.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 09 June 2005 17:56, antoine wrote:
> > > Then I tried adding some more experimental features...
> > > Attached is a stacktrace I encountered (pcap related):
> >
> > It happens only when inside the chroot, right?

> Yes.

> > > Seems like the pcap patch
> >
> > ? You applied it on your own, or have I merged it somewhere without
> > noticing? See my signature about that.
>
> I applied it separately.
Forgot to add a smilie to mark the pun ;-) (Always remind me of my 
errors.....)

> > > Also, is anyone interested in some SELinux policies for UML?
> >
> > I guess yes, it would be very useful.... but against which distro policy
> > are they prepared? Fedora, I guess, correct?

> They are designed on gentoo but should work on most selinux systems.

> > IIRC, in fact, policies "link" together, for instance your one below
> > refers to tmp_t...

> All policies are based on the core policies, all of them have tmp_t,
> bin_t, etc_t, usr_t, var_t and much more.
Ok, good thing.
> > Also, I guess this policy needs some security label settings on files,
> > right?

> Yep, that part is much more specific to my setup: the place where you
> install the UML instances is not part of the LSB, so I didn't include
> the file labels in the previous email. What is the consensus on where
> UML should be installed on a production system? (assuming multiple
> instances + possibility of a chroot)
There is no consensus, so that should be parametrized somehow (if policies 
don't have a builtin preprocessor, then sed is a good last resort - put the 
parameters inside %%, like %UML_ROOT_FS_PATH%, and use sed on that to produce 
the policy).

> > > They need a
> > > little bit of tidying up but seem to work. See below (I extracted the
> > > generic part - unfortunately some parts are specific to my setup).

> > Wow! Is this the "assembler-like language" that lwn.net mentioned?

> Not sure what you mean.
lwn.net said that writing a SELinux policy was a terrible and complicate 
task...


> > > type um_tmp_t, file_type, tmpfile;
> >
> > "tmpfile" is already assigned to files in /tmp...
Sorry, this was a question....
> That's because my um_tmp_t is not in /tmp (it is in chroot somewhere
> else)
>
> > > allow um_kernel_t um_tmp_t:file execute;

> > Allow execution of temporary files? Guess this is needed to avoid /tmp
> > being like noexec, but does this allow to exec a random process on the
> > host being put inside tmp?

> AFAIK, it would allow a file with this label to be executed.
This label is auto-given by some of the above 
file_type_auto_trans(um_t, tmp_t, um_tmp_t)
or something like that, right? Is a normal user restricted from assigning this 
label another way or anybody can give this label and cross the check?

> I was 
> hoping that allowing just the directory to be "execute"-able would be
> enough but it is not. Is this due to the uml tmp-exec check? How is it
> done?

UML needs simply to mmap (PROT_EXEC) datas from the /tmp/vm_XXXXXX file to 
work, and so it tries doing this very early, to give the user a hint on what 
happens. On a fs mounted noexec this is forbidden, so possibly it's forbidden 
also by SELinux; however, it would be nicer if SELinux could simply allow 
mmap()ing with PROT_EXEC without allowing file execution...; allowing mmap() 
does not put a big hole inside protections while allowing file execution 
does...means that if the user can supply a program to execute, that program 
can be written to mmap() and execute code from /tmp, but at that point the 
intruder could simply execute his code.
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
