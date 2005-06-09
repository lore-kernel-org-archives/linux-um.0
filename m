Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgPFK-0007yv-27	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 08:47:06 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DgPFH-00041d-OC	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 08:47:05 -0700
Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <200506091724.50908.blaisorblade@yahoo.it>
References: <1118280325.10107.124.camel@localhost>
	 <200506091724.50908.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1118332604.10190.58.camel@localhost>
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
Date: Thu, 09 Jun 2005 16:56:44 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > Then I tried adding some more experimental features...
> > Attached is a stacktrace I encountered (pcap related):
> It happens only when inside the chroot, right?
Yes.
> > Seems like the pcap patch
> ? You applied it on your own, or have I merged it somewhere without noticing? 
> See my signature about that.
I applied it separately.
> > is causing some problems when running in a 
> > chroot which does not have the libraries required by pcap (nss?)
> Yes, it's related to the compilation-time warning somebody (either you or Nix) 
> got...
Yep, I saw them.

> > Some processes were still running when I got back to the shell.
> Well, it was segfaulting on exit, so it's a bit normal. Well, it shouldn't 
> segfault in that case but simply handle the error gracefully.
> > Btw, how do I figure out which libs I need to copy to the chroot?
> Hmm, look at /etc/nsswitch.conf (to copy inside) and /lib/libnss_* (to copy 
> too, you can limit what you copy by looking at the configuration).
Thanks, I'll try that.

> > Now, if someone could have a look at hppfs I could resurect my
> > honeypots.
> I've not the time, however test the attached patches. The first one fixes the 
> basical bugs; the second one could be needed to fix a fd leak... but I don't 
> think it's needed at all, so test with only the first and let me know if the 
> 2nd is needed, or if there are any problems (in that case, a ready-to-use 
> hppfs configuration + explaination would be happily accepted, I've really 
> little time now).
Will do.


(..)
> > Also, is anyone interested in some SELinux policies for UML?
> I guess yes, it would be very useful.... but against which distro policy are 
> they prepared? Fedora, I guess, correct?
They are designed on gentoo but should work on most selinux systems.
> 
> IIRC, in fact, policies "link" together, for instance your one below refers to 
> tmp_t...
All policies are based on the core policies, all of them have tmp_t,
bin_t, etc_t, usr_t, var_t and much more.

> Also, I guess this policy needs some security label settings on files, right?
Yep, that part is much more specific to my setup: the place where you
install the UML instances is not part of the LSB, so I didn't include
the file labels in the previous email. What is the consensus on where
UML should be installed on a production system? (assuming multiple
instances + possibility of a chroot)
> 
> Would you put it on the Wiki, please? Thanks
Will do.
> 
> > They need a 
> > little bit of tidying up but seem to work. See below (I extracted the
> > generic part - unfortunately some parts are specific to my setup).
> 
> Wow! Is this the "assembler-like language" that lwn.net mentioned?
Not sure what you mean.
> 
> > Antoine
> 
> > type um_t, domain, privowner;
> > type um_kernel_t, domain, privowner;
> 
> > type um_admin_t, file_type, sysadmfile;
> > type um_exec_t, file_type, exec_type;
> > type um_kernel_exec_t, file_type, sysadmfile, exec_type;
> > type um_home_t, file_type;
> > type um_fs_t, file_type;
> This should be restricted somewhere to UML root_fs's, right (or maybe that is 
> done with Security labels...)?
Yes, something like:
/chroot/uml/1/root_fs	--	system_u:object_r:um_fs_t
> > type um_tmp_t, file_type, tmpfile;
> "tmpfile" is already assigned to files in /tmp...
That's because my um_tmp_t is not in /tmp (it is in chroot somewhere
else)
> > allow um_kernel_t um_tmp_t:file execute;
> Allow execution of temporary files? Guess this is needed to avoid /tmp being 
> like noexec, but does this allow to exec a random process on the host being 
> put inside tmp?
AFAIK, it would allow a file with this label to be executed. I was
hoping that allowing just the directory to be "execute"-able would be
enough but it is not. Is this due to the uml tmp-exec check? How is it
done?

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
